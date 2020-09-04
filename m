Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C82EC28E83
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 07:02:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39BF2206D4
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 07:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JnOEzlMu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39BF2206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE5kA-0003LN-AF
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 03:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kE5iu-00024a-HC
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 03:01:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35478)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kE5is-0002K0-40
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 03:01:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599202880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oh0dsR9TI3mzIVeN0IPikw4F2PQLKCbM82ZwfYzDhZo=;
 b=JnOEzlMuT6qp+IGYG14urKQCu+3+znSRI5OFscztpMX+mlyNhy7X5hAVA8PSJrfSZyEFJS
 dwKu5t0zzr/kLYFNGP1eRe/vy0kuWDydcoZZwl6telN40ATvbcfFYPEDNQeEjVuHNE6fjg
 8tJ1bXIX5fuj03Jjx2QKhGf+xeYixkA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-9jjU3xGKP9qkwr7SpoAVGw-1; Fri, 04 Sep 2020 03:01:18 -0400
X-MC-Unique: 9jjU3xGKP9qkwr7SpoAVGw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91D1A10BBEC5;
 Fri,  4 Sep 2020 07:01:17 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-62.ams2.redhat.com
 [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E241F7E419;
 Fri,  4 Sep 2020 07:01:13 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 17C2A31E23; Fri,  4 Sep 2020 09:01:13 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/4] ui: Add more mouse buttons to SPICE
Date: Fri,  4 Sep 2020 09:01:11 +0200
Message-Id: <20200904070112.7315-4-kraxel@redhat.com>
In-Reply-To: <20200904070112.7315-1-kraxel@redhat.com>
References: <20200904070112.7315-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 02:03:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, Frediano Ziglio <freddy77@gmail.com>
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
Message-id: 20200820145851.50846-1-fziglio@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/spice-input.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ui/spice-input.c b/ui/spice-input.c
index cd4bb0043fd9..d5bba231c95c 100644
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
2.27.0


