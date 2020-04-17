Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DF2C352BE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 10:53:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EE5721D94
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 10:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DuCPzRyb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EE5721D94
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPOcH-0005uw-K2
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 06:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41513)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <npiggin@gmail.com>) id 1jPObh-0005PO-3C
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 06:52:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1jPObg-0005ce-1j
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 06:52:25 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:32801)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1jPObf-0005bz-T1; Fri, 17 Apr 2020 06:52:24 -0400
Received: by mail-pf1-x444.google.com with SMTP id c138so912934pfc.0;
 Fri, 17 Apr 2020 03:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=TGY77s+Ktj7oo2VS8jtKIHmxK3JgyufgXnXmwZxG/tE=;
 b=DuCPzRybsugHxhw0rPLo69B+K0jdETrUk3x4734TgXVRgxEKvtPEeRcxjIUKIgESvm
 PgSwymnXqbnctn/eRSxRNmP8VpE0hPCqgm9kiat1sQMVDUXSYmHQsxXQ3u4Xp/Oey6YW
 vVfP/1siwq8VZ7NrW32cHsyCGZP1rIXPRdr6SNvKmpE9TyJjVJZ6JNEo5qWcVL7B8AwU
 P+ubWWvQyi8o6cHHEr6zlzii4fkPE/irKy3af4CApLzJanlG09MAWmXUmfw6u31f7ocm
 nllMKO7/avt2VqL0lvm0gP7ne1Am0ZFp6RcwzMClF1Cj7/OqCK/6IJZlydL0gKdpFCGs
 fU1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=TGY77s+Ktj7oo2VS8jtKIHmxK3JgyufgXnXmwZxG/tE=;
 b=FMm+xupdCOPBhiSiB/KUaBbbw+YhyMilGT140dddizS1bV3+LaZydA5kz6sPHDBNui
 YGOIRFE5nHTcgRR2fMasPKi7YY/dHszeUoqRuJ8omDwYaKXxtmA64OLDeYu3NXM+NGX8
 RndnapYz+hllcfLiafRIKlcHU9k40Wf7Dea/Z/thfjWUwG6nzlfSWucQRDGIqsG9XBQ8
 Zn7U3VlIveXJvccr4NgCEi9fO9/1kLv82tVr8ZrllpQGPt/ELlm1wx4l16JWfG0WN7ux
 c5XVR9gMtwAis6zqpCsGfWJSKpBKjRCOz+pkkzRgM6Jly3Yxt5ef67amEMcpXXl6/b2m
 z8HQ==
X-Gm-Message-State: AGi0PuanOmQoXqukb8PDZp4LNkyO8PwkQBNgkGg1gD/D0kkaR8ceuU3T
 7oQmzNM8WJ5pDJ65kqQKws8=
X-Google-Smtp-Source: APiQypLW2vYw4jD9Yin/BglQSCAo1WtRO1Ckofm+vBAIO2enkiafp9wN5dBfvKumYsdvr/aIGHiWdw==
X-Received: by 2002:a63:a55b:: with SMTP id r27mr2459077pgu.141.1587120742261; 
 Fri, 17 Apr 2020 03:52:22 -0700 (PDT)
Received: from localhost ([203.87.15.194])
 by smtp.gmail.com with ESMTPSA id i8sm1086551pfq.126.2020.04.17.03.52.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2020 03:52:21 -0700 (PDT)
Date: Fri, 17 Apr 2020 20:51:58 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH-for-5.0?] target/ppc: Fix TCG temporary leaks in
 gen_slbia()
To: Philippe =?iso-8859-1?q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200417090749.14310-1-f4bug@amsat.org>
In-Reply-To: <20200417090749.14310-1-f4bug@amsat.org>
MIME-Version: 1.0
Message-Id: <1587120086.g7mzwaexlz.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Dennis Clarke <dclarke@blastwave.org>,
 =?iso-8859-1?q?C=E9dric?= Le Goater <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Excerpts from Philippe Mathieu-Daud=C3=A9's message of April 17, 2020 7:07 =
pm:
> This fixes:
>=20
>   $ qemu-system-ppc64 \
>   -machine pseries-4.1 -cpu power9 \
>   -smp 4 -m 12G -accel tcg ...
>   ...
>   Quiescing Open Firmware ...
>   Booting Linux via __start() @ 0x0000000002000000 ...
>   Opcode 1f 12 0f 00 (7ce003e4) leaked temporaries
>   Opcode 1f 12 0f 00 (7ce003e4) leaked temporaries
>   Opcode 1f 12 0f 00 (7ce003e4) leaked temporaries
>=20
> [*] https://www.mail-archive.com/qemu-discuss@nongnu.org/msg05400.html
>=20
> Fixes: 0418bf78fe8 ("Fix ISA v3.0 (POWER9) slbia implementation")
> Reported-by: Dennis Clarke <dclarke@blastwave.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Thank you, brown bag required. Looks like I should be testing
this stuff with --enable-debug, sorry I didn't realise it.

Thanks,
Nick

