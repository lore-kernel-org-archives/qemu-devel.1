Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A65CC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 10:30:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66DEC206FA
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 10:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X77MsG92"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66DEC206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7cPk-000125-LH
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 06:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1k7cP3-0000Yz-RG
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 06:30:09 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d]:41178)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1k7cP1-0000LI-T9
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 06:30:09 -0400
Received: by mail-lj1-x22d.google.com with SMTP id f26so16855826ljc.8
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 03:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=bIWKDS93H3R/6z5/h/E/DNbwzUNbGNv/dIbC01dC6Qg=;
 b=X77MsG92Vn1b1+J5ztk239lOicSQERYwj019cr2xa4OdpnaUyRM1q9WMXsCpsOA0mq
 NKHLOdpOryEixmU1lp4qOCuKvEajw2SsuOcDg6zmvX4yTNElm0+v7FU6KDBzYVKDfG8d
 l9BEfWpWYdNWhSjFv5eYjEMRl8pErvM6WxuQ9M/CMlwoHPGbG5KPn4vkmiHo48fM1DFM
 IYyCAzinJz08O4ce2E2fp794B6YRSI5XOhHb7pRlz+RTfC/Q0U0Ro9bzvIF+YgLKZaLr
 eGWbgp9hVvIPcpJsD8QECpYrSQAsvCLPcLWHhS09US/CLlzZ7A8rvo6MifXMiu5VToxt
 no7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=bIWKDS93H3R/6z5/h/E/DNbwzUNbGNv/dIbC01dC6Qg=;
 b=HNaoRumcXx1EZwIPlkY7fSqKYkOZaN1EX+IsLZBLYUODcX53mmbACKx5Zxd7K96fEz
 JZt3Hm/k/zYuhI3/Uqi7zBb2tR/Qj9D078lxKKtekh0ATmbdqWgAuiaub4JdjqXZiCyk
 BWIHnLNyQHSErn4yFqDLQbfcYzntI2+rszy4+pvVKvXRgx69EjA/vGTQwYpxAnQWDJSW
 rdfNMcrkUyeAcFv2zGkbTHnKeFAwtppv2ylw7ytKzgNc02CHLAh3fCjw8HRH56bRgr18
 RzJSoB7gptuDpwVViV3tPhYSTbvBCFRLb1eUr7ry/zyCd7vwVI41EOZEgTAmRnhMT7aN
 Q5kQ==
X-Gm-Message-State: AOAM532msGgW5+arB3M2tTC4sMXUK21qp2vvIqDD6yAH6OplhDW8xeji
 RKjaPy4y8k1HXSD91CFUM/9y3x000CbysmNNzNhOMZl1
X-Google-Smtp-Source: ABdhPJzQNtnRtYFUooHmcqwtgZntzQq0pDa5cEJDiALDZBmZ+55CiDVE+0IePBpcIGjTgD6Ud0Gg6+vB0t3yxxdXSJQ=
X-Received: by 2002:a2e:908a:: with SMTP id l10mr6744918ljg.409.1597660204429; 
 Mon, 17 Aug 2020 03:30:04 -0700 (PDT)
MIME-Version: 1.0
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Date: Mon, 17 Aug 2020 12:30:00 +0200
Message-ID: <CALTWKrV=oppHwqQaybT0uxhQhXGRn=RkfZGE+DyUAi5_w6ZRvw@mail.gmail.com>
Subject: [REPORT] [GSoC - TCG Continuous Benchmarking] [#8] QEMU Nightly
 Performance Tests
To: QEMU Developers <qemu-devel@nongnu.org>, 
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, 
 Richard Henderson <rth@twiddle.net>, luoyonggang@gmail.com,
 John Snow <jsnow@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000f4f4bb05ad1040d5"
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-lj1-x22d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000f4f4bb05ad1040d5
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

QEMU currently lacks a system for measuring the performance of targets
automatically. The previous reports introduced different tools and
methods for locating performance regressions, but all of them had to
be manually executed by the user when needed.

This report devises a new nightly tests system that runs automatically
each night. After the execution is completed, it sends a report to the
QEMU mailing list with the performance measurements of seventeen
different QEMU targets, and how these measurements compare to
previously obtained ones.

Report link:
https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/QEMU-Nightly-Performance-Tests/

The system is now scheduled to execute daily, and starting from
tonight, the results will be sent to the mailing list.

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
Report 7 - Measuring QEMU Emulation Efficiency:
https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg00098.html

Best regards,
Ahmed Karaman

--000000000000f4f4bb05ad1040d5
Content-Type: text/html; charset="UTF-8"

<div dir="auto">Hi everyone,<br>
<br>
QEMU currently lacks a system for measuring the performance of targets<br>
automatically. The previous reports introduced different tools and<br>
methods for locating performance regressions, but all of them had to<br>
be manually executed by the user when needed.<br>
<br>
This report devises a new nightly tests system that runs automatically<br>
each night. After the execution is completed, it sends a report to the<br>
QEMU mailing list with the performance measurements of seventeen<br>
different QEMU targets, and how these measurements compare to<br>
previously obtained ones.<br>
<br>
Report link:<br>
<a href="https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/QEMU-Nightly-Performance-Tests/" rel="noreferrer noreferrer" target="_blank">https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/QEMU-Nightly-Performance-Tests/</a><br>
<br>
The system is now scheduled to execute daily, and starting from<br>
tonight, the results will be sent to the mailing list.<br>
<br>
Previous reports:<br>
Report 1 - Measuring Basic Performance Metrics of QEMU:<br>
<a href="https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg06692.html" rel="noreferrer noreferrer" target="_blank">https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg06692.html</a><br>
Report 2 - Dissecting QEMU Into Three Main Parts:<br>
<a href="https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg09441.html" rel="noreferrer noreferrer" target="_blank">https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg09441.html</a><br>
Report 3 - QEMU 5.0 and 5.1-pre-soft-freeze Dissect Comparison:<br>
<a href="https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg01978.html" rel="noreferrer noreferrer" target="_blank">https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg01978.html</a><br>
Report 4 - Listing QEMU Helpers and Function Callees:<br>
<a href="https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg04227.html" rel="noreferrer noreferrer" target="_blank">https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg04227.html</a><br>
Report 5 - Finding Commits Affecting QEMU Performance:<br>
<a href="https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg05769.html" rel="noreferrer noreferrer" target="_blank">https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg05769.html</a><br>
Report 6 - Performance Comparison of Two QEMU Builds:<br>
<a href="https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg07389.html" rel="noreferrer noreferrer" target="_blank">https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg07389.html</a><br>
Report 7 - Measuring QEMU Emulation Efficiency:<br>
<a href="https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg00098.html" rel="noreferrer noreferrer" target="_blank">https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg00098.html</a><br>
<br>
Best regards,<br>
Ahmed Karaman<br></div>

--000000000000f4f4bb05ad1040d5--

