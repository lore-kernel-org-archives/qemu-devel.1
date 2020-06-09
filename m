Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23DEC433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:29:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80B0B207C3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gLvr4g3A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80B0B207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jii3c-0000jc-Ls
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 13:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jihjC-0003cg-Q1
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 13:07:58 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27148
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jihjA-0008T5-Vx
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 13:07:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591722476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bnuHye+9ACGI1Yv56xc1M8XlF7qOKtZ2bxHpIQ9SYnQ=;
 b=gLvr4g3A05KBW6sD0seu+PpUwoaWQkNYypTamKlRF1ukWNH7Gsqmg1pURSZUM/nRU6zyeW
 2z4TDOGIekDx3778rpdOI29eILrtz17pYPc+XpRdN6WjdN5dk08ZQLlvvOHF5zIFWHjF3z
 LHmi6QpDSkDbSlzxSTwR2io0YkzeOjQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-8tIrTd-eO0eLIn6aJtg10Q-1; Tue, 09 Jun 2020 13:07:50 -0400
X-MC-Unique: 8tIrTd-eO0eLIn6aJtg10Q-1
Received: by mail-wr1-f72.google.com with SMTP id n6so8871223wrv.6
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 10:07:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bnuHye+9ACGI1Yv56xc1M8XlF7qOKtZ2bxHpIQ9SYnQ=;
 b=gncS6UcQS5Ftnb0jyu7Lk29wQ2/M8lg9CLs0nNNKMwWBZZeuqSJto2J866PzYjboIs
 Hd733zyZ73fK+D/0s5Dz+4ZLdEqV0UtKECRLLLd3zhg9MUGPsnFWnmHC/f7o0VuX3VIb
 1kWool/zHTbAuHdV4jKxa5NreSqWvLWXqFhyDTorrFzXEcj2h6zWZ9EbaBnlG6Ncfo7b
 GzdiJ43jkV+ULNLf3oF791XPQgZKUq9QuBlN//L3PHo3cdRkUJkoqmO+a3B5R+w0cXUf
 Co0XXW3b2p6SYAPLMdVHhrxc4rT/NLYZawZbK1vIVpNbSDwed2AWa3oj7yBEgEEkbTFy
 SS6A==
X-Gm-Message-State: AOAM531JIdoscxwDUJB8DHg93QR5CFh8gSCd4ZP3Q8YJc6jzbe2WufrX
 UuJxMJY/9TdWK+EWxMd5Fq82bhfWFZTu1L9ma9kJwXChPWh92kVpXGiDVGEKNhET71RCPnaXjpo
 VYwtOHEse5mqKUQs=
X-Received: by 2002:adf:9205:: with SMTP id 5mr5296664wrj.232.1591722468970;
 Tue, 09 Jun 2020 10:07:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpOKtFJBeZwZCQRH+vWCbCGuP54Jw3oO8sTsozLsqw5XERFzlslXkgzC6JWonWxJ2BtsMrCw==
X-Received: by 2002:adf:9205:: with SMTP id 5mr5296630wrj.232.1591722468554;
 Tue, 09 Jun 2020 10:07:48 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id y14sm3523162wma.25.2020.06.09.10.07.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 10:07:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v8 4/5] crypto: Add tls-cipher-suites object
Date: Tue,  9 Jun 2020 19:07:26 +0200
Message-Id: <20200609170727.9977-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200609170727.9977-1-philmd@redhat.com>
References: <20200609170727.9977-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 02:41:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On the host OS, various aspects of TLS operation are configurable.
In particular it is possible for the sysadmin to control the TLS
cipher/protocol algorithms that applications are permitted to use.

* Any given crypto library has a built-in default priority list
  defined by the distro maintainer of the library package (or by
  upstream).

* The "crypto-policies" RPM (or equivalent host OS package)
  provides a config file such as "/etc/crypto-policies/config",
  where the sysadmin can set a high level (library-independent)
  policy.

  The "update-crypto-policies --set" command (or equivalent) is
  used to translate the global policy to individual library
  representations, producing files such as
  "/etc/crypto-policies/back-ends/*.config". The generated files,
  if present, are loaded by the various crypto libraries to
  override their own built-in defaults.

  For example, the GNUTLS library may read
  "/etc/crypto-policies/back-ends/gnutls.config".

* A management application (or the QEMU user) may overide the
  system-wide crypto-policies config via their own config, if
  they need to diverge from the former.

Thus the priority order is "QEMU user config" > "crypto-policies
system config" > "library built-in config".

Introduce the "tls-cipher-suites" object for exposing the ordered
list of permitted TLS cipher suites from the host side to the
guest firmware, via fw_cfg. The list is represented as an array
of IANA_TLS_CIPHER objects. The firmware uses the IANA_TLS_CIPHER
array for configuring guest-side TLS, for example in UEFI HTTPS
Boot.

The priority at which the host-side policy is retrieved is given
by the "priority" property of the new object type. For example,
"priority=@SYSTEM" may be used to refer to
"/etc/crypto-policies/back-ends/gnutls.config" (given that QEMU
uses GNUTLS).

[Description from Daniel P. Berrangé, edited by Laszlo Ersek.]

Example of use to dump the cipher suites:

  $ qemu-system-x86_64 -S \
    -object tls-cipher-suites,id=mysuite,priority=@SYSTEM \
    -trace qcrypto\*
  1590664444.197123:qcrypto_tls_cipher_suite_priority priority: @SYSTEM
  1590664444.197219:qcrypto_tls_cipher_suite_info data=[0x13,0x02] version=TLS1.3 name=TLS_AES_256_GCM_SHA384
  1590664444.197228:qcrypto_tls_cipher_suite_info data=[0x13,0x03] version=TLS1.3 name=TLS_CHACHA20_POLY1305_SHA256
  1590664444.197233:qcrypto_tls_cipher_suite_info data=[0x13,0x01] version=TLS1.3 name=TLS_AES_128_GCM_SHA256
  1590664444.197236:qcrypto_tls_cipher_suite_info data=[0x13,0x04] version=TLS1.3 name=TLS_AES_128_CCM_SHA256
  1590664444.197240:qcrypto_tls_cipher_suite_info data=[0xc0,0x30] version=TLS1.2 name=TLS_ECDHE_RSA_AES_256_GCM_SHA384
  1590664444.197245:qcrypto_tls_cipher_suite_info data=[0xcc,0xa8] version=TLS1.2 name=TLS_ECDHE_RSA_CHACHA20_POLY1305
  1590664444.197250:qcrypto_tls_cipher_suite_info data=[0xc0,0x14] version=TLS1.0 name=TLS_ECDHE_RSA_AES_256_CBC_SHA1
  1590664444.197254:qcrypto_tls_cipher_suite_info data=[0xc0,0x2f] version=TLS1.2 name=TLS_ECDHE_RSA_AES_128_GCM_SHA256
  1590664444.197258:qcrypto_tls_cipher_suite_info data=[0xc0,0x13] version=TLS1.0 name=TLS_ECDHE_RSA_AES_128_CBC_SHA1
  1590664444.197261:qcrypto_tls_cipher_suite_info data=[0xc0,0x2c] version=TLS1.2 name=TLS_ECDHE_ECDSA_AES_256_GCM_SHA384
  1590664444.197266:qcrypto_tls_cipher_suite_info data=[0xcc,0xa9] version=TLS1.2 name=TLS_ECDHE_ECDSA_CHACHA20_POLY1305
  1590664444.197270:qcrypto_tls_cipher_suite_info data=[0xc0,0xad] version=TLS1.2 name=TLS_ECDHE_ECDSA_AES_256_CCM
  1590664444.197274:qcrypto_tls_cipher_suite_info data=[0xc0,0x0a] version=TLS1.0 name=TLS_ECDHE_ECDSA_AES_256_CBC_SHA1
  1590664444.197278:qcrypto_tls_cipher_suite_info data=[0xc0,0x2b] version=TLS1.2 name=TLS_ECDHE_ECDSA_AES_128_GCM_SHA256
  1590664444.197283:qcrypto_tls_cipher_suite_info data=[0xc0,0xac] version=TLS1.2 name=TLS_ECDHE_ECDSA_AES_128_CCM
  1590664444.197287:qcrypto_tls_cipher_suite_info data=[0xc0,0x09] version=TLS1.0 name=TLS_ECDHE_ECDSA_AES_128_CBC_SHA1
  1590664444.197291:qcrypto_tls_cipher_suite_info data=[0x00,0x9d] version=TLS1.2 name=TLS_RSA_AES_256_GCM_SHA384
  1590664444.197296:qcrypto_tls_cipher_suite_info data=[0xc0,0x9d] version=TLS1.2 name=TLS_RSA_AES_256_CCM
  1590664444.197300:qcrypto_tls_cipher_suite_info data=[0x00,0x35] version=TLS1.0 name=TLS_RSA_AES_256_CBC_SHA1
  1590664444.197304:qcrypto_tls_cipher_suite_info data=[0x00,0x9c] version=TLS1.2 name=TLS_RSA_AES_128_GCM_SHA256
  1590664444.197308:qcrypto_tls_cipher_suite_info data=[0xc0,0x9c] version=TLS1.2 name=TLS_RSA_AES_128_CCM
  1590664444.197312:qcrypto_tls_cipher_suite_info data=[0x00,0x2f] version=TLS1.0 name=TLS_RSA_AES_128_CBC_SHA1
  1590664444.197316:qcrypto_tls_cipher_suite_info data=[0x00,0x9f] version=TLS1.2 name=TLS_DHE_RSA_AES_256_GCM_SHA384
  1590664444.197320:qcrypto_tls_cipher_suite_info data=[0xcc,0xaa] version=TLS1.2 name=TLS_DHE_RSA_CHACHA20_POLY1305
  1590664444.197325:qcrypto_tls_cipher_suite_info data=[0xc0,0x9f] version=TLS1.2 name=TLS_DHE_RSA_AES_256_CCM
  1590664444.197329:qcrypto_tls_cipher_suite_info data=[0x00,0x39] version=TLS1.0 name=TLS_DHE_RSA_AES_256_CBC_SHA1
  1590664444.197333:qcrypto_tls_cipher_suite_info data=[0x00,0x9e] version=TLS1.2 name=TLS_DHE_RSA_AES_128_GCM_SHA256
  1590664444.197337:qcrypto_tls_cipher_suite_info data=[0xc0,0x9e] version=TLS1.2 name=TLS_DHE_RSA_AES_128_CCM
  1590664444.197341:qcrypto_tls_cipher_suite_info data=[0x00,0x33] version=TLS1.0 name=TLS_DHE_RSA_AES_128_CBC_SHA1
  1590664444.197345:qcrypto_tls_cipher_suite_count count: 29

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
v8: addressed Laszlo's comments
- updated trace events format to match other crypto ones
- inserted Daniel/Laszlo commit description
- describe object in qemu-options.hx
---
 include/crypto/tls-cipher-suites.h |  38 +++++++++
 crypto/tls-cipher-suites.c         | 127 +++++++++++++++++++++++++++++
 crypto/Makefile.objs               |   1 +
 crypto/trace-events                |   5 ++
 qemu-options.hx                    |  19 +++++
 5 files changed, 190 insertions(+)
 create mode 100644 include/crypto/tls-cipher-suites.h
 create mode 100644 crypto/tls-cipher-suites.c

diff --git a/include/crypto/tls-cipher-suites.h b/include/crypto/tls-cipher-suites.h
new file mode 100644
index 0000000000..3848393a20
--- /dev/null
+++ b/include/crypto/tls-cipher-suites.h
@@ -0,0 +1,38 @@
+/*
+ * QEMU TLS Cipher Suites Registry (RFC8447)
+ *
+ * Copyright (c) 2019 Red Hat, Inc.
+ *
+ * Author: Philippe Mathieu-Daudé <philmd@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QCRYPTO_TLSCIPHERSUITES_H
+#define QCRYPTO_TLSCIPHERSUITES_H
+
+#include "qom/object.h"
+#include "crypto/tlscreds.h"
+
+#define TYPE_QCRYPTO_TLS_CIPHER_SUITES "tls-cipher-suites"
+#define QCRYPTO_TLS_CIPHER_SUITES(obj) \
+    OBJECT_CHECK(QCryptoTLSCipherSuites, (obj), TYPE_QCRYPTO_TLS_CIPHER_SUITES)
+
+/*
+ * IANA registered TLS ciphers:
+ * https://www.iana.org/assignments/tls-parameters/tls-parameters.xhtml#tls-parameters-4
+ */
+typedef struct {
+    uint8_t data[2];
+} QEMU_PACKED IANA_TLS_CIPHER;
+
+typedef struct QCryptoTLSCipherSuites {
+    /* <private> */
+    QCryptoTLSCreds parent_obj;
+
+    /* <public> */
+    IANA_TLS_CIPHER *cipher_list;
+    unsigned cipher_count;
+} QCryptoTLSCipherSuites;
+
+#endif /* QCRYPTO_TLSCIPHERSUITES_H */
diff --git a/crypto/tls-cipher-suites.c b/crypto/tls-cipher-suites.c
new file mode 100644
index 0000000000..f02a041f9a
--- /dev/null
+++ b/crypto/tls-cipher-suites.c
@@ -0,0 +1,127 @@
+/*
+ * QEMU TLS Cipher Suites
+ *
+ * Copyright (c) 2019 Red Hat, Inc.
+ *
+ * Author: Philippe Mathieu-Daudé <philmd@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qom/object_interfaces.h"
+#include "qemu/error-report.h"
+#include "crypto/tlscreds.h"
+#include "crypto/tls-cipher-suites.h"
+#include "trace.h"
+
+static void parse_cipher_suites(QCryptoTLSCipherSuites *s,
+                                const char *priority_name, Error **errp)
+{
+    int ret;
+    const char *err;
+    gnutls_priority_t pcache;
+    enum { M_ENUMERATE, M_GENERATE, M_DONE } mode;
+
+    assert(priority_name);
+    trace_qcrypto_tls_cipher_suite_priority(priority_name);
+    ret = gnutls_priority_init(&pcache, priority_name, &err);
+    if (ret < 0) {
+        error_setg(errp, "Syntax error using priority '%s': %s",
+                   priority_name, gnutls_strerror(ret));
+        return;
+    }
+
+    for (mode = M_ENUMERATE; mode < M_DONE; mode++) {
+        size_t i;
+
+        for (i = 0;; i++) {
+            int ret;
+            unsigned idx;
+            const char *name;
+            IANA_TLS_CIPHER cipher;
+            gnutls_protocol_t protocol;
+
+            ret = gnutls_priority_get_cipher_suite_index(pcache, i, &idx);
+            if (ret == GNUTLS_E_REQUESTED_DATA_NOT_AVAILABLE) {
+                break;
+            }
+            if (ret == GNUTLS_E_UNKNOWN_CIPHER_SUITE) {
+                continue;
+            }
+
+            name = gnutls_cipher_suite_info(idx, (unsigned char *)&cipher,
+                                            NULL, NULL, NULL, &protocol);
+            if (name == NULL) {
+                continue;
+            }
+
+            if (mode == M_GENERATE) {
+                const char *version;
+
+                version = gnutls_protocol_get_name(protocol);
+                trace_qcrypto_tls_cipher_suite_info(cipher.data[0],
+                                                    cipher.data[1],
+                                                    version, name);
+                s->cipher_list[s->cipher_count] = cipher;
+            }
+            s->cipher_count++;
+        }
+
+        if (mode == M_ENUMERATE) {
+            if (s->cipher_count == 0) {
+                break;
+            }
+            s->cipher_list = g_new(IANA_TLS_CIPHER, s->cipher_count);
+            s->cipher_count = 0;
+        }
+    }
+    trace_qcrypto_tls_cipher_suite_count(s->cipher_count);
+    gnutls_priority_deinit(pcache);
+}
+
+static void qcrypto_tls_cipher_suites_complete(UserCreatable *uc, Error **errp)
+{
+    QCryptoTLSCreds *s = QCRYPTO_TLS_CREDS(uc);
+
+    if (!s->priority) {
+        error_setg(errp, "'priority' property is not set");
+        return;
+    }
+    parse_cipher_suites(QCRYPTO_TLS_CIPHER_SUITES(s), s->priority, errp);
+}
+
+static void qcrypto_tls_cipher_suites_finalize(Object *obj)
+{
+    QCryptoTLSCipherSuites *s = QCRYPTO_TLS_CIPHER_SUITES(obj);
+
+    g_free(s->cipher_list);
+}
+
+static void qcrypto_tls_cipher_suites_class_init(ObjectClass *oc, void *data)
+{
+    UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
+
+    ucc->complete = qcrypto_tls_cipher_suites_complete;
+}
+
+static const TypeInfo qcrypto_tls_cipher_suites_info = {
+    .parent = TYPE_QCRYPTO_TLS_CREDS,
+    .name = TYPE_QCRYPTO_TLS_CIPHER_SUITES,
+    .instance_size = sizeof(QCryptoTLSCipherSuites),
+    .instance_finalize = qcrypto_tls_cipher_suites_finalize,
+    .class_size = sizeof(QCryptoTLSCredsClass),
+    .class_init = qcrypto_tls_cipher_suites_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_USER_CREATABLE },
+        { }
+    }
+};
+
+static void qcrypto_tls_cipher_suites_register_types(void)
+{
+    type_register_static(&qcrypto_tls_cipher_suites_info);
+}
+
+type_init(qcrypto_tls_cipher_suites_register_types);
diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
index c2a371b0b4..1c1b5e21ff 100644
--- a/crypto/Makefile.objs
+++ b/crypto/Makefile.objs
@@ -13,6 +13,7 @@ crypto-obj-y += cipher.o
 crypto-obj-$(CONFIG_AF_ALG) += afalg.o
 crypto-obj-$(CONFIG_AF_ALG) += cipher-afalg.o
 crypto-obj-$(CONFIG_AF_ALG) += hash-afalg.o
+crypto-obj-$(CONFIG_GNUTLS) += tls-cipher-suites.o
 crypto-obj-y += tlscreds.o
 crypto-obj-y += tlscredsanon.o
 crypto-obj-y += tlscredspsk.o
diff --git a/crypto/trace-events b/crypto/trace-events
index 9e594d30e8..798b6067ab 100644
--- a/crypto/trace-events
+++ b/crypto/trace-events
@@ -21,3 +21,8 @@ qcrypto_tls_creds_x509_load_cert_list(void *creds, const char *file) "TLS creds
 # tlssession.c
 qcrypto_tls_session_new(void *session, void *creds, const char *hostname, const char *authzid, int endpoint) "TLS session new session=%p creds=%p hostname=%s authzid=%s endpoint=%d"
 qcrypto_tls_session_check_creds(void *session, const char *status) "TLS session check creds session=%p status=%s"
+
+# tls-cipher-suites.c
+qcrypto_tls_cipher_suite_priority(const char *name) "priority: %s"
+qcrypto_tls_cipher_suite_info(uint8_t data0, uint8_t data1, const char *version, const char *name) "data=[0x%02x,0x%02x] version=%s name=%s"
+qcrypto_tls_cipher_suite_count(unsigned count) "count: %u"
diff --git a/qemu-options.hx b/qemu-options.hx
index 93bde2bbc8..c74366d7cc 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4566,6 +4566,25 @@ SRST
         string as described at
         https://gnutls.org/manual/html_node/Priority-Strings.html.
 
+    ``-object tls-cipher-suites,id=id,priority=priority``
+        Creates a TLS cipher suites object, which can be used to control
+        the TLS cipher/protocol algorithms that applications are permitted
+        to use.
+
+        The ``id`` parameter is a unique ID which backends will use to
+        access the ordered list of permitted TLS cipher suites from the
+        host.
+
+        The ``priority`` parameter allows to override the global default
+        priority used by gnutls. This can be useful if the system
+        administrator needs to use a weaker set of crypto priorities for
+        QEMU without potentially forcing the weakness onto all
+        applications. Or conversely if one wants wants a stronger
+        default for QEMU than for all other applications, they can do
+        this through this parameter. Its format is a gnutls priority
+        string as described at
+        https://gnutls.org/manual/html_node/Priority-Strings.html.
+
     ``-object filter-buffer,id=id,netdev=netdevid,interval=t[,queue=all|rx|tx][,status=on|off][,position=head|tail|id=<id>][,insert=behind|before]``
         Interval t can't be 0, this filter batches the packet delivery:
         all packets arriving in a given interval on netdev netdevid are
-- 
2.21.3


