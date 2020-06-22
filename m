Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5C3C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 10:33:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3994F20578
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 10:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oIaaFpf6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3994F20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnJl6-0003xn-El
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 06:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jnJk5-0002WK-43
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 06:31:58 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c]:39484)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jnJk3-0003aS-7S
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 06:31:56 -0400
Received: by mail-lf1-x12c.google.com with SMTP id d21so7203146lfb.6
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 03:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=EQjXZ3runtdht+K7+QiiC3akkJ4ufJTXklG30G9Y4SI=;
 b=oIaaFpf6U02dY5tSduY6l2Ul7LZcB6ryykhNBK7U9IUTQhu4Xs4zm1McfauzvVwyx+
 g3dL/AKvu0HWN9sg+fTMSy/3esXI3Y8MQUNjQsFKP+TcM23RFHQK8vlhiLzv5KTbxCVQ
 tkVvticR0O0WcxOMgLQfCKgHGXNl+JLJvNtu/QiTrrUGc8crYOQuifUZVGvcrf3yaOx9
 NQnK/+Sk4teALcshLJR9BiAPZ9M08c4dvQ7XIvygsDprDhRvOtCPVIQXUQDhNDQfKuxO
 I/VfchTaHenVkS8GfO9i2jfSVo1Fodih1LkVLzBP946ARrmRhlYxbqJ1s8jx41XG5FVP
 62Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=EQjXZ3runtdht+K7+QiiC3akkJ4ufJTXklG30G9Y4SI=;
 b=PjH8TV72sUyva7b+PrqdsglS7fwQGfXgbdcIcbiqsEbdFwYMkkZ3QB+szDYosNbG9Y
 z18slIVefOfQ2M1XmUmOFwZJj3JN3zZoXTJmNK5jTm4EMfZOrbP9aUOz0WP/71Xu8yij
 9si9gZdi1i28xgY59GV/KdMn2zERYEHsUB9xlFkKuKa1yc6eMRGCwkCKGeC6dHLK6vgT
 +tLriJmyJe9RRrY8cLjbDyO2Fc0fSOJgbGauT5g1Gt5pDHzDWFvUtpx6yshToOXHaY7B
 8cA9NYz/19Zm26BsGCgcSK+HLLLAE7uuCcouEMQFKb8LBJSszePhta9+npNsxwyNtl5L
 kIqg==
X-Gm-Message-State: AOAM532RDs3oOIidWVaQ3C5VPmiKuASzytnPLtWgEZ7U09NkbUIxv6hm
 KLrth1SnXiZ+AHfcOBCHcY59i40UwWIiRhcjgnLfruWK
X-Google-Smtp-Source: ABdhPJwh/eO9xTTa2zfdBANyOu+bRCPCZ3vldekowh6JMzJRtpEZZKNu+0XZX8+dAStPwghdPMBEdTJ9QLah1psX5ME=
X-Received: by 2002:a19:6b15:: with SMTP id d21mr9411319lfa.42.1592821912295; 
 Mon, 22 Jun 2020 03:31:52 -0700 (PDT)
MIME-Version: 1.0
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Date: Mon, 22 Jun 2020 12:31:17 +0200
Message-ID: <CALTWKrVWSvWOQVorXuC4HQbjSN=Tu+TDsc=mr1CUCL1cvJQS9Q@mail.gmail.com>
Subject: [REPORT] [GSoC - TCG Continuous Benchmarking] [#1] Measuring Basic
 Performance Metrics of QEMU
To: QEMU Developers <qemu-devel@nongnu.org>, 
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Eric Blake <eblake@redhat.com>, Richard Henderson <rth@twiddle.net>, 
 =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000045dcd305a8a9c02d"
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-lf1-x12c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000045dcd305a8a9c02d
Content-Type: text/plain; charset="UTF-8"

Greetings,

Welcome to the TCG Continuous Benchmarking GSoC project!
This is the first report in a series that will be posted here on the
mailing list as part of the project.

During the project, multiple Linux profiling tools will be used.
These tools will help you profile your different QEMU execution
scenarios, and locate performance bottlenecks as well as performance
regression problems.

To provide you with a better understanding of these tools, this report
presents two of them - Perf and Callgrind.
It starts with measuring the basic performance metrics when running
a program using both tools, then it proceeds to calculating the top 25
most executed functions in QEMU.
To dissect the output of each of the two tools, a separate section
for comparing the output results is presented which focuses on how
these results apply to QEMU.
Finally, a stability test is devised that compares how the output
of the two tools differ with each subsequent invocation of QEMU.

For easier accessibility, all reports will be hosted on a dedicated
website:
https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/

Link to the first report:
https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/Measuring-Basic-Performance-Metrics-of-QEMU/

Best regards,
Ahmed Karaman

--00000000000045dcd305a8a9c02d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Greetings,<br><br>Welcome to the TCG Continuous Benchmarki=
ng GSoC project!<br>This is the first report in a series that will be poste=
d here on the<br>mailing list as part of the project.<br><br>During the pro=
ject, multiple Linux profiling tools will be used.<br>These tools will help=
 you profile your different QEMU execution<br>scenarios, and locate perform=
ance bottlenecks as well as performance<br>regression problems.<br><br>To p=
rovide you with a better understanding of these tools, this report<br>prese=
nts two of them - Perf and Callgrind.<br>It starts with measuring the basic=
 performance metrics when running<br>a program using both tools, then it pr=
oceeds to calculating the top 25<br>most executed functions in QEMU.<br>To =
dissect the output of each of the two tools, a separate section<br>for comp=
aring the output results is presented which focuses on how<br>these results=
 apply to QEMU.<br>Finally, a stability test is devised that compares how t=
he output<br>of the two tools differ with each subsequent invocation of QEM=
U.<br><br>For easier accessibility, all reports will be hosted on a dedicat=
ed<br>website:<br><a href=3D"https://ahmedkrmn.github.io/TCG-Continuous-Ben=
chmarking/" target=3D"_blank">https://ahmedkrmn.github.io/TCG-Continuous-Be=
nchmarking/</a><br><br>Link to the first report:<br><a href=3D"https://ahme=
dkrmn.github.io/TCG-Continuous-Benchmarking/Measuring-Basic-Performance-Met=
rics-of-QEMU/" target=3D"_blank">https://ahmedkrmn.github.io/TCG-Continuous=
-Benchmarking/Measuring-Basic-Performance-Metrics-of-QEMU/</a><br><br>Best =
regards,<br>Ahmed Karaman<br></div>

--00000000000045dcd305a8a9c02d--

