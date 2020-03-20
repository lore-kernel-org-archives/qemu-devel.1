Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5804C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 14:36:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DA3020709
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 14:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/KXe7Lg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DA3020709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFIlA-0003Qm-KJ
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 10:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49645)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuval.shaia.ml@gmail.com>) id 1jFIjN-0001Ca-CI
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 10:34:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuval.shaia.ml@gmail.com>) id 1jFIjM-0006zJ-9d
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 10:34:37 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34094)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuval.shaia.ml@gmail.com>)
 id 1jFIjM-0006yn-4I
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 10:34:36 -0400
Received: by mail-wm1-x341.google.com with SMTP id 26so3173931wmk.1
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 07:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MSy2m9Hc8R9mimywtmcC2XkgYtSZ8HfEQRcayL/1MSs=;
 b=p/KXe7LgQGNBDE20R2vbhSKypXHBlAA0fUw0CTaqpoqdNbKILwBvSc6uyuTpMzlKwE
 pDz8O9juY5GK1PyqN8gsqdOYRHnP4ChctX0+c2S8EIMRfPy5IbPqM55w7TSBWbeX3V5Q
 16X0kMk3eQVCz7WzGltId6bE0fyy6jylYp8oRvy9EfVYP/Q/rhQdPtoXwwgoVq/jVURh
 92hkb12iH0kv/nsDpP0aJOvBtZFm79vbiTUc3Kdf3VV5obHqngC28xppLEyeAk/kiRyv
 nY+DOm8dTnPK9GBnwA9kB0w6VAFKKHyXjP7VB9W8EegXkSGTBCVzPpC8zLntuTcbNkUo
 fLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MSy2m9Hc8R9mimywtmcC2XkgYtSZ8HfEQRcayL/1MSs=;
 b=VmulNoMvM+laHR6BA0xKLBoDEqYmtQWoGxcOFwtfYlQM5ZJKzNk31NgHt2zc0Xdp7W
 +WztU4fMmnLUkZkKV3tqK9UHQVi4uVr3v9+p8wCklxWewbPB32m5KevGzj361LXBrcUJ
 gMiMuvuv3IJ5owHMfMbZODxJ68L1cSBWzrUqQ2WhErFcqgrZTinMz5X10KDI4ZGw8cfh
 qPO57bzpl5k5GhNtyFUX9QpUr92MCwp52TSK+M3Yf5CjeRvNla69bc55xy7Cqmu52xjA
 5cwvYKC190V1Ygttsyfbhjz15aWSVWYAtWWBVjuSt2CJoghdIRGUu4cyn1vpMi3j+anf
 +RhQ==
X-Gm-Message-State: ANhLgQ23+sIF2zSPaXgrvKxti23ajcK8efOlHuydRXO5Ulqn6rHV2UEX
 S/N4jgVHS1FjF2dkZBSoML0+jsox
X-Google-Smtp-Source: ADFU+vvS9P2ORhhlRTlNVJ5y93oRwifHfKl5Ix48qQBKmLe9UCR+IUTUulft4F8Az/JkE9pv7Mp9yA==
X-Received: by 2002:a1c:a5d4:: with SMTP id o203mr1801522wme.47.1584714874638; 
 Fri, 20 Mar 2020 07:34:34 -0700 (PDT)
Received: from localhost.localdomain ([2a00:a040:186:a1ad:5254:ff:fe84:1be0])
 by smtp.gmail.com with ESMTPSA id
 s22sm7336694wmc.16.2020.03.20.07.34.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 07:34:34 -0700 (PDT)
From: Yuval Shaia <yuval.shaia.ml@gmail.com>
To: qemu-devel@nongnu.org, yuval.shaia.ml@gmail.com, marcel.apfelbaum@gmail.com
Subject: [PATCH v1 0/2] hw/rdma: Last step in eliminating data-path processing
Date: Fri, 20 Mar 2020 16:34:27 +0200
Message-Id: <20200320143429.9490-1-yuval.shaia.ml@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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

With emulated device we have the luxury of doing things in data-path.
Considering a future virtio-rdma device we no longer have this luxury. The
driver will directly post WQEs to HW queues, bypassing the device emulator
in qemu. These WQEs will consist of addresses known to the device (even if
it is guest addresses) and ID of an HW memory region (mr).

Commit 68b89aee71 ("Utilize ibv_reg_mr_iova for memory registration") did
the first important step of utilizing a new rdma API so addresses
translation is no longer needed.
This patch-set continues and remove entirely the processing in data-path by
eliminating the need to translate emulated mr_id to backend device mr_id.

v0 -> v1:
	* Accept comment from Marcel

Yuval Shaia (2):
  hw/rdma: Cosmetic change - no need for two sge arrays
  hw/rdma: Skip data-path mr_id translation

 hw/rdma/rdma_backend.c | 61 +++++++++++++++++++++---------------------
 hw/rdma/rdma_backend.h |  5 ----
 hw/rdma/rdma_rm.c      | 13 +++++----
 3 files changed, 36 insertions(+), 43 deletions(-)

-- 
2.20.1


