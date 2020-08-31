Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0D3C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:08:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E327820866
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g+hVztBP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E327820866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCr2r-0004w7-Vq
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 17:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kCr1v-0003MH-Bb
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:07:55 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50538
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kCr1t-00006h-TV
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:07:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598908073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7yt5A66bPpOsnwcSVwH3FHeVoJv52fCdoEPIWk8mR4I=;
 b=g+hVztBPwIL625cedyGAcT/5wpjLU/rLanxEF6xmjurGfWOH7+yLdyuJbi55TInPIgc3CZ
 8nbBi2eUnUwGfTQRdeLt9+g977NO6hCWAIYcTxb1Xen3+NyqaMRtHtDTu3jlWI3pKhz9oq
 iWb3TeeESkJdaZs21b2XmvVMUfvSe7E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-Tr0xQKb0Oem3KdaaBE4Ayw-1; Mon, 31 Aug 2020 17:07:51 -0400
X-MC-Unique: Tr0xQKb0Oem3KdaaBE4Ayw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 454F7801AAC
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 21:07:50 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1358F26335;
 Mon, 31 Aug 2020 21:07:49 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 07/18] [automated] Delete duplicate QOM typedefs
Date: Mon, 31 Aug 2020 17:07:29 -0400
Message-Id: <20200831210740.126168-8-ehabkost@redhat.com>
In-Reply-To: <20200831210740.126168-1-ehabkost@redhat.com>
References: <20200831210740.126168-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 03:06:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Generated using:

 $ ./scripts/codeconverter/converter.py -i \
   --pattern=QOMDuplicatedTypedefs $(git grep -l '' -- '*.[ch]')

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v3 -> v4: none

Changes v2 -> v3: none

Changes v1 -> v2: none

---
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
---
 include/crypto/secret_keyring.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/crypto/secret_keyring.h b/include/crypto/secret_keyring.h
index 9f371ad251..4345eb048e 100644
--- a/include/crypto/secret_keyring.h
+++ b/include/crypto/secret_keyring.h
@@ -39,14 +39,14 @@
 typedef struct QCryptoSecretKeyring QCryptoSecretKeyring;
 typedef struct QCryptoSecretKeyringClass QCryptoSecretKeyringClass;
 
-typedef struct QCryptoSecretKeyring {
+struct QCryptoSecretKeyring {
     QCryptoSecretCommon parent;
     int32_t serial;
-} QCryptoSecretKeyring;
+};
 
 
-typedef struct QCryptoSecretKeyringClass {
+struct QCryptoSecretKeyringClass {
     QCryptoSecretCommonClass parent;
-} QCryptoSecretKeyringClass;
+};
 
 #endif /* QCRYPTO_SECRET_KEYRING_H */
-- 
2.26.2


