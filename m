Return-Path: <SRS0=clLO=73=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123F0C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 07:38:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D20462065C
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 07:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oOMM/lWR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D20462065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkNDl-00042u-5o
	for qemu-devel@archiver.kernel.org; Sun, 14 Jun 2020 03:38:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mindentropy@gmail.com>)
 id 1jkNDA-0003ca-Mo
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 03:37:48 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:38649)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mindentropy@gmail.com>)
 id 1jkND9-0008UM-1b
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 03:37:48 -0400
Received: by mail-oi1-x235.google.com with SMTP id c194so12997129oig.5
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2020 00:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=i+HSTkQrs1tM5euwFKjzMVSjtyZX9PH3OC7BoSnTc/4=;
 b=oOMM/lWR/HifIKKzK9ArLK/3Ylt4Ig9m+Qv1n9PHB3dZHWhJ7Rr/j/57K4hQ/abu2f
 FNDVHHrHaVpCLuKdHS5bNm0zlELLBKi+UYX33M0D4U7rTRW3Ny86lvLUEoykRPppLimJ
 s0eNEUimiobmZUkq2UdDB4j9gWkXW/I5Bt8sF263MMvotrlKpOT3wdYtqBXBm4xLHqxn
 jTuTzZTO0UImNNc3mXouyE14/fXsnX74KSVIVZYuAwLaLTG7qEruiZr5/FD0Na7h4Fjh
 I5pUUx4WKiGwAjbrR5mgzaZbxEPcmOuXGTNbDmIkytQo8m2zRCfZNR66ZNwTgG1n+wGI
 VdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=i+HSTkQrs1tM5euwFKjzMVSjtyZX9PH3OC7BoSnTc/4=;
 b=BpySx6wNSRwqt33OscoUE0EhchvJgTYaC5rSuliqadO/16x8jLpDJRb76ttW+y48u5
 v4MwsnOFVNi+ztCSbSIrn+OkevqlbFj0+c/7p9gYj7pQXbLzqSJfQ7v5g4uznLX1hNE5
 4JkIuBwXNzx1kAe9W1xKwN9DYdga7P1AZ96T7mXzPdZBDqOV0Ope2is/mGqkUeOsRYIn
 I1ICRhBxXGhL5mwXrbCb4xGQRV8vX8prkmyCQ4OrcA613YwuNr8qfW5gk1xzcacRd84I
 h64sGx7WDZDltumK6D/cTruvOpBnXuWHahq1fBpg6bVweDrp7BO2xE4MZXWjYS5UkWD+
 vzxQ==
X-Gm-Message-State: AOAM532X18KdRIIe7vkr2sMmqjpiekcWth7yWJmBgdPMcnNCd0viaY49
 5VeWFRdQhI1sJMXY0F+fpR3Y8LjUjepGKTxyFrEct/+Y
X-Google-Smtp-Source: ABdhPJwMTJQneLliDxcyapyphFoZbivaAnMRPgG8vNvk+rpc+wKD4WAY9iT2cscpA1yURShlXYntehBPsF9SlX8clzg=
X-Received: by 2002:a05:6808:6d9:: with SMTP id
 m25mr4723421oih.111.1592120259555; 
 Sun, 14 Jun 2020 00:37:39 -0700 (PDT)
MIME-Version: 1.0
From: Gautam Bhat <mindentropy@gmail.com>
Date: Sun, 14 Jun 2020 13:07:28 +0530
Message-ID: <CAM2a4uw6J_+w9i6cN-Qfuyiq58_+vFqiBFrrx+A7hq7appo-4w@mail.gmail.com>
Subject: Pain points in Software Virtual Development
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000082b61905a806622b"
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=mindentropy@gmail.com; helo=mail-oi1-x235.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_40=-0.001, DKIM_SIGNED=0.1,
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

--00000000000082b61905a806622b
Content-Type: text/plain; charset="UTF-8"

Hi All,

I am interested in knowing what are the pain points in using Qemu as a
Software Virtual Development Platform from not only CPU perspective but a
complete PCB (CPU + different peripherals).

In most of the engineering firms that I have worked at, the PCB board was
the problem. There would either be a lack of boards due to costs, systems
being bulky etc. All these could easily be emulated using Qemu.

Is Qemu lacking a good way to model the entire system quickly to start with
BSP and application software development?

Any help would be appreciated.

Thanks,
Gautam

--00000000000082b61905a806622b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div style=3D"font-family:verdana,sans-serif" class=3D"gma=
il_default">Hi All,</div><div style=3D"font-family:verdana,sans-serif" clas=
s=3D"gmail_default"><br></div><div style=3D"font-family:verdana,sans-serif"=
 class=3D"gmail_default">I am interested in knowing what are the pain point=
s in using Qemu as a Software Virtual Development Platform from not only CP=
U perspective but a complete PCB (CPU + different peripherals).<br></div><d=
iv style=3D"font-family:verdana,sans-serif" class=3D"gmail_default"><br></d=
iv><div style=3D"font-family:verdana,sans-serif" class=3D"gmail_default">In=
 most of the engineering firms that I have worked at, the PCB board was the=
 problem. There would either be a lack of boards due to costs, systems bein=
g bulky etc. All these could easily be emulated using Qemu.</div><div style=
=3D"font-family:verdana,sans-serif" class=3D"gmail_default"><br></div><div =
style=3D"font-family:verdana,sans-serif" class=3D"gmail_default">Is Qemu la=
cking a good way to model the entire system quickly to start with BSP and a=
pplication software development?</div><div style=3D"font-family:verdana,san=
s-serif" class=3D"gmail_default"><br></div><div style=3D"font-family:verdan=
a,sans-serif" class=3D"gmail_default">Any help would be appreciated.<br></d=
iv><div style=3D"font-family:verdana,sans-serif" class=3D"gmail_default"><b=
r></div><div style=3D"font-family:verdana,sans-serif" class=3D"gmail_defaul=
t">Thanks,</div><div style=3D"font-family:verdana,sans-serif" class=3D"gmai=
l_default">Gautam<br></div><br></div>

--00000000000082b61905a806622b--

