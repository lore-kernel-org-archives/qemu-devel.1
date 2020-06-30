Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F52C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 15:40:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCEB920663
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 15:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fo1rq93G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCEB920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqIMr-0006Oz-0f
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 11:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jqILw-0004va-Me
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 11:39:20 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52230)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jqILu-0003KJ-3C
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 11:39:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593531557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RfDTnZyAnMKxrAwhwYFuNYjdOfKdvzDk5jy6V9PyZC4=;
 b=fo1rq93GGbAYa+PJ0AkeBrEPD53Fjxe1lYNW7VM2ezOByJGB0jUCwkvKqOeOvLZ1Wjvkbh
 +5EJSI9xlY8CjfkTlszOL/bUpvT6OcJ3acY5l6MOLT4gC1l/SjTvQZsjTgSH7grPbTrOMj
 f4RXJOT6f2EeVWYLIcjSuldJMdR/Ego=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-48C3fXQtNKyvTj5rVWIJjw-1; Tue, 30 Jun 2020 11:39:14 -0400
X-MC-Unique: 48C3fXQtNKyvTj5rVWIJjw-1
Received: by mail-qv1-f71.google.com with SMTP id m18so1048403qvt.8
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 08:39:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=RfDTnZyAnMKxrAwhwYFuNYjdOfKdvzDk5jy6V9PyZC4=;
 b=hde19Eeev6BNTdBJw8mWUmxp/rI/x4H6/1GU972ckEhIRKtL7+Rh+VDuTpw5wIMlmq
 MfSYMHapsYg6AuddHtYLShWxYj3Qtj06Hhj9B0a6T4RGNK8OK+6XlSquQxT7oAqNyF1Q
 duzce/4mujGAJ/9QxyitJi59m/oMuGxi0Ax1CSBTXyRU1TKMNH0qlfmTUreoWYXZRirO
 WGBfmUPUvyB3IZxS234+w18cBLRPdiPLSQ0ZRiHPprKeem0dELFMfC/76CjCu9hsnBVL
 wJXoFfJtynQhZjWml9Z2a4ZIHDAb5Xc6UW8p/XEMNjLIg337OSRCjS9bL1YLlqlwxRMH
 j0/Q==
X-Gm-Message-State: AOAM530c8YeE8RbaLLdjjvYTjkobFO+Pc5gQsf6uo6D3zjB1YDOP2t3G
 x0reun2oylE/iD2mUKYx8lTjuC8DKs/1HzDjT9APd/TIEAIDPWZa05GKk+ZFB96kbCByKzOu7m3
 xij2YLIPwtyo8anE=
X-Received: by 2002:a05:620a:1385:: with SMTP id
 k5mr19835417qki.148.1593531554161; 
 Tue, 30 Jun 2020 08:39:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7pPgUKCwc1gJRfuL+VDoCP5hXui91OFR6cxvTos4qcKPFpFv1xfhm/2HVA+AxEES49aqRpw==
X-Received: by 2002:a05:620a:1385:: with SMTP id
 k5mr19835387qki.148.1593531553884; 
 Tue, 30 Jun 2020 08:39:13 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id z18sm3481813qta.51.2020.06.30.08.39.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 08:39:13 -0700 (PDT)
Date: Tue, 30 Jun 2020 11:39:11 -0400
From: Peter Xu <peterx@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC v2 1/1] memory: Delete assertion in
 memory_region_unregister_iommu_notifier
Message-ID: <20200630153911.GD3138@xz-x1>
References: <20200626064122.9252-1-eperezma@redhat.com>
 <20200626064122.9252-2-eperezma@redhat.com>
 <20200626212917.GD175520@xz-x1>
 <8cf25190-53e6-8cbb-372b-e3d4ec714dc5@redhat.com>
 <20200628144746.GA239443@xz-x1>
 <54d2cdfd-97b8-9e1d-a607-d7a5e96be3a1@redhat.com>
 <20200629133403.GA266532@xz-x1>
 <2589d0e9-cc5b-a4df-8790-189b49f1a40e@redhat.com>
MIME-Version: 1.0
In-Reply-To: <2589d0e9-cc5b-a4df-8790-189b49f1a40e@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 02:00:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, Yan Zhao <yan.y.zhao@intel.com>,
 Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 30, 2020 at 10:41:10AM +0800, Jason Wang wrote:
> >      /* According to ATS spec table 2.4:
> >       * S = 0, bits 15:12 = xxxx     range size: 4K
> >       * S = 1, bits 15:12 = xxx0     range size: 8K
> >       * S = 1, bits 15:12 = xx01     range size: 16K
> >       * S = 1, bits 15:12 = x011     range size: 32K
> >       * S = 1, bits 15:12 = 0111     range size: 64K
> >       * ...
> >       */
> 
> 
> Right, but the comment is probably misleading here, since it's for the PCI-E
> transaction between IOMMU and device not for the device IOTLB invalidation
> descriptor.
> 
> For device IOTLB invalidation descriptor, spec allows a [0, ~0ULL]
> invalidation:
> 
> "
> 
> 6.5.2.5 Device-TLB Invalidate Descriptor
> 
> ...
> 
> Size (S): The size field indicates the number of consecutive pages targeted
> by this invalidation
> request. If S field is zero, a single page at page address specified by
> Address [63:12] is requested
> to be invalidated. If S field is Set, the least significant bit in the
> Address field with value 0b
> indicates the invalidation address range. For example, if S field is Set and
> Address[12] is Clear, it
> indicates an 8KB invalidation address range with base address in Address
> [63:13]. If S field and
> Address[12] is Set and bit 13 is Clear, it indicates a 16KB invalidation
> address range with base
> address in Address [63:14], etc.
> 
> "
> 
> So if we receive an address whose [63] is 0 and the rest is all 1, it's then
> a [0, ~0ULL] invalidation.

Yes.  I think invalidating the whole range is always fine.  It's still not
arbitrary, right?  E.g., we can't even invalidate (0x1000, 0x3000) with
device-iotlb because of the address mask, not to say sub-pages.

> 
> 
> > 
> > > 
> > > > > How about just convert to use a range [start, end] for any notifier and move
> > > > > the checks (e.g the assert) into the actual notifier implemented (vhost or
> > > > > vfio)?
> > > > IOMMUTLBEntry itself is the abstraction layer of TLB entry.  Hardware TLB entry
> > > > is definitely not arbitrary range either (because AFAICT the hardware should
> > > > only cache PFN rather than address, so at least PAGE_SIZE aligned).
> > > > Introducing this flag will already make this trickier just to avoid introducing
> > > > another similar struct to IOMMUTLBEntry, but I really don't want to make it a
> > > > default option...  Not to mention I probably have no reason to urge the rest
> > > > iommu notifier users (tcg, vfio) to change their existing good code to suite
> > > > any of the backend who can cooperate with arbitrary address ranges...
> > > 
> > > Ok, so it looks like we need a dedicated notifiers to device IOTLB.
> > Or we can also make a new flag for device iotlb just like current UNMAP? Then
> > we replace the vhost type from UNMAP to DEVICE_IOTLB.  But IMHO using the
> > ARBITRARY_LENGTH flag would work in a similar way.  DEVICE_IOTLB flag could
> > also allow virtio/vhost to only receive one invalidation (now IIUC it'll
> > receive both iotlb and device-iotlb for unmapping a page when ats=on), but then
> > ats=on will be a must and it could break some old (misconfiged) qemu because
> > afaict previously virtio/vhost could even work with vIOMMU (accidentally) even
> > without ats=on.
> 
> 
> That's a bug and I don't think we need to workaround mis-configurated qemu
> :)

IMHO it depends on the strictness we want on the qemu cmdline API. :)

We should at least check libvirt to make sure it's using ats=on always, then I
agree maybe we can avoid considering the rest...

Thanks,

-- 
Peter Xu


