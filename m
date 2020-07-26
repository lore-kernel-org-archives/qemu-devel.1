Return-Path: <SRS0=rO5d=BF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D7CC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2020 15:26:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C19972065E
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2020 15:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PeBZFk4S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C19972065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jziXr-0002Lt-3v
	for qemu-devel@archiver.kernel.org; Sun, 26 Jul 2020 11:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1jziWz-0001AG-Rw; Sun, 26 Jul 2020 11:25:41 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:46710)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1jziWx-0001rx-6G; Sun, 26 Jul 2020 11:25:41 -0400
Received: by mail-wr1-x42b.google.com with SMTP id r12so12414880wrj.13;
 Sun, 26 Jul 2020 08:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=n8dPla0oiAVcNFWPdn+biQb1fG0sR9uDpkDyFzSvdk0=;
 b=PeBZFk4SHLd704sCa7uikuDY8YzssDLItB+ZXazVpqmBv9oLrmeLT9bQhei+VxGjDQ
 2IgA6Qnyu0bKubFDHOux2EhKsFiR4m/lkauhAyjKJ3vZD0O2WXyq/fnzqRnYEIUjVnSb
 bCV2n0QuwPnf0LVbKo+poB6Xtj9SHpLWB8hiIjuR1XdHp2igSRoDqAwf597bHmQyufHj
 hGIFoJR8EDWn8FaTKlQetXTlPqjiN4Unbxz+8vv1pQ7qUVlO81RRX2EgAAQoRUv3Dn6L
 /uerpVXmsa6h7Lr3AvOTKzXbujFZ1JRXWWrHGIEC/V7C6DHjM67tcR6T/5aBafQ9rv3S
 tNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=n8dPla0oiAVcNFWPdn+biQb1fG0sR9uDpkDyFzSvdk0=;
 b=SOs0aOAUzsHhCSAI2hlNw6E+Y/+4EByYPLklBmnYW3rW13DtIFOTYYVUihV3TfnzPs
 yRFK779M8h+143TN+wb8Vk9fQSQdgSxUnWzh725FEh4bIx4Y78WGQDi0tUV/81LSM+pv
 L57EeiXeHmXC0bazSrB4lGbDTwyUk7zpYW4GICRuEVaHWiKRLFkodYb54gBShkkkKP54
 ftq6fnVlkbTMa6YxDr5ioCeIs+9MVUCmzgJTfHkxJO3JkwpwHOD7xF1JXTRFPyC9Zz6I
 NZS2oeVRJQq4GViYAKWcWKIgADhVLlbhQWsDYwcJeBoNv8FwSO+yYFeRCijfZbyqwjku
 t0CA==
X-Gm-Message-State: AOAM533qCv+VGYiKxXptUFp77mL1rxHM0F4WkFY1QdKm4YbLh1KCtXGc
 hDcQG4hkx3qgB64uPJMBSC5N5XQJLjk=
X-Google-Smtp-Source: ABdhPJwzESqZWs/cKMFmFQka+1qLnFmeGFc3VsSejWkc33RFr1F2rPUgdzyNh0utEazZZXMr0nFYog==
X-Received: by 2002:a5d:54ca:: with SMTP id x10mr9425930wrv.36.1595777136180; 
 Sun, 26 Jul 2020 08:25:36 -0700 (PDT)
Received: from localhost.localdomain (109-186-134-209.bb.netvision.net.il.
 [109.186.134.209])
 by smtp.gmail.com with ESMTPSA id 14sm14160206wmk.19.2020.07.26.08.25.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2020 08:25:35 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
X-Google-Original-From: Nir Soffer <nsoffer@redhat.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 0/2] Fix convert to qcow2 compressed to NBD
Date: Sun, 26 Jul 2020 18:25:30 +0300
Message-Id: <20200726152532.256261-1-nsoffer@redhat.com>
X-Mailer: git-send-email 2.25.4
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=nirsof@gmail.com; helo=mail-wr1-x42b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix qemu-img convert -O qcow2 -c to NBD URL and add missing test for this=0D
usage.=0D
=0D
This already works now, but unfortunately qemu-img fails when trying to=0D
truncate the target image to the same size at the end of the operation.=0D
=0D
Nir Soffer (2):=0D
  block: nbd: Fix convert qcow2 compressed to nbd=0D
  qemu-iotests: Test convert to qcow2 compressed to NBD=0D
=0D
 block/nbd.c                | 27 +++++++++++++=0D
 tests/qemu-iotests/302     | 83 ++++++++++++++++++++++++++++++++++++++=0D
 tests/qemu-iotests/302.out | 27 +++++++++++++=0D
 tests/qemu-iotests/group   |  1 +=0D
 4 files changed, 138 insertions(+)=0D
 create mode 100755 tests/qemu-iotests/302=0D
 create mode 100644 tests/qemu-iotests/302.out=0D
=0D
-- =0D
2.25.4=0D
=0D

