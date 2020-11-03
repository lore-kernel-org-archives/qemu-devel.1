Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A1FC388F9
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 21:42:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C4D120786
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 21:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WCfVvSd9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C4D120786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka44E-0004Z6-K5
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 16:42:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ka42t-0003dB-0d
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 16:40:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29170)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ka42p-00006k-T4
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 16:40:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604439645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d86XF9nHMPv/y6mvTzW6eEj0xC20MexuuiA7vwahA+M=;
 b=WCfVvSd9N+9ORcti+HaD81/ZM91Z9gyTTP3FLeDspSwgS2T0KCl7dykMji3uJmem0re96O
 UvxQF9gcTLDGjt0uWVXFKUZtv1taEpz+0MNLF5wfOJiw1MzTsvDoyQqOGn+FerRFltQUrc
 RzJGR3OhV/BEO+UgjKGuqrDE2QEdCBY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-WyQcT6OfOaGR0JiGKqKPOw-1; Tue, 03 Nov 2020 16:40:43 -0500
X-MC-Unique: WyQcT6OfOaGR0JiGKqKPOw-1
Received: by mail-wr1-f71.google.com with SMTP id q15so8291107wrw.8
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 13:40:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=d86XF9nHMPv/y6mvTzW6eEj0xC20MexuuiA7vwahA+M=;
 b=BnoyP7gbllbcVBBQF5zl/V90gULmMANXSwUG99LvP147A5YuL9t1eH+ki9621NvO/8
 wrOz9RxD7dh1zfe3tdcfFLR09H4BiJN0EeNIDLClIhWLLCwXay9hK1/7jLzerilBEfPM
 sgAOKcDpRtbSZ3Geu6+qy0CitxOzbGArC6mMk2Mk0LajaOEB/Ppj1yMj/zldQt/wd9Yv
 yj9MivIeDYHEqoahlnj4HiLICGZgO495nHwFaW9aEOA/bbluhy3Thh4/V92gnN7hvSl4
 R2TQ5GvpSg2qdzfTFw0c8RrYW54pgXybxrROr+JSJvhh5hCbh63Faa6s5h5xsVw/aOh6
 1hZw==
X-Gm-Message-State: AOAM531MDFd4S63bPLro8G6nB54CSnGe6N9HqVSc3jt/LCw2R5p+5Met
 CF0vAZeIg6wK9852jzEuylEwPslc1J2q2b+fM0SV+slt3hMrbGFemC7rz8uxEg7nJfrIWXHymcL
 hdnTKs2XSE+QVPNI=
X-Received: by 2002:a1c:4ca:: with SMTP id 193mr1185360wme.137.1604439642537; 
 Tue, 03 Nov 2020 13:40:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyCLdaPXVWBQOcYPwkfW5uVC4Qt0Qx3J4G0nSzQ8MeO2Ed7ftePQ2yFxuEYhlt8Nv0vYd5KIg==
X-Received: by 2002:a1c:4ca:: with SMTP id 193mr1185350wme.137.1604439642356; 
 Tue, 03 Nov 2020 13:40:42 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id l1sm29131323wrb.1.2020.11.03.13.40.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 13:40:41 -0800 (PST)
Date: Tue, 3 Nov 2020 16:40:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/38] pc,pci,vhost,virtio: fixes
Message-ID: <20201103163942-mutt-send-email-mst@kernel.org>
References: <20201103142306.71782-1-mst@redhat.com>
 <CAFEAcA_xrTeHybdCro0CNar1dsMtfGG2ucHtF=j_QsU2g-JZxw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_xrTeHybdCro0CNar1dsMtfGG2ucHtF=j_QsU2g-JZxw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Nov 03, 2020 at 03:59:26PM +0000, Peter Maydell wrote:
> On Tue, 3 Nov 2020 at 14:34, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > The following changes since commit c7a7a877b716cf14848f1fd5c754d293e2f8d852:
> >
> >   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20201102' into staging (2020-11-03 10:38:05 +0000)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> >
> > for you to fetch changes up to cf0bdd0a703911f80fc645dec97f17c4415af267:
> >
> >   vhost-user-blk-test: fix races by using fd passing (2020-11-03 09:19:12 -0500)
> >
> > ----------------------------------------------------------------
> > pc,pci,vhost,virtio: fixes
> >
> > Lots of fixes all over the place.
> > virtio-mem and virtio-iommu patches are kind of fixes but
> > it seems better to just make them behave sanely than
> > try to educate users about the limitations ...
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > ----------------------------------------------------------------
> 
> Fails to compile on 32-bit host:
> 
> ../../hw/vfio/common.c: In function 'vfio_listener_region_del':
> ../../hw/vfio/common.c:953:20: error: invalid operands to binary ==
> (have 'Int128 {aka struct Int128}' and 'Int128 {aka struct Int128}')
>          if (llsize == int128_2_64()) {
>                     ^~ ~~~~~~~~~~~~~
> 
> This needs to use int128_eq() to do the comparison.
> 
> thanks
> -- PMM

Pushed same tag again.

-- 
MST


