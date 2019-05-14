Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5469C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 19:20:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CD2520881
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 19:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nvLzqvhn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CD2520881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52926 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQcy5-00047D-Pa
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 15:20:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQcv6-0002Qk-4E
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQcv5-0006Yk-2w
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:00 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:38182)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQcv4-0006XS-T2
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:16:59 -0400
Received: by mail-pf1-x443.google.com with SMTP id b76so5105pfb.5
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 12:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=av3lT3tB0E6MniPcJlUSedb9hAsWsyXtFxkAveRaX+4=;
	b=nvLzqvhnv+ElZBEAG1AOsTIF/YA3g1Fsm/33pqJH3O8JS4Yzkw0N3z1AL09mFKhtwk
	VOkqh1EytBQ79nQ5vpZzQ4pyiWxPglWq+cgKK1QaV324saRBQN2LQ+rdQ3Mq0xHAaUbY
	SGDaviQuX6/3TVR+Xh5IoAROzEtFb8+hu9nDt+Pw+rGhQQlBcDJGUZ5Y6u8roUxZqay3
	6sbLDIcmq7iBqt9EIWVZl0c2r0TAag9UjwkBLRCwfb860DZaFb0LFdWQ9TbjV6Fw0axz
	4PIc/jpOUfmrxIHMisxeUfgJ6OsrMjvJKus6n3jGpx6ghOR7zhqQFxyxAtKtE+HyrKVf
	u4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=av3lT3tB0E6MniPcJlUSedb9hAsWsyXtFxkAveRaX+4=;
	b=YJVFqfrBCAgiUB3haAn2zbC/CLjbL0CkkEFpH839FdTE5+NZc+ax7HVfgn+7pkYAsR
	wXwU8wcuXYUJA/MlOnFgI9tfOlDZTfuiGD0bI+r7wzUIquiIV0l65FhX9E1j2FXbfDOj
	xKE3x7/O1t55glKtzeJUmnOgOJFTvwsRmYyd6f0MW8mInv5o+YjZB0YqnAV2dyZrIOQB
	fZ13XX7U0NsuPqUrBXW93nTxT8DCNGwiA/dnGqSBD+YZ1+x7C8KMarjgQHaoTExT0NfJ
	2dKsbTNYaL4m/SyjWgCcw0brqhJc9soLAHXoJABQQiv3LIF+WB9xYv+SpCXkQ4+kYQIZ
	yPsg==
X-Gm-Message-State: APjAAAWPsmmDShrF01Tf0iWruGq7OjXro7UC6B3YDV0MJUpqS5ajLY4g
	HwxzFiy1xYYu6Z4nGdvrBbUB0Z5p7g0=
X-Google-Smtp-Source: APXvYqwfHc+8AeGVIQxBL82j1t9GKOouULDlwIRkflPH4w0i+MML4Iq/GhF5Kuhgpl/LA222pZx0hQ==
X-Received: by 2002:aa7:8c1a:: with SMTP id c26mr42182591pfd.25.1557861417150; 
	Tue, 14 May 2019 12:16:57 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	o6sm18682982pfa.88.2019.05.14.12.16.55
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 12:16:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 14 May 2019 12:16:30 -0700
Message-Id: <20190514191653.31488-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514191653.31488-1-richard.henderson@linaro.org>
References: <20190514191653.31488-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v7 01/24] build: Link user-only with
 crypto-rng-obj-y
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, berrange@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For user-only, we require only the random number bits of the
crypto subsystem.

We need to preserve --static linking, which for many recent Linux
distributions precludes using GnuTLS or GCrypt.  Instead, use our
random-platform module unconditionally.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 Makefile             | 6 ++++--
 Makefile.objs        | 1 +
 Makefile.target      | 3 ++-
 crypto/Makefile.objs | 1 +
 4 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 66d5c65156..524f2f8a57 100644
--- a/Makefile
+++ b/Makefile
@@ -411,6 +411,7 @@ dummy := $(call unnest-vars,, \
                 block-obj-m \
                 crypto-obj-y \
                 crypto-aes-obj-y \
+                crypto-rng-obj-y \
                 qom-obj-y \
                 io-obj-y \
                 common-obj-y \
@@ -482,8 +483,9 @@ subdir-capstone: .git-submodule-status
 subdir-slirp: .git-submodule-status
 	$(call quiet-command,$(MAKE) -C $(SRC_PATH)/slirp BUILD_DIR="$(BUILD_DIR)/slirp" CC="$(CC)" AR="$(AR)" LD="$(LD)" RANLIB="$(RANLIB)" CFLAGS="$(QEMU_CFLAGS) $(CFLAGS)" LDFLAGS="$(LDFLAGS)")
 
-$(SUBDIR_RULES): libqemuutil.a $(common-obj-y) $(chardev-obj-y) \
-	$(qom-obj-y) $(crypto-aes-obj-$(CONFIG_USER_ONLY))
+$(SUBDIR_RULES): libqemuutil.a $(common-obj-y) $(chardev-obj-y) $(qom-obj-y) \
+	$(crypto-aes-obj-$(CONFIG_USER_ONLY)) \
+	$(crypto-rng-obj-$(CONFIG_USER_ONLY))
 
 ROMSUBDIR_RULES=$(patsubst %,romsubdir-%, $(ROMS))
 # Only keep -O and -g cflags
diff --git a/Makefile.objs b/Makefile.objs
index cf065de5ed..0c13ff47ea 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -26,6 +26,7 @@ block-obj-m = block/
 
 crypto-obj-y = crypto/
 crypto-aes-obj-y = crypto/
+crypto-rng-obj-y = crypto/
 
 #######################################################################
 # qom-obj-y is code used by both qemu system emulation and qemu-img
diff --git a/Makefile.target b/Makefile.target
index ae02495951..4e579a0a84 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -181,6 +181,7 @@ dummy := $(call unnest-vars,.., \
                chardev-obj-y \
                crypto-obj-y \
                crypto-aes-obj-y \
+               crypto-rng-obj-y \
                qom-obj-y \
                io-obj-y \
                common-obj-y \
@@ -189,7 +190,7 @@ all-obj-y += $(common-obj-y)
 all-obj-y += $(qom-obj-y)
 all-obj-$(CONFIG_SOFTMMU) += $(authz-obj-y)
 all-obj-$(CONFIG_SOFTMMU) += $(block-obj-y) $(chardev-obj-y)
-all-obj-$(CONFIG_USER_ONLY) += $(crypto-aes-obj-y)
+all-obj-$(CONFIG_USER_ONLY) += $(crypto-aes-obj-y) $(crypto-rng-obj-y)
 all-obj-$(CONFIG_SOFTMMU) += $(crypto-obj-y)
 all-obj-$(CONFIG_SOFTMMU) += $(io-obj-y)
 
diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
index 256c9aca1f..ee7e628ca6 100644
--- a/crypto/Makefile.objs
+++ b/crypto/Makefile.objs
@@ -37,5 +37,6 @@ crypto-obj-y += block-luks.o
 
 # Let the userspace emulators avoid linking gnutls/etc
 crypto-aes-obj-y = aes.o
+crypto-rng-obj-y = random-platform.o
 
 stub-obj-y += pbkdf-stub.o
-- 
2.17.1


