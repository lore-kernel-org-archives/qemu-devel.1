Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1B4C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 09:09:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86A312076C
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 09:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZA2vgwZn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86A312076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI6yG-0008Kl-KA
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 05:09:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1kI6xM-0007Pm-Gy
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 05:08:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25325
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1kI6xK-0000kf-Ta
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 05:08:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600160933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ljHoSgP4fZPqjYXA6VWI9ioohZ8TxPCiRLt/xe9ap6A=;
 b=ZA2vgwZng0TLD9JjufhcRa7LFVKeChUGGrdDM0waspDOJkItddPHqZ/dqNwU7uAx/an4Zx
 ovz8DRwsxhm0FU2Z2RM1NC190tlVNOaRQm9o8gzzGa6n22XYj2iR7bCkWJ95K+tZJysF4l
 rr6/4ZJ1bQTtAMMF7rhOROpM2z919vs=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-_xOJt5EzN4Wx5I4mkMURIQ-1; Tue, 15 Sep 2020 05:08:52 -0400
X-MC-Unique: _xOJt5EzN4Wx5I4mkMURIQ-1
Received: by mail-oi1-f199.google.com with SMTP id k7so1191081oif.22
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 02:08:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ljHoSgP4fZPqjYXA6VWI9ioohZ8TxPCiRLt/xe9ap6A=;
 b=PSLcJU+a0u2eGd/K5cVBOXsWv8OznoI6wCvnyjMGyvocNvfnHrFxXuCo7oyBpE0168
 KP4gS6zymchIvw4L2BoR5WRLipR23kOqPGlOZmkhVnimH3PI+K/edot+76E4EiDEpixP
 NwjDFpRb85kVBla252+vx8kp4HBHXrsuhDhOcvnaocOGEN/ds95UyZ7HpeZt6DO2Mknv
 xoXb5h0A3Pt5Zkh9IyaRTmuhrmuCwllfnRsSf3nLU87g2Z0YjGE8ApnPoYSduD7ZRIs+
 vAip6nZL+5NtCgo4kDjVCMAnxwnkZ6iSue5abp6Qh17JpzWpY6yD0Zy87HhXFQdVHnfi
 DxaA==
X-Gm-Message-State: AOAM533KJMsjA6kCiFDWBRWjXgnciwr54IQTHUErkVg4lkU6iEt5oMNg
 jV9/c/vaf9k0gsR4hDmNJQpKaDlmREaFYDoJcrwe5iZtrKR2dUvTsSN98rP+PIiDJZcLBD/lvbQ
 +mJ0R05suuStOVdyko8SutjsHjscF4Kw=
X-Received: by 2002:a9d:1:: with SMTP id 1mr10598613ota.81.1600160931149;
 Tue, 15 Sep 2020 02:08:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhtbW3Hzytx5lXQnXQm9lUS1pN5lXZUeUdoaMgFbtMZWUPTh60Dzinx8D1CgEB3Ud0oMflnqWOyMlk6GDCgKc=
X-Received: by 2002:a9d:1:: with SMTP id 1mr10598596ota.81.1600160930887; Tue,
 15 Sep 2020 02:08:50 -0700 (PDT)
MIME-Version: 1.0
References: <1b7b5aa0-2ab0-75a5-68f4-01eb4684dbcb@proxmox.com>
In-Reply-To: <1b7b5aa0-2ab0-75a5-68f4-01eb4684dbcb@proxmox.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Tue, 15 Sep 2020 12:08:35 +0300
Message-ID: <CAMRbyyuLboa+XWAmboC5Q6ZQ2KoVXMKJC=r+fGiHPTMEJR8JnA@mail.gmail.com>
Subject: Re: Potential regression in 'qemu-img convert' to LVM
To: Stefan Reiter <s.reiter@proxmox.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=nsoffer@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=nsoffer@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 03:21:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 14, 2020 at 3:25 PM Stefan Reiter <s.reiter@proxmox.com> wrote:
>
> Hi list,
>
> following command fails since 5.1 (tested on kernel 5.4.60):
>
> # qemu-img convert -p -f raw -O raw /dev/zvol/pool/disk-1 /dev/vg/disk-1
> qemu-img: error while writing at byte 2157968896: Device or resource busy
>
> (source is ZFS here, but doesn't matter in practice, it always fails the
> same; offset changes slightly but consistently hovers around 2^31)
>
> strace shows the following:
> fallocate(13, FALLOC_FL_KEEP_SIZE|FALLOC_FL_PUNCH_HOLE, 2157968896,
> 4608) = -1 EBUSY (Device or resource busy)

What is the size of the LV?

Does it happen if you change sparse minimum size (-S)?

For example: -S 64k

    qemu-img convert -p -f raw -O raw -S 64k /dev/zvol/pool/disk-1
/dev/vg/disk-1

> Other fallocate calls leading up to this work fine.
>
> This happens since commit edafc70c0c "qemu-img convert: Don't pre-zero
> images", before that all fallocates happened at the start. Reverting the
> commit and calling qemu-img exactly the same way on the same data works
> fine.

But slowly, doing up to 100% more work for fully allocated images.

> Simply retrying the syscall on EBUSY (like EINTR) does *not* work,
> once it fails it keeps failing with the same error.
>
> I couldn't find anything related to EBUSY on fallocate, and it only
> happens on LVM targets... Any idea or pointers where to look?

Is this thin LV?

This works for us using regular LVs.

Which kernel? which distro?

Nir


