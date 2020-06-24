Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A16C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 12:53:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64E3920663
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 12:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="moJpyLkW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64E3920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo4uI-0003sR-MR
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 08:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35302)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1jo4tg-00039H-0Y
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 08:53:00 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:33149)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1jo4te-00060P-6V
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 08:52:59 -0400
Received: by mail-lj1-x243.google.com with SMTP id s1so2440100ljo.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 05:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=L2VfXr+wrRkLpcYiMpgSJbGnKK49VpSgllN39LKBgUE=;
 b=moJpyLkWwhBSb97Itz2uOmKHAMBB6Shej3HOy3IyJQvTM53KA9KJhMHnL8FYt+zjuA
 nIbGXg9dMF2oENgkDQ+3pX5Z1CScve4fPLZn9mlVnNuYz5BroRrDm2sGdQbqMx0aBzoG
 +WgXWUeGIFcnNAoyk+pqzBmM0GxGq84p2OKqR/PmnVjUQw7iahHZmPfrhyJ7nRnUr/vV
 2TupTloIhqaJXHtUSvZTVGyCPCK5+X5mifUMSUJjZNQq5eOzPJqS8KJLhIFhbjfmmepB
 TJmbG2tRZh/rHWnArCMYPwUMHbjw5ZFKu8UjcK5UlWOHEy8PdKF3jQn+u33ukIwJ/zCz
 zU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=L2VfXr+wrRkLpcYiMpgSJbGnKK49VpSgllN39LKBgUE=;
 b=EpIhP+IjQyVoXh2rhDDqqV+REBAnrlzXFpCQhTR2hq3rvOLsLex6Q8CjBu3i6vUBP3
 YxKkNCm71mbJopxgPpyE9mkG0aTaLHPMuR5SgRGYwKU4/gn+y/XBJ3Wtkbh5GBTGV6Bt
 iqbKJgoeXpvtaeI5BaExJ8xqz/B9uPLx+bVST2BSKkBJZhlM2S4YAKfPNXPNTccyFGy+
 FcTP7EbQiRn0u5ivlpqWfKLtcczgm06R2Xnuo9HHlonGzoVAlIJimkiq3rsDSJDocR7p
 GIrwImFKXKfi8FzXaA+609bfbSqPMi2xcb+U8WRmj6ZP2GHq6gFOWdq7h6+PDT1HKpYp
 TRVQ==
X-Gm-Message-State: AOAM532x1od5IetA/NgKurr/bddVVW1Oa58ogp+hrXdbrKHSDoSmqDil
 rwIOJ5GXR9XZUfHX5xsyPd5Xu07q37Pvqgx5/j4=
X-Google-Smtp-Source: ABdhPJyIxbtadZc95+Z5PRSpPgsxAcE1qBgoXjjgpynlW/K8aJOqdQu1yqcI78stkMCEvVZ69GuBZqLEw98bdJ76kdI=
X-Received: by 2002:a2e:b8c2:: with SMTP id s2mr14830277ljp.368.1593003176111; 
 Wed, 24 Jun 2020 05:52:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200624121939.10282-1-jandryuk@gmail.com>
 <000a01d64a23$4a595e90$df0c1bb0$@xen.org>
In-Reply-To: <000a01d64a23$4a595e90$df0c1bb0$@xen.org>
From: Jason Andryuk <jandryuk@gmail.com>
Date: Wed, 24 Jun 2020 08:52:44 -0400
Message-ID: <CAKf6xpuiRj_b+M+E0wBzPhraLxdebL6xr_1dMGc-jnzhWb0mhg@mail.gmail.com>
Subject: Re: [PATCH] xen: Fix xen-legacy-backend qdev types
To: Paul Durrant <paul@xen.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=jandryuk@gmail.com; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Anthony Perard <anthony.perard@citrix.com>,
 xen-devel <xen-devel@lists.xenproject.org>,
 Stefano Stabellini <sstabellini@kernel.org>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 24, 2020 at 8:30 AM Paul Durrant <xadimgnik@gmail.com> wrote:
>
> > -----Original Message-----
> > From: Jason Andryuk <jandryuk@gmail.com>
> > Sent: 24 June 2020 13:20
> > To: Stefano Stabellini <sstabellini@kernel.org>; Anthony Perard <anthony.perard@citrix.com>; Paul
> > Durrant <paul@xen.org>; xen-devel@lists.xenproject.org
> > Cc: Jason Andryuk <jandryuk@gmail.com>; qemu-devel@nongnu.org
> > Subject: [PATCH] xen: Fix xen-legacy-backend qdev types
> >
> > xen-sysdev is a TYPE_SYS_BUS_DEVICE.  bus_type should not be changed so
> > that it can plug into the System bus.  Otherwise this assert triggers:
> > qemu-system-i386: hw/core/qdev.c:102: qdev_set_parent_bus: Assertion
> > `dc->bus_type && object_dynamic_cast(OBJECT(bus), dc->bus_type)'
> > failed.
> >
> > TYPE_XENBACKEND attaches to TYPE_XENSYSBUS, so its class_init needs to
> > be set accordingly to attach the qdev.  Otherwise the following assert
> > triggers:
> > qemu-system-i386: hw/core/qdev.c:102: qdev_set_parent_bus: Assertion
> > `dc->bus_type && object_dynamic_cast(OBJECT(bus), dc->bus_type)'
> > failed.
> >
> > TYPE_XENBACKEND is not a subclass of XEN_XENSYSDEV, so it's parent
> > is just TYPE_DEVICE.  Change that.
> >
> > Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
>
> Clearly we raced. This patch and my patch #1 are identical so I'm happy to give my ack to this.

Yeah, looks like you beat me by a hair :)

Either way it gets fixed is fine by me.

Thanks,
Jason

