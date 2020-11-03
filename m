Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535A5C00A89
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 03:12:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63064207BB
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 03:12:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63064207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZmk6-00089J-94
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 22:12:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiliyang@huawei.com>)
 id 1kZmir-0007X8-D0; Mon, 02 Nov 2020 22:11:01 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:2068)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiliyang@huawei.com>)
 id 1kZmip-0002PJ-07; Mon, 02 Nov 2020 22:11:00 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CQFCf5ZrNzhd5q;
 Tue,  3 Nov 2020 11:10:38 +0800 (CST)
Received: from [10.108.235.13] (10.108.235.13) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Tue, 3 Nov 2020 11:10:33 +0800
To: <berrange@redhat.com>
From: shiliyang <shiliyang@huawei.com>
Subject: [PATCH] crypto: Add spaces around operator
Message-ID: <bb45d748-01e4-2fde-9fe3-32a7db4b64e7@huawei.com>
Date: Tue, 3 Nov 2020 11:10:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.108.235.13]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32; envelope-from=shiliyang@huawei.com;
 helo=szxga06-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 22:10:41
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: alex.chen@huawei.com, hunongda@huawei.com, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I am reading crypto related code, find some code style problems while
using checkpatch.pl to check crypto folder. Fix the error style
problems.

Signed-off-by: Liyang Shi <shiliyang@huawei.com>

---
 crypto/aes.c          | 6 +++---
 crypto/desrfb.c       | 2 +-
 crypto/tlscredsx509.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/crypto/aes.c b/crypto/aes.c
index 159800df65..af72ff7779 100644
--- a/crypto/aes.c
+++ b/crypto/aes.c
@@ -1080,9 +1080,9 @@ int AES_set_encrypt_key(const unsigned char *userKey, const int bits,

         rk = key->rd_key;

-        if (bits==128)
+        if (bits == 128)
                 key->rounds = 10;
-        else if (bits==192)
+        else if (bits == 192)
                 key->rounds = 12;
         else
                 key->rounds = 14;
@@ -1182,7 +1182,7 @@ int AES_set_decrypt_key(const unsigned char *userKey, const int bits,
         rk = key->rd_key;

         /* invert the order of the round keys: */
-        for (i = 0, j = 4*(key->rounds); i < j; i += 4, j -= 4) {
+        for (i = 0, j = 4 * (key->rounds); i < j; i += 4, j -= 4) {
                 temp = rk[i    ]; rk[i    ] = rk[j    ]; rk[j    ] = temp;
                 temp = rk[i + 1]; rk[i + 1] = rk[j + 1]; rk[j + 1] = temp;
                 temp = rk[i + 2]; rk[i + 2] = rk[j + 2]; rk[j + 2] = temp;
diff --git a/crypto/desrfb.c b/crypto/desrfb.c
index 3274c36510..14288fcf96 100644
--- a/crypto/desrfb.c
+++ b/crypto/desrfb.c
@@ -93,7 +93,7 @@ void deskey(unsigned char *key, int edf)
                     }
                 for( j = 0; j < 24; j++ ) {
                         if( pcr[pc2[j]] ) kn[m] |= bigbyte[j];
-                        if( pcr[pc2[j+24]] ) kn[n] |= bigbyte[j];
+                        if( pcr[pc2[j + 24]] ) kn[n] |= bigbyte[j];
                         }
                 }
         cookey(kn);
diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
index dd7267ccdb..c89dd62435 100644
--- a/crypto/tlscredsx509.c
+++ b/crypto/tlscredsx509.c
@@ -143,7 +143,7 @@ qcrypto_tls_creds_check_cert_key_usage(QCryptoTLSCredsX509 *creds,
     if (status < 0) {
         if (status == GNUTLS_E_REQUESTED_DATA_NOT_AVAILABLE) {
             usage = isCA ? GNUTLS_KEY_KEY_CERT_SIGN :
-                GNUTLS_KEY_DIGITAL_SIGNATURE|GNUTLS_KEY_KEY_ENCIPHERMENT;
+                GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT;
         } else {
             error_setg(errp,
                        "Unable to query certificate %s key usage: %s",
-- 
2.17.1.windows.2


