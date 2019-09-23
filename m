Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8E9C04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 12:23:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 065A520867
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 12:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KWHb2i1i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 065A520867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCNMo-0001hi-SI
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 08:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48413)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iCNJi-0007ph-6x
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 08:19:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iCNJf-0002FX-6o
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 08:19:45 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:44868)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iCNJe-0002FF-VD
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 08:19:43 -0400
Received: by mail-ot1-x332.google.com with SMTP id 21so11837729otj.11
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 05:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=TU72nRS6vrGhj/ZwwO/XbiFj78nK4ba+JHVAFSZmzRU=;
 b=KWHb2i1iZRzuTcf3bP3s3rh/XEU3qiFrDVH9OPrFxWGbWc4WULXiJJ3m3/j3L4UA9g
 GOCwDJQ5rViibTz7llDoIvMwv4mZmQcReBnG2nhVXqmCzrD0XrMSYYkNuJK3xHN0+4jM
 uLVcziT8GaMHThAEhDQdVzJU6DCpwcp8/ZByC1SEtRMJMduvf+vzGzpNcnmNp1ahsRdd
 qM2+eNQ4250J0Tnc+Q8ewu5SA3RaqKMcBbm90RaukEZr4+u8/52/LDsRbxCnCciaG+T3
 SKIUxfcIbS+H8quvopgHiAiM9kQ6lR7b+CaKdYmfquynrh3o4Cc2VRVIbz84CN3pMzyI
 5OSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=TU72nRS6vrGhj/ZwwO/XbiFj78nK4ba+JHVAFSZmzRU=;
 b=cMzX+AOpJqd4jxi40hY1/W3uYUBOvI7zr5PMtdTlZTuK48lhzUqNAVqEZ5iAX5b6Ys
 +tZqCbLlDPErayl7mKuhIhbWGvzG8EdrD7DYTwJdCx2FA3klvDuxMeE5RxxVTxv2T/Cp
 3SNXoEwomkXQD5hFQHsfgFvSzZtU27jThfT4vS1//nKtFytrFAODgZOLDhhzGQ2z9zuh
 GwlxhYRkIBbt5qNLcKlNvQoZojMM7PkgormI+GMhdX2gQbNBXYqOkGWPIlEjnnQSrAi7
 w4S6uBZdJOxAJtwaXvbQGBTgCDG5zimM89jnLiBRJpXlpz58gw4/xC0QcxNZqncn+uA9
 rjYw==
X-Gm-Message-State: APjAAAVH9PzJpgWqB5RzDBl1SWcT7aeEuETf6CYYefPDQ1HHtWscrvCn
 +N+9cs15P8QbAE9M6KKEisM5oWSoQtwJM+FX8EXtTg==
X-Google-Smtp-Source: APXvYqzXcvQbvlN6cfVpM8SP9315GGvXlp0ERehYxDcIK2WMBeCafggUYRSoESMebuftrhx9r3DKbiKi/+pyKcnzlzc=
X-Received: by 2002:a9d:6d0a:: with SMTP id o10mr19982946otp.221.1569241181458; 
 Mon, 23 Sep 2019 05:19:41 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_5D6D8ED31E83C5675AB8AA3C@qq.com>
 <tencent_6E390A001F25D33F67930C37@qq.com>
In-Reply-To: <tencent_6E390A001F25D33F67930C37@qq.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Sep 2019 13:19:30 +0100
Message-ID: <CAFEAcA98asDEZru6ht3PVN6g9duXnTTEHsuUzckFHZmV3+sqXw@mail.gmail.com>
Subject: Re: illegal hardware instruction during MIPS-I ELF linux user
 emulation
To: Libo Zhou <zhlb29@foxmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::332
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
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 23 Sep 2019 at 13:08, Libo Zhou <zhlb29@foxmail.com> wrote:
>
> Any help guys? Is there a way to look at the ELF binary code to see if th=
e instructions have invalid encoding scheme? Since I used a custom compiler=
 that claims to have MIPS-I instructions. I doubt it though because 'file' =
command gives a reasonable output saying it surely is MIPS-I.

'file' just looks at the header on the file to see what it
claims to be. It doesn't look through the rest of the file
to check what actual instructions the compiler emitted.
You can use 'objdump' if you want to disassemble a file.

I would start by using the QEMU gdbstub to connect a
MIPS-aware gdb. Then when the SIGILL arrives you can see
what instruction the guest program was trying to execute.

thanks
-- PMM

