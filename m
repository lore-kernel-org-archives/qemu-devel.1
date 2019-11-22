Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA53AC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 18:07:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 769592071B
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 18:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWy4EwtB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 769592071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYDL9-0000Z7-4z
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 13:07:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55665)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iYCGy-0003Bg-N5
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:59:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iYCGx-0000YY-CW
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:59:08 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:39557)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iYCGw-0000Xp-MK
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:59:06 -0500
Received: by mail-oi1-x243.google.com with SMTP id v138so7081064oif.6
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 08:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=soYy6cOiyZowYkmKSqj+4/j+SB6o+oyWOOv+w7Q+wIY=;
 b=lWy4EwtBBAs79M+mJG0ygf92BGsl9+pCR5nfU/EkWhAOWNvtQd7Myk4iSVqFkDRE8a
 BUGld+1vm69FAgS84VRkOaxOgAKCP9cHItyoT4/YnXSlEGRtXP9f6CPTdd/qoLm3v1rr
 HM9Hu7AvWh4Li/qa1dVja5jlKk8GT3t5+RDkPq694v3XH3zXqsRBSrsXDhAXtqp/J41a
 ga2zmqjE0pYXwVq3zOQ3CCNh+S3Lcsp8ET2DTiYlMgWbtxmojWvAeLVA8Uqiyck9S4OG
 i8HsNbtTGZY/VfFRJIrmPN3OxOR96tToKd1/YT2bIFcs3adsilrK2DfFzybbp0/vaC4Z
 FtnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=soYy6cOiyZowYkmKSqj+4/j+SB6o+oyWOOv+w7Q+wIY=;
 b=o7obTDwSqpEnW4HnhuadjzsKvPjRQEcOpjMfKySE9oLpXwxIa5mU2WA266tLeqVVXy
 iOkiZQ2+q0ERRl4g8ymEud2SdH1qQO5mZtf5oE5QLoWi4eoeNv0E3pCnINvCSTKmJPRi
 j6YclzJyKK2MSad03jY+DEb5nOi7OStjEeM2CP3xPfJYKP9Toz7dZoQRd7bVXoCyP5Rl
 JS0zTasGJVEqIlFZjwpdlbiHpSTFWCYH2nWTm9iFPgKSBVCPvyyJgozdO/sMd3IAt/UO
 qwrJwX05lsBx0ggSWXl6ZPgLm/sR8xsUWf2DkujTgM05CgKQX8XyaZT+0JlTOmIlpSTT
 Q3TQ==
X-Gm-Message-State: APjAAAUI2z1isFw3HLi3t+ILMpNEnCoLj3Ae0yCpp0v/I+qxeVJCdi43
 Y1o+7BmYr8fzCmVPz5xn2SJV/Bg25Za5qSWN1HU=
X-Google-Smtp-Source: APXvYqxopNkBY0eQpFz3DQfGWzSUVATkIP3Gnd1eyzlAo4Cu6Em1iZVaO8zk9E3FLwgIUf5osxmScWILLIQ4zqjngNw=
X-Received: by 2002:aca:5786:: with SMTP id l128mr13195669oib.53.1574441944249; 
 Fri, 22 Nov 2019 08:59:04 -0800 (PST)
MIME-Version: 1.0
References: <20191029212430.20617-1-mrolnik@gmail.com>
 <20191029212430.20617-2-mrolnik@gmail.com>
In-Reply-To: <20191029212430.20617-2-mrolnik@gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 22 Nov 2019 17:58:53 +0100
Message-ID: <CAL1e-=hrm_FAuxaAuR=GJ1viE6MS-OP62i-h8kc5_ZJuADk96w@mail.gmail.com>
Subject: Re: [PATCH v35 01/13] target/avr: Add outward facing interfaces and
 core CPU logic
To: Michael Rolnik <mrolnik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Thomas Huth <thuth@redhat.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> +/* Number of CPU registers */
> +#define NO_CPU_REGISTERS 32
> +/* Number of IO registers accessible by ld/st/in/out */
> +#define NO_IO_REGISTERS 64

Hi again, Michael. :)

May I ask you to do a global replace of names of these two constants
to CPU_REGISTERS_COUNT / IO_REGISTERS_COUNT or NUMBER_OF_CPU_REGISTERS
/ NUMBER_OF_IO_REGISTERS, or whatever else you find suitable (the
reason being "NO_" is visually/perceptually very confusing - many
readers would have first impression that it means a negative ("no"),
not a "number of" as you, for sure, want.

Thanks,
Aleksandar

