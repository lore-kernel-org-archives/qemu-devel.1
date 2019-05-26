Return-Path: <SRS0=5YAC=T2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3063FC07542
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:44:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07B1D20815
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07B1D20815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49355 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUiD0-0000mN-9z
	for qemu-devel@archiver.kernel.org; Sat, 25 May 2019 21:44:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhxI-0003GC-QO
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:28:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhgB-0006GQ-G8
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:28 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:33092)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hUhgB-0006F1-AX
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:27 -0400
Received: by mail-pf1-f171.google.com with SMTP id z28so7508929pfk.0
	for <qemu-devel@nongnu.org>; Sat, 25 May 2019 18:10:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:cc:from:to;
	bh=DrfuOvljxEFhT82DbF62j50YM7gx233MXTyQHjUvuWU=;
	b=Ad3kU92+nPVEIHDL3wnYNJksGitV2+YoVEthMf6+4XhC/p04TA1v6OSsPfKrhPKPtd
	4vYwenpnIDt82J34givxS3YcBlkL0L19QrSPdDgADPW2OQ9jBSPvtKnZ/1Tjg+1ITycE
	VpUMJF+K7n/+Wa84EHRF8aay17Iiq45xA5olC+mymNSNnhhJgu37N1THwlebTwfMmpz1
	x/Ivu1qD39BsdwucVJGxqazpojh6ph4IIuBUSRJ+i7WzNHohXUPozDFh3Y+Z8qTXBrSQ
	M+0tNaBgsLBIREDXET4n9Rpc4oierZYFGc3WSiJEc7igYcD86Ppl4UL8sn8ijcxjVrrq
	N9kw==
X-Gm-Message-State: APjAAAWlUmlw2gkowMgidI0dQ2CrznZAavnYOVO6w/8np4pYPYUBozDZ
	lljX8kmn6xqdgrkkYS0pnNdjDA==
X-Google-Smtp-Source: APXvYqzN1jgLu30vHNwmopJC3v+QatjUhO/sKIwGI8cYsP3STg7KukDdBX/2IegoNab4ZQs811a/xw==
X-Received: by 2002:a65:6295:: with SMTP id f21mr14955958pgv.416.1558833025924;
	Sat, 25 May 2019 18:10:25 -0700 (PDT)
Received: from localhost ([12.206.222.5])
	by smtp.gmail.com with ESMTPSA id y7sm8353520pge.89.2019.05.25.18.10.24
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 25 May 2019 18:10:24 -0700 (PDT)
Date: Sat, 25 May 2019 18:09:36 -0700
Message-Id: <20190526010948.3923-18-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190526010948.3923-1-palmer@sifive.com>
References: <20190526010948.3923-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.210.171
Subject: [Qemu-devel] [PULL 17/29] target/riscv: Deprecate the generic no
 MMU CPUs
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
	Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <Alistair.Francis@wdc.com>

These can now be specified via the command line so we no longer need
these.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 qemu-deprecated.texi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index fbdde3d1b4af..9dca81f461e3 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -147,6 +147,12 @@ four CPUs are: ``rv32gcsu-v1.9.1``, ``rv32gcsu-v1.10.0``, ``rv64gcsu-v1.9.1`` an
 ``rv64gcsu-v1.10.0``. Instead the version can be specified via the CPU ``priv_spec``
 option when using the ``rv32`` or ``rv64`` CPUs.
 
+@subsection RISC-V ISA CPUs (since 4.1)
+
+The RISC-V no MMU cpus have been depcreated. The two CPUs: ``rv32imacu-nommu`` and
+``rv64imacu-nommu`` should no longer be used. Instead the MMU status can be specified
+via the CPU ``mmu`` option when using the ``rv32`` or ``rv64`` CPUs.
+
 @section System emulator devices
 
 @subsection bluetooth (since 3.1)
-- 
2.21.0


