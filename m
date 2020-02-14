Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCA7C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 16:38:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EBAB24650
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 16:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKfb9tYn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EBAB24650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2dyl-0003Ho-QB
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 11:38:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33400)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jerry.geis@gmail.com>) id 1j2dy1-0002Ln-JM
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 11:37:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jerry.geis@gmail.com>) id 1j2dy0-0001Kh-Ig
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 11:37:25 -0500
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30]:46745)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jerry.geis@gmail.com>)
 id 1j2dy0-0001KK-Cd
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 11:37:24 -0500
Received: by mail-qv1-xf30.google.com with SMTP id y2so4523055qvu.13
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 08:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WhR0GKpZ6Up0cBYJ65D3ATdQmjvlEAp3QKE/LPGDxJk=;
 b=XKfb9tYnLE2iA/GxiT7PMqrBksFs0NGMciy/TfO9b4NnCWZrgjGGPq1kKri31KWG/L
 uJ8Av4kOJuh2tHiX/3etLt/w5mCM6a2J7U2uy3b+ryq+di1z8E+qo3kWtwX2tzf33aZQ
 HHNpo0X3K+/KgTArxqUdXsncUz+9l3rQFACgPmWSWzKBvKymUR6YSibIjIAvCj8v6T+h
 Oryy4io361+JwOYGVKBT5n+uEijPfCXHfDpqx+2lYWlesU5WX3ywbzJBKy8yiQK1Bxb4
 X5zEGj2ORIzm5yfI8FE2zSGv8u6vtiLeZt1XBjbB8BfRdjpDohGwdrcyywT77nZWA7NL
 4/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WhR0GKpZ6Up0cBYJ65D3ATdQmjvlEAp3QKE/LPGDxJk=;
 b=IkKkS2rqkI3HOeYXDKm4yyOZympsNgFvoEH4kPvrFYCzTAk1DJ2AfHxUgFAHTNdhX+
 +kfgg2bobCRznn52JrasrIUKLX7wHLmej4vU9jwVaou/kuTNYPOm6EEQoavMyozdYTuA
 dIgYw3YC0NH8kSwlnDyT5gMu2C5XpC2XQ6yooakGfMJHSUeW9JigCVsRtLE203riKoGv
 z/tBUbu2jl7D22p6dYWc2oYVDmnH2zUfAVgXwAgIDSpX3pO+6g0ZzzYJq2UpBXVZJVBg
 pitBTjd60Ie/N9O5fB9QFCfFkj7etygePTcoWLeB8zwFXkV4oxRGfa3ctV4uK1EE5z31
 L8Gg==
X-Gm-Message-State: APjAAAXcIJSkmvBdL+wxycIAlCP3AkcijpZPLZ/kQ01DeLpLVUBwtA1b
 xZE/rjT9OW5kX1cHI1WU3rW1n4bKJVtViNzfVvE=
X-Google-Smtp-Source: APXvYqzAVX4TvujyctOyHAMwTq0bXl010ibgil4qCUBsGy+6PrOI1sN1gaa676g2U34/zxlBEv4uQT/shoulj5/XQQc=
X-Received: by 2002:ad4:5429:: with SMTP id g9mr2819542qvt.134.1581698243860; 
 Fri, 14 Feb 2020 08:37:23 -0800 (PST)
MIME-Version: 1.0
References: <CABr8-B4_mEkOkodKVVe=U_eiMemWictNSQj4T5R6nEynVXCEGw@mail.gmail.com>
 <58491266-962f-4c4f-9a51-829ec30f008b@redhat.com>
In-Reply-To: <58491266-962f-4c4f-9a51-829ec30f008b@redhat.com>
From: Jerry Geis <jerry.geis@gmail.com>
Date: Fri, 14 Feb 2020 11:37:23 -0500
Message-ID: <CABr8-B6xARb1iuD7M_i9Pgs7OXF+EQQBxKDDC-o_imbiEDbMJw@mail.gmail.com>
Subject: Re: How do UEFI on Windows host
To: Laszlo Ersek <lersek@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000f79ce7059e8bd116"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f30
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
Cc: Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f79ce7059e8bd116
Content-Type: text/plain; charset="UTF-8"

I dont know how to get all files listing on windows. But, I cd \program
files\qemu
dir *.fd
edk2-x86_64-code.fd
edk2-x86_64-secure-code.fd

It seems like from other posts these might be the files - but still not
sure how to do "boot" a command line for UEFI.

Jerry

--000000000000f79ce7059e8bd116
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I dont know how to get all files listing on windows. =
But, I cd \program files\qemu</div><div>dir *.fd</div><div>edk2-x86_64-code=
.fd</div><div>edk2-x86_64-secure-code.fd</div><div><br></div><div>It seems =
like from other posts these might be the files - but still not sure how to =
do &quot;boot&quot; a command line for UEFI.</div><div><br></div><div>Jerry=
=C2=A0</div></div>

--000000000000f79ce7059e8bd116--

