Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0145CC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 10:32:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C619D2073E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 10:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cplzl+pR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C619D2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsOQ1-0003eW-0U
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 06:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jsOOs-000326-Ip
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 06:31:02 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f]:40523)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jsOOq-0008Sf-Oa
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 06:31:02 -0400
Received: by mail-lj1-x22f.google.com with SMTP id n23so44686822ljh.7
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 03:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=AmHrUJg2SO9n6ZkB1Wlb9OB7sfcuSYUhdnDYFGtNcJA=;
 b=Cplzl+pRaEpD2uXFpshITIXvpX5j5hz0j+o0pkjIEFE3ml/nphhL74aDDX83uvhCWf
 44OnVlqShqbeocTziTdU4+TJWliWOUjWxGmuaA7WZBjkNrynTwGQj36B+jwA9qHA8bMA
 //huF0Qe7lxKCo3GulaKmHfhtlTf3RtvsC7IRML1o1PvEzesAtpcrd1OdsER4pByDGx0
 kDD4vTKGPaLucOOLVKvjLBdtioU/HObXSFDS5ld+NZ++0ekUpyzeAc8rhP+unk3ge3E/
 gcHt4dYAmhJlp2h21fJXfBTQTUa/SfqlJs8cnvIRM5+M3BrGJR+Q6ZKAwvjuBZZi+eqP
 e+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=AmHrUJg2SO9n6ZkB1Wlb9OB7sfcuSYUhdnDYFGtNcJA=;
 b=pXbVYafaxZ3ZSYeyx5PbDt4KEp7PzTVWzBAC1RVzSPcpxCbsWIhxwfuJIY4F0cGH5c
 PXVVqpvlSl/yYydt1qp5diWq69V83iOO6TLFoFl9Cj7S4lRlhPIx9Cn8KqjzmYyAPPde
 9aAvHolDa+feynZdl/L7UfYDL4JdErQMbEb8kC97yOMcIuX4/3wxQs6Cm5bJcKKjMRB7
 yeKfoUt7DXSU5bTZJd4RqELFTwuvPRpWqLfUOXFa/h4wkPildZr1YcXIs6JiXqv1SePk
 W/+wDa3irJN8ZaPSamePASHGLrVXTcZInS4a5wEoK3JEFS0He0PQgrnHZsGmbswDTBEC
 ERZQ==
X-Gm-Message-State: AOAM5317Y2tej2c6KAdg+BxN4nWzoUmIS+Y5ApodRFVh1ayYhaODC45B
 nplr3rubBnsPf5SDxYbShNW38YRsL169/OP5Qsnm1H7TlKM=
X-Google-Smtp-Source: ABdhPJw/Cc4hbWeZs5dl9dMPIw0umt2zFB+BB6eYMAZipRpXhexRNM0oBUivUVNBBmuuNP5YEuXhEzrP7E8r33OrG3Y=
X-Received: by 2002:a2e:a30f:: with SMTP id l15mr26859228lje.228.1594031458155; 
 Mon, 06 Jul 2020 03:30:58 -0700 (PDT)
MIME-Version: 1.0
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Date: Mon, 6 Jul 2020 12:30:00 +0200
Message-ID: <CALTWKrUE3r4+BMKQY1YX6zMOriKcd_5QNyqGBk5Z_S5ZZPs+4w@mail.gmail.com>
Subject: [REPORT] [GSoC - TCG Continuous Benchmarking] [#3] QEMU 5.0 and
 5.1-pre-soft-freeze Dissect Comparison
To: QEMU Developers <qemu-devel@nongnu.org>, 
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, 
 Richard Henderson <rth@twiddle.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-lj1-x22f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

The third report of the TCG Continuous Benchmarking series utilizes
the tools presented in the previous report for comparing the
performance of 17 different targets across two versions of QEMU. The
two versions addressed are 5.0 and 5.1-pre-soft-freeze (current state
of QEMU).

After summarizing the results, the report utilizes the KCachegrind
tool and dives into the analysis of why all three PowerPC targets
(ppc, ppc64, ppc64le) had a performance degradation between the two
QEMU versions.

Report link:
https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/QEMU-5.0-and-5.1-pre-soft-freeze-Dissect-Comparison/

Previous reports:
Report 1 - Measuring Basic Performance Metrics of QEMU:
https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg06692.html
Report 2 - Dissecting QEMU Into Three Main Parts:
https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg09441.html

Best regards,
Ahmed Karaman

