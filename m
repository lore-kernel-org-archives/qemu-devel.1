Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18DDC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 10:31:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 811DB20719
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 10:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvCQwK7H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 811DB20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2XkF-0003JR-EQ
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 06:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1k2XjO-0002nD-Pp
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 06:30:10 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:46383)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1k2XjN-0007LU-34
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 06:30:10 -0400
Received: by mail-lj1-x243.google.com with SMTP id h19so39047527ljg.13
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 03:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=tyN3J3z8CMEzetcW4d4uVlZeQXSIBOgxsIE9NC+CUD0=;
 b=SvCQwK7HTyXwhV5fWCeoGcHTFHKU+9UQAy+pebzPeqNgBsO+KnUqRwU48zT65Lukxp
 kWAw2Wk52Up6SADmKZ5RvloEvZFc31gLraJR59YiRVN+7VFaEDqCBd2GvU5Q4R6t2Bmg
 fghO5MjdiSvPgcCh2DmA48WEKFSMCm7SRwGFSMJOD3X3WPsjdqfUA0sje5yi6xGoQIJ4
 bHzw7T4PP7XLA0pHPRQrt3hBOFHwDipH+/RQgp3WG0+znJ9S7XfJ8tI6pfl/q88k84Mm
 LKVlXXivm4zjeDXelxK+IXZxdT0x/TSvSDzZziXpDP48A3K1nvJyjOpJ4BHsa0ww8yMh
 JAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=tyN3J3z8CMEzetcW4d4uVlZeQXSIBOgxsIE9NC+CUD0=;
 b=gHzCICgx1Cg/wlkS+4TGpvcp9K4ZjGWVK6FdVAidassJ+g+JpN8Vj/5MIsaP9M5Mn1
 VPsGwgiLH/u/+/ifmDZA2/WbaQO2+Mxr/jGXHg2pkMiNON3190mMAnVg0xg0Zt1QWLjz
 Hku1MJfn8kKqYBHtz/Z5CehPXAz8A6Zg0ydqp3D7MLmdhYPPJ3+DLps5kyK6rLtCseg8
 FWlG/c/fClP9os43tHycBwI27zcQeGYuIAZdAZoFha6yUxtkMMoawE2JmtvubLfWKq1/
 OfsPGpT3ZCUr9hy9g6imqJ3uDH9VZn/Ew0mbIybsPR3hd3hCWRgxRBllaprg/u2xXcdf
 cp6A==
X-Gm-Message-State: AOAM532YSgpMODzXJh2unJ4oliLWxXO/njgvQcpfaDnzjQL/E8k787/G
 lwmtLoNaWV08SUtoh1K0SymvrLtfv9O8Yht5qeilow==
X-Google-Smtp-Source: ABdhPJyRrp7sPPf1XP19M4UYavYiN/r8sRRE4XJUHy0YE9cRxzqkF9csva9Cr4TCXs6a4WO0KOUEGchLIvocA8fhz/Y=
X-Received: by 2002:a2e:9050:: with SMTP id n16mr7694633ljg.228.1596450606079; 
 Mon, 03 Aug 2020 03:30:06 -0700 (PDT)
MIME-Version: 1.0
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Date: Mon, 3 Aug 2020 12:30:00 +0200
Message-ID: <CALTWKrX7bX-RotBXL_DDC0aqX7u0QBeJY4DJvrrh6w+3bGDKPQ@mail.gmail.com>
Subject: [REPORT] [GSoC - TCG Continuous Benchmarking] [#7] Measuring QEMU
 Emulation Efficiency
To: QEMU Developers <qemu-devel@nongnu.org>, 
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, 
 Richard Henderson <rth@twiddle.net>, luoyonggang@gmail.com,
 John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-lj1-x243.google.com
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

Hi everyone,

The seventh report of the TCG Continuous Benchmarking series presents
a method for measuring the TCG emulation efficiency of QEMU for
seventeen different targets.

This is achieved by comparing the number of guest instructions
(running the program natively on the target) and the number of QEMU
instructions (running the program through QEMU). For each target, the
ratio between these two numbers presents a rough estimation of the
emulation efficiency for that target.

It's clearly shown in the report that the emulation efficiency for a
given target depends on the type of the program being emulated, for
that reason, six different benchmark programs are used to provide a
set of diverse workloads.

Report link:
https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/Measuring-QEMU-Emulation-Efficiency/

Previous reports:
Report 1 - Measuring Basic Performance Metrics of QEMU:
https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg06692.html
Report 2 - Dissecting QEMU Into Three Main Parts:
https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg09441.html
Report 3 - QEMU 5.0 and 5.1-pre-soft-freeze Dissect Comparison:
https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg01978.html
Report 4 - Listing QEMU Helpers and Function Callees:
https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg04227.html
Report 5 - Finding Commits Affecting QEMU Performance:
https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg05769.html
Report 6 - Performance Comparison of Two QEMU Builds:
https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg07389.html

Best regards,
Ahmed Karaman

