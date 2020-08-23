Return-Path: <SRS0=gE17=CB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04835C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 13:57:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA3572075B
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 13:57:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA3572075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9qV8-0006j6-2h
	for qemu-devel@archiver.kernel.org; Sun, 23 Aug 2020 09:57:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k9qUQ-0005tE-U1
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 09:56:54 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:49487)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k9qUP-0000o8-7q
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 09:56:54 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MEFjJ-1kJypJ2Xyf-00AHuq; Sun, 23 Aug 2020 15:56:48 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH] configure: avoid compiling qemu-keymap by default
Date: Sun, 23 Aug 2020 15:56:44 +0200
Message-Id: <20200823135644.1143953-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:GDywqQVIALNvNizIKFjs7ECWeTOGy8eSyEHZ+7UTfdcdol8gKXq
 yI5aoaAOVyTNypz+sx8CW9StXZUrqX3CVmyYP69uAnL2Yy8DNqkDGI1tSU36Zc3W8y0Nn4Q
 DG1Up2ROfS6+KgOR5/JB4zRNIx3H8BfE410fn6SHxJKoJkMdI6VGJchMWF6dKlyKHMGqOWV
 L1sJ5uSF+i5R2vX7OK5jA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Qq+1F/+hYpY=:bDP7XBFzfJCStoqbaR8iBe
 FjqFG/knTeKklK2inYRdED5RA2J7uZPweE+rfPLiLqbjM89J9P2ZSV4eFO9S97cFtclvDxwG8
 Mrre/oBqnGv67lenAx0YS6LqR0VZkuxgC+U8h31Q1E5xpoVv/jY3tdCKgg9l6nBstfpnxEpKr
 JIgMeo48jaWBZ8mWxv1HX3IYj6ippRNUB1E08xuZ/VF6zxELk9kPc8fgdFUeKkKWFeCsHKvKS
 kjp96wqO9dGezGkZWzaiZZsADpK3rCW5BwhSXFn5Vtozd8HvCioVBD6hw2sMr8rRpGNYi7NmE
 y0q2c//+uGXaZqoogYbjhFaq5bdeTZ4oYjFVEk0whDWcNJYx6QPiKyw8yjO8idylIWqlG+slc
 /OyXjEj1Fk3ynfc1bCVMUB5aclH9VYBmP3fB8NwEIkjndUEydwqhClMAZF6rcmqUyMKqJZUHJ
 bqcpkJ6OfKCs/770aFOnppW4kHmZ/olnG+ncDPFMOkWKpEUKfvrDKnoUJsWqPfHbf8HDZbkLQ
 hf8C1KTKkkp08e97r5WceFuKF6x9iZYgXbWnmCRaw0EgT6PeBYApdL2iiHvWOzhvLyaQx4exc
 te8w2zOmHWPA1Jr68t4M8Q6fYDwWahyJ1j/ID5GcRqEBvQXT1OVK30f7tfxiNR11UF0FCneIo
 iQL7jhUvmTokZr7mim3EuJjsgym0P0YTt1TElgG0G0vyjGR293cV3URYt0lqA7n7w5r+kJ12A
 T8dnBq29q6W73JQqbf2k545xTHmLaKS2dqkZYsCDBzkpbXhTPbRmgksrFcy2rXVWeVI+OvLVg
 APRatAkH/TsmsHK/Q/aBItEmenlsMiwM+wko7Eo7+fnf5OOZhT7J7XH6YjopctacnDmniRQ
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/23 09:56:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qemu-keymap is not needed with linux-user, so disable it by default if
tools are disabled (tools are disabled by default with linux-user).

Avoid this error with statically linked binaries:

    Linking target qemu-keymap
    /usr/bin/ld: cannot find -lxkbcommon

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 configure | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configure b/configure
index d9ca87fbbb52..2cab3330d010 100755
--- a/configure
+++ b/configure
@@ -3448,6 +3448,11 @@ fi
 
 ##########################################
 # xkbcommon probe
+if test -z "$xkbcommon"; then
+  if test "$want_tools" = "no"; then
+    xkbcommon=no
+  fi
+fi
 if test "$xkbcommon" != "no" ; then
   if $pkg_config xkbcommon --exists; then
     xkbcommon_cflags=$($pkg_config xkbcommon --cflags)
-- 
2.26.2


