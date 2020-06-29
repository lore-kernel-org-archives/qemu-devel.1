Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496CAC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 10:26:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12F32235FC
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 10:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRbdBhAk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12F32235FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpqzi-0005Ph-AR
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 06:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jpqyy-0004yR-KP
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 06:25:48 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133]:44289)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jpqyw-0008KR-SV
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 06:25:48 -0400
Received: by mail-lf1-x133.google.com with SMTP id y18so8746935lfh.11
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 03:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=8HK8ghMLxXPCeiqO+nr5RrPUrRHwDpgIW9367BtMR9c=;
 b=hRbdBhAk/sg4FQV9ZARfz0Ptdk6VR+GH8B1NGL8FKHdxZBAchaAMkTs9D3HHzxldeH
 AlC+Nu9KNLHpyxUj/dZrtI7r23OAyt7c6ED64jfsFDNNWe5DdTBl20I8Yj3HK468xmjP
 I2bgJkSmXCYX1lcwOM7eJlcabjpZXkDR5lup78qlq4hcVwKdntcNO4u9AdAZwFxgNhMR
 impzhNF0yLSyrdqmtd+JwSPoWFKE2GzmT/DJKPlhqq6nHs25kGOTYw1f6NzFNcA84KT0
 fT9yK7C6SDe0u2s4DqpzLOPwLOP7avAZp7KnZvC4zRJ09ohRzeM6AjrFthCm10HgQInj
 q3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=8HK8ghMLxXPCeiqO+nr5RrPUrRHwDpgIW9367BtMR9c=;
 b=gaYq6aDFNUrzkhsUO+4h+ghH0wa8fYR34ee5gHjkptZgJxB/j3zc8gC8e0Na8+iF2o
 N+3ivCVypLjX0oZ1g9SmVyhHF5je/ufR6M1YeLeDCpsk/vfa5fZQkPLdSXPM/4Rm47Eq
 Spp0DRyYiwtRoI6yUuBlt5Rr+uHWqf0hYlK89st6ORgzsxLO+/6Y9GuxV4UTBajjlOo6
 XWkt9v3ir31eqP1d1EbaM+e9Lz15Vfxep6EOFkqoF+as588Fpp8KPIJUZijiTOHiWRvi
 EysQ31AXanGM2u4o7D40HCh58rWgBlhxc2VaAPM7M9NEDTQNaShabDa8W+qLZeiJpxIB
 Y/VA==
X-Gm-Message-State: AOAM533cO+Qh2BAr+xoCx0bVKPnn3rWfLbmlnGg2zMHzBsT3vwmL2nQP
 PHwAYHjc4FAf3efPsNqjgtLFeJGVvHtCUgjdWM7xR9KN
X-Google-Smtp-Source: ABdhPJwP1LAek3SvY0dVzB7YgGiPSPkk96C2gwzoUEJ7iZ9QOKcUa+fVrO1R4DdU6tc55IxmlKFev/PurlwkhHM9Dqw=
X-Received: by 2002:a19:f20a:: with SMTP id q10mr8941388lfh.89.1593426344954; 
 Mon, 29 Jun 2020 03:25:44 -0700 (PDT)
MIME-Version: 1.0
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Date: Mon, 29 Jun 2020 12:25:00 +0200
Message-ID: <CALTWKrVAW33jJs1Q+51wN07DDUbAqwo=o+WDCpoT=NFB6dNZ6A@mail.gmail.com>
Subject: [REPORT] [GSoC - TCG Continuous Benchmarking] [#2] Dissecting QEMU
 Into Three Main Parts
To: QEMU Developers <qemu-devel@nongnu.org>, 
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Eric Blake <eblake@redhat.com>, Richard Henderson <rth@twiddle.net>, 
 =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000444f4d05a9367b64"
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-lf1-x133.google.com
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

--000000000000444f4d05a9367b64
Content-Type: text/plain; charset="UTF-8"

Hi,

The second report of the TCG Continuous Benchmarking series builds
upon the QEMU performance metrics calculated in the previous report.
This report presents a method to dissect the number of instructions
executed by a QEMU invocation into three main phases:
- Code Generation
- JIT Execution
- Helpers Execution
It devises a Python script that automates this process.

After that, the report presents an experiment for comparing the
output of running the script on 17 different targets. Many conclusions
can be drawn from the results and two of them are discussed in the
analysis section.

Report link:
https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/Dissecting-QEMU-Into-Three-Main-Parts/

Previous reports:
Report 1 - Measuring Basic Performance Metrics of QEMU:
https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg06692.html

Best regards,
Ahmed Karaman

--000000000000444f4d05a9367b64
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>The second report of the TCG Continuous Benchma=
rking series builds<br>upon the QEMU performance metrics calculated in the =
previous=C2=A0report.<br>This report presents a method to dissect the numbe=
r of instructions<br>executed by a QEMU invocation into three main phases:<=
div>- Code Generation<div>- JIT Execution<br>- Helpers Execution<br>It devi=
ses a Python script that automates this process.<br><br></div><div>After th=
at, the report presents an experiment for comparing the<br>output of runnin=
g the script on 17 different targets. Many conclusions</div><div>can be dra=
wn from the results and two of them are discussed in the</div><div>analysis=
 section.<br></div><div><br></div><div>Report link:</div><div><a href=3D"ht=
tps://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/Dissecting-QEMU-Into-=
Three-Main-Parts/">https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/=
Dissecting-QEMU-Into-Three-Main-Parts/</a><br></div><div><br>Previous repor=
ts:</div><div>Report 1 - Measuring Basic Performance Metrics of QEMU:<br><a=
 href=3D"https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg06692.htm=
l" target=3D"_blank">https://lists.gnu.org/archive/html/qemu-devel/2020-06/=
msg06692.html</a><br></div><div><br></div><div>Best regards,<br>Ahmed Karam=
an</div></div></div>

--000000000000444f4d05a9367b64--

