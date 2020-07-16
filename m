Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AD8C433EC
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 12:51:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8B6C20739
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 12:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dhcMKPY6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8B6C20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw3M1-00089C-3P
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 08:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jw3L7-0007dm-8E
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 08:50:17 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:38356)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jw3L5-0004yN-J6
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 08:50:16 -0400
Received: by mail-lf1-x141.google.com with SMTP id t9so3205018lfl.5
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 05:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=SdxBRr5Y1kayguOXAHhZuM/e4fwAv2C7IG4L9yrYhJ4=;
 b=dhcMKPY6ElRxqRntrKbhn8WVFKxb1VFxUc1A5kZpx2FCREfcdwBBR7963Vo/myu0su
 N65cb33nbsJoSkO1ljZvCLM3P/hC4LYN5TWKdgnrhnNGLZnwJp01f9Ho8nXyozTRnZww
 aj+2i99QXp6LcG9vZG/6Zzsjx8hBbPVTfkBQOVHCn2YTq4QC3RvfupU+WdzZC2GNR6pt
 cJfxjZetolyv4yyT0AO1KoZtC0rpvPlxGqTQ63W0b5nhB550IT/7SzV1c7HMDFyyooNG
 yC4DvggIvMyhyivOJirXtz74jf6pDRmC7JpGnyq1ei2mCP8l7u/QXe5faDYr5SAq8B82
 Kxhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=SdxBRr5Y1kayguOXAHhZuM/e4fwAv2C7IG4L9yrYhJ4=;
 b=XnKB29RK6TmCnanmvjMtAtUPYpA1TEIdi1dlJo2IZlfB/0/yR81diHflHgFQOxY3xv
 dWiQNPI3Omm+TCsVIk8Icf4GHMeQAsicgbC5CRl4UD9KqgVoYUd2i0sJygTgW8NMs9Ab
 qmCwM39mev5jugckZCz120IcaXY2kev/RKHpa12HmOfFgLcZJHkgurSxY7+y0xT8Zy2y
 SYgm4dMIzGQryrNgVHvwzusP7hI62MTpP2NDFHbk4WREZSKC2nC2e+IKQImiV2TGLvQf
 hPszCD4AInU5IwP5yJMQ/lQXPJxeaGw8GVZO+z6VV8cvQAlOz03+sBBLgiPqj6kfI+YR
 NeDQ==
X-Gm-Message-State: AOAM5309PbuUXDzJTolA5Y59mB6bnFSJHofqpsDpU6Mn7PXmHUGcNpdd
 qjRr5YXPZS3iE/H5QJ3JQ/qU2oyza5wOS3rgFDsbFQ==
X-Google-Smtp-Source: ABdhPJwnxGTGFlYv0oz4rvksSOrHFLuMmSIuv/33VYE6ZB+d8cP8C43BVr9KCLLEX/roHKYcrXQY1LzSDN2n4smT/ms=
X-Received: by 2002:ac2:5325:: with SMTP id f5mr2063212lfh.6.1594903813021;
 Thu, 16 Jul 2020 05:50:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200715204814.2630-1-robert.foley@linaro.org>
 <20200715204814.2630-2-robert.foley@linaro.org> <87blkfwwe4.fsf@linaro.org>
In-Reply-To: <87blkfwwe4.fsf@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Thu, 16 Jul 2020 08:50:25 -0400
Message-ID: <CAEyhzFsu9P4y15uSEZj=VgWE+mZKfsUyb2ov3WxG2NzXkuRqfA@mail.gmail.com>
Subject: Re: [PATCH 1/2] python/qemu: Cleanup changes to ConsoleSocket
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=robert.foley@linaro.org; helo=mail-lf1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Puhov <peter.puhov@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 Jul 2020 at 07:07, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Robert Foley <robert.foley@linaro.org> writes:
>
> > The changes to console_socket.py and machine.py are to
> > cleanup for pylint and flake8.
> >
> > Signed-off-by: Robert Foley <robert.foley@linaro.org>
> > ---
> >  python/qemu/console_socket.py | 58 +++++++++++++++++------------------
> >  python/qemu/machine.py        |  7 +++--
> >  python/qemu/pylintrc          |  2 +-
> >  3 files changed, 34 insertions(+), 33 deletions(-)
> >
> > diff --git a/python/qemu/console_socket.py b/python/qemu/console_socket=
.py
> > index 830cb7c628..6a746c1dbf 100644
> > --- a/python/qemu/console_socket.py
> > +++ b/python/qemu/console_socket.py
> > @@ -1,12 +1,9 @@
> <snip>
> > @@ -103,7 +104,6 @@ class ConsoleSocket(asyncore.dispatcher):
> >
> >      def set_blocking(self):
> >          """Maintain compatibility with socket API"""
> > -        pass
>
> Hmm shouldn't this be with the change in 2/2 because I thought you
> needed a "pass" for an empty function in python?

Thanks for the review !

Sure, I can move this change to 2/2.  Probably makes more sense there
since we're changing this function there too.

This change was one of the suggestions from John Snow.
He pointed out that the pass is not needed here since the docstring takes
the role of the function body.

Thanks & Regards,
-Rob

>
> Otherwise:
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> --
> Alex Benn=C3=A9e

