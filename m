Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B25C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 10:31:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 880F220B1F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 10:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="spFS9/5G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 880F220B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxT4y-0001kT-Lc
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 06:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jxT4J-0001JD-VE
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 06:30:47 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234]:43396)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jxT4I-0004EC-74
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 06:30:47 -0400
Received: by mail-lj1-x234.google.com with SMTP id f5so19642346ljj.10
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 03:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=wu3CSW3NA8ZZ28jxQFNtE3qGyEqFG5uWciX5osl5i0U=;
 b=spFS9/5G1Ay4s/D0mhUhJ1KqcuMl7eevc9uDwuwsQrLbOzB5VKcTLMYaHJcl8yhuS6
 pT++RObltbT/wfmJe1oae1lUFrmPAhcrO8sQEbt9SLS3oiclLbng8DYXSYUmG0jSxkEL
 fNUWetavMlTZUjavD/WAXbrX8yyInaTv5tt3Ti5yGcmZN3S3HtZgGOi+yzHY4y+MOiBx
 axJKKhgvn9mF+f5MVP7CPRizsXoE+y6n6ymksPPGSoJTkjuIEc1JIGMSWBtVsZaC8eAf
 hG1Yd3V3s//GF1vpeby8QGs+M/FS79CCY6JZBbAXc/cEnwlfDkCNdbO3kSeFN4Yhw9A6
 nnKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=wu3CSW3NA8ZZ28jxQFNtE3qGyEqFG5uWciX5osl5i0U=;
 b=X6d4d5EiHza1UwXCoh5t1G+Ce+CWsAtUrlMhqd0zDjGP2yIfoTLg5ehwiMabTlY97J
 33DzbDhTctWHBH7rrjsE3noep6hoLMr/ZirdDmgp4gdV5InJkJWYU8m69iESTb/M+YJG
 RPf/vxCem35ll8WUCS/pEjlu6pkOEoFz/h6jz7vHpYPpSA7AXp1yzsFEqtRBhaOzBEDn
 9ikVAtYeoo07vHyMn5iJJEZ4afpqbmouJT6Pow0bLBwP7IEPQx6+2dO+3CW1yo5OHnSJ
 HW0bDRYAG4AFDy/Nis7i2VpiP4L0u/gaVSaU195GdiUL2r3hSEWj/c78rBBg/Yv5oKsW
 bC0Q==
X-Gm-Message-State: AOAM533fCwcy2IQW+tCLlh0T/3hI75NuwCgvJhKo9//UbxbEY0Dkwo1x
 ER7wEIO/vFGCkBTyyPQ0x504O5TMsYYMj8zpb1/KhzgLPAc=
X-Google-Smtp-Source: ABdhPJwPUUnJEXNPDljgDuUThubUT6M2xaa8OuWLBJh95s+0E5cOHwZErjuL0IBOkkhqz+Br2Sj7iToistU0lGkxeWc=
X-Received: by 2002:a2e:850b:: with SMTP id j11mr10797138lji.30.1595241043744; 
 Mon, 20 Jul 2020 03:30:43 -0700 (PDT)
MIME-Version: 1.0
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Date: Mon, 20 Jul 2020 12:30:00 +0200
Message-ID: <CALTWKrVvaA7HWxsHNS+tCygLu+x4FCjSZn=+AP0hnEWOCp8vww@mail.gmail.com>
Subject: [REPORT] [GSoC - TCG Continuous Benchmarking] [#5] Finding Commits
 Affecting QEMU Performance
To: QEMU Developers <qemu-devel@nongnu.org>, 
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, 
 Richard Henderson <rth@twiddle.net>, luoyonggang@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-lj1-x234.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

The fifth report of the TCG Continuous Benchmarking project concludes
a mini-series of three reports that dealt with the performance
comparison and analysis of QEMU 5.0 and 5.1-pre-soft-freeze.

The report presents a new Python script that utilizes "git bisect" for
running a binary search within a specified range of commits to
automatically detect the commit causing a performance improvement or
degradation.

The new script is then used to find the commit introducing the PowerPC
performance degradation as well as that introducing the performance
improvement in MIPS. The results obtained for both commits proves the
correctness of the conclusions and analyses presented in the two
previous reports.

Report link:
https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/Finding-Commits-Affecting-QEMU-Performance/

Previous reports:
Report 1 - Measuring Basic Performance Metrics of QEMU:
https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg06692.html
Report 2 - Dissecting QEMU Into Three Main Parts:
https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg09441.html
Report 3 - QEMU 5.0 and 5.1-pre-soft-freeze Dissect Comparison:
https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg01978.html
Report 4 - Listing QEMU Helpers and Function Callees:
https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg04227.html

Best regards,
Ahmed Karaman

