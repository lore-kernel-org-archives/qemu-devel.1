Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77DBC4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 07:17:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D8A72220D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 07:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="n60AfUXe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D8A72220D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKz20-00030s-PN
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 03:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kKz1A-0002Uu-PY
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 03:16:45 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633]:39397)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kKz18-0004Oc-KD
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 03:16:44 -0400
Received: by mail-pl1-x633.google.com with SMTP id y17so660373plb.6
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 00:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:message-id:references:subject:mime-version;
 bh=kslFoUK13OsPLcwSVX2ApkUX1m3i2wVGB5v+dgIWMTg=;
 b=n60AfUXerbLRK1LyPdn2trPHvNstuDquAKoEE/ggYdhZU8Pd8bP6bNepvow1OL87tN
 I7QVTpIjAzEsKHwUmHW1T4v+lS1FiDXzg7ArGfexMM6FxgDwKYbRkqMTLQ+QRgAcRPvX
 qsidggAmKRoB0BU5ab8zvYkxk4Cxx7l7XRJlqyWzXV1Y18WmxKGC/n9ofxxvpw7ejsda
 pspftIuuwtM3KlGAMp8kAHab7lMAgnBM1j5jEAceK1tz9riEnjNpI+rAl+0LKIk1d0bH
 wq9/j5oQ4Mw8W8qoMRh8/zyR5Klt0KKwgrHxe8wQWTvAfDIYde7rD4+aj3y+La+jD9PJ
 K2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:message-id:references:subject
 :mime-version;
 bh=kslFoUK13OsPLcwSVX2ApkUX1m3i2wVGB5v+dgIWMTg=;
 b=fCXTBoE0Du3/g8M95GfKf5CVbQozyqcswcoQ40efRRoyQISSDOqbdAaurbcpInxqDk
 c3mKHwdwCHX3yhwoqeOoAAqGe7AifnL2gn7uxf0RjIvgZwp3YAWANRXkGc05bbHvpxxe
 +5YdI2aE3OURbs5cWrtRJmNAltZgYdoG85X/rH6Qe6WYGJhHKQzr94meRP6u3dv148uh
 1nHOE8oBFODScGDDxP+SfcBvSo8cFJsf3eGwlUFi1ykjoN30NXIY1eP+LeRaH4DU8i6m
 KvDyOubnXmGJFtpr9r1cEeMSN8OEDq7OpyP66Udjw0634lqabxQ1DAYyBdzXDMccLvaz
 BHgg==
X-Gm-Message-State: AOAM53170U6Qe6l6vVnn9amrc2aq54Qa3A8sKKHoCTcntJx4c+FXWEmm
 +yjw/w2mNYGqTY9CSvZY/O0Y++azzbXHr1vS
X-Google-Smtp-Source: ABdhPJzg660CuxbLrVe9rhXT1lVBd3HgKeLaLzbis4CCbJMtUIqkDQyvyCz6BV2LynbSCLWq3A/LXA==
X-Received: by 2002:a17:902:7d8e:b029:d1:f2df:ad4 with SMTP id
 a14-20020a1709027d8eb02900d1f2df0ad4mr8540803plm.44.1600845399974; 
 Wed, 23 Sep 2020 00:16:39 -0700 (PDT)
Received: from [192.168.1.3] ([115.96.127.221])
 by smtp.gmail.com with ESMTPSA id i9sm1460063pfo.138.2020.09.23.00.16.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 23 Sep 2020 00:16:39 -0700 (PDT)
Date: Wed, 23 Sep 2020 12:46:28 +0530
From: Ani Sinha <ani@anisinha.ca>
To: QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <962d6c59-2dcb-438c-85c8-248a1df84c68@Spark>
References: <cf42575a-e4df-446f-a9cd-90070e240644@Spark>
Subject: Looking for a project in i440fx
X-Readdle-Message-ID: 962d6c59-2dcb-438c-85c8-248a1df84c68@Spark
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="5f6af654_2ae8944a_1dd2"
Received-SPF: none client-ip=2607:f8b0:4864:20::633;
 envelope-from=ani@anisinha.ca; helo=mail-pl1-x633.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--5f6af654_2ae8944a_1dd2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

Does anyone have any ideas for a project around pci space or PCIE space, =
preferably in i440fx but for PCIE it can be q35 as well.=C2=A0=C2=A0I=E2=80=
=99m basically looking to learn some qemu specific stuff as a hobby proje=
ct.

Thanks in advance,

Ani

--5f6af654_2ae8944a_1dd2
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html xmlns=3D=22http://www.w3.org/1999/xhtml=22>
<head>
<title></title>
</head>
<body>
<div name=3D=22messageBodySection=22>
<div dir=3D=22auto=22>Hi,<br />
<br />
Does anyone have any ideas for a project around pci space or PCIE space, =
preferably in i440fx but for PCIE it can be q35 as well.&=23160;&=23160;I=
=E2=80=99m basically looking to learn some qemu specific stuff as a hobby=
 project.<br />
<br />
Thanks in advance,</div>
</div>
<div name=3D=22messageSignatureSection=22><br />
Ani</div>
</body>
</html>

--5f6af654_2ae8944a_1dd2--


