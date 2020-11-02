Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB35C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 10:11:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 159B322275
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 10:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q72gpJk2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 159B322275
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZWoY-0005tp-2E
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 05:11:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZWly-0002eK-5a
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 05:09:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43419)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZWlv-0005Ki-FS
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 05:09:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604311744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tpfvga1D5sVj+WNXSSRop+Andp3BEC3tZxvRURQO4mU=;
 b=Q72gpJk26tr5nrB72dKR6CPWNx6gDkhjZk+cCqO7QlS45rj0tcBNNpSXDfuxZPnGPcruVc
 Ks+aLv3SoGY1tUKnxU4whFb9Ra+Skxuq9Fc1X/0gNIuLexJwtBAQH5rYkUg68Bypwudame
 mqsxdWLK0EEnLcA9a8wUKYpYD0pyWX4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-OXirh0ztPrWm2C5dnsp55g-1; Mon, 02 Nov 2020 05:09:01 -0500
X-MC-Unique: OXirh0ztPrWm2C5dnsp55g-1
Received: by mail-wr1-f70.google.com with SMTP id w1so6230389wrr.5
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 02:09:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tpfvga1D5sVj+WNXSSRop+Andp3BEC3tZxvRURQO4mU=;
 b=K0sCLrlifTCNP2gJYV9UarYy4BlAg8M2c5tndXJextO3PamCRpljPfne4r5zUbX7MI
 MXcSa2k8KTJJToMY7f0xmpSv/oiXvs6HyZuvtZ3VqEnEuVKUn6jySf2t1qT6kPbohYcq
 WahZXq6r2NuFFZWRLC+uYglOXsK0C1FTcefD5Kb4Wik4ggS451sw33oVaks2qFm4YMiF
 1RLEKRb9km9h5sKD95K1dB1zlcX6bbgCP0YlJtBvkMIEXR/RYSl0SClusfhEAvdaEwSa
 QGDSUKhPNXk7BvsEC19w9Vv1AvyuQKjr8LSGASdZGh4Nvv37bZfZIbh/GujKXXBjh6uv
 iUfQ==
X-Gm-Message-State: AOAM532Hi9G7a4P+QGkG5R5pSyf0ALiaB//1NEd7Z5OwweA3lyecrnvL
 +nXLhLkr2j+yb4Bhx8Itc28W4Teibx1g/DDBYFxMDsjUxH44fJZK/K5gnVmehdgLHR5jizzT/Ro
 +6lIlm+y3V/iyQaw=
X-Received: by 2002:a5d:6652:: with SMTP id f18mr18331581wrw.186.1604311740590; 
 Mon, 02 Nov 2020 02:09:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzmX3tvwWS9UX5PjFMVfx+vqQVboPvrpGs+gV+hACem3k9ADfZdZmAnXa2J8KLUlkp71+lMWw==
X-Received: by 2002:a5d:6652:: with SMTP id f18mr18331563wrw.186.1604311740423; 
 Mon, 02 Nov 2020 02:09:00 -0800 (PST)
Received: from redhat.com (bzq-79-182-97-190.red.bezeqint.net. [79.182.97.190])
 by smtp.gmail.com with ESMTPSA id r3sm21576928wrm.51.2020.11.02.02.08.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 02:08:59 -0800 (PST)
Date: Mon, 2 Nov 2020 05:08:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/15] pc,pci,vhost,virtio: misc fixes
Message-ID: <20201102050841-mutt-send-email-mst@kernel.org>
References: <20201030141136.1013521-1-mst@redhat.com>
 <160406842210.5222.16586020334648182159@66eaa9a8a123>
 <CAFEAcA_vzpTivJSGmM2aR56-z5adXe0hn9A8K+2Hb0KdR6sXkA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_vzpTivJSGmM2aR56-z5adXe0hn9A8K+2Hb0KdR6sXkA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 03:02:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Nov 01, 2020 at 02:03:56PM +0000, Peter Maydell wrote:
> On Fri, 30 Oct 2020 at 14:33, <no-reply@patchew.org> wrote:
> >
> > Patchew URL: https://patchew.org/QEMU/20201030141136.1013521-1-mst@redhat.com/
> 
> I'll apply this pullreq (unless it has other more serious
> issues), but could you look at the coding style warnings in
> a followup patch, please?


Will do, thanks!

> 
> > 9/15 Checking commit 660b206b990b (pc: Implement -no-hpet as sugar for -machine hpet=on)
> > WARNING: Block comments use a leading /* on a separate line
> > #53: FILE: hw/i386/pc.c:1152:
> > +        /* For pc-piix-*, hpet's intcap is always IRQ2. For pc-q35-1.7
> >
> > WARNING: Block comments should align the * on each line
> > #54: FILE: hw/i386/pc.c:1153:
> > +        /* For pc-piix-*, hpet's intcap is always IRQ2. For pc-q35-1.7
> > +            * and earlier, use IRQ2 for compat. Otherwise, use IRQ16~23,
> >
> 
> > 13/15 Checking commit e013e462e230 (vhost-blk: set features before setting inflight feature)
> > ERROR: trailing whitespace
> > #45: FILE: hw/virtio/vhost.c:1651:
> > + $
> >
> > ERROR: trailing whitespace
> > #50: FILE: hw/virtio/vhost.c:1656:
> > + $
> 
> These all look like nits that should be fixed.
> 
> thanks
> -- PMM


