Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C719C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 13:23:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 416E6206DC
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 13:23:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 416E6206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhYnA-0001w3-Fb
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 09:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhYgX-0007I2-Pn
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 09:16:29 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:40297)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhYgW-0007fa-51
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 09:16:29 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MQuwR-1jLsZS2Jnz-00NzMn; Sat, 06 Jun 2020 15:16:17 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 10/19] tests/Makefile: Restrict some softmmu-only tests
Date: Sat,  6 Jun 2020 15:15:58 +0200
Message-Id: <20200606131607.1250819-11-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200606131607.1250819-1-laurent@vivier.eu>
References: <20200606131607.1250819-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:0d77vywlXSIr/QyK74MUzi8ToVKmhLC91J+32C5XTUekvll3ZnY
 n4KIQqOzfZb/hQCuyDH4QDHgq6EnuRbFGQOAjJwHq/jA1ibmruZXit+15Y6wz4sG2XRGgbG
 6ggo9duWg3NaqgfRNJVGAvjXopkn+ya1CipC2QNlmcWT+pb4qfIbVPuCEZIda6rw6VQ6VGz
 Eb8vWSLrP1/BzKwOJMf9g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G1gy5rMAdeI=:PyGoKuG280zSjCpy4kbZ6w
 gMfIeqQv5Z7kFcUZCR+Ch0A8bvxACYY5ZUKCyiyiXHCf2vqpoEuFv2p3rKPCcJfl282phCie6
 iL/A/9ke8bfqXIeJzUJcM99PtZ/OVBRA9fgdPcoyxvby6klPz2n2WkehZcmpIIFAah9eRhysi
 6fQsT17N+KnE6BOSJLeOZoYvJ5Yja8/gDrvZcKeqUizGQuiRlCODxtv935nPH7KfOXa+v50/d
 9VCbp/Ic+3QDIKPJlMfFv1XlWqzs60BTuf9ySzw2UrpN0clAobzDPSZfJPAo5O5r6kAe9GRPE
 MZyWRLWwFLac+ZMecPn9DdtKADp6MhRSzcIZtr7NfZkrJegAnEnTfb+JeOzaBpU5R2vzqWpeN
 nbp7+A3FKhbyqhMFoB/HcznSEvgQYJvZEeecjtA6MCg7pxWGq/70C2vA8e1jTiNlfxxrEiTzg
 ZZKEX7dDM5AmyTjl8zTVBuzYNfCQVDLAZfrP1dCqWyUp5df3oH0wBnHr4Cf4giCi9AlEF6IwA
 AZtXqx6anq9CfBV07/3rI2BmwBsFd00ggdVTSIYAjJNmziC6F+o3dfmR5WxOuDiRZ46BmInwi
 VUFgcjqRwCGK4Yycpw7CrVB7hgP5saUlqDPU35BD6gu5lSS0dDw9UEeK/Fj3Q9I+JZkk0Tdid
 Sk9SoHxZ5lbXU68aqwiusWpXlf4xcn72ZT4MSdwYGSnFwO4sSUsSGhoXGH8eyaeuE7Ug+D4dd
 MygUdAh95I97NRdd/nRhPNtXiTEDY7oWaSB71cPiil+n/mMfvPZ2ok07TXWzDswfDl8a3H35F
 dTm7IsgIAB6roQZWecpNmy+TC48hi5M7X79sFv4ulCJh53TXPmjimfNEal6pIZpF+hhXg+Y
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/06 09:16:19
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


