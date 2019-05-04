Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28A5C43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 13:47:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B75420651
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 13:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vha6dtPJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B75420651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56955 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMv0b-0002yt-N9
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 09:47:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hMuyu-00021C-NK
	for qemu-devel@nongnu.org; Sat, 04 May 2019 09:45:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hMuyt-0002JP-Oc
	for qemu-devel@nongnu.org; Sat, 04 May 2019 09:45:36 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38058)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1hMuyt-0002HV-JC
	for qemu-devel@nongnu.org; Sat, 04 May 2019 09:45:35 -0400
Received: by mail-wm1-x344.google.com with SMTP id f2so4892068wmj.3
	for <qemu-devel@nongnu.org>; Sat, 04 May 2019 06:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=a5Y6deqr1g5k0Prfrm2Y8oZJjfoDCCNVzTD/vmf2iJU=;
	b=Vha6dtPJ83dVDD09upVUbNulfea/Pb8kcrjDEFx1fb2w0M09lUTW5dia36EQKZc7im
	s25VZdhEKhXwgrGE3WAmNOJY4RXmku8G1ZwgEu24waHqQT6Iu5+xDfVY2PX9ozLuQbco
	GzQftt21EYRN2B9poVLrJU4N4GxvZL/3+MRuLMqJW4QiNl60wSSYfX9c6dfPf73Owq/j
	vqT4Xx7I9YPuRj0tuouV9O0lhzYr/Te5triiafVxNqIZbB1hjb1wjBp6EMQmVuEvcSDe
	h43gp9FuBuQUXxpLlKOGCzt0DLPakma1k6p2EikQsnDY4xQOkZUyzDvwl5I2fWzhkezJ
	miZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=a5Y6deqr1g5k0Prfrm2Y8oZJjfoDCCNVzTD/vmf2iJU=;
	b=hvQdgBPlLZ4RHrP4y+2Apd/a3PP+JCbxlttwpcGtTbRLzYQOdxnuSYaFuI7iifz157
	4F7W47VTr/yJE1GFjSqBZ1i66UG+2A3Y1Bs1c1UWRwAFWkx5i9F0aFgV4b+32Ert50or
	wLrrR0RaP2JGvfAJdXXEbDCSRR1sQELSRhuysx/Whc2z+r7XUn9kOrIUP54CYy6+Olv0
	UG9czRUYe8etF9DcWlh+hNSyPrvBV6dqjgexMsU/pfCsFMQ/oLVbQ+c6ByvJpAKeKQa9
	qrBz08lZD/FE3B/SHBJ0MRoYPcFgoDAjEg5ECZZC3Al1lW8fAHAkMLxWV49XTvsyPudp
	QVDg==
X-Gm-Message-State: APjAAAXQbX7TtKPJdjJQoaiyXvMK1NOUlRZU4NVRV+YaiKPEDs8nS/9S
	d4mLNDy+YV4WXOW2Mvj6geRWlWgo
X-Google-Smtp-Source: APXvYqxNTCxgR+osjKgsf10Yyc/I8Q2wocNylCL6wyN0boDfFv5D6LD+SzOFFoFNG/3rxynnSsh99A==
X-Received: by 2002:a1c:cfcf:: with SMTP id f198mr2777548wmg.35.1556977533183; 
	Sat, 04 May 2019 06:45:33 -0700 (PDT)
Received: from localhost.localdomain ([37.142.144.27])
	by smtp.gmail.com with ESMTPSA id t1sm5095610wro.34.2019.05.04.06.45.31
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 04 May 2019 06:45:32 -0700 (PDT)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Date: Sat,  4 May 2019 16:45:25 +0300
Message-Id: <20190504134529.4755-1-marcel.apfelbaum@gmail.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel]  [PATCH PULL 0/4] RDMA queue
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
Cc: kamalheib1@gmail.com, yuval.shaia@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190504134525.vu2LP-1KVQWsfqDjKyiLe5SlYvfTXXISivhdYAOfANI@z>

The following changes since commit a6ae23831b05a11880b40f7d58e332c45a6b04f7:

  Merge remote-tracking branch 'remotes/ehabkost/tags/python-next-pull-request' into staging (2019-05-03 15:26:09 +0100)

are available in the Git repository at:

  https://github.com/marcel-apf/qemu tags/rdma-pull-request

for you to fetch changes up to 355b7cf356b7f506ca1b716647cc0cf19d312fd2:

  hw/pvrdma: Add support for SRQ (2019-05-04 15:55:56 +0300)

----------------------------------------------------------------
RDMA queue

* pvrdma: Add support for SRQ

----------------------------------------------------------------
Kamal Heib (4):
      hw/rdma: Add SRQ support to backend layer
      hw/rdma: Add support for managing SRQ resource
      hw/rdma: Modify create/destroy QP to support SRQ
      hw/pvrdma: Add support for SRQ

 hw/rdma/rdma_backend.c      | 125 +++++++++++++++++++++++++--
 hw/rdma/rdma_backend.h      |  18 +++-
 hw/rdma/rdma_backend_defs.h |   5 ++
 hw/rdma/rdma_rm.c           | 117 ++++++++++++++++++++++++-
 hw/rdma/rdma_rm.h           |  13 ++-
 hw/rdma/rdma_rm_defs.h      |  10 +++
 hw/rdma/vmw/pvrdma_cmd.c    | 206 +++++++++++++++++++++++++++++++++++++++-----
 hw/rdma/vmw/pvrdma_main.c   |  16 ++++
 hw/rdma/vmw/pvrdma_qp_ops.c |  46 +++++++++-
 hw/rdma/vmw/pvrdma_qp_ops.h |   1 +
 10 files changed, 521 insertions(+), 36 deletions(-)

-- 
2.17.1


