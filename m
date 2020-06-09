Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C629DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:14:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93EFC2078D
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fvANTs0n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93EFC2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jihpu-0005aP-Qr
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 13:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jihMm-0003VY-7I
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:44:48 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49781
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jihMl-0004H6-7s
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:44:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591721086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1VmI2S/FFa3/Cp3SFwKgzsChmcTkfZqlEPSdL9RPOcM=;
 b=fvANTs0nUFEPuaVcbGEuTvIkECnqWtZ7zpw9jXsokNbrK2T6AWD0YTXunTcfKd4Ia47kj4
 4ammH6CrmjpwTpOVeIDVf0ZPFFIX1rxmbymEoHhYujcM95BP5VxJiEAiLs2wbHzzyvWMM3
 /QmYH4Wk/o6kS/ED5TkYWZ0rtl7GsyE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-Up8A1mfyO-eRLYzHpqYzXg-1; Tue, 09 Jun 2020 12:44:44 -0400
X-MC-Unique: Up8A1mfyO-eRLYzHpqYzXg-1
Received: by mail-wr1-f69.google.com with SMTP id d6so8817055wrn.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 09:44:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1VmI2S/FFa3/Cp3SFwKgzsChmcTkfZqlEPSdL9RPOcM=;
 b=ptRmRHnJ6982NM3+csbFQpKhNLw/seeghKdiH81GfwOYQdInRW/vvaYTz8s7rts+HC
 zB3TEBIbiF2KiFiAvKHELGR+sYKwnhiM98OiU4tf5CFml6NEdQGsb64NI2xgi/1Ny40V
 h05yVJ7oNxmBy1uoRqdCYhREfmkj1uFpzw5fUXQgz0EcBBchSc++7LUNIwRJZ1tR2+j7
 7gwOJr9HH47S6GoPMJ70MzlbyGsRNKvrHFcusPWbgDF6Y+oWxfJMjVGHztkoqlGI31in
 q6t4TRjXJGCf+xDRsLV4zd+SncVnEIM1WyhQIYRppPB9sIPlX086yc6+V4VQp05bdLVq
 yBmg==
X-Gm-Message-State: AOAM532Kp6JcV9IXTtt2CknX8S8ujcZF5LVH/ZJq2e7oPUSu7u6BjbrU
 Wg8TWXIPTlCzq0+GfRfdRjA4qpoOKHjnyeBpzVhYUb2CFb41QWXtqAzQzfGShdeZ73oZBkGK5NE
 rDfSIpWa1a726hFc=
X-Received: by 2002:a05:6000:90:: with SMTP id
 m16mr5603657wrx.191.1591721083388; 
 Tue, 09 Jun 2020 09:44:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6J9ClStTZtc8DsOSxCKqwLN+j8iZrYVtE8gx9ag1in5PvXThQm70ISGepPQzlLEmFW///ZA==
X-Received: by 2002:a05:6000:90:: with SMTP id
 m16mr5603634wrx.191.1591721083196; 
 Tue, 09 Jun 2020 09:44:43 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id z206sm3646477wmg.30.2020.06.09.09.44.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 09:44:42 -0700 (PDT)
Date: Tue, 9 Jun 2020 12:44:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v2 1/1] virtio-ccw: auto-manage VIRTIO_F_IOMMU_PLATFORM
 if PV
Message-ID: <20200609124155-mutt-send-email-mst@kernel.org>
References: <20200514221155.32079-1-pasic@linux.ibm.com>
 <20200520121507-mutt-send-email-mst@kernel.org>
 <20200606013217.2cffa3ed.pasic@linux.ibm.com>
 <20200608181428.3c6f127c.cohuck@redhat.com>
 <20200608190045.319dd68b.pasic@linux.ibm.com>
 <20200609084402.35d317ec.cohuck@redhat.com>
 <20200609114130.0ca9190b.pasic@linux.ibm.com>
 <20200609174747.4e300818@ibm-vm>
 <20200609182839.7ac80938.pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20200609182839.7ac80938.pasic@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 02:41:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Viktor Mihajlovski <mihajlov@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Boris Fiuczynski <fiuczy@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>,
 Pierre Morel <pmorel@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 09, 2020 at 06:28:39PM +0200, Halil Pasic wrote:
> On Tue, 9 Jun 2020 17:47:47 +0200
> Claudio Imbrenda <imbrenda@linux.ibm.com> wrote:
> 
> > On Tue, 9 Jun 2020 11:41:30 +0200
> > Halil Pasic <pasic@linux.ibm.com> wrote:
> > 
> > [...]
> > 
> > > I don't know. Janosch could answer that, but he is on vacation. Adding
> > > Claudio maybe he can answer. My understanding is, that while it might
> > > be possible, it is ugly at best. The ability to do a transition is
> > > indicated by a CPU model feature. Indicating the feature to the guest
> > > and then failing the transition sounds wrong to me.
> > 
> > I agree. If the feature is advertised, then it has to work. I don't
> > think we even have an architected way to fail the transition for that
> > reason.
> > 
> > What __could__ be done is to prevent qemu from even starting if an
> > incompatible device is specified together with PV.
> 
> AFAIU, the "specified together with PV" is the problem here. Currently
> we don't "specify PV" but PV is just a capability that is managed by the
> CPU model (like so many other).

So if we want to keep it user friendly, there could be
protection property with values on/off/auto, and auto
would poke at host capability to figure out whether
it's supported.

Both virtio and CPU would inherit from that.

This will allow other useful features such as ability
to hide PV from guest, which could in turn be handy e.g.
to allow migration to hosts without PV support,
or if host wants to force ability to read guest memory
e.g. for security.


-- 
MST


