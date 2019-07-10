Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374CAC74A35
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 17:53:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2E5E20844
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 17:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rilG+KSF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2E5E20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlGmo-0003Zj-4V
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 13:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57722)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lucienmp.qemu@gmail.com>) id 1hlGkA-0001jB-72
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 13:51:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lucienmp.qemu@gmail.com>) id 1hlGk9-0007QQ-0f
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 13:51:02 -0400
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830]:36126)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lucienmp.qemu@gmail.com>)
 id 1hlGk7-0007Ef-Ff
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 13:51:00 -0400
Received: by mail-qt1-x830.google.com with SMTP id z4so3391198qtc.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 10:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8W/Y05Li8VFvO1Ks+KVGlZBRIMg+6RO3kbPzP3ielB8=;
 b=rilG+KSFoZZEmBz974V9eC0mwzz9LcMtBnlCpAdZfvzC5glj0W0gTNpxRosspUURno
 2g/Q1K2C6xO+yuW5+n5nSJ8m39xKYKteHplV6H2fLCSkaqLZpWeO1blSC3c3n21KSctJ
 3Bjs5gRqAtY1Ojrn/mdm43L2/KWsKUlvKW6rRZmy/dDqN1R0HDv0lQCrr3erXI9x2qx0
 M7dcLcTSR4B3Q8bDPAflyLhM5VN7pJjLf3KwbNrhwULUT9cvy4HPWY8vSDu2qwIVAM0a
 R95utWi2v5tz4UH/trqj2cHvV8/jI9QJ55rDzALazDrc2f+NuLCVROSsc0KvfIj141I+
 5CQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8W/Y05Li8VFvO1Ks+KVGlZBRIMg+6RO3kbPzP3ielB8=;
 b=U2iwVtaC6Jq18Io/gHKAmPtBGba5yWLkx0ktKZnhemZlg/vHkatRCaeGyRnxtQycCK
 tlZmRezCh/pnFZ+J7MkEuBpdsAUIylMxEPYANd906aKdx0NRCsPT11FsxMHT8JKqT0Sl
 poFS5FEn2WoCEmGGx6t0vOQXMLj8CiQn0DMFBCEcMZk418J+HaDqGMUvW3L84ZfAURv7
 Zk014NhFAvCRytItJ2A/9J4/Ue+rHnbnfcfCGLZYEdhHtm3/UY9M8F0hwoQBsnaOApzQ
 Gwjnw8CIIdUaIc8nZobUgjaLznWw+uPEK4OAltWILyiM4pMS4yoNhjGhRgRhK4fi6VEp
 90HQ==
X-Gm-Message-State: APjAAAXiQibBCmWJddkprpi1oifzxGo4DDOO85YbyBS6Yq6ycv6CrQBw
 8vrA6CPgLJzgwxqxbLWJn/JAzhf9KHKHj2GNJbw=
X-Google-Smtp-Source: APXvYqzqOqMdxNNKuxM72jLztR3cJtg9//zbL7WQCsqxZ2wVq0yV/kbw+BRLv8AGBYKflSt5b4w0Bb0ybtVqPEkcHuc=
X-Received: by 2002:aed:3535:: with SMTP id a50mr25964038qte.237.1562781056712; 
 Wed, 10 Jul 2019 10:50:56 -0700 (PDT)
MIME-Version: 1.0
References: <2136180936.260219.1561641583358.ref@mail.yahoo.com>
 <2136180936.260219.1561641583358@mail.yahoo.com>
 <1079763171.281101.1561641752988@mail.yahoo.com>
 <e4c1fbc4-3e43-5df4-a17c-527d98d9763c@linaro.org>
 <20190628002713.GA19257@localhost.localdomain>
 <eadb57ae-256d-0bb7-5988-f493662a5caf@linaro.org>
 <20190628155030.GA34320@localhost.localdomain>
 <ea16a81c-5b94-8dd0-8339-2bd82733aed2@linaro.org>
 <20190629163621.GA111724@localhost.localdomain>
 <CAFEAcA9sfNisAz-zAZAx=ZNFmsEpP0Ec2DeRedtZSd9KQ4fvNA@mail.gmail.com>
 <1399218244.1210557.1561982640362@mail.yahoo.com>
 <CAFEAcA-0vGg_1nfkbq+o6JwoDsRyP=6mnv6ADi-atV0ROX269Q@mail.gmail.com>
 <CALvKS=GvAkNr3OKZzjGoTGG_Eys76zjcjodiN4hKXjFM5B0a4A@mail.gmail.com>
 <d9e5602c-bb33-1812-ebc2-b533e9dd5f25@linaro.org>
In-Reply-To: <d9e5602c-bb33-1812-ebc2-b533e9dd5f25@linaro.org>
From: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
Date: Thu, 11 Jul 2019 02:50:47 +0900
Message-ID: <CALvKS=EbuQOvRx+bmRnqCD6JuHK87dnkx00EiH--aXYWuNF0VQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::830
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] RFC: Why does target/m68k RTE insn. use
 gen_exception
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Lucien Anti-Spam <lucienmp_antispam@yahoo.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> On Wed, Jul 10, 2019 at 4:04 AM Richard Henderson <
richard.henderson@linaro.org> wrote:

> > I did have a suggestion.  It was fairly detailed.
> > https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg06522.html
>
> Your solution is elegant at about 10 lines that return getl_ilen(pc), but
it seems the s390 has a far simpler
instruction word format than the m68k.

However then that got me to thinking, it seems that we can call a portion
of the TCG system to disassemble a single instruction.
    TranslationBlock tb;
    tb.pc = env->pc;
    gen_intermediate_code(cs, &tb, /* max isn */ 1);
    int ilen = tb.size;
    printf( "PC: %08x sz:%08x\n", env->pc, tb, ilen ) ;

I am very new to TCG, so it does seem there is a lot of code in the
translator_loop that appears to be interacting with the CPU model/state.
Should I be worried about this, or is this a safe function to call outside
of the translator core proper?
(if everyone is too busy I can dig by myself but I think its going to take
some time)

Cheers,
Luc
