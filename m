Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C505C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 18:31:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2C5B2087F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 18:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zRSZ1uUV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2C5B2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60624 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNiOl-0008Bp-43
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 14:31:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNiN1-0007Dq-09
	for qemu-devel@nongnu.org; Mon, 06 May 2019 14:29:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNiMz-0000HU-FR
	for qemu-devel@nongnu.org; Mon, 06 May 2019 14:29:46 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:44517)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hNiMz-0000Gf-1i
	for qemu-devel@nongnu.org; Mon, 06 May 2019 14:29:45 -0400
Received: by mail-pg1-x52d.google.com with SMTP id z16so6859323pgv.11
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 11:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=6dv6QYqUs/4eBBK3Q0CjZ/bsDel5OeXX/xyV4025EYY=;
	b=zRSZ1uUV6lwWSOOrrY4BXAH/iKuCr9iUK5EZEWYWvyMFIsPD+D9IaDLbp3OnQTDFhn
	VHRS6qTpOBaOiZ1ik/S0ODQW1RASZoQRpiR245wMHPZO0/r6LnFNJpXcayf5MW4+n1yt
	ioVz9/gECqoamOO1KG7RA9CE/mjJnfwK+ym8m8dTTw7SWrvHca+BP4cHjSMB0RUQSHvO
	Zrj6oJpzE24gh7if5PQbWceueNPhbET0ljDt59MyAv0d8NrP5tVs4zEPxnhTQKfh+V6a
	pfxiwIaoFoItenoLT+1BOyN2eADU2F2giKsyUZX8BXytzO7+88lhXjhBy6pMDSJr7psM
	yYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=6dv6QYqUs/4eBBK3Q0CjZ/bsDel5OeXX/xyV4025EYY=;
	b=OA3PnDXeQNw1byPIpN/m4cNayXfIYP0SkzbEREPeV1o9Tr4gycKEWYDqKQCYb9iGHw
	KquafNtUAI1pbfkanLZTSirMe5fzSoagGJ5fJRG1FbMsTyxoVqObgGIzm5pEQvDqKN4h
	vQtVW/iBEJBwP0MBjDi6TNvgEYMqXSDBWjyw87D97B9YmzwRv+9KxzQ0gt0McVQOOdBT
	C6o53CVhd4ydBzH2NpwQSuZAnp64Z7p+UewR5RLWFsdwOD7sIVIFj46tD5ZThLnaB5ya
	/gQTNnPiXjVxGxdKMCXGjC1LUcb5B3YAgKeik/U9W3QryPDt0Dj9VeEUOcc8e47hWwTs
	dfAA==
X-Gm-Message-State: APjAAAVneMkMj5wM4S3PZ57WVauusWbHTVYUh0eH6jayMJbeYYD6hryD
	Vq+xkDPLzwn09is3DWLipNUirWIEe/c=
X-Google-Smtp-Source: APXvYqxneCj4KmXCPfhEQKyf4Pcic6IjFAGFUShkf599TXoXOeuHcaLTBYmKrybYCu9h2FdRBvzmmQ==
X-Received: by 2002:a63:ca0b:: with SMTP id n11mr32751307pgi.442.1557167383457;
	Mon, 06 May 2019 11:29:43 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	j32sm12909924pgi.73.2019.05.06.11.29.41
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 06 May 2019 11:29:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  6 May 2019 11:29:37 -0700
Message-Id: <20190506182940.2200-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::52d
Subject: [Qemu-devel] [PULL 0/3] decodetree: Support variable-length ISAs
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a pre-requisite for the RX port.


r~


The following changes since commit a6ae23831b05a11880b40f7d58e332c45a6b04f7:

  Merge remote-tracking branch 'remotes/ehabkost/tags/python-next-pull-request' into staging (2019-05-03 15:26:09 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-dt-20190506

for you to fetch changes up to 451e4ffdb0003ab5ed0d98bd37b385c076aba183:

  decodetree: Add DisasContext argument to !function expanders (2019-05-06 11:18:34 -0700)

----------------------------------------------------------------
Add support for variable-length ISAs

----------------------------------------------------------------
Richard Henderson (3):
      decodetree: Initial support for variable-length ISAs
      decodetree: Expand a decode_load function
      decodetree: Add DisasContext argument to !function expanders

 target/arm/translate-sve.c              |  24 ++--
 target/hppa/translate.c                 |  16 +--
 target/riscv/insn_trans/trans_rvc.inc.c |  10 +-
 target/riscv/translate.c                |   4 +-
 scripts/decodetree.py                   | 233 +++++++++++++++++++++++++++++---
 5 files changed, 241 insertions(+), 46 deletions(-)

