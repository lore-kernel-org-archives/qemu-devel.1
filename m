Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3BBC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 00:34:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 263B62078D
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 00:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RewCn6qd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 263B62078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8YWw-0001X8-Cw
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 20:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k8YE0-0008UN-5e
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 20:14:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33012)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k8YDy-0002Wz-KD
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 20:14:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597882473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D5nUl9M2rvJax/fSSuJ03XAZWGob4bwNdKhi2eFy+jo=;
 b=RewCn6qdXjn04pJsQFP7gvGgZ0L51gDRHu3zYypTfDvv+aSSC4LbnLlCf+Rq9f90roPgYL
 Ni/zyzmxzGmDr+DYE5gPlRJn9JQd5mb+MzN29gR+xyn3Gm1j5XSc41T1NiiVS3t4JettPH
 Z10D13zJjbdoj06XhWZUay9QdvEx13s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-lxQK7SlGPrmjYtFLXu9Txg-1; Wed, 19 Aug 2020 20:14:31 -0400
X-MC-Unique: lxQK7SlGPrmjYtFLXu9Txg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19C112FD00
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 00:14:31 +0000 (UTC)
Received: from localhost (ovpn-117-244.rdu2.redhat.com [10.10.117.244])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A3FE760BEC;
 Thu, 20 Aug 2020 00:14:30 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 50/58] [automated] Delete duplicate QOM typedefs
Date: Wed, 19 Aug 2020 20:12:28 -0400
Message-Id: <20200820001236.1284548-51-ehabkost@redhat.com>
In-Reply-To: <20200820001236.1284548-1-ehabkost@redhat.com>
References: <20200820001236.1284548-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 20:12:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Changes v1 -> v2: none
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


