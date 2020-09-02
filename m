Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37B1C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 23:04:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76D5420767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 23:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RxQDVGAU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76D5420767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDbnM-00006E-7M
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 19:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbV3-0004DZ-7Q
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:45:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30683)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbV1-0008W3-CT
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:45:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599086702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vP+1cnoEiRRF/Veskzjah97JOmeQT5Sjpx4NEsWWbnQ=;
 b=RxQDVGAUjuBpnBaYcTEIao/QMwF2rlBOJb1A1uQA8QOStxw6dIRGj5SoUEBMZcVM0T5tum
 QhkZV6PIiP64sb8JcFCpcpygbrJdLItyMsZSOK70mlWt5kwltYC1kj8GqOwnEfR/BToKs8
 ZwskRKWVmP+4d2MCYRqbMA4F+EAYmbI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-EUGyTUulNP-PZ5vq3A1GNQ-1; Wed, 02 Sep 2020 18:45:01 -0400
X-MC-Unique: EUGyTUulNP-PZ5vq3A1GNQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3808810059A8
 for <qemu-devel@nongnu.org>; Wed,  2 Sep 2020 22:45:00 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 168B37E313;
 Wed,  2 Sep 2020 22:44:56 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 38/63] ccid-card-passthru: Rename PASSTHRU_CCID_CARD to
 CCID_PASSTHRU
Date: Wed,  2 Sep 2020 18:42:46 -0400
Message-Id: <20200902224311.1321159-39-ehabkost@redhat.com>
In-Reply-To: <20200902224311.1321159-1-ehabkost@redhat.com>
References: <20200902224311.1321159-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:42:29
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
Cc: berrange@redhat.com, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make the type checking macro name consistent with the TYPE_*
constant.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
---
 hw/usb/ccid-card-passthru.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index e8e9d37e88..d9f569e201 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -65,7 +65,7 @@ struct PassthruState {
 };
 
 #define TYPE_CCID_PASSTHRU "ccid-card-passthru"
-DECLARE_INSTANCE_CHECKER(PassthruState, PASSTHRU_CCID_CARD,
+DECLARE_INSTANCE_CHECKER(PassthruState, CCID_PASSTHRU,
                          TYPE_CCID_PASSTHRU)
 
 /*
@@ -332,7 +332,7 @@ static void ccid_card_vscard_event(void *opaque, QEMUChrEvent event)
 static void passthru_apdu_from_guest(
     CCIDCardState *base, const uint8_t *apdu, uint32_t len)
 {
-    PassthruState *card = PASSTHRU_CCID_CARD(base);
+    PassthruState *card = CCID_PASSTHRU(base);
 
     if (!qemu_chr_fe_backend_connected(&card->cs)) {
         printf("ccid-passthru: no chardev, discarding apdu length %d\n", len);
@@ -343,7 +343,7 @@ static void passthru_apdu_from_guest(
 
 static const uint8_t *passthru_get_atr(CCIDCardState *base, uint32_t *len)
 {
-    PassthruState *card = PASSTHRU_CCID_CARD(base);
+    PassthruState *card = CCID_PASSTHRU(base);
 
     *len = card->atr_length;
     return card->atr;
@@ -351,7 +351,7 @@ static const uint8_t *passthru_get_atr(CCIDCardState *base, uint32_t *len)
 
 static void passthru_realize(CCIDCardState *base, Error **errp)
 {
-    PassthruState *card = PASSTHRU_CCID_CARD(base);
+    PassthruState *card = CCID_PASSTHRU(base);
 
     card->vscard_in_pos = 0;
     card->vscard_in_hdr = 0;
-- 
2.26.2


