Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51962C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 23:11:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9D1E2084E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 23:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4FA+gbr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9D1E2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45334 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hR338-0002fK-UK
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 19:11:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hR32G-0002FB-Gn
	for qemu-devel@nongnu.org; Wed, 15 May 2019 19:10:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hR32F-0002NS-L0
	for qemu-devel@nongnu.org; Wed, 15 May 2019 19:10:08 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:43334)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hR32D-0002Ht-LV; Wed, 15 May 2019 19:10:05 -0400
Received: by mail-lj1-x243.google.com with SMTP id z5so1292669lji.10;
	Wed, 15 May 2019 16:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=SEA0weuAopREcGK/9RGgbjirEdTuVM8BWT7R4Wr+Jr4=;
	b=F4FA+gbr6aVBdvkboBrQkX+JQM2Lv+8NAKCt9BVzVYKp6zWipEPsdWpw5s0Q3ilHsk
	fa2gfm3jPbhNGgLu42bChDYWGWK8TRjmb0GeWljksijfwkMiAqWLWlBnX175O7a9f3Rs
	8wqjWVst4e4Cw31q3KIiaU5plg5EgCD0HlJUv14UDy06LmXvj0+tETUOviVTxF4WYHkq
	yJ38lXV6XNJeZDweFA1M9iZP8HgXiA7YwLShT5b7rOaHL4iTnjmRJwTe0dvnPlXlL7d7
	8ezSheUsOxtTF25bLAdad9HS/Vq829NlaSBAoR98361Dk3nsJjAgYgUQm4mDSvdgASuJ
	sf9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=SEA0weuAopREcGK/9RGgbjirEdTuVM8BWT7R4Wr+Jr4=;
	b=mlXgVybLFBoMRLS0MavNOVSEFsPgCUUSG0uWCZjaiDS05h2i4xhKZvd1b7TQ6MBBTm
	p76vNCCgkIkrRBSKi1u51aE97wkzMB82Xvln8wfEGVhaitKzgIzX5kZLxB8roifQLfv+
	PNSAwLSWjfZYRlUkvxtm1/Xpi9UTVw8AScN1btvLt984wX5BGYEnrpDI+27vPNpSn8Bm
	/6SloeZPFqEihJVVOjEJZZnw0USXU8e0dWLd8s4mbBOxHKUqy7Oikg3kjUGaeBe1OjC4
	ygQ+2+crGlKDyi3/xrfDmBfrC2bQ7vAqjVExSu7JrQiT5hSQ/dEhEo1zQ0MEx89atzAS
	eotw==
X-Gm-Message-State: APjAAAWNPulynxNT50K7wnrxtu2QUxH/hy+UHHP6xubusVf06krwci30
	F2Mg6O3AhqvmDT/YLzK/wcVLT+k+IdVcDqt7asw=
X-Google-Smtp-Source: APXvYqwaeI/6fFaYyXmw4MXRGosbehibcNg5nSY8FRhxvYox9AUnnRAy/kTuAxf0rBAzzHLBT5xyYJKzcSPLFNK2qc0=
X-Received: by 2002:a2e:8988:: with SMTP id c8mr16429243lji.99.1557961803496; 
	Wed, 15 May 2019 16:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <78cf484c4d991e899d0065b2dab3a2e204ce8723.1557879499.git.alistair.francis@wdc.com>
	<87tvdvn9qw.fsf@zen.linaroharston>
In-Reply-To: <87tvdvn9qw.fsf@zen.linaroharston>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 15 May 2019 16:07:47 -0700
Message-ID: <CAKmqyKPT5yCO7+pQ+ijUSDP33-_sRwv3D217gqATnmeC5WHTvQ@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::243
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 1/1] target/arm: Fix vector
 operation segfault
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
	"richard.henderson@linaro.org" <richard.henderson@linaro.org>,
	qemu-arm <qemu-arm@nongnu.org>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 15, 2019 at 6:11 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>
>
> Alistair Francis <Alistair.Francis@wdc.com> writes:
>
> > Commit 89e68b575 "target/arm: Use vector operations for saturation"
> > causes this abort() when booting QEMU ARM with a Cortex-A15:
>
> You may want to check your email settings because when I tried to apply
> this patch it failed because the message is base64 encoded which choked g=
it-am:
>
>   Content-Type: text/plain; charset=3D"utf-8"
>   Content-Transfer-Encoding: base64

Yeah, it does look strange. I'll look into it, thanks for pointing it out.

Alistair

>
> --
> Alex Benn=C3=A9e

