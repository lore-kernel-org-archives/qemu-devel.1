Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E70C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 07:53:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8A4320775
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 07:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uR8f6+8w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A4320775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDk3K-0004Bl-Lr
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 03:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDjuk-0000rh-DJ
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 03:44:10 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:42721)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDjuf-0003uu-GO
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 03:44:10 -0400
Received: by mail-pf1-x444.google.com with SMTP id 17so1603923pfw.9
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 00:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=J7jnwobGRIDUa/em/2YcJoKe5IITUTAYh0YoCe/oM4I=;
 b=uR8f6+8wxQiGuKMusQHfs3q1NgCVppHtYIUFOl5Zu77r16bQ6nTuLTcF4LbIqSr0j0
 lYtvzIVps59TwS23a3V0u16vxf4uezmOSohKYXOJi+OtMG23iXJXVOBOFAtBf7wFkvzc
 ty2F03Msk4Yd+E8A7txfI8VQMNiEj4HC6rGnSvuiY2qHZvBZA1MD8m/sAT5K9gahcOUZ
 0LRDX9HyUsIumkgWZm5Czm4Fbin2vA9D1630Cl+6bxnaSx9BcdRh38O9Iuz86DYqPHJK
 zR5rb0d8kFOqOc3OQZcy3g8h7XMiaeuB/L1YQQhZsRTbJY23kXezlz25Qhf5WYnEXVZ8
 S96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=J7jnwobGRIDUa/em/2YcJoKe5IITUTAYh0YoCe/oM4I=;
 b=rDwoIwBWsMSju6b28gnLw52jsoSwSNhROGASZHKrah9PLW+333DWo1CWxGPWXaC6Ge
 EZ3LI2WMF+IX0GfSWiNe9zrr0lG2O8ESkGMSP5Eu+RPsy5AniO6BVY66NHg19om60+LJ
 LCdwHrqUMV6BQry+ZiXEz0Fm9hgDWcJ6yI+ZzUvmwN1ii0NrbIbeUV30oY9UK78gORTb
 f6wD4yuwovnpBgU3Qk4p1mEL7HWe/mlbFCpZuqQGRxRh7l7uSZ2SrccTRTzyDuSuisum
 fu6E0ENTI4QdbET6sFgY2QTeAaOHHxkQlvgDa1qmhvoldfplCKeuv/ekufpgnl5cZdLm
 Mhtw==
X-Gm-Message-State: AOAM530phdNVkupwwMocPsGgBmG9M1oqf+Xpj2ldml7mcLhUho1JEb0x
 q3gS+o8UeDHOOZnnTpzJ8vLZcZYZlLiT8IVn
X-Google-Smtp-Source: ABdhPJzaJVwJVMkVpCrTVXmdc4w6tnDyJND6q4wPE1faO9V/tRjsoO+pAuXRRcFGGTlTLenoZq4kpg==
X-Received: by 2002:a65:66c4:: with SMTP id c4mr1991372pgw.442.1599119042329; 
 Thu, 03 Sep 2020 00:44:02 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id o6sm1512472pju.25.2020.09.03.00.43.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 00:44:01 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 11/12] tests: Disable test-image-locking that not works
 under Win32
Date: Thu,  3 Sep 2020 15:43:12 +0800
Message-Id: <20200903074313.1498-12-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200903074313.1498-1-luoyonggang@gmail.com>
References: <20200903074313.1498-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x444.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tests/Makefile.include | 1086 ++++++++++++++++++++--------------------
 1 file changed, 544 insertions(+), 542 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 9ac8f5b86a..497f1f21ff 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -1,542 +1,544 @@
-# -*- Mode: makefile -*-
-
-.PHONY: check-help
-check-help:
-	@echo "Regression testing targets:"
-	@echo
-	@echo " $(MAKE) check                Run block, qapi-schema, unit, softfl=
oat, qtest and decodetree tests"
-	@echo
-	@echo " $(MAKE) check-qtest-TARGET   Run qtest tests for given target"
-	@echo " $(MAKE) check-qtest          Run qtest tests"
-	@echo " $(MAKE) check-unit           Run qobject tests"
-	@echo " $(MAKE) check-speed          Run qobject speed tests"
-	@echo " $(MAKE) check-qapi-schema    Run QAPI schema tests"
-	@echo " $(MAKE) check-block          Run block tests"
-ifeq ($(CONFIG_TCG),y)
-	@echo " $(MAKE) check-tcg            Run TCG tests"
-	@echo " $(MAKE) check-softfloat      Run FPU emulation tests"
-endif
-	@echo " $(MAKE) check-acceptance     Run all acceptance (functional) test=
s"
-	@echo
-	@echo " $(MAKE) check-report.tap     Generates an aggregated TAP test rep=
ort"
-	@echo " $(MAKE) check-venv           Creates a Python venv for tests"
-	@echo " $(MAKE) check-clean          Clean the tests and related data"
-	@echo
-	@echo "The following are useful for CI builds"
-	@echo " $(MAKE) check-build          Build most test binaris"
-	@echo " $(MAKE) get-vm-images        Downloads all images used by accepta=
nce tests, according to configured targets (~350 MB each, 1.5 GB max)"
-	@echo
-	@echo
-	@echo "The variable SPEED can be set to control the gtester speed setting=
."
-	@echo "Default options are -k and (for $(MAKE) V=3D1) --verbose; they can=
 be"
-	@echo "changed with variable GTESTER_OPTIONS."
-
-ifneq ($(wildcard config-host.mak),)
-export SRC_PATH
-
-# TODO don't duplicate $(SRC_PATH)/Makefile's qapi-py here
-qapi-py =3D $(SRC_PATH)/scripts/qapi/__init__.py \
-$(SRC_PATH)/scripts/qapi/commands.py \
-$(SRC_PATH)/scripts/qapi/common.py \
-$(SRC_PATH)/scripts/qapi/doc.py \
-$(SRC_PATH)/scripts/qapi/error.py \
-$(SRC_PATH)/scripts/qapi/events.py \
-$(SRC_PATH)/scripts/qapi/expr.py \
-$(SRC_PATH)/scripts/qapi/gen.py \
-$(SRC_PATH)/scripts/qapi/introspect.py \
-$(SRC_PATH)/scripts/qapi/parser.py \
-$(SRC_PATH)/scripts/qapi/schema.py \
-$(SRC_PATH)/scripts/qapi/source.py \
-$(SRC_PATH)/scripts/qapi/types.py \
-$(SRC_PATH)/scripts/qapi/visit.py \
-$(SRC_PATH)/scripts/qapi-gen.py
-
-# Get the list of all supported sysemu targets
-SYSEMU_TARGET_LIST :=3D $(subst -softmmu.mak,,$(notdir \
-   $(wildcard $(SRC_PATH)/default-configs/*-softmmu.mak)))
-
-check-unit-y +=3D tests/check-qdict$(EXESUF)
-check-unit-y +=3D tests/check-block-qdict$(EXESUF)
-check-unit-y +=3D tests/check-qnum$(EXESUF)
-check-unit-y +=3D tests/check-qstring$(EXESUF)
-check-unit-y +=3D tests/check-qlist$(EXESUF)
-check-unit-y +=3D tests/check-qnull$(EXESUF)
-check-unit-y +=3D tests/check-qobject$(EXESUF)
-check-unit-y +=3D tests/check-qjson$(EXESUF)
-check-unit-y +=3D tests/check-qlit$(EXESUF)
-check-unit-y +=3D tests/test-qobject-output-visitor$(EXESUF)
-check-unit-y +=3D tests/test-clone-visitor$(EXESUF)
-check-unit-y +=3D tests/test-qobject-input-visitor$(EXESUF)
-check-unit-$(CONFIG_SOFTMMU) +=3D tests/test-qmp-cmds$(EXESUF)
-check-unit-y +=3D tests/test-string-input-visitor$(EXESUF)
-check-unit-y +=3D tests/test-string-output-visitor$(EXESUF)
-check-unit-y +=3D tests/test-qmp-event$(EXESUF)
-check-unit-y +=3D tests/test-opts-visitor$(EXESUF)
-check-unit-$(CONFIG_BLOCK) +=3D tests/test-coroutine$(EXESUF)
-check-unit-y +=3D tests/test-visitor-serialization$(EXESUF)
-check-unit-$(CONFIG_SOFTMMU) +=3D tests/test-iov$(EXESUF)
-check-unit-y +=3D tests/test-bitmap$(EXESUF)
-check-unit-$(CONFIG_BLOCK) +=3D tests/test-aio$(EXESUF)
-check-unit-$(CONFIG_BLOCK) +=3D tests/test-aio-multithread$(EXESUF)
-check-unit-$(CONFIG_BLOCK) +=3D tests/test-throttle$(EXESUF)
-check-unit-$(CONFIG_BLOCK) +=3D tests/test-thread-pool$(EXESUF)
-check-unit-$(CONFIG_BLOCK) +=3D tests/test-hbitmap$(EXESUF)
-check-unit-$(CONFIG_BLOCK) +=3D tests/test-bdrv-drain$(EXESUF)
-check-unit-$(CONFIG_BLOCK) +=3D tests/test-bdrv-graph-mod$(EXESUF)
-check-unit-$(CONFIG_BLOCK) +=3D tests/test-blockjob$(EXESUF)
-check-unit-$(CONFIG_BLOCK) +=3D tests/test-blockjob-txn$(EXESUF)
-check-unit-$(CONFIG_BLOCK) +=3D tests/test-block-backend$(EXESUF)
-check-unit-$(CONFIG_BLOCK) +=3D tests/test-block-iothread$(EXESUF)
-check-unit-$(CONFIG_BLOCK) +=3D tests/test-image-locking$(EXESUF)
-check-unit-y +=3D tests/test-x86-cpuid$(EXESUF)
-# all code tested by test-x86-cpuid is inside topology.h
-ifeq ($(CONFIG_SOFTMMU),y)
-check-unit-y +=3D tests/test-xbzrle$(EXESUF)
-check-unit-$(CONFIG_POSIX) +=3D tests/test-vmstate$(EXESUF)
-endif
-check-unit-y +=3D tests/test-cutils$(EXESUF)
-check-unit-y +=3D tests/test-shift128$(EXESUF)
-check-unit-y +=3D tests/test-mul64$(EXESUF)
-check-unit-y +=3D tests/test-int128$(EXESUF)
-# all code tested by test-int128 is inside int128.h
-check-unit-y +=3D tests/rcutorture$(EXESUF)
-check-unit-y +=3D tests/test-rcu-list$(EXESUF)
-check-unit-y +=3D tests/test-rcu-simpleq$(EXESUF)
-check-unit-y +=3D tests/test-rcu-tailq$(EXESUF)
-check-unit-y +=3D tests/test-rcu-slist$(EXESUF)
-check-unit-y +=3D tests/test-qdist$(EXESUF)
-check-unit-y +=3D tests/test-qht$(EXESUF)
-check-unit-y +=3D tests/test-qht-par$(EXESUF)
-check-unit-y +=3D tests/test-bitops$(EXESUF)
-check-unit-y +=3D tests/test-bitcnt$(EXESUF)
-check-unit-y +=3D tests/test-qgraph$(EXESUF)
-check-unit-y +=3D tests/check-qom-interface$(EXESUF)
-check-unit-y +=3D tests/check-qom-proplist$(EXESUF)
-check-unit-y +=3D tests/test-qemu-opts$(EXESUF)
-check-unit-y +=3D tests/test-keyval$(EXESUF)
-check-unit-$(CONFIG_BLOCK) +=3D tests/test-write-threshold$(EXESUF)
-check-unit-$(CONFIG_BLOCK) +=3D tests/test-crypto-hash$(EXESUF)
-check-speed-$(CONFIG_BLOCK) +=3D tests/benchmark-crypto-hash$(EXESUF)
-check-unit-$(CONFIG_BLOCK) +=3D tests/test-crypto-hmac$(EXESUF)
-check-speed-$(CONFIG_BLOCK) +=3D tests/benchmark-crypto-hmac$(EXESUF)
-check-unit-$(CONFIG_BLOCK) +=3D tests/test-crypto-cipher$(EXESUF)
-check-speed-$(CONFIG_BLOCK) +=3D tests/benchmark-crypto-cipher$(EXESUF)
-check-unit-$(CONFIG_BLOCK) +=3D tests/test-crypto-secret$(EXESUF)
-check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_GNUTLS)) +=3D tests/test-c=
rypto-tlscredsx509$(EXESUF)
-check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_GNUTLS)) +=3D tests/test-c=
rypto-tlssession$(EXESUF)
-ifndef CONFIG_TSAN
-# Some tests: test-char, test-qdev-global-props, and test-qga,
-# are not runnable under TSan due to a known issue.
-# https://github.com/google/sanitizers/issues/1116
-check-unit-$(CONFIG_SOFTMMU) +=3D tests/test-char$(EXESUF)
-check-unit-$(CONFIG_SOFTMMU) +=3D tests/test-qdev-global-props$(EXESUF)
-ifeq ($(CONFIG_GUEST_AGENT),y)
-check-unit-$(call land,$(CONFIG_LINUX),$(CONFIG_VIRTIO_SERIAL)) +=3D tests=
/test-qga$(EXESUF)
-endif
-endif
-check-unit-$(CONFIG_SOFTMMU) +=3D tests/test-timed-average$(EXESUF)
-check-unit-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_INOTIFY1)) +=3D tests/te=
st-util-filemonitor$(EXESUF)
-check-unit-$(CONFIG_SOFTMMU) +=3D tests/test-util-sockets$(EXESUF)
-check-unit-$(CONFIG_BLOCK) +=3D tests/test-authz-simple$(EXESUF)
-check-unit-$(CONFIG_BLOCK) +=3D tests/test-authz-list$(EXESUF)
-check-unit-$(CONFIG_BLOCK) +=3D tests/test-authz-listfile$(EXESUF)
-check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_AUTH_PAM)) +=3D tests/test=
-authz-pam$(EXESUF)
-check-unit-$(CONFIG_BLOCK) +=3D tests/test-io-task$(EXESUF)
-check-unit-$(CONFIG_BLOCK) +=3D tests/test-io-channel-socket$(EXESUF)
-check-unit-$(CONFIG_BLOCK) +=3D tests/test-io-channel-file$(EXESUF)
-check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_GNUTLS)) +=3D tests/test-i=
o-channel-tls$(EXESUF)
-check-unit-$(CONFIG_BLOCK) +=3D tests/test-io-channel-command$(EXESUF)
-check-unit-$(CONFIG_BLOCK) +=3D tests/test-io-channel-buffer$(EXESUF)
-check-unit-$(CONFIG_SOFTMMU) +=3D tests/test-base64$(EXESUF)
-check-unit-$(call land,$(CONFIG_BLOCK),$(if $(CONFIG_NETTLE),y,$(CONFIG_GC=
RYPT))) +=3D tests/test-crypto-pbkdf$(EXESUF)
-check-unit-$(CONFIG_BLOCK) +=3D tests/test-crypto-ivgen$(EXESUF)
-check-unit-$(CONFIG_BLOCK)  +=3D tests/test-crypto-afsplit$(EXESUF)
-check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_QEMU_PRIVATE_XTS)) +=3D te=
sts/test-crypto-xts$(EXESUF)
-check-unit-$(CONFIG_BLOCK)  +=3D tests/test-crypto-block$(EXESUF)
-check-unit-y +=3D tests/test-logging$(EXESUF)
-check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_REPLICATION)) +=3D tests/t=
est-replication$(EXESUF)
-check-unit-$(CONFIG_SOFTMMU) +=3D tests/test-bufferiszero$(EXESUF)
-check-unit-y +=3D tests/test-uuid$(EXESUF)
-check-unit-y +=3D tests/ptimer-test$(EXESUF)
-check-unit-y +=3D tests/test-qapi-util$(EXESUF)
-
-generated-files-y +=3D tests/test-qapi-types.h
-generated-files-y +=3D tests/include/test-qapi-types-sub-module.h
-generated-files-y +=3D tests/test-qapi-types-sub-sub-module.h
-generated-files-y +=3D tests/test-qapi-visit.h
-generated-files-y +=3D tests/include/test-qapi-visit-sub-module.h
-generated-files-y +=3D tests/test-qapi-visit-sub-sub-module.h
-generated-files-y +=3D tests/test-qapi-commands.h
-generated-files-y +=3D tests/test-qapi-init-commands.h
-generated-files-y +=3D tests/include/test-qapi-commands-sub-module.h
-generated-files-y +=3D tests/test-qapi-commands-sub-sub-module.h
-generated-files-y +=3D tests/test-qapi-emit-events.h
-generated-files-y +=3D tests/test-qapi-events.h
-generated-files-y +=3D tests/include/test-qapi-events-sub-module.h
-generated-files-y +=3D tests/test-qapi-events-sub-sub-module.h
-generated-files-y +=3D tests/test-qapi-introspect.h
-
-QEMU_CFLAGS +=3D -I$(SRC_PATH)/tests -I$(SRC_PATH)/tests/qtest
-
-
-# Deps that are common to various different sets of tests below
-test-util-obj-y =3D libqemuutil.a
-test-qom-obj-y =3D $(qom-obj-y) $(test-util-obj-y)
-test-qapi-obj-y =3D tests/test-qapi-types.o \
-	tests/include/test-qapi-types-sub-module.o \
-	tests/test-qapi-types-sub-sub-module.o \
-	tests/test-qapi-visit.o \
-	tests/include/test-qapi-visit-sub-module.o \
-	tests/test-qapi-visit-sub-sub-module.o \
-	tests/test-qapi-introspect.o \
-	$(test-qom-obj-y)
-benchmark-crypto-obj-$(CONFIG_BLOCK) =3D $(authz-obj-y) $(crypto-obj-y) $(=
test-qom-obj-y)
-test-crypto-obj-$(CONFIG_BLOCK) =3D $(authz-obj-y) $(crypto-obj-y) $(test-=
qom-obj-y)
-test-io-obj-$(CONFIG_BLOCK) =3D $(io-obj-y) $(test-crypto-obj-y)
-test-authz-obj-$(CONFIG_BLOCK) =3D $(test-qom-obj-y) $(authz-obj-y)
-test-block-obj-$(CONFIG_BLOCK) =3D $(block-obj-y) $(test-io-obj-y) tests/i=
othread.o
-
-tests/check-qnum$(EXESUF): tests/check-qnum.o $(test-util-obj-y)
-tests/check-qstring$(EXESUF): tests/check-qstring.o $(test-util-obj-y)
-tests/check-qdict$(EXESUF): tests/check-qdict.o $(test-util-obj-y)
-tests/check-block-qdict$(EXESUF): tests/check-block-qdict.o $(test-util-ob=
j-y)
-tests/check-qlist$(EXESUF): tests/check-qlist.o $(test-util-obj-y)
-tests/check-qnull$(EXESUF): tests/check-qnull.o $(test-util-obj-y)
-tests/check-qobject$(EXESUF): tests/check-qobject.o $(test-util-obj-y)
-tests/check-qjson$(EXESUF): tests/check-qjson.o $(test-util-obj-y)
-tests/check-qlit$(EXESUF): tests/check-qlit.o $(test-util-obj-y)
-tests/check-qom-interface$(EXESUF): tests/check-qom-interface.o $(test-qom=
-obj-y)
-tests/check-qom-proplist$(EXESUF): tests/check-qom-proplist.o $(test-qom-o=
bj-y)
-
-tests/test-char$(EXESUF): tests/test-char.o $(test-util-obj-y) $(test-io-o=
bj-y) $(chardev-obj-y) tests/socket-helpers.o
-tests/test-coroutine$(EXESUF): tests/test-coroutine.o $(test-block-obj-y)
-tests/test-aio$(EXESUF): tests/test-aio.o $(test-block-obj-y)
-tests/test-aio-multithread$(EXESUF): tests/test-aio-multithread.o $(test-b=
lock-obj-y)
-tests/test-throttle$(EXESUF): tests/test-throttle.o $(test-block-obj-y)
-tests/test-bdrv-drain$(EXESUF): tests/test-bdrv-drain.o $(test-block-obj-y=
) $(test-util-obj-y)
-tests/test-bdrv-graph-mod$(EXESUF): tests/test-bdrv-graph-mod.o $(test-blo=
ck-obj-y) $(test-util-obj-y)
-tests/test-blockjob$(EXESUF): tests/test-blockjob.o $(test-block-obj-y) $(=
test-util-obj-y)
-tests/test-blockjob-txn$(EXESUF): tests/test-blockjob-txn.o $(test-block-o=
bj-y) $(test-util-obj-y)
-tests/test-block-backend$(EXESUF): tests/test-block-backend.o $(test-block=
-obj-y) $(test-util-obj-y)
-tests/test-block-iothread$(EXESUF): tests/test-block-iothread.o $(test-blo=
ck-obj-y) $(test-util-obj-y)
-tests/test-image-locking$(EXESUF): tests/test-image-locking.o $(test-block=
-obj-y) $(test-util-obj-y)
-tests/test-thread-pool$(EXESUF): tests/test-thread-pool.o $(test-block-obj=
-y)
-tests/test-iov$(EXESUF): tests/test-iov.o $(test-util-obj-y)
-tests/test-hbitmap$(EXESUF): tests/test-hbitmap.o $(test-util-obj-y) $(tes=
t-crypto-obj-y)
-tests/test-bitmap$(EXESUF): tests/test-bitmap.o $(test-util-obj-y)
-tests/test-x86-cpuid$(EXESUF): tests/test-x86-cpuid.o
-tests/test-xbzrle$(EXESUF): tests/test-xbzrle.o migration/libmigration.fa =
$(test-util-obj-y) \
-	$(test-io-obj-y)
-tests/test-cutils$(EXESUF): tests/test-cutils.o util/cutils.o $(test-util-=
obj-y)
-tests/test-int128$(EXESUF): tests/test-int128.o
-tests/rcutorture$(EXESUF): tests/rcutorture.o $(test-util-obj-y)
-tests/test-rcu-list$(EXESUF): tests/test-rcu-list.o $(test-util-obj-y)
-tests/test-rcu-simpleq$(EXESUF): tests/test-rcu-simpleq.o $(test-util-obj-=
y)
-tests/test-rcu-tailq$(EXESUF): tests/test-rcu-tailq.o $(test-util-obj-y)
-tests/test-rcu-slist$(EXESUF): tests/test-rcu-slist.o $(test-util-obj-y)
-tests/test-qdist$(EXESUF): tests/test-qdist.o $(test-util-obj-y)
-tests/test-qht$(EXESUF): tests/test-qht.o $(test-util-obj-y)
-tests/test-qht-par$(EXESUF): tests/test-qht-par.o tests/qht-bench$(EXESUF)=
 $(test-util-obj-y)
-tests/qht-bench$(EXESUF): tests/qht-bench.o $(test-util-obj-y)
-tests/test-bufferiszero$(EXESUF): tests/test-bufferiszero.o $(test-util-ob=
j-y)
-tests/atomic_add-bench$(EXESUF): tests/atomic_add-bench.o $(test-util-obj-=
y)
-tests/atomic64-bench$(EXESUF): tests/atomic64-bench.o $(test-util-obj-y)
-
-tests/test-qdev-global-props$(EXESUF): tests/test-qdev-global-props.o hw/c=
ore/libhwcore.fa \
-	$(test-qapi-obj-y)
-tests/test-vmstate$(EXESUF): tests/test-vmstate.o migration/libmigration.f=
a \
-	$(test-io-obj-y)
-tests/test-timed-average$(EXESUF): tests/test-timed-average.o $(test-util-=
obj-y)
-tests/test-base64$(EXESUF): tests/test-base64.o $(test-util-obj-y)
-tests/ptimer-test$(EXESUF): tests/ptimer-test.o tests/ptimer-test-stubs.o =
hw/core/ptimer.o
-tests/test-qemu-opts$(EXESUF): tests/test-qemu-opts.o $(test-util-obj-y)
-tests/test-keyval$(EXESUF): tests/test-keyval.o $(test-util-obj-y) $(test-=
qapi-obj-y)
-tests/test-write-threshold$(EXESUF): tests/test-write-threshold.o $(test-b=
lock-obj-y)
-tests/test-uuid$(EXESUF): tests/test-uuid.o $(test-util-obj-y)
-tests/test-qapi-util$(EXESUF): tests/test-qapi-util.o $(test-util-obj-y)
-
-tests/test-logging$(EXESUF): tests/test-logging.o $(test-util-obj-y)
-
-tests/test-replication$(EXESUF): tests/test-replication.o $(test-util-obj-=
y) \
-	$(test-block-obj-y)
-
-tests/test-qapi-types.c tests/test-qapi-types.h \
-tests/include/test-qapi-types-sub-module.c \
-tests/include/test-qapi-types-sub-module.h \
-tests/test-qapi-types-sub-sub-module.c \
-tests/test-qapi-types-sub-sub-module.h \
-tests/test-qapi-visit.c tests/test-qapi-visit.h \
-tests/include/test-qapi-visit-sub-module.c \
-tests/include/test-qapi-visit-sub-module.h \
-tests/test-qapi-visit-sub-sub-module.c \
-tests/test-qapi-visit-sub-sub-module.h \
-tests/test-qapi-commands.h tests/test-qapi-commands.c \
-tests/include/test-qapi-commands-sub-module.h \
-tests/include/test-qapi-commands-sub-module.c \
-tests/test-qapi-commands-sub-sub-module.h \
-tests/test-qapi-commands-sub-sub-module.c \
-tests/test-qapi-emit-events.c tests/test-qapi-emit-events.h \
-tests/test-qapi-events.c tests/test-qapi-events.h \
-tests/test-qapi-init-commands.c \
-tests/test-qapi-init-commands.h \
-tests/include/test-qapi-events-sub-module.c \
-tests/include/test-qapi-events-sub-module.h \
-tests/test-qapi-events-sub-sub-module.c \
-tests/test-qapi-events-sub-sub-module.h \
-tests/test-qapi-introspect.c tests/test-qapi-introspect.h: \
-tests/test-qapi-gen-timestamp ;
-tests/test-qapi-gen-timestamp: \
-		$(SRC_PATH)/tests/qapi-schema/qapi-schema-test.json \
-		$(SRC_PATH)/tests/qapi-schema/include/sub-module.json \
-		$(SRC_PATH)/tests/qapi-schema/sub-sub-module.json \
-		$(qapi-py)
-	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-gen.py \
-		-o tests -p "test-" $<, \
-		"GEN","$(@:%-timestamp=3D%)")
-	@rm -f tests/test-qapi-doc.texi
-	@>$@
-
-tests/test-string-output-visitor$(EXESUF): tests/test-string-output-visito=
r.o $(test-qapi-obj-y)
-tests/test-string-input-visitor$(EXESUF): tests/test-string-input-visitor.=
o $(test-qapi-obj-y)
-tests/test-qmp-event$(EXESUF): tests/test-qmp-event.o $(test-qapi-obj-y) t=
ests/test-qapi-emit-events.o tests/test-qapi-events.o
-tests/test-qobject-output-visitor$(EXESUF): tests/test-qobject-output-visi=
tor.o $(test-qapi-obj-y)
-tests/test-clone-visitor$(EXESUF): tests/test-clone-visitor.o $(test-qapi-=
obj-y)
-tests/test-qobject-input-visitor$(EXESUF): tests/test-qobject-input-visito=
r.o $(test-qapi-obj-y)
-tests/test-qmp-cmds$(EXESUF): tests/test-qmp-cmds.o tests/test-qapi-comman=
ds.o tests/test-qapi-init-commands.o $(test-qapi-obj-y)
-tests/test-visitor-serialization$(EXESUF): tests/test-visitor-serializatio=
n.o $(test-qapi-obj-y)
-tests/test-opts-visitor$(EXESUF): tests/test-opts-visitor.o $(test-qapi-ob=
j-y)
-
-tests/test-shift128$(EXESUF): tests/test-shift128.o $(test-util-obj-y)
-tests/test-mul64$(EXESUF): tests/test-mul64.o $(test-util-obj-y)
-tests/test-bitops$(EXESUF): tests/test-bitops.o $(test-util-obj-y)
-tests/test-bitcnt$(EXESUF): tests/test-bitcnt.o $(test-util-obj-y)
-tests/test-qgraph$(EXESUF): tests/test-qgraph.o tests/qtest/libqos/qgraph.=
o $(test-util-obj-y)
-tests/test-crypto-hash$(EXESUF): tests/test-crypto-hash.o $(test-crypto-ob=
j-y)
-tests/benchmark-crypto-hash$(EXESUF): tests/benchmark-crypto-hash.o $(test=
-crypto-obj-y)
-tests/test-crypto-hmac$(EXESUF): tests/test-crypto-hmac.o $(test-crypto-ob=
j-y)
-tests/benchmark-crypto-hmac$(EXESUF): tests/benchmark-crypto-hmac.o $(test=
-crypto-obj-y)
-tests/test-crypto-cipher$(EXESUF): tests/test-crypto-cipher.o $(test-crypt=
o-obj-y)
-tests/benchmark-crypto-cipher$(EXESUF): tests/benchmark-crypto-cipher.o $(=
test-crypto-obj-y)
-tests/test-crypto-secret$(EXESUF): tests/test-crypto-secret.o $(test-crypt=
o-obj-y)
-tests/test-crypto-xts$(EXESUF): tests/test-crypto-xts.o $(test-crypto-obj-=
y)
-
-ifeq ($(CONFIG_TEST_SECRET_KEYRING),y)
-tests/test-crypto-secret.o-libs :=3D -lkeyutils
-endif
-
-tests/crypto-tls-x509-helpers.o-cflags :=3D $(TASN1_CFLAGS)
-tests/crypto-tls-x509-helpers.o-libs :=3D $(TASN1_LIBS)
-tests/pkix_asn1_tab.o-cflags :=3D $(TASN1_CFLAGS)
-
-tests/test-crypto-tlscredsx509.o-cflags :=3D $(TASN1_CFLAGS)
-tests/test-crypto-tlscredsx509$(EXESUF): tests/test-crypto-tlscredsx509.o \
-	tests/crypto-tls-x509-helpers.o tests/pkix_asn1_tab.o $(test-crypto-obj-y)
-
-tests/test-crypto-tlssession.o-cflags :=3D $(TASN1_CFLAGS)
-tests/test-crypto-tlssession$(EXESUF): tests/test-crypto-tlssession.o \
-	tests/crypto-tls-x509-helpers.o tests/pkix_asn1_tab.o \
-	tests/crypto-tls-psk-helpers.o \
-        $(test-crypto-obj-y)
-tests/test-util-filemonitor$(EXESUF): tests/test-util-filemonitor.o \
-	$(test-util-obj-y)
-tests/test-util-sockets$(EXESUF): tests/test-util-sockets.o \
-	tests/socket-helpers.o $(test-util-obj-y)
-tests/test-authz-simple$(EXESUF): tests/test-authz-simple.o $(test-authz-o=
bj-y)
-tests/test-authz-list$(EXESUF): tests/test-authz-list.o $(test-authz-obj-y)
-tests/test-authz-listfile$(EXESUF): tests/test-authz-listfile.o $(test-aut=
hz-obj-y)
-tests/test-authz-pam$(EXESUF): tests/test-authz-pam.o $(test-authz-obj-y)
-tests/test-io-task$(EXESUF): tests/test-io-task.o $(test-io-obj-y)
-tests/test-io-channel-socket$(EXESUF): tests/test-io-channel-socket.o \
-        tests/io-channel-helpers.o tests/socket-helpers.o $(test-io-obj-y)
-tests/test-io-channel-file$(EXESUF): tests/test-io-channel-file.o \
-        tests/io-channel-helpers.o $(test-io-obj-y)
-tests/test-io-channel-tls$(EXESUF): tests/test-io-channel-tls.o \
-	tests/crypto-tls-x509-helpers.o tests/pkix_asn1_tab.o \
-	tests/io-channel-helpers.o $(test-io-obj-y)
-tests/test-io-channel-command$(EXESUF): tests/test-io-channel-command.o \
-        tests/io-channel-helpers.o $(test-io-obj-y)
-tests/test-io-channel-buffer$(EXESUF): tests/test-io-channel-buffer.o \
-        tests/io-channel-helpers.o $(test-io-obj-y)
-tests/test-crypto-pbkdf$(EXESUF): tests/test-crypto-pbkdf.o $(test-crypto-=
obj-y)
-tests/test-crypto-ivgen$(EXESUF): tests/test-crypto-ivgen.o $(test-crypto-=
obj-y)
-tests/test-crypto-afsplit$(EXESUF): tests/test-crypto-afsplit.o $(test-cry=
pto-obj-y)
-tests/test-crypto-block$(EXESUF): tests/test-crypto-block.o $(test-crypto-=
obj-y)
-
-tests/migration/stress$(EXESUF): tests/migration/stress.o
-	$(call quiet-command, $(LINKPROG) -static -O3 $(PTHREAD_LIB) -o $@ $< ,"L=
INK","$(TARGET_DIR)$@")
-
-INITRD_WORK_DIR=3Dtests/migration/initrd
-
-tests/migration/initrd-stress.img: tests/migration/stress$(EXESUF)
-	mkdir -p $(INITRD_WORK_DIR)
-	cp $< $(INITRD_WORK_DIR)/init
-	(cd $(INITRD_WORK_DIR) && (find | cpio --quiet -o -H newc | gzip -9)) > $@
-	rm $(INITRD_WORK_DIR)/init
-	rmdir $(INITRD_WORK_DIR)
-
-tests/test-qga$(EXESUF): qga/qemu-ga$(EXESUF)
-tests/test-qga$(EXESUF): tests/test-qga.o tests/qtest/libqtest.o $(test-ut=
il-obj-y)
-tests/vhost-user-bridge$(EXESUF): tests/vhost-user-bridge.o $(test-util-ob=
j-y) libvhost-user.a
-tests/qemu-iotests/socket_scm_helper$(EXESUF): tests/qemu-iotests/socket_s=
cm_helper.o
-
-SPEED =3D quick
-
-# gtester tests, possibly with verbose output
-# do_test_tap runs all tests, even if some of them fail, while do_test_hum=
an
-# stops at the first failure unless -k is given on the command line
-
-define do_test_human_k
-        $(quiet-@)rc=3D0; $(foreach COMMAND, $1, \
-          $(call quiet-command-run, \
-            export MALLOC_PERTURB_=3D$${MALLOC_PERTURB_:-$$(( $${RANDOM:-0=
} % 255 + 1))} $2; \
-              $(COMMAND) -m=3D$(SPEED) -k --tap < /dev/null \
-              | ./scripts/tap-driver.pl --test-name=3D"$(notdir $(COMMAND)=
)" $(if $(V),, --show-failures-only) \
-              || rc=3D$$?;, "TEST", "$@: $(COMMAND)")) exit $$rc
-endef
-define do_test_human_no_k
-        $(foreach COMMAND, $1, \
-          $(call quiet-command, \
-            MALLOC_PERTURB_=3D$${MALLOC_PERTURB_:-$$(( $${RANDOM:-0} % 255=
 + 1))} $2 \
-              $(COMMAND) -m=3D$(SPEED) -k --tap < /dev/null \
-              | ./scripts/tap-driver.pl --test-name=3D"$(notdir $(COMMAND)=
)" $(if $(V),, --show-failures-only), \
-              "TEST", "$@: $(COMMAND)")
-)
-endef
-do_test_human =3D \
-        $(if $(findstring k, $(MAKEFLAGS)), $(do_test_human_k), $(do_test_=
human_no_k))
-
-define do_test_tap
-	$(call quiet-command, \
-          { export MALLOC_PERTURB_=3D$${MALLOC_PERTURB_:-$$(( $${RANDOM:-0=
} % 255 + 1))} $2; \
-            $(foreach COMMAND, $1, \
-	      $(COMMAND) -m=3D$(SPEED) -k --tap < /dev/null \
-	      | sed "s/^\(not \)\?ok [0-9]* /&$(notdir $(COMMAND)) /" || true; ) =
} \
-	      | ./scripts/tap-merge.pl | tee "$@" \
-	      | ./scripts/tap-driver.pl $(if $(V),, --show-failures-only), \
-	  "TAP","$@")
-endef
-
-build-unit: $(check-unit-y)
-
-check-unit: $(check-unit-y)
-	$(call do_test_human, $^)
-
-check-speed: $(check-speed-y)
-	$(call do_test_human, $^)
-
-# gtester tests with TAP output
-
-check-report-unit.tap: $(check-unit-y)
-	$(call do_test_tap,$^)
-
-# Per guest TCG tests
-
-BUILD_TCG_TARGET_RULES=3D$(patsubst %,build-tcg-tests-%, $(TARGET_DIRS))
-CLEAN_TCG_TARGET_RULES=3D$(patsubst %,clean-tcg-tests-%, $(TARGET_DIRS))
-RUN_TCG_TARGET_RULES=3D$(patsubst %,run-tcg-tests-%, $(TARGET_DIRS))
-
-# Probe for the Docker Builds needed for each build
-$(foreach PROBE_TARGET,$(TARGET_DIRS), 				\
-	$(eval -include $(SRC_PATH)/tests/tcg/Makefile.prereqs))
-
-build-tcg-tests-%: $(if $(CONFIG_PLUGIN),plugins)
-	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) \
-		-f $(SRC_PATH)/tests/tcg/Makefile.qemu \
-		SRC_PATH=3D$(SRC_PATH) \
-	       	V=3D"$(V)" TARGET=3D"$*" guest-tests, \
-		"BUILD", "TCG tests for $*")
-
-run-tcg-tests-%: build-tcg-tests-% all
-	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) \
-		-f $(SRC_PATH)/tests/tcg/Makefile.qemu \
-		SRC_PATH=3D$(SRC_PATH) SPEED=3D"$(SPEED)" \
-		V=3D"$(V)" TARGET=3D"$*" run-guest-tests, \
-		"RUN", "TCG tests for $*")
-
-clean-tcg-tests-%:
-	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) \
-		-f $(SRC_PATH)/tests/tcg/Makefile.qemu \
-		SRC_PATH=3D$(SRC_PATH) TARGET=3D"$*" clean-guest-tests, \
-		"CLEAN", "TCG tests for $*")
-
-.PHONY: build-tcg
-build-tcg: $(BUILD_TCG_TARGET_RULES)
-
-.PHONY: check-tcg
-check-tcg: $(RUN_TCG_TARGET_RULES)
-
-.PHONY: clean-tcg
-clean-tcg: $(CLEAN_TCG_TARGET_RULES)
-
-
-# Python venv for running tests
-
-.PHONY: check-venv check-acceptance
-
-TESTS_VENV_DIR=3D$(BUILD_DIR)/tests/venv
-TESTS_VENV_REQ=3D$(SRC_PATH)/tests/requirements.txt
-TESTS_RESULTS_DIR=3D$(BUILD_DIR)/tests/results
-# Controls the output generated by Avocado when running tests.
-# Any number of command separated loggers are accepted.  For more
-# information please refer to "avocado --help".
-AVOCADO_SHOW=3Dapp
-AVOCADO_TAGS=3D$(patsubst %-softmmu,-t arch:%, $(filter %-softmmu,$(TARGET=
_DIRS)))
-
-$(TESTS_VENV_DIR): $(TESTS_VENV_REQ)
-	$(call quiet-command, \
-            $(PYTHON) -m venv --system-site-packages $@, \
-            VENV, $@)
-	$(call quiet-command, \
-            $(TESTS_VENV_DIR)/bin/python -m pip -q install -r $(TESTS_VENV=
_REQ), \
-            PIP, $(TESTS_VENV_REQ))
-	$(call quiet-command, touch $@)
-
-$(TESTS_RESULTS_DIR):
-	$(call quiet-command, mkdir -p $@, \
-            MKDIR, $@)
-
-check-venv: $(TESTS_VENV_DIR)
-
-FEDORA_31_ARCHES_CANDIDATES=3D$(patsubst ppc64,ppc64le,$(TARGETS))
-FEDORA_31_ARCHES :=3D x86_64 aarch64 ppc64le s390x
-FEDORA_31_DOWNLOAD=3D$(filter $(FEDORA_31_ARCHES),$(FEDORA_31_ARCHES_CANDI=
DATES))
-
-# download one specific Fedora 31 image
-get-vm-image-fedora-31-%: check-venv
-	$(call quiet-command, \
-             $(TESTS_VENV_DIR)/bin/python -m avocado vmimage get \
-             --distro=3Dfedora --distro-version=3D31 --arch=3D$*, \
-	"AVOCADO", "Downloading acceptance tests VM image for $*")
-
-# download all vm images, according to defined targets
-get-vm-images: check-venv $(patsubst %,get-vm-image-fedora-31-%, $(FEDORA_=
31_DOWNLOAD))
-
-check-acceptance: check-venv $(TESTS_RESULTS_DIR) get-vm-images
-	$(call quiet-command, \
-            $(TESTS_VENV_DIR)/bin/python -m avocado \
-            --show=3D$(AVOCADO_SHOW) run --job-results-dir=3D$(TESTS_RESUL=
TS_DIR) \
-            --filter-by-tags-include-empty --filter-by-tags-include-empty-=
key \
-            $(AVOCADO_TAGS) \
-            $(if $(GITLAB_CI),,--failfast=3Don) tests/acceptance, \
-            "AVOCADO", "tests/acceptance")
-
-# Consolidated targets
-
-.PHONY: check-block check-unit check check-clean get-vm-images
-check-block:
-check-build: build-unit
-
-check-clean:
-	rm -rf $(check-unit-y) tests/*.o tests/*/*.o $(QEMU_IOTESTS_HELPERS-y)
-	rm -f tests/test-qapi-gen-timestamp
-	rm -rf $(TESTS_VENV_DIR) $(TESTS_RESULTS_DIR)
-
-check: check-unit
-
-clean: check-clean
-
-# Build the help program automatically
-
--include $(wildcard tests/*.d)
-
-endif
+# -*- Mode: makefile -*-=0D
+=0D
+.PHONY: check-help=0D
+check-help:=0D
+	@echo "Regression testing targets:"=0D
+	@echo=0D
+	@echo " $(MAKE) check                Run block, qapi-schema, unit, softfl=
oat, qtest and decodetree tests"=0D
+	@echo=0D
+	@echo " $(MAKE) check-qtest-TARGET   Run qtest tests for given target"=0D
+	@echo " $(MAKE) check-qtest          Run qtest tests"=0D
+	@echo " $(MAKE) check-unit           Run qobject tests"=0D
+	@echo " $(MAKE) check-speed          Run qobject speed tests"=0D
+	@echo " $(MAKE) check-qapi-schema    Run QAPI schema tests"=0D
+	@echo " $(MAKE) check-block          Run block tests"=0D
+ifeq ($(CONFIG_TCG),y)=0D
+	@echo " $(MAKE) check-tcg            Run TCG tests"=0D
+	@echo " $(MAKE) check-softfloat      Run FPU emulation tests"=0D
+endif=0D
+	@echo " $(MAKE) check-acceptance     Run all acceptance (functional) test=
s"=0D
+	@echo=0D
+	@echo " $(MAKE) check-report.tap     Generates an aggregated TAP test rep=
ort"=0D
+	@echo " $(MAKE) check-venv           Creates a Python venv for tests"=0D
+	@echo " $(MAKE) check-clean          Clean the tests and related data"=0D
+	@echo=0D
+	@echo "The following are useful for CI builds"=0D
+	@echo " $(MAKE) check-build          Build most test binaris"=0D
+	@echo " $(MAKE) get-vm-images        Downloads all images used by accepta=
nce tests, according to configured targets (~350 MB each, 1.5 GB max)"=0D
+	@echo=0D
+	@echo=0D
+	@echo "The variable SPEED can be set to control the gtester speed setting=
."=0D
+	@echo "Default options are -k and (for $(MAKE) V=3D1) --verbose; they can=
 be"=0D
+	@echo "changed with variable GTESTER_OPTIONS."=0D
+=0D
+ifneq ($(wildcard config-host.mak),)=0D
+export SRC_PATH=0D
+=0D
+# TODO don't duplicate $(SRC_PATH)/Makefile's qapi-py here=0D
+qapi-py =3D $(SRC_PATH)/scripts/qapi/__init__.py \=0D
+$(SRC_PATH)/scripts/qapi/commands.py \=0D
+$(SRC_PATH)/scripts/qapi/common.py \=0D
+$(SRC_PATH)/scripts/qapi/doc.py \=0D
+$(SRC_PATH)/scripts/qapi/error.py \=0D
+$(SRC_PATH)/scripts/qapi/events.py \=0D
+$(SRC_PATH)/scripts/qapi/expr.py \=0D
+$(SRC_PATH)/scripts/qapi/gen.py \=0D
+$(SRC_PATH)/scripts/qapi/introspect.py \=0D
+$(SRC_PATH)/scripts/qapi/parser.py \=0D
+$(SRC_PATH)/scripts/qapi/schema.py \=0D
+$(SRC_PATH)/scripts/qapi/source.py \=0D
+$(SRC_PATH)/scripts/qapi/types.py \=0D
+$(SRC_PATH)/scripts/qapi/visit.py \=0D
+$(SRC_PATH)/scripts/qapi-gen.py=0D
+=0D
+# Get the list of all supported sysemu targets=0D
+SYSEMU_TARGET_LIST :=3D $(subst -softmmu.mak,,$(notdir \=0D
+   $(wildcard $(SRC_PATH)/default-configs/*-softmmu.mak)))=0D
+=0D
+check-unit-y +=3D tests/check-qdict$(EXESUF)=0D
+check-unit-y +=3D tests/check-block-qdict$(EXESUF)=0D
+check-unit-y +=3D tests/check-qnum$(EXESUF)=0D
+check-unit-y +=3D tests/check-qstring$(EXESUF)=0D
+check-unit-y +=3D tests/check-qlist$(EXESUF)=0D
+check-unit-y +=3D tests/check-qnull$(EXESUF)=0D
+check-unit-y +=3D tests/check-qobject$(EXESUF)=0D
+check-unit-y +=3D tests/check-qjson$(EXESUF)=0D
+check-unit-y +=3D tests/check-qlit$(EXESUF)=0D
+check-unit-y +=3D tests/test-qobject-output-visitor$(EXESUF)=0D
+check-unit-y +=3D tests/test-clone-visitor$(EXESUF)=0D
+check-unit-y +=3D tests/test-qobject-input-visitor$(EXESUF)=0D
+check-unit-$(CONFIG_SOFTMMU) +=3D tests/test-qmp-cmds$(EXESUF)=0D
+check-unit-y +=3D tests/test-string-input-visitor$(EXESUF)=0D
+check-unit-y +=3D tests/test-string-output-visitor$(EXESUF)=0D
+check-unit-y +=3D tests/test-qmp-event$(EXESUF)=0D
+check-unit-y +=3D tests/test-opts-visitor$(EXESUF)=0D
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-coroutine$(EXESUF)=0D
+check-unit-y +=3D tests/test-visitor-serialization$(EXESUF)=0D
+check-unit-$(CONFIG_SOFTMMU) +=3D tests/test-iov$(EXESUF)=0D
+check-unit-y +=3D tests/test-bitmap$(EXESUF)=0D
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-aio$(EXESUF)=0D
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-aio-multithread$(EXESUF)=0D
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-throttle$(EXESUF)=0D
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-thread-pool$(EXESUF)=0D
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-hbitmap$(EXESUF)=0D
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-bdrv-drain$(EXESUF)=0D
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-bdrv-graph-mod$(EXESUF)=0D
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-blockjob$(EXESUF)=0D
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-blockjob-txn$(EXESUF)=0D
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-block-backend$(EXESUF)=0D
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-block-iothread$(EXESUF)=0D
+ifeq ($(CONFIG_POSIX),y)=0D
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-image-locking$(EXESUF)=0D
+endif=0D
+check-unit-y +=3D tests/test-x86-cpuid$(EXESUF)=0D
+# all code tested by test-x86-cpuid is inside topology.h=0D
+ifeq ($(CONFIG_SOFTMMU),y)=0D
+check-unit-y +=3D tests/test-xbzrle$(EXESUF)=0D
+check-unit-$(CONFIG_POSIX) +=3D tests/test-vmstate$(EXESUF)=0D
+endif=0D
+check-unit-y +=3D tests/test-cutils$(EXESUF)=0D
+check-unit-y +=3D tests/test-shift128$(EXESUF)=0D
+check-unit-y +=3D tests/test-mul64$(EXESUF)=0D
+check-unit-y +=3D tests/test-int128$(EXESUF)=0D
+# all code tested by test-int128 is inside int128.h=0D
+check-unit-y +=3D tests/rcutorture$(EXESUF)=0D
+check-unit-y +=3D tests/test-rcu-list$(EXESUF)=0D
+check-unit-y +=3D tests/test-rcu-simpleq$(EXESUF)=0D
+check-unit-y +=3D tests/test-rcu-tailq$(EXESUF)=0D
+check-unit-y +=3D tests/test-rcu-slist$(EXESUF)=0D
+check-unit-y +=3D tests/test-qdist$(EXESUF)=0D
+check-unit-y +=3D tests/test-qht$(EXESUF)=0D
+check-unit-y +=3D tests/test-qht-par$(EXESUF)=0D
+check-unit-y +=3D tests/test-bitops$(EXESUF)=0D
+check-unit-y +=3D tests/test-bitcnt$(EXESUF)=0D
+check-unit-y +=3D tests/test-qgraph$(EXESUF)=0D
+check-unit-y +=3D tests/check-qom-interface$(EXESUF)=0D
+check-unit-y +=3D tests/check-qom-proplist$(EXESUF)=0D
+check-unit-y +=3D tests/test-qemu-opts$(EXESUF)=0D
+check-unit-y +=3D tests/test-keyval$(EXESUF)=0D
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-write-threshold$(EXESUF)=0D
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-crypto-hash$(EXESUF)=0D
+check-speed-$(CONFIG_BLOCK) +=3D tests/benchmark-crypto-hash$(EXESUF)=0D
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-crypto-hmac$(EXESUF)=0D
+check-speed-$(CONFIG_BLOCK) +=3D tests/benchmark-crypto-hmac$(EXESUF)=0D
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-crypto-cipher$(EXESUF)=0D
+check-speed-$(CONFIG_BLOCK) +=3D tests/benchmark-crypto-cipher$(EXESUF)=0D
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-crypto-secret$(EXESUF)=0D
+check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_GNUTLS)) +=3D tests/test-c=
rypto-tlscredsx509$(EXESUF)=0D
+check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_GNUTLS)) +=3D tests/test-c=
rypto-tlssession$(EXESUF)=0D
+ifndef CONFIG_TSAN=0D
+# Some tests: test-char, test-qdev-global-props, and test-qga,=0D
+# are not runnable under TSan due to a known issue.=0D
+# https://github.com/google/sanitizers/issues/1116=0D
+check-unit-$(CONFIG_SOFTMMU) +=3D tests/test-char$(EXESUF)=0D
+check-unit-$(CONFIG_SOFTMMU) +=3D tests/test-qdev-global-props$(EXESUF)=0D
+ifeq ($(CONFIG_GUEST_AGENT),y)=0D
+check-unit-$(call land,$(CONFIG_LINUX),$(CONFIG_VIRTIO_SERIAL)) +=3D tests=
/test-qga$(EXESUF)=0D
+endif=0D
+endif=0D
+check-unit-$(CONFIG_SOFTMMU) +=3D tests/test-timed-average$(EXESUF)=0D
+check-unit-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_INOTIFY1)) +=3D tests/te=
st-util-filemonitor$(EXESUF)=0D
+check-unit-$(CONFIG_SOFTMMU) +=3D tests/test-util-sockets$(EXESUF)=0D
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-authz-simple$(EXESUF)=0D
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-authz-list$(EXESUF)=0D
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-authz-listfile$(EXESUF)=0D
+check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_AUTH_PAM)) +=3D tests/test=
-authz-pam$(EXESUF)=0D
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-io-task$(EXESUF)=0D
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-io-channel-socket$(EXESUF)=0D
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-io-channel-file$(EXESUF)=0D
+check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_GNUTLS)) +=3D tests/test-i=
o-channel-tls$(EXESUF)=0D
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-io-channel-command$(EXESUF)=0D
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-io-channel-buffer$(EXESUF)=0D
+check-unit-$(CONFIG_SOFTMMU) +=3D tests/test-base64$(EXESUF)=0D
+check-unit-$(call land,$(CONFIG_BLOCK),$(if $(CONFIG_NETTLE),y,$(CONFIG_GC=
RYPT))) +=3D tests/test-crypto-pbkdf$(EXESUF)=0D
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-crypto-ivgen$(EXESUF)=0D
+check-unit-$(CONFIG_BLOCK)  +=3D tests/test-crypto-afsplit$(EXESUF)=0D
+check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_QEMU_PRIVATE_XTS)) +=3D te=
sts/test-crypto-xts$(EXESUF)=0D
+check-unit-$(CONFIG_BLOCK)  +=3D tests/test-crypto-block$(EXESUF)=0D
+check-unit-y +=3D tests/test-logging$(EXESUF)=0D
+check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_REPLICATION)) +=3D tests/t=
est-replication$(EXESUF)=0D
+check-unit-$(CONFIG_SOFTMMU) +=3D tests/test-bufferiszero$(EXESUF)=0D
+check-unit-y +=3D tests/test-uuid$(EXESUF)=0D
+check-unit-y +=3D tests/ptimer-test$(EXESUF)=0D
+check-unit-y +=3D tests/test-qapi-util$(EXESUF)=0D
+=0D
+generated-files-y +=3D tests/test-qapi-types.h=0D
+generated-files-y +=3D tests/include/test-qapi-types-sub-module.h=0D
+generated-files-y +=3D tests/test-qapi-types-sub-sub-module.h=0D
+generated-files-y +=3D tests/test-qapi-visit.h=0D
+generated-files-y +=3D tests/include/test-qapi-visit-sub-module.h=0D
+generated-files-y +=3D tests/test-qapi-visit-sub-sub-module.h=0D
+generated-files-y +=3D tests/test-qapi-commands.h=0D
+generated-files-y +=3D tests/test-qapi-init-commands.h=0D
+generated-files-y +=3D tests/include/test-qapi-commands-sub-module.h=0D
+generated-files-y +=3D tests/test-qapi-commands-sub-sub-module.h=0D
+generated-files-y +=3D tests/test-qapi-emit-events.h=0D
+generated-files-y +=3D tests/test-qapi-events.h=0D
+generated-files-y +=3D tests/include/test-qapi-events-sub-module.h=0D
+generated-files-y +=3D tests/test-qapi-events-sub-sub-module.h=0D
+generated-files-y +=3D tests/test-qapi-introspect.h=0D
+=0D
+QEMU_CFLAGS +=3D -I$(SRC_PATH)/tests -I$(SRC_PATH)/tests/qtest=0D
+=0D
+=0D
+# Deps that are common to various different sets of tests below=0D
+test-util-obj-y =3D libqemuutil.a=0D
+test-qom-obj-y =3D $(qom-obj-y) $(test-util-obj-y)=0D
+test-qapi-obj-y =3D tests/test-qapi-types.o \=0D
+	tests/include/test-qapi-types-sub-module.o \=0D
+	tests/test-qapi-types-sub-sub-module.o \=0D
+	tests/test-qapi-visit.o \=0D
+	tests/include/test-qapi-visit-sub-module.o \=0D
+	tests/test-qapi-visit-sub-sub-module.o \=0D
+	tests/test-qapi-introspect.o \=0D
+	$(test-qom-obj-y)=0D
+benchmark-crypto-obj-$(CONFIG_BLOCK) =3D $(authz-obj-y) $(crypto-obj-y) $(=
test-qom-obj-y)=0D
+test-crypto-obj-$(CONFIG_BLOCK) =3D $(authz-obj-y) $(crypto-obj-y) $(test-=
qom-obj-y)=0D
+test-io-obj-$(CONFIG_BLOCK) =3D $(io-obj-y) $(test-crypto-obj-y)=0D
+test-authz-obj-$(CONFIG_BLOCK) =3D $(test-qom-obj-y) $(authz-obj-y)=0D
+test-block-obj-$(CONFIG_BLOCK) =3D $(block-obj-y) $(test-io-obj-y) tests/i=
othread.o=0D
+=0D
+tests/check-qnum$(EXESUF): tests/check-qnum.o $(test-util-obj-y)=0D
+tests/check-qstring$(EXESUF): tests/check-qstring.o $(test-util-obj-y)=0D
+tests/check-qdict$(EXESUF): tests/check-qdict.o $(test-util-obj-y)=0D
+tests/check-block-qdict$(EXESUF): tests/check-block-qdict.o $(test-util-ob=
j-y)=0D
+tests/check-qlist$(EXESUF): tests/check-qlist.o $(test-util-obj-y)=0D
+tests/check-qnull$(EXESUF): tests/check-qnull.o $(test-util-obj-y)=0D
+tests/check-qobject$(EXESUF): tests/check-qobject.o $(test-util-obj-y)=0D
+tests/check-qjson$(EXESUF): tests/check-qjson.o $(test-util-obj-y)=0D
+tests/check-qlit$(EXESUF): tests/check-qlit.o $(test-util-obj-y)=0D
+tests/check-qom-interface$(EXESUF): tests/check-qom-interface.o $(test-qom=
-obj-y)=0D
+tests/check-qom-proplist$(EXESUF): tests/check-qom-proplist.o $(test-qom-o=
bj-y)=0D
+=0D
+tests/test-char$(EXESUF): tests/test-char.o $(test-util-obj-y) $(test-io-o=
bj-y) $(chardev-obj-y) tests/socket-helpers.o=0D
+tests/test-coroutine$(EXESUF): tests/test-coroutine.o $(test-block-obj-y)=
=0D
+tests/test-aio$(EXESUF): tests/test-aio.o $(test-block-obj-y)=0D
+tests/test-aio-multithread$(EXESUF): tests/test-aio-multithread.o $(test-b=
lock-obj-y)=0D
+tests/test-throttle$(EXESUF): tests/test-throttle.o $(test-block-obj-y)=0D
+tests/test-bdrv-drain$(EXESUF): tests/test-bdrv-drain.o $(test-block-obj-y=
) $(test-util-obj-y)=0D
+tests/test-bdrv-graph-mod$(EXESUF): tests/test-bdrv-graph-mod.o $(test-blo=
ck-obj-y) $(test-util-obj-y)=0D
+tests/test-blockjob$(EXESUF): tests/test-blockjob.o $(test-block-obj-y) $(=
test-util-obj-y)=0D
+tests/test-blockjob-txn$(EXESUF): tests/test-blockjob-txn.o $(test-block-o=
bj-y) $(test-util-obj-y)=0D
+tests/test-block-backend$(EXESUF): tests/test-block-backend.o $(test-block=
-obj-y) $(test-util-obj-y)=0D
+tests/test-block-iothread$(EXESUF): tests/test-block-iothread.o $(test-blo=
ck-obj-y) $(test-util-obj-y)=0D
+tests/test-image-locking$(EXESUF): tests/test-image-locking.o $(test-block=
-obj-y) $(test-util-obj-y)=0D
+tests/test-thread-pool$(EXESUF): tests/test-thread-pool.o $(test-block-obj=
-y)=0D
+tests/test-iov$(EXESUF): tests/test-iov.o $(test-util-obj-y)=0D
+tests/test-hbitmap$(EXESUF): tests/test-hbitmap.o $(test-util-obj-y) $(tes=
t-crypto-obj-y)=0D
+tests/test-bitmap$(EXESUF): tests/test-bitmap.o $(test-util-obj-y)=0D
+tests/test-x86-cpuid$(EXESUF): tests/test-x86-cpuid.o=0D
+tests/test-xbzrle$(EXESUF): tests/test-xbzrle.o migration/libmigration.fa =
$(test-util-obj-y) \=0D
+	$(test-io-obj-y)=0D
+tests/test-cutils$(EXESUF): tests/test-cutils.o util/cutils.o $(test-util-=
obj-y)=0D
+tests/test-int128$(EXESUF): tests/test-int128.o=0D
+tests/rcutorture$(EXESUF): tests/rcutorture.o $(test-util-obj-y)=0D
+tests/test-rcu-list$(EXESUF): tests/test-rcu-list.o $(test-util-obj-y)=0D
+tests/test-rcu-simpleq$(EXESUF): tests/test-rcu-simpleq.o $(test-util-obj-=
y)=0D
+tests/test-rcu-tailq$(EXESUF): tests/test-rcu-tailq.o $(test-util-obj-y)=0D
+tests/test-rcu-slist$(EXESUF): tests/test-rcu-slist.o $(test-util-obj-y)=0D
+tests/test-qdist$(EXESUF): tests/test-qdist.o $(test-util-obj-y)=0D
+tests/test-qht$(EXESUF): tests/test-qht.o $(test-util-obj-y)=0D
+tests/test-qht-par$(EXESUF): tests/test-qht-par.o tests/qht-bench$(EXESUF)=
 $(test-util-obj-y)=0D
+tests/qht-bench$(EXESUF): tests/qht-bench.o $(test-util-obj-y)=0D
+tests/test-bufferiszero$(EXESUF): tests/test-bufferiszero.o $(test-util-ob=
j-y)=0D
+tests/atomic_add-bench$(EXESUF): tests/atomic_add-bench.o $(test-util-obj-=
y)=0D
+tests/atomic64-bench$(EXESUF): tests/atomic64-bench.o $(test-util-obj-y)=0D
+=0D
+tests/test-qdev-global-props$(EXESUF): tests/test-qdev-global-props.o hw/c=
ore/libhwcore.fa \=0D
+	$(test-qapi-obj-y)=0D
+tests/test-vmstate$(EXESUF): tests/test-vmstate.o migration/libmigration.f=
a \=0D
+	$(test-io-obj-y)=0D
+tests/test-timed-average$(EXESUF): tests/test-timed-average.o $(test-util-=
obj-y)=0D
+tests/test-base64$(EXESUF): tests/test-base64.o $(test-util-obj-y)=0D
+tests/ptimer-test$(EXESUF): tests/ptimer-test.o tests/ptimer-test-stubs.o =
hw/core/ptimer.o=0D
+tests/test-qemu-opts$(EXESUF): tests/test-qemu-opts.o $(test-util-obj-y)=0D
+tests/test-keyval$(EXESUF): tests/test-keyval.o $(test-util-obj-y) $(test-=
qapi-obj-y)=0D
+tests/test-write-threshold$(EXESUF): tests/test-write-threshold.o $(test-b=
lock-obj-y)=0D
+tests/test-uuid$(EXESUF): tests/test-uuid.o $(test-util-obj-y)=0D
+tests/test-qapi-util$(EXESUF): tests/test-qapi-util.o $(test-util-obj-y)=0D
+=0D
+tests/test-logging$(EXESUF): tests/test-logging.o $(test-util-obj-y)=0D
+=0D
+tests/test-replication$(EXESUF): tests/test-replication.o $(test-util-obj-=
y) \=0D
+	$(test-block-obj-y)=0D
+=0D
+tests/test-qapi-types.c tests/test-qapi-types.h \=0D
+tests/include/test-qapi-types-sub-module.c \=0D
+tests/include/test-qapi-types-sub-module.h \=0D
+tests/test-qapi-types-sub-sub-module.c \=0D
+tests/test-qapi-types-sub-sub-module.h \=0D
+tests/test-qapi-visit.c tests/test-qapi-visit.h \=0D
+tests/include/test-qapi-visit-sub-module.c \=0D
+tests/include/test-qapi-visit-sub-module.h \=0D
+tests/test-qapi-visit-sub-sub-module.c \=0D
+tests/test-qapi-visit-sub-sub-module.h \=0D
+tests/test-qapi-commands.h tests/test-qapi-commands.c \=0D
+tests/include/test-qapi-commands-sub-module.h \=0D
+tests/include/test-qapi-commands-sub-module.c \=0D
+tests/test-qapi-commands-sub-sub-module.h \=0D
+tests/test-qapi-commands-sub-sub-module.c \=0D
+tests/test-qapi-emit-events.c tests/test-qapi-emit-events.h \=0D
+tests/test-qapi-events.c tests/test-qapi-events.h \=0D
+tests/test-qapi-init-commands.c \=0D
+tests/test-qapi-init-commands.h \=0D
+tests/include/test-qapi-events-sub-module.c \=0D
+tests/include/test-qapi-events-sub-module.h \=0D
+tests/test-qapi-events-sub-sub-module.c \=0D
+tests/test-qapi-events-sub-sub-module.h \=0D
+tests/test-qapi-introspect.c tests/test-qapi-introspect.h: \=0D
+tests/test-qapi-gen-timestamp ;=0D
+tests/test-qapi-gen-timestamp: \=0D
+		$(SRC_PATH)/tests/qapi-schema/qapi-schema-test.json \=0D
+		$(SRC_PATH)/tests/qapi-schema/include/sub-module.json \=0D
+		$(SRC_PATH)/tests/qapi-schema/sub-sub-module.json \=0D
+		$(qapi-py)=0D
+	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-gen.py \=0D
+		-o tests -p "test-" $<, \=0D
+		"GEN","$(@:%-timestamp=3D%)")=0D
+	@rm -f tests/test-qapi-doc.texi=0D
+	@>$@=0D
+=0D
+tests/test-string-output-visitor$(EXESUF): tests/test-string-output-visito=
r.o $(test-qapi-obj-y)=0D
+tests/test-string-input-visitor$(EXESUF): tests/test-string-input-visitor.=
o $(test-qapi-obj-y)=0D
+tests/test-qmp-event$(EXESUF): tests/test-qmp-event.o $(test-qapi-obj-y) t=
ests/test-qapi-emit-events.o tests/test-qapi-events.o=0D
+tests/test-qobject-output-visitor$(EXESUF): tests/test-qobject-output-visi=
tor.o $(test-qapi-obj-y)=0D
+tests/test-clone-visitor$(EXESUF): tests/test-clone-visitor.o $(test-qapi-=
obj-y)=0D
+tests/test-qobject-input-visitor$(EXESUF): tests/test-qobject-input-visito=
r.o $(test-qapi-obj-y)=0D
+tests/test-qmp-cmds$(EXESUF): tests/test-qmp-cmds.o tests/test-qapi-comman=
ds.o tests/test-qapi-init-commands.o $(test-qapi-obj-y)=0D
+tests/test-visitor-serialization$(EXESUF): tests/test-visitor-serializatio=
n.o $(test-qapi-obj-y)=0D
+tests/test-opts-visitor$(EXESUF): tests/test-opts-visitor.o $(test-qapi-ob=
j-y)=0D
+=0D
+tests/test-shift128$(EXESUF): tests/test-shift128.o $(test-util-obj-y)=0D
+tests/test-mul64$(EXESUF): tests/test-mul64.o $(test-util-obj-y)=0D
+tests/test-bitops$(EXESUF): tests/test-bitops.o $(test-util-obj-y)=0D
+tests/test-bitcnt$(EXESUF): tests/test-bitcnt.o $(test-util-obj-y)=0D
+tests/test-qgraph$(EXESUF): tests/test-qgraph.o tests/qtest/libqos/qgraph.=
o $(test-util-obj-y)=0D
+tests/test-crypto-hash$(EXESUF): tests/test-crypto-hash.o $(test-crypto-ob=
j-y)=0D
+tests/benchmark-crypto-hash$(EXESUF): tests/benchmark-crypto-hash.o $(test=
-crypto-obj-y)=0D
+tests/test-crypto-hmac$(EXESUF): tests/test-crypto-hmac.o $(test-crypto-ob=
j-y)=0D
+tests/benchmark-crypto-hmac$(EXESUF): tests/benchmark-crypto-hmac.o $(test=
-crypto-obj-y)=0D
+tests/test-crypto-cipher$(EXESUF): tests/test-crypto-cipher.o $(test-crypt=
o-obj-y)=0D
+tests/benchmark-crypto-cipher$(EXESUF): tests/benchmark-crypto-cipher.o $(=
test-crypto-obj-y)=0D
+tests/test-crypto-secret$(EXESUF): tests/test-crypto-secret.o $(test-crypt=
o-obj-y)=0D
+tests/test-crypto-xts$(EXESUF): tests/test-crypto-xts.o $(test-crypto-obj-=
y)=0D
+=0D
+ifeq ($(CONFIG_TEST_SECRET_KEYRING),y)=0D
+tests/test-crypto-secret.o-libs :=3D -lkeyutils=0D
+endif=0D
+=0D
+tests/crypto-tls-x509-helpers.o-cflags :=3D $(TASN1_CFLAGS)=0D
+tests/crypto-tls-x509-helpers.o-libs :=3D $(TASN1_LIBS)=0D
+tests/pkix_asn1_tab.o-cflags :=3D $(TASN1_CFLAGS)=0D
+=0D
+tests/test-crypto-tlscredsx509.o-cflags :=3D $(TASN1_CFLAGS)=0D
+tests/test-crypto-tlscredsx509$(EXESUF): tests/test-crypto-tlscredsx509.o =
\=0D
+	tests/crypto-tls-x509-helpers.o tests/pkix_asn1_tab.o $(test-crypto-obj-y=
)=0D
+=0D
+tests/test-crypto-tlssession.o-cflags :=3D $(TASN1_CFLAGS)=0D
+tests/test-crypto-tlssession$(EXESUF): tests/test-crypto-tlssession.o \=0D
+	tests/crypto-tls-x509-helpers.o tests/pkix_asn1_tab.o \=0D
+	tests/crypto-tls-psk-helpers.o \=0D
+        $(test-crypto-obj-y)=0D
+tests/test-util-filemonitor$(EXESUF): tests/test-util-filemonitor.o \=0D
+	$(test-util-obj-y)=0D
+tests/test-util-sockets$(EXESUF): tests/test-util-sockets.o \=0D
+	tests/socket-helpers.o $(test-util-obj-y)=0D
+tests/test-authz-simple$(EXESUF): tests/test-authz-simple.o $(test-authz-o=
bj-y)=0D
+tests/test-authz-list$(EXESUF): tests/test-authz-list.o $(test-authz-obj-y=
)=0D
+tests/test-authz-listfile$(EXESUF): tests/test-authz-listfile.o $(test-aut=
hz-obj-y)=0D
+tests/test-authz-pam$(EXESUF): tests/test-authz-pam.o $(test-authz-obj-y)=
=0D
+tests/test-io-task$(EXESUF): tests/test-io-task.o $(test-io-obj-y)=0D
+tests/test-io-channel-socket$(EXESUF): tests/test-io-channel-socket.o \=0D
+        tests/io-channel-helpers.o tests/socket-helpers.o $(test-io-obj-y)=
=0D
+tests/test-io-channel-file$(EXESUF): tests/test-io-channel-file.o \=0D
+        tests/io-channel-helpers.o $(test-io-obj-y)=0D
+tests/test-io-channel-tls$(EXESUF): tests/test-io-channel-tls.o \=0D
+	tests/crypto-tls-x509-helpers.o tests/pkix_asn1_tab.o \=0D
+	tests/io-channel-helpers.o $(test-io-obj-y)=0D
+tests/test-io-channel-command$(EXESUF): tests/test-io-channel-command.o \=
=0D
+        tests/io-channel-helpers.o $(test-io-obj-y)=0D
+tests/test-io-channel-buffer$(EXESUF): tests/test-io-channel-buffer.o \=0D
+        tests/io-channel-helpers.o $(test-io-obj-y)=0D
+tests/test-crypto-pbkdf$(EXESUF): tests/test-crypto-pbkdf.o $(test-crypto-=
obj-y)=0D
+tests/test-crypto-ivgen$(EXESUF): tests/test-crypto-ivgen.o $(test-crypto-=
obj-y)=0D
+tests/test-crypto-afsplit$(EXESUF): tests/test-crypto-afsplit.o $(test-cry=
pto-obj-y)=0D
+tests/test-crypto-block$(EXESUF): tests/test-crypto-block.o $(test-crypto-=
obj-y)=0D
+=0D
+tests/migration/stress$(EXESUF): tests/migration/stress.o=0D
+	$(call quiet-command, $(LINKPROG) -static -O3 $(PTHREAD_LIB) -o $@ $< ,"L=
INK","$(TARGET_DIR)$@")=0D
+=0D
+INITRD_WORK_DIR=3Dtests/migration/initrd=0D
+=0D
+tests/migration/initrd-stress.img: tests/migration/stress$(EXESUF)=0D
+	mkdir -p $(INITRD_WORK_DIR)=0D
+	cp $< $(INITRD_WORK_DIR)/init=0D
+	(cd $(INITRD_WORK_DIR) && (find | cpio --quiet -o -H newc | gzip -9)) > $=
@=0D
+	rm $(INITRD_WORK_DIR)/init=0D
+	rmdir $(INITRD_WORK_DIR)=0D
+=0D
+tests/test-qga$(EXESUF): qga/qemu-ga$(EXESUF)=0D
+tests/test-qga$(EXESUF): tests/test-qga.o tests/qtest/libqtest.o $(test-ut=
il-obj-y)=0D
+tests/vhost-user-bridge$(EXESUF): tests/vhost-user-bridge.o $(test-util-ob=
j-y) libvhost-user.a=0D
+tests/qemu-iotests/socket_scm_helper$(EXESUF): tests/qemu-iotests/socket_s=
cm_helper.o=0D
+=0D
+SPEED =3D quick=0D
+=0D
+# gtester tests, possibly with verbose output=0D
+# do_test_tap runs all tests, even if some of them fail, while do_test_hum=
an=0D
+# stops at the first failure unless -k is given on the command line=0D
+=0D
+define do_test_human_k=0D
+        $(quiet-@)rc=3D0; $(foreach COMMAND, $1, \=0D
+          $(call quiet-command-run, \=0D
+            export MALLOC_PERTURB_=3D$${MALLOC_PERTURB_:-$$(( $${RANDOM:-0=
} % 255 + 1))} $2; \=0D
+              $(COMMAND) -m=3D$(SPEED) -k --tap < /dev/null \=0D
+              | ./scripts/tap-driver.pl --test-name=3D"$(notdir $(COMMAND)=
)" $(if $(V),, --show-failures-only) \=0D
+              || rc=3D$$?;, "TEST", "$@: $(COMMAND)")) exit $$rc=0D
+endef=0D
+define do_test_human_no_k=0D
+        $(foreach COMMAND, $1, \=0D
+          $(call quiet-command, \=0D
+            MALLOC_PERTURB_=3D$${MALLOC_PERTURB_:-$$(( $${RANDOM:-0} % 255=
 + 1))} $2 \=0D
+              $(COMMAND) -m=3D$(SPEED) -k --tap < /dev/null \=0D
+              | ./scripts/tap-driver.pl --test-name=3D"$(notdir $(COMMAND)=
)" $(if $(V),, --show-failures-only), \=0D
+              "TEST", "$@: $(COMMAND)")=0D
+)=0D
+endef=0D
+do_test_human =3D \=0D
+        $(if $(findstring k, $(MAKEFLAGS)), $(do_test_human_k), $(do_test_=
human_no_k))=0D
+=0D
+define do_test_tap=0D
+	$(call quiet-command, \=0D
+          { export MALLOC_PERTURB_=3D$${MALLOC_PERTURB_:-$$(( $${RANDOM:-0=
} % 255 + 1))} $2; \=0D
+            $(foreach COMMAND, $1, \=0D
+	      $(COMMAND) -m=3D$(SPEED) -k --tap < /dev/null \=0D
+	      | sed "s/^\(not \)\?ok [0-9]* /&$(notdir $(COMMAND)) /" || true; ) =
} \=0D
+	      | ./scripts/tap-merge.pl | tee "$@" \=0D
+	      | ./scripts/tap-driver.pl $(if $(V),, --show-failures-only), \=0D
+	  "TAP","$@")=0D
+endef=0D
+=0D
+build-unit: $(check-unit-y)=0D
+=0D
+check-unit: $(check-unit-y)=0D
+	$(call do_test_human, $^)=0D
+=0D
+check-speed: $(check-speed-y)=0D
+	$(call do_test_human, $^)=0D
+=0D
+# gtester tests with TAP output=0D
+=0D
+check-report-unit.tap: $(check-unit-y)=0D
+	$(call do_test_tap,$^)=0D
+=0D
+# Per guest TCG tests=0D
+=0D
+BUILD_TCG_TARGET_RULES=3D$(patsubst %,build-tcg-tests-%, $(TARGET_DIRS))=0D
+CLEAN_TCG_TARGET_RULES=3D$(patsubst %,clean-tcg-tests-%, $(TARGET_DIRS))=0D
+RUN_TCG_TARGET_RULES=3D$(patsubst %,run-tcg-tests-%, $(TARGET_DIRS))=0D
+=0D
+# Probe for the Docker Builds needed for each build=0D
+$(foreach PROBE_TARGET,$(TARGET_DIRS), 				\=0D
+	$(eval -include $(SRC_PATH)/tests/tcg/Makefile.prereqs))=0D
+=0D
+build-tcg-tests-%: $(if $(CONFIG_PLUGIN),plugins)=0D
+	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) \=0D
+		-f $(SRC_PATH)/tests/tcg/Makefile.qemu \=0D
+		SRC_PATH=3D$(SRC_PATH) \=0D
+	       	V=3D"$(V)" TARGET=3D"$*" guest-tests, \=0D
+		"BUILD", "TCG tests for $*")=0D
+=0D
+run-tcg-tests-%: build-tcg-tests-% all=0D
+	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) \=0D
+		-f $(SRC_PATH)/tests/tcg/Makefile.qemu \=0D
+		SRC_PATH=3D$(SRC_PATH) SPEED=3D"$(SPEED)" \=0D
+		V=3D"$(V)" TARGET=3D"$*" run-guest-tests, \=0D
+		"RUN", "TCG tests for $*")=0D
+=0D
+clean-tcg-tests-%:=0D
+	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) \=0D
+		-f $(SRC_PATH)/tests/tcg/Makefile.qemu \=0D
+		SRC_PATH=3D$(SRC_PATH) TARGET=3D"$*" clean-guest-tests, \=0D
+		"CLEAN", "TCG tests for $*")=0D
+=0D
+.PHONY: build-tcg=0D
+build-tcg: $(BUILD_TCG_TARGET_RULES)=0D
+=0D
+.PHONY: check-tcg=0D
+check-tcg: $(RUN_TCG_TARGET_RULES)=0D
+=0D
+.PHONY: clean-tcg=0D
+clean-tcg: $(CLEAN_TCG_TARGET_RULES)=0D
+=0D
+=0D
+# Python venv for running tests=0D
+=0D
+.PHONY: check-venv check-acceptance=0D
+=0D
+TESTS_VENV_DIR=3D$(BUILD_DIR)/tests/venv=0D
+TESTS_VENV_REQ=3D$(SRC_PATH)/tests/requirements.txt=0D
+TESTS_RESULTS_DIR=3D$(BUILD_DIR)/tests/results=0D
+# Controls the output generated by Avocado when running tests.=0D
+# Any number of command separated loggers are accepted.  For more=0D
+# information please refer to "avocado --help".=0D
+AVOCADO_SHOW=3Dapp=0D
+AVOCADO_TAGS=3D$(patsubst %-softmmu,-t arch:%, $(filter %-softmmu,$(TARGET=
_DIRS)))=0D
+=0D
+$(TESTS_VENV_DIR): $(TESTS_VENV_REQ)=0D
+	$(call quiet-command, \=0D
+            $(PYTHON) -m venv --system-site-packages $@, \=0D
+            VENV, $@)=0D
+	$(call quiet-command, \=0D
+            $(TESTS_VENV_DIR)/bin/python -m pip -q install -r $(TESTS_VENV=
_REQ), \=0D
+            PIP, $(TESTS_VENV_REQ))=0D
+	$(call quiet-command, touch $@)=0D
+=0D
+$(TESTS_RESULTS_DIR):=0D
+	$(call quiet-command, mkdir -p $@, \=0D
+            MKDIR, $@)=0D
+=0D
+check-venv: $(TESTS_VENV_DIR)=0D
+=0D
+FEDORA_31_ARCHES_CANDIDATES=3D$(patsubst ppc64,ppc64le,$(TARGETS))=0D
+FEDORA_31_ARCHES :=3D x86_64 aarch64 ppc64le s390x=0D
+FEDORA_31_DOWNLOAD=3D$(filter $(FEDORA_31_ARCHES),$(FEDORA_31_ARCHES_CANDI=
DATES))=0D
+=0D
+# download one specific Fedora 31 image=0D
+get-vm-image-fedora-31-%: check-venv=0D
+	$(call quiet-command, \=0D
+             $(TESTS_VENV_DIR)/bin/python -m avocado vmimage get \=0D
+             --distro=3Dfedora --distro-version=3D31 --arch=3D$*, \=0D
+	"AVOCADO", "Downloading acceptance tests VM image for $*")=0D
+=0D
+# download all vm images, according to defined targets=0D
+get-vm-images: check-venv $(patsubst %,get-vm-image-fedora-31-%, $(FEDORA_=
31_DOWNLOAD))=0D
+=0D
+check-acceptance: check-venv $(TESTS_RESULTS_DIR) get-vm-images=0D
+	$(call quiet-command, \=0D
+            $(TESTS_VENV_DIR)/bin/python -m avocado \=0D
+            --show=3D$(AVOCADO_SHOW) run --job-results-dir=3D$(TESTS_RESUL=
TS_DIR) \=0D
+            --filter-by-tags-include-empty --filter-by-tags-include-empty-=
key \=0D
+            $(AVOCADO_TAGS) \=0D
+            $(if $(GITLAB_CI),,--failfast=3Don) tests/acceptance, \=0D
+            "AVOCADO", "tests/acceptance")=0D
+=0D
+# Consolidated targets=0D
+=0D
+.PHONY: check-block check-unit check check-clean get-vm-images=0D
+check-block:=0D
+check-build: build-unit=0D
+=0D
+check-clean:=0D
+	rm -rf $(check-unit-y) tests/*.o tests/*/*.o $(QEMU_IOTESTS_HELPERS-y)=0D
+	rm -f tests/test-qapi-gen-timestamp=0D
+	rm -rf $(TESTS_VENV_DIR) $(TESTS_RESULTS_DIR)=0D
+=0D
+check: check-unit=0D
+=0D
+clean: check-clean=0D
+=0D
+# Build the help program automatically=0D
+=0D
+-include $(wildcard tests/*.d)=0D
+=0D
+endif=0D
--=20
2.28.0.windows.1


