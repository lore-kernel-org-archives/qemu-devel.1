Return-Path: <SRS0=oVW3=4Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044ADC10F00
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 12:57:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C40032073C
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 12:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XK9I5oVF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C40032073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAZ16-00052z-U6
	for qemu-devel@archiver.kernel.org; Sat, 07 Mar 2020 07:57:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50815)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuval.shaia.ml@gmail.com>) id 1jAZ04-0003sd-J1
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 07:56:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuval.shaia.ml@gmail.com>) id 1jAZ03-00081z-Fu
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 07:56:16 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54993)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuval.shaia.ml@gmail.com>)
 id 1jAZ03-0007w4-9i
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 07:56:15 -0500
Received: by mail-wm1-x343.google.com with SMTP id n8so1282205wmc.4
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2020 04:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=J5sz4X5HFMjlOoPvFobErcoB4S2g1F9KLqeFqys09TI=;
 b=XK9I5oVFZuhWWk7yEDVbJRreoYE57Au9o3bVsdW4/Z43xpruHeEoknyw/XW/Ld0KwS
 iT8MV7ilGarFLnTIUeb2KbiEj+V2TA+GGFnQeoLwJUfv+t6jq1slnYAEyCfbKSPgfuMd
 tcYtFQ118zkh7qX/SxXKaCL+GGkEW8q1IVMxMvanBhuzP2PnbJ53YF+vr1hJQ1hUb+vk
 0e5O4rIzDKT4MW4ZPB3J/OVHjvm/iwlNK+a5WUHa+EkSRx6ah9Pe8+Jn9ETpHrsXG7VT
 MYVz7+Etu6/kDTf+u8aSqYYo+Vx8JyE0PYYbi+FiXGBvaUfaoRAA47AB9z1kr/1+h+Y/
 FxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=J5sz4X5HFMjlOoPvFobErcoB4S2g1F9KLqeFqys09TI=;
 b=ZE0jXL2yyfVN6EjTgkCz2Y1bC/AvvLy9SiyxM8PMiYLu8mHenklt6gsGfIjQ5OpxS7
 +Aa8qz9ogFAcss2nwMR6RqG9sXqR0I6MfBIgd1dy2cdCDdUfNZGwQP0iXQW8qVVtztjZ
 RnqBwxOAq77ce7Fu4jS2eEQ1vg9D0kwdbTQSz+Ns/eh9CYTK8rh1K7r70TLU9tWnCnMV
 CPdfS1P2NeeGouB/hphyAW6eYbmKMavfyYASLEDGU7ppZ1kIEqneyuGc4Z4dATgwpj/B
 KdT6vaRZexG0Xm4Zys0i/HpUxnOz3pIUUOstJ40dmhbi/i5nAbuwXhsS6Xs1PpIMTgs8
 ozIQ==
X-Gm-Message-State: ANhLgQ0WpWOxtKE6i4jVL91sX3ds4mcLqFfc6ItEZ+m2oFaqpHcKrgzK
 jrTusjhODSzz8e+E3+pq5euUZnDB
X-Google-Smtp-Source: ADFU+vuNhq2KvUm3N+sfAFONF4JAGU8gyGwDpJtDezZP1XMKaqI4+BQhMI6TlTb86G8+ULWTNqsY9g==
X-Received: by 2002:a1c:e918:: with SMTP id q24mr9816512wmc.25.1583585773527; 
 Sat, 07 Mar 2020 04:56:13 -0800 (PST)
Received: from localhost.localdomain ([2a00:a040:186:a1ad:5254:ff:fe84:1be0])
 by smtp.gmail.com with ESMTPSA id
 19sm19690289wma.3.2020.03.07.04.56.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2020 04:56:13 -0800 (PST)
From: Yuval Shaia <yuval.shaia.ml@gmail.com>
To: qemu-devel@nongnu.org, yuval.shaia.ml@gmail.com, marcel.apfelbaum@gmail.com
Subject: [PATCH 0/2] hw/rdma: Last step in eliminating data-path processing
Date: Sat,  7 Mar 2020 14:56:06 +0200
Message-Id: <20200307125608.2476-1-yuval.shaia.ml@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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

Yuval Shaia (2):
  hw/rdma: Cosmetic change - no need for two sge arrays
  hw/rdma: Skip data-path mr_id translation

 hw/rdma/rdma_backend.c | 61 +++++++++++++++++++++---------------------
 hw/rdma/rdma_backend.h |  5 ----
 hw/rdma/rdma_rm.c      | 13 +++++----
 3 files changed, 36 insertions(+), 43 deletions(-)

-- 
2.20.1


