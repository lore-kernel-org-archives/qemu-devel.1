Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB08C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 21:17:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E6F32173E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 21:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v7sun+Fz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E6F32173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51608 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTYbs-00037z-Ku
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 17:17:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTYas-0002oi-GL
	for qemu-devel@nongnu.org; Wed, 22 May 2019 17:16:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTYaq-0000dL-Tt
	for qemu-devel@nongnu.org; Wed, 22 May 2019 17:16:13 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:38222)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hTYaq-0000cu-Ob
	for qemu-devel@nongnu.org; Wed, 22 May 2019 17:16:12 -0400
Received: by mail-oi1-x229.google.com with SMTP id u199so2760572oie.5
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 14:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=o48tEENcujHdXgixW7J+PM58PeR29DkEZ8Cs0OJ7Aws=;
	b=v7sun+Fz9ldyLX1TMaQ/OpygX616F1VEq7CrFUJXmvPrX/F/OmMireCEbBh4vCNAph
	Rkmd+vBHJfZme/gVs+q13qPVfDftyOeSk4X8paBJMtRCNdE5lvQLIRgs7oQtOfL+1TQI
	g2BK5VADTftemRTXGyblBC0e+C2h2QnfaDqAtt09uEL5/xcqa9BY7zT3f2sQWPajjADU
	SzNcM0zsjiYUAcSH+T8rHWnfsBVcRLCVyMlBlAEGSTX+hQTooZ5Iw8rieHKss0roW87j
	CU30a9ZJBqL2ZsO2zkZ6sH405wdzNW/stRi9iPcCWvBAj3CHPlhE5pE1L8bKNT3PBLsW
	dl7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=o48tEENcujHdXgixW7J+PM58PeR29DkEZ8Cs0OJ7Aws=;
	b=eDAhwtCple8B1V7LYJfHjZBJRXMby6BPfCfoCRwENADo05xekLAm/pFgLkb+YQ6Mp2
	0f6ay3tSHJGDLueWhCBpOBW6tkdmSB/k7WI7/DkpwTY4ZLXdvB8Qf6mJgwMtsAKd0YwD
	ZyfTmciWJtiQ+HqIv2NlBURfbsAXwTcBgps2Q1siOZyOpZjo8RTCOc3E/Pt8+B6XNH4I
	0v/08m3yrjnTUb4Uv8cr9DZZUlKj4TPpZHp68jS8IdNkNIECC4tAHDNm+60vskG84c+5
	ePd9nFqan2Aiz/KPtpPfVqcyQHMvJPne7AWHfOu8ClT93a/9u9wHee7cv+CZXlFoy+op
	xUJQ==
X-Gm-Message-State: APjAAAV4lXaikbLrValmb61cMr97YNCk6xg6rqRC9tsPOnUtVE7/zHaT
	uC1x+0yOwGfCAN6yi26ZYvp0GD5JN13ZDTZ6Um19kw==
X-Google-Smtp-Source: APXvYqx4ZzN46MKjkyxTLAdV74gv4ykU2WlyOQ307kL/h2tHkVBZeafFMA0bMi9Ytu+vwpHAR83s8gW3C7ZxADUkSiY=
X-Received: by 2002:aca:5785:: with SMTP id l127mr476861oib.48.1558559771918; 
	Wed, 22 May 2019 14:16:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190520231008.20140-1-mst@redhat.com>
	<CAFEAcA80Q8zWxM4TBVMZHLuOzo0HSpT=4C76uAwdMjLn2Xye=w@mail.gmail.com>
	<20190521092553-mutt-send-email-mst@kernel.org>
	<20190522150642.3da34e6b@redhat.com>
	<4b230fb0-ae2c-5221-39cb-1bed7b6df8d0@redhat.com>
In-Reply-To: <4b230fb0-ae2c-5221-39cb-1bed7b6df8d0@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 22 May 2019 22:15:59 +0100
Message-ID: <CAFEAcA8rxpMEQcdeHk9s3Cs8f+LMzM2Y=RE_hW9Y7UKRkZhqpg@mail.gmail.com>
To: Laszlo Ersek <lersek@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::229
Subject: Re: [Qemu-devel] [PULL v2 00/36] pci, pc, virtio: features, fixes
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Igor Mammedov <imammedo@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 22 May 2019 at 15:22, Laszlo Ersek <lersek@redhat.com> wrote:
> This is very interesting. I had obviously tested booting
> "bios-tables-test.aarch64.iso.qcow2" against "edk2-aarch64-code.fd",
> using TCG, on my x86_64 laptop. (And, I've run the above exact command
> just now, at commit a4f667b67149 -- it works 100% fine.)
>
> However, I've never been *near* a 32-bit ARM host. Therefore my
> suspicion is that the AARCH64 UEFI guest code tickles something in the
> 32-bit ARM code generator. It could be a bug in 32-bit ARM TCG, or it
> could be a bug in edk2 that is exposed by 32-bit ARM TCG.

Does it repro in a 32-bit-chroot in an aarch64 host ?
I don't know if that might be easier for you to set up than
getting access to real 32-bit hardware.

thanks
-- PMM

