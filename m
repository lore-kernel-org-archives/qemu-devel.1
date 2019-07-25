Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13786C76190
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 17:53:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB5C0229F3
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 17:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uhriwS/p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB5C0229F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqhvj-0004YY-4P
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 13:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33984)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mrolnik@gmail.com>) id 1hqhvV-000492-CS
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 13:53:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1hqhvT-00029v-QM
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 13:53:13 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:36493)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1hqhvT-00028N-GB
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 13:53:11 -0400
Received: by mail-qk1-x741.google.com with SMTP id g18so37087973qkl.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 10:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7nHMDdMw4iqP112wV+Uy9WlwnW7HGNatTt555uYKeDk=;
 b=uhriwS/pgRq7l4E9Q2eEB5odVF2/Bzky4NWXQ0T17db9/miGpgiL8ZwAMYaSS9rVIj
 3qC5Q/e+Z9zYKjzPnuj4q0dR6pIR7ThsEN14JythKNH6jfkBCYMPL7Kqltvec0aowpoM
 GIPN36Xolkpf139/pA/46IQvGvAiog7qdZIYnwAPkF9c21gIy6yx8fS38aojh3thPsiy
 1mweJSYGII1QVLeupHSH1m+kGEEYsoSLUVgRcMSC0F9hf6CMz7108TiMPFhL7fmqs7Lm
 PhpIL6oETE5L8Br8D07NyLtj9KWHQ7q3QdUfz5ngNMqJ+NziyCrFwBiAyVyXpj1I8xeJ
 gWmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7nHMDdMw4iqP112wV+Uy9WlwnW7HGNatTt555uYKeDk=;
 b=lKDcggvOxZTjn5dLx7rXfzsKxDkqPNsFG27WgCqgBdC6nFLIQBqFdEphsF7Z0xzeAJ
 DrHNOnAvyd+MYR6avoveqIonj/AiwXWjrPCuVQ+Wvgq4xxWoZQRF0g0sREM07oOK4tPx
 8RgWaOW3VYb/oEeqzZ+Fljxb1HbcuyiujC/XWLIRExX3x/RyevRRPXoB15k68EPB/2Ci
 2umY8UriOcbeZk0gcYu8W/OG3nYbUNSUCJVvhugJWFZdKFYsBhTRmVff5j8puJDfPvk1
 FhlEHiEt8K9bg9kZQnTvRcBXXSa2jy82/UhEIMM3KnOx2Y4j6hHIFrjZPrp+hlSTVNl/
 BnCA==
X-Gm-Message-State: APjAAAXjgVFSRHGbTmFd+kD569ExZSWZXQs7SQXSxM5AIgQ5rDltyFC6
 AnnGZC5GcjvNQ8JRBJYNSkpu3jxmDJK/IXZ5pwI=
X-Google-Smtp-Source: APXvYqwi1JMHidgJJdI1fW0uqmA6orC+iv0B6Xa1ea/zsm6TWD91Ltm8JQPyMIdzKC1MovcJPZ31Rm9z6KXje6XIwPE=
X-Received: by 2002:a37:72c5:: with SMTP id
 n188mr53684241qkc.181.1564077189604; 
 Thu, 25 Jul 2019 10:53:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190719082647.18113-1-mrolnik@gmail.com>
 <20190719082647.18113-6-mrolnik@gmail.com>
 <000c01d542cf$d8476a00$88d63e00$@ru>
In-Reply-To: <000c01d542cf$d8476a00$88d63e00$@ru>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Thu, 25 Jul 2019 20:52:33 +0300
Message-ID: <CAK4993g3sX5QEq-qXg_1s9+us3pBW5RDYFnLLiJe7=2OUxpjtQ@mail.gmail.com>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v27 5/8] target/avr: Add limited support
 for USART and 16 bit timer peripherals
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Sarah Harris <S.E.Harris@kent.ac.uk>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Pavel.

Please see my answers below.

On Thu, Jul 25, 2019 at 1:00 PM Pavel Dovgalyuk <dovgaluk@ispras.ru> wrote:

> > From: Qemu-devel [mailto:qemu-devel-bounces+patchwork-qemu-
> > devel=patchwork.kernel.org@nongnu.org] On Behalf Of Michael Rolnik
> > From: Sarah Harris <S.E.Harris@kent.ac.uk>
> >
> > These were designed to facilitate testing but should provide enough
> function to be useful in
> > other contexts.
>
> USART is very useful for testing, but to which model of AVR is belongs?
> We also started implementation of USART and other devices in our
> internship program,
> using prior version of your patches.
> There were other register addresses for the registers and some of them
> even intersect
> making read/write logic more complex (we looked at Atmega8).
>

This is a question for Sara as she built it. (I think it was ATmega2560)


>
> You also mix the board and the SoC into one file, making hardware-on-chip
> harder to reuse.
>
> I think that the structure can be revised in the following way:
> Board -> SoC -> Devices
>
> Board includes SoC, loads the firmware, and adds some external peripheral
> devices, if needed.
>
> SoC includes embedded peripherals. It dispatches IO memory accesses and
> passes them
> to the devices. In this case you can have different register addresses for
> different SoCs, but
> the embedded device emulation code can be mostly the same for simple
> devices like USART.
>
> > Only a subset of the functions of each peripheral is implemented, mainly
> due to the lack of a
> > standard way to handle electrical connections (like GPIO pins).
>
You are right.

>
> We did not got too much results, you can check for our changes here:
> https://github.com/Dovgalyuk/qemu/tree/avr8
>
> But we can help you in development of better version of the patches and
> split the work
> for making this platform more usable.
>

Gladly.
You are welcome.
My initial intent was to provide CPU only and I hoped that others will
model the devices.

*Richard, Phil & all,*
what would be the right mechanism / procedure to split the work?


>
> Pavel Dovgalyuk
>
>

-- 
Best Regards,
Michael Rolnik
