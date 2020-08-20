Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBBEC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 15:00:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2695C2075E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 15:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NPS8LPwU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2695C2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8m2t-0002Hk-As
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 11:00:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fziglio@redhat.com>)
 id 1k8m24-0001q8-17
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 10:59:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24635)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <fziglio@redhat.com>)
 id 1k8m22-000526-5J
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 10:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597935548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0bFXu0/5Hwwr35baKveo9eGBIbuOUSmbsq/iU/omYQ0=;
 b=NPS8LPwURO4gP+oASLJRUc9aTfdHGJt7XZxCOe39cEAA8ZwblCW9iip4YC69UkNLTAGMlx
 pg1C+98Xt9vMZYvaczzutXdqMtMv178tyU4r51OcW/YeeDZjfjBjSpGgR3dP7B2jzQbEdS
 8vbEl/rvMRlx20EpBI7GSoGLDJZ7sMI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-M2QOJH3EOaaUSWRq_qCMuw-1; Thu, 20 Aug 2020 10:59:02 -0400
X-MC-Unique: M2QOJH3EOaaUSWRq_qCMuw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7BDF4425CB;
 Thu, 20 Aug 2020 14:59:01 +0000 (UTC)
Received: from fziglio.remote.csb (unknown [10.40.195.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3CBAA60BF1;
 Thu, 20 Aug 2020 14:58:57 +0000 (UTC)
From: Frediano Ziglio <fziglio@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] ui: Add more mouse buttons to SPICE
Date: Thu, 20 Aug 2020 15:58:51 +0100
Message-Id: <20200820145851.50846-1-fziglio@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=fziglio@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=fziglio@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 09:00:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: qemu-devel@nongnu.org, Frediano Ziglio <freddy77@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Frediano Ziglio <freddy77@gmail.com>

Add support for SIDE and EXTRA buttons.

The constants for buttons in both SPICE and QEMU are defined as
  LEFT
  MIDDLE
  RIGHT
  UP
  DOWN
  SIDE
  EXTRA
(same order).

"button_mask" contains for each bit the state of a button. Qemu currently
uses bits 0, 1, 2 respectively as LEFT, RIGHT, MIDDLE; also add bits 4
and 5 as UP and DOWN (using wheel movements). SPICE protocol uses
a bitmask based on the order above where LEFT is bit 0, MIDDLE is
bit 1 and so on till EXTRA being bit 6. To avoid clash with Qemu usage
SPICE bitmask from SIDE are move a bit more resulting respectively
in 0x40 and 0x80 values.

Signed-off-by: Frediano Ziglio <freddy77@gmail.com>
---
 ui/spice-input.c | 2 ++
 1 file changed, 2 insertions(+)

See also https://gitlab.freedesktop.org/spice/spice/-/merge_requests/140

diff --git a/ui/spice-input.c b/ui/spice-input.c
index cd4bb0043f..d5bba231c9 100644
--- a/ui/spice-input.c
+++ b/ui/spice-input.c
@@ -123,6 +123,8 @@ static void spice_update_buttons(QemuSpicePointer *pointer,
         [INPUT_BUTTON_RIGHT]       = 0x02,
         [INPUT_BUTTON_WHEEL_UP]    = 0x10,
         [INPUT_BUTTON_WHEEL_DOWN]  = 0x20,
+        [INPUT_BUTTON_SIDE]        = 0x40,
+        [INPUT_BUTTON_EXTRA]       = 0x80,
     };
 
     if (wheel < 0) {
-- 
2.25.4


