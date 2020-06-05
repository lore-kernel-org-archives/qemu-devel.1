Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE95C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:54:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 809262063A
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:54:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 809262063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhAvn-0005fb-Og
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 07:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhAok-0008Jr-K9
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 07:47:24 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:60211)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhAod-0006iH-US
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 07:47:22 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mt7x1-1iofRv3XtB-00tTeI; Fri, 05 Jun 2020 13:47:11 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 10/19] tests/Makefile: Restrict some softmmu-only tests
Date: Fri,  5 Jun 2020 13:46:51 +0200
Message-Id: <20200605114700.1052050-11-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605114700.1052050-1-laurent@vivier.eu>
References: <20200605114700.1052050-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:oQKwhrkEiFwCnvvwNMxzM/AINxfavth2I5iOWmIU9UYGXq027Rg
 bz87Ma6b6FDHxylZ1xiA4nk4jm5NIG/KaQjd+4wuWXJ45n++4Kj1G1TDbd0DqJaILbFZojU
 AeC6g2Xsx0jW94eJlvbdK+sEb6nD39nTPYKuZ+ciApvwwfnXi8matvnHbKzURXv7S+71SsI
 kaSUASLme2/utBytlg5vQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MZgOMM32aWs=:rFnGVlxpTB8cJwSOPVuMyB
 HCEq/DNC3dq801aUxD4AgMEUJfw8vMZAfjM1V4y1fHizeP3rJxmnTWj/TCCnJnUUhRVYt1bHo
 k7OWN4thFwtzUFZlibgkWAdInMMA5cYXL9qsW5wkgu5bwngB7oVZSYlJvqbBxz7RUoOE9zlxa
 76J6D4axzbds+h7kDIPZ4/Se6gMU388cjWoGIbRimlrRgE55GUjac1hu1YmWrxoEtYXXbQvFO
 ROwUqGFtBvrSo+JYTsKQKX7Ip21BQtox3Qcc6MHxbniqb1MQfdk8tok1Mc8+/eIoPEgUhD5mv
 Frqj12KQ+aJ7iSI+yfAYb0rEV4naZMkeOiOn44B2+J/CqYTqgnX3B3sMc3W3LKg1uH3+cWZHE
 gnvBPPm7Nt/2nyRmzRxhO5gt4uOa/5fMJKHqZaq5c2Bd/nkr8nEWFTjAIuGcUBEiMLr+vF1CR
 owxRcXt+TsvhC3jRchQs2kgfzcY46uQUSatN7tFyQlk611aemJ8/ZVSOHaRoO7EEKixgfr6Gu
 PqT6GjzQodCkVEuifb3QYXgUVYfsOHO31ZJXiPivCm9z2FIZ/FpUeyfGCd5BOA/DVWCd57eV1
 qtqGjewesO24WZe7fcAaFc4Omc3PBHmn5Y4N0HTYPcE1vwNq3juObnoogpsZIYmAcPvkv5xz1
 phyoNm85+yrMDTH5SYpUw7dsdSYGDWJrcu+W6URk/y7rc+DGvAJKKSvuzW86t8wmE86MH5ILB
 EE2Geh6eVIfQ6BPEyASwTwqRrRmJrYNdHdT/uWDQghbWdNEBA/UDaIaNpcF6DwhkleJ0nljpr
 glqOVZ+6T5qy2oaWXwgYWmCNJfqJazwxXbOF83eyG4nxjHcEK4WmTVfdDeQOk5dEzUMQDWx
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 07:46:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

In the next commit we are going to remove some objects from the
util-obj-y variable (objects which are not used by user-mode,
when configured with --disable-system).
Then some system-mode tests are going to fail, due to the missing
objects:

  $ make check-unit -k
    LINK    tests/test-iov
  /usr/bin/ld: tests/test-iov.o: in function `iov_from_buf':
  include/qemu/iov.h:49: undefined reference to `iov_from_buf_full'
  make: *** [rules.mak:124: tests/test-iov] Error 1
    LINK    tests/test-timed-average
  /usr/bin/ld: tests/test-timed-average.o: in function `account':
  tests/test-timed-average.c:27: undefined reference to `timed_average_account'
  make: *** [rules.mak:124: tests/test-timed-average] Error 1
    LINK    tests/test-util-filemonitor
  /usr/bin/ld: tests/test-util-filemonitor.o: in function `qemu_file_monitor_test_event_loop':
  tests/test-util-filemonitor.c:83: undefined reference to `main_loop_wait'
  make: *** [rules.mak:124: tests/test-util-filemonitor] Error 1
    LINK    tests/test-util-sockets
  /usr/bin/ld: tests/test-util-sockets.o: in function `test_socket_fd_pass_name_good':
  tests/test-util-sockets.c:91: undefined reference to `socket_connect'
  make: *** [rules.mak:124: tests/test-util-sockets] Error 1
    LINK    tests/test-base64
  /usr/bin/ld: tests/test-base64.o: in function `test_base64_good':
  tests/test-base64.c:35: undefined reference to `qbase64_decode'
  collect2: error: ld returned 1 exit status
  make: *** [rules.mak:124: tests/test-base64] Error 1
    LINK    tests/test-bufferiszero
  /usr/bin/ld: tests/test-bufferiszero.o: in function `test_1':
  tests/test-bufferiszero.c:31: undefined reference to `buffer_is_zero'
  make: *** [rules.mak:124: tests/test-bufferiszero] Error 1
  make: Target 'check-unit' not remade because of errors.

Instead, restrict these tests to system-mode, by using the
$(CONFIG_SOFTMMU) variable.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200522172510.25784-5-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 tests/Makefile.include | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 6bc3d1096bc9..0cb58aad2685 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -66,14 +66,14 @@ check-unit-y += tests/check-qlit$(EXESUF)
 check-unit-y += tests/test-qobject-output-visitor$(EXESUF)
 check-unit-y += tests/test-clone-visitor$(EXESUF)
 check-unit-y += tests/test-qobject-input-visitor$(EXESUF)
-check-unit-y += tests/test-qmp-cmds$(EXESUF)
+check-unit-$(CONFIG_SOFTMMU) += tests/test-qmp-cmds$(EXESUF)
 check-unit-y += tests/test-string-input-visitor$(EXESUF)
 check-unit-y += tests/test-string-output-visitor$(EXESUF)
 check-unit-y += tests/test-qmp-event$(EXESUF)
 check-unit-y += tests/test-opts-visitor$(EXESUF)
 check-unit-$(CONFIG_BLOCK) += tests/test-coroutine$(EXESUF)
 check-unit-y += tests/test-visitor-serialization$(EXESUF)
-check-unit-y += tests/test-iov$(EXESUF)
+check-unit-$(CONFIG_SOFTMMU) += tests/test-iov$(EXESUF)
 check-unit-y += tests/test-bitmap$(EXESUF)
 check-unit-$(CONFIG_BLOCK) += tests/test-aio$(EXESUF)
 check-unit-$(CONFIG_BLOCK) += tests/test-aio-multithread$(EXESUF)
@@ -108,7 +108,7 @@ check-unit-y += tests/test-qht$(EXESUF)
 check-unit-y += tests/test-qht-par$(EXESUF)
 check-unit-y += tests/test-bitops$(EXESUF)
 check-unit-y += tests/test-bitcnt$(EXESUF)
-check-unit-y += tests/test-qdev-global-props$(EXESUF)
+check-unit-$(CONFIG_SOFTMMU) += tests/test-qdev-global-props$(EXESUF)
 check-unit-y += tests/check-qom-interface$(EXESUF)
 check-unit-y += tests/check-qom-proplist$(EXESUF)
 check-unit-y += tests/test-qemu-opts$(EXESUF)
@@ -126,9 +126,9 @@ check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_GNUTLS)) += tests/test-crypto-tl
 ifneq (,$(findstring qemu-ga,$(TOOLS)))
 check-unit-$(call land,$(CONFIG_LINUX),$(CONFIG_VIRTIO_SERIAL)) += tests/test-qga$(EXESUF)
 endif
-check-unit-y += tests/test-timed-average$(EXESUF)
-check-unit-$(CONFIG_INOTIFY1) += tests/test-util-filemonitor$(EXESUF)
-check-unit-y += tests/test-util-sockets$(EXESUF)
+check-unit-$(CONFIG_SOFTMMU) += tests/test-timed-average$(EXESUF)
+check-unit-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_INOTIFY1)) += tests/test-util-filemonitor$(EXESUF)
+check-unit-$(CONFIG_SOFTMMU) += tests/test-util-sockets$(EXESUF)
 check-unit-$(CONFIG_BLOCK) += tests/test-authz-simple$(EXESUF)
 check-unit-$(CONFIG_BLOCK) += tests/test-authz-list$(EXESUF)
 check-unit-$(CONFIG_BLOCK) += tests/test-authz-listfile$(EXESUF)
@@ -139,7 +139,7 @@ check-unit-$(CONFIG_BLOCK) += tests/test-io-channel-file$(EXESUF)
 check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_GNUTLS)) += tests/test-io-channel-tls$(EXESUF)
 check-unit-$(CONFIG_BLOCK) += tests/test-io-channel-command$(EXESUF)
 check-unit-$(CONFIG_BLOCK) += tests/test-io-channel-buffer$(EXESUF)
-check-unit-y += tests/test-base64$(EXESUF)
+check-unit-$(CONFIG_SOFTMMU) += tests/test-base64$(EXESUF)
 check-unit-$(call land,$(CONFIG_BLOCK),$(if $(CONFIG_NETTLE),y,$(CONFIG_GCRYPT))) += tests/test-crypto-pbkdf$(EXESUF)
 check-unit-$(CONFIG_BLOCK) += tests/test-crypto-ivgen$(EXESUF)
 check-unit-$(CONFIG_BLOCK)  += tests/test-crypto-afsplit$(EXESUF)
@@ -147,7 +147,7 @@ check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_QEMU_PRIVATE_XTS)) += tests/test
 check-unit-$(CONFIG_BLOCK)  += tests/test-crypto-block$(EXESUF)
 check-unit-y += tests/test-logging$(EXESUF)
 check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_REPLICATION)) += tests/test-replication$(EXESUF)
-check-unit-y += tests/test-bufferiszero$(EXESUF)
+check-unit-$(CONFIG_SOFTMMU) += tests/test-bufferiszero$(EXESUF)
 check-unit-y += tests/test-uuid$(EXESUF)
 check-unit-y += tests/ptimer-test$(EXESUF)
 check-unit-y += tests/test-qapi-util$(EXESUF)
-- 
2.26.2


