Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD8FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 15:27:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A308420663
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 15:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YL/Rrp70"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A308420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqIAe-0004YH-SV
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 11:27:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jqI4G-0005m7-1b
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 11:21:04 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31877
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jqI4E-00087s-C6
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 11:21:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593530458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yUmhadzYsbJoUsPNvSzXULsKvEgPV32pY2Dh+SsTOBs=;
 b=YL/Rrp70o6VwAgegTSjdxJtFfZQmcTRY5weZznk27S7XM1S22xQYd0Yv2l1mtephZZO/Mr
 58T/ue6YTyMXgvXpaswccQUgnH/XxW2uAeGTFdHw2Z77PtVqQuErI+PsRvnmVx9kWB2nub
 vu8RIfX7uatNFhfkNL5sCUHgbvtEZMU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-tfOaxwxuMpWY0jrC2DgSoA-1; Tue, 30 Jun 2020 11:20:56 -0400
X-MC-Unique: tfOaxwxuMpWY0jrC2DgSoA-1
Received: by mail-qv1-f69.google.com with SMTP id 59so14130377qvb.4
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 08:20:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yUmhadzYsbJoUsPNvSzXULsKvEgPV32pY2Dh+SsTOBs=;
 b=ekVlex57BqbF74YXzbTpR5uYPIS5SIOHaGARh7FgFKh+KZTN3WkGloyyA/Mt3E0K1F
 4HtgDL4bqNMjpPv2iPrgbPFGmIm3LXdZsKvkDqilhhGxtxefFP1FggxlX4qMJsyly6Ma
 7q1E4+uLPd3EX8Y3edOXRnJXX67THiQ7XBFY/egDKYz1gy0YBUF+Dt2b/6btGqumoHi4
 pmr1tJpn0w2Yhn7lIk4THsTkMpstYca2EKRr8Vp6XrXDeWkFlWUQfGfr6XSMJFh0UGZU
 dOhG6W82mxojzbVxINIhCE/hSw0ggjk/eUK3IIik5u+NtNQTDXjpv3lfCezN3RFdSbv+
 LBqw==
X-Gm-Message-State: AOAM530WT9OeyYkP2FE0hMO4ueMe95OzZDUpFb05V3l4l2mFWajpBG5L
 1p8tGTIX1RseRIZjuLTFj3VcUwIfuNBB2qXnt6UQgd7b4IMSUaJAFXzxAQLKGcrt0wLnH1M2eBj
 xwbPGSVCDCm7EohM=
X-Received: by 2002:ac8:691:: with SMTP id f17mr21071263qth.60.1593530455163; 
 Tue, 30 Jun 2020 08:20:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyaSyRApaOEKtSry3MwsgGncS6tKjbi/UUHjyaY0u983MTzn5zOMB9Ndi7N57O0ZmipW+5A6g==
X-Received: by 2002:ac8:691:: with SMTP id f17mr21071097qth.60.1593530453188; 
 Tue, 30 Jun 2020 08:20:53 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id t48sm3530585qtb.50.2020.06.30.08.20.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 08:20:52 -0700 (PDT)
Date: Tue, 30 Jun 2020 11:20:50 -0400
From: Peter Xu <peterx@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC v2 1/1] memory: Delete assertion in
 memory_region_unregister_iommu_notifier
Message-ID: <20200630152050.GC3138@xz-x1>
References: <20200626064122.9252-2-eperezma@redhat.com>
 <20200626212917.GD175520@xz-x1>
 <8cf25190-53e6-8cbb-372b-e3d4ec714dc5@redhat.com>
 <20200628144746.GA239443@xz-x1>
 <54d2cdfd-97b8-9e1d-a607-d7a5e96be3a1@redhat.com>
 <20200629133403.GA266532@xz-x1>
 <2589d0e9-cc5b-a4df-8790-189b49f1a40e@redhat.com>
 <1b4eaaaf-c2ab-0da8-afb4-1b7b4221e6cf@redhat.com>
 <20200630052148-mutt-send-email-mst@kernel.org>
 <49f547e1-dd87-7abe-1075-9dcece75b641@redhat.com>
MIME-Version: 1.0
In-Reply-To: <49f547e1-dd87-7abe-1075-9dcece75b641@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 01:11:03
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

On Tue, Jun 30, 2020 at 05:23:31PM +0800, Jason Wang wrote:
> > > Ok, we had a dedicated mr for interrupt:
> > > 
> > > memory_region_add_subregion_overlap(MEMORY_REGION(&vtd_dev_as->iommu),
> > > VTD_INTERRUPT_ADDR_FIRST,
> > > &vtd_dev_as->iommu_ir, 1);
> > > 
> > > So it should be fine. I guess the reason that I'm asking is that I thought
> > > "IR" means "Interrupt remapping" but in fact it means "Interrupt Region"?

I was meaning "interrupt remapping", and of course it's the interrupt region
too when IR enabled...

> > > 
> > > But I'm still not clear about the invalidation part for interrupt region,
> > > maybe you can elaborate a little more on this.
> > > 
> > > Btw, I think guest can trigger the assert in vtd_do_iommu_translate() if we
> > > teach vhost to DMA to that region:
> > 
> > Why would we want to?
> 
> 
> I meant a buggy(malicious) guest driver.

Yes seems possible.  Do you want to post a patch?  Let me know if you want me
to...  Thanks,

-- 
Peter Xu


