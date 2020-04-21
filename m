Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4068CC55181
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 19:22:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F33F720656
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 19:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e9PVpOMh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F33F720656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQyTn-0005Aw-UP
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 15:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52026)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jQyQU-0007fk-M2
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 15:19:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jQyQT-0007bT-Dr
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 15:19:22 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:38549)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jQyQS-0007Zj-Sg
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 15:19:21 -0400
Received: by mail-ot1-x342.google.com with SMTP id g19so2046173otk.5
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 12:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=LtahMI0PchBod6dZ0xcNxfzDoxWSqDr8ZNAgukecsFE=;
 b=e9PVpOMhSjqbHU9QRO1WFfI+wA0H1EjhnGLc9m7xW8wPP9EnKBXiq+jKQ6MiwaYZWh
 yi19R9SVfEOUF02L5ANL6IDUJMSJf0ejjQa/CXnjJzxWpI04NQ5MMJiFuxehGSVrw0CG
 uM4IHtAuTZkTAVsNdaOe2ZMcM7wrYZR7a3GI8qvkif4M2F5NG1CRDFQSfpORuJs+iQyC
 VEHmbdvVVYZMmXKmzghL1oOSWpe6vMOdAfOxAO19ysVxTh0xgZqz8pExTd2gT8fXYfb3
 F4cjlj2DGtc6WEhzrWUo1mp3WAFUY1amwYSQRjouj1+Au9QlLrdUItP+tUWuiHHocQkV
 cDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LtahMI0PchBod6dZ0xcNxfzDoxWSqDr8ZNAgukecsFE=;
 b=sWmpkGkltbk6kh0RvmBJ0pa7i3c2oOKACoNImBS45y8oDmoKVDCTpR3C+QkYlUuRUq
 DqpXMJE3ezYEQL2RqH5xYHNk7FydHDmyDehM4siZ1DXdSwwHFcArhL6Qr1I4LtrtSqp1
 t807aFrgNZN3eFow6eAo8lqD/6sSCgNobgp593NPqccozqj6WNxkG1B31uyrJmo3rQap
 if+6WwuH6bjjKwbDfBPAJVdREWig8h/MzwbTCbLp0orBHWFZ0HyByFvdFvCp3GLMey2n
 /HcAYXGHJtkR5X2rykE5l+RgPZc6I9Lk8+1Xpy4LwX0E6G7nFUubuSvkGL6Y9Qa3vJeN
 7tAA==
X-Gm-Message-State: AGi0PuZDgcCETWOaTi6y56YegL9vzzgrU4V6a7Rt2vrKqikaaitBBs3f
 XyuveAIHilcx+MxZR8EdKH+KU4kr0hVowBEzmx9g2j8nMYw=
X-Google-Smtp-Source: APiQypJTEYOQzZBYA0TmdnNo1YXE2jV7/SD4I19C+bWvgkOQsez1r1vMj3cvpMEwsKuKXObKabix6XrW8DnaP543cS4=
X-Received: by 2002:a05:6830:22dc:: with SMTP id
 q28mr14064744otc.221.1587496758338; 
 Tue, 21 Apr 2020 12:19:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200421170227.843555-1-marcandre.lureau@redhat.com>
In-Reply-To: <20200421170227.843555-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Apr 2020 20:19:07 +0100
Message-ID: <CAFEAcA85GEfDiwo8a9r00x1e6a5d6UDw6LJiYPkm0EstMtccOQ@mail.gmail.com>
Subject: Re: [PATCH for-5.0?] slirp: update to fix CVE-2020-1983
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 Apr 2020 at 18:03, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> This is an update on the stable-4.2 branch of libslirp.git:
>
> git shortlog 55ab21c9a3..2faae0f778f81
>
> Marc-Andr=C3=A9 Lureau (1):
>       Fix use-afte-free in ip_reass() (CVE-2020-1983)
>
> CVE-2020-1983 is actually a follow up fix for commit
> 126c04acbabd7ad32c2b018fe10dfac2a3bc1210 ("Fix heap overflow in
> ip_reass on big packet input") which was was included in qemu
> v4.1 (commit e1a4a24d262ba5ac74ea1795adb3ab1cd574c7fb "slirp: update
> with CVE-2019-14378 fix").
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Hi; thanks for putting together this stable-branch update.
I've run it through my test setup and it's fine; I'm just
going to wait a little until I push it to master just in case
anybody wants to speak up with an opinion/objection.
I'll do that tomorrow afternoon UK time and then tag rc4.

thanks
-- PMM

