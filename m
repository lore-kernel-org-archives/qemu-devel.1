Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A40C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:40:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF2EB2088E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1qhiFso"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2EB2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfmy-00042m-Tp
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:40:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <agarwal.khyati5@gmail.com>)
 id 1jlclA-0006Nt-95
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 14:26:04 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f]:45562)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <agarwal.khyati5@gmail.com>)
 id 1jlcl8-00065K-ND
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 14:26:03 -0400
Received: by mail-lj1-x22f.google.com with SMTP id i27so4049823ljb.12
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 11:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=XgrhYxKRpnRab278wei/1TDcfoaJpWDDlGdEs7vHmEg=;
 b=a1qhiFso1nW+36DshNvhfDhVxYAZDhcm+nfRL1jD9FyBsS12mgDaSjEMmSXcXodRyf
 rTYwJAb9C7ndygc8u3cqfzCilJkhhbTDj8YXRrh0mKNnBQQmes971vpCf341KM5gI5y2
 hw/QMCBgTC8gYYr3hq/vAklxVN7KFRRkdexaghSlfGCVi9iK6STBbPCpXN1PBRWSiKb0
 uK0GF6x8sPHD75M12LYOOMdgRFLI42Rc7qQwh2KZsVICzGSR8MXY26BQLK+NB6qvVMbu
 3+/c19njXCPmx47bQzshoopNd3l3GQcAIn1mXtg5tFUXNUaRgwxJM6eYq9fVhBA3RsFD
 As3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=XgrhYxKRpnRab278wei/1TDcfoaJpWDDlGdEs7vHmEg=;
 b=ASx1tC0bg9avg78ork1SP2H1x1XsNN598gXrP4fGTSQ38anrN4MunMkFY5kOVWCtJU
 UH2Wyw+CvK7itvZxLWbbLnUGLAIGs3bMm5DqAd5UWrlYAdkuTG8HeApNLeV+9eKt5DxB
 hGz5qtXASSCGce8jz9inwhY7uAx0+4F5FnJ69rEcm22tQ6zN4wwjBEnffNN+nVuamOS7
 dxCvm+UqD20cdT3TYtnzbEFkS3XXUwwKocUzqfHfAzN5vUuB+eVzUYMWeSkBHf1blk4U
 Yeqqs2vL+ipoETLxyGwtH8DVJOKpPVxnKUl65IUKc5ttPfFodEDYnJaUhKV5M3ypuQQT
 MGxA==
X-Gm-Message-State: AOAM530FMDxpJ4G9MOq9eif04E9bPGUboqh6p4LdK2TxI/q1o6omhJsi
 gZzhXulBSQ+5hZc21qRIiwOPKOTJ7s2A+AP9WCsdAUjcEQ0=
X-Google-Smtp-Source: ABdhPJw8upSz6N/E5W/5IDG+Jg8pzYora1AhPxa6idDMt0QC6DnjrfUG+mdhzVlKrb/MwmpsHE3j/jfJSxAU8AHYM24=
X-Received: by 2002:a2e:97d8:: with SMTP id m24mr301246ljj.166.1592418359978; 
 Wed, 17 Jun 2020 11:25:59 -0700 (PDT)
MIME-Version: 1.0
From: khyati agarwal <agarwal.khyati5@gmail.com>
Date: Wed, 17 Jun 2020 23:55:47 +0530
Message-ID: <CAJ70gCNkiiOzVsDsZgOJ2k6mOvT2aBX_4QcC8cc=Pu9Dqtzwog@mail.gmail.com>
Subject: Query Regarding Contribution
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000ae30d105a84bca0c"
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=agarwal.khyati5@gmail.com; helo=mail-lj1-x22f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 17 Jun 2020 17:13:33 -0400
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

--000000000000ae30d105a84bca0c
Content-Type: text/plain; charset="UTF-8"

Respected ,
I am Khyati Agarwal, second-year undergraduate in CSE, IIT, Mandi, India. I
have good knowledge of git, Python, C/C++, php, machine learning and
databases like mongodb, mysql. I'm interested in contributing to QEMU. I
have worked with nlp, tensorflow, keras, etc on ML projects. I am also
looking forward to the next Outreachy round. Could you please guide me on
how to start expressing and contributing ?

Regards
Khyati Agarwal
https://www.linkedin.com/in/khyati-agarwal-29913116b/

--000000000000ae30d105a84bca0c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Respected , <br></div><div>I am Khya=
ti Agarwal, second-year undergraduate in CSE, IIT,=20
Mandi, India. I have good knowledge of git,=20
Python, C/C++, php, machine learning and databases like mongodb, mysql.=20
I&#39;m interested in contributing to QEMU. I have worked with nlp,=20
tensorflow, keras, etc on ML projects. I am also looking forward to the nex=
t Outreachy round. Could you please guide=20
me on how to start expressing and contributing ?</div><div><br></div><div>R=
egards <br></div><font color=3D"#888888"><font color=3D"#888888"><div>Khyat=
i Agarwal</div><div><a href=3D"https://www.linkedin.com/in/khyati-agarwal-2=
9913116b/" target=3D"_blank">https://www.linkedin.com/in/khyati-agarwal-299=
13116b/</a></div></font></font></div></div>

--000000000000ae30d105a84bca0c--

