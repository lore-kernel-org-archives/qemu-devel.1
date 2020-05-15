Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8508CC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:07:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C30C205CB
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XMhQFkuu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C30C205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZWJW-0000mI-Ex
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 05:07:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zxq_yx_007@163.com>)
 id 1jZWIh-00085O-F6
 for qemu-devel@nongnu.org; Fri, 15 May 2020 05:06:39 -0400
Received: from mail-m973.mail.163.com ([123.126.97.3]:56398)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <zxq_yx_007@163.com>)
 id 1jZWIe-0002LD-18
 for qemu-devel@nongnu.org; Fri, 15 May 2020 05:06:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=/NcvS
 o1vK7M28qvvpL0Qua7NUSmc+hQjegBGuU0seYQ=; b=XMhQFkuuCvih89dvNsSMK
 AhCNvykoXCaethWwJ8ad4TV1ywe99YaCUrD7cMgBFWZg7KTRfcUfqi9KEi6zlcKv
 7g+Vd+FkcK6WkLGH/qJJtnJGzXSzCzM5AfBv0sbpfVYf8wH7FsXiexS0S9MmzZS+
 HBtL0HSZ7sadOVx5N35N7I=
Received: from localhost.localdomain (unknown [114.240.93.195])
 by smtp3 (Coremail) with SMTP id G9xpCgBnt5uKW75eMHSGBQ--.172S5;
 Fri, 15 May 2020 17:06:25 +0800 (CST)
From: xiaoqiang zhao <zxq_yx_007@163.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 3/3] qemu-options: updates for abstract unix sockets
Date: Fri, 15 May 2020 17:06:08 +0800
Message-Id: <20200515090608.5373-4-zxq_yx_007@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200515090608.5373-1-zxq_yx_007@163.com>
References: <20200515090608.5373-1-zxq_yx_007@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: G9xpCgBnt5uKW75eMHSGBQ--.172S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw45Ary5Zr4rZF4ftrWUArb_yoW8Cr48pr
 90gas8t348J3WFvrsrG3W8tryFkw4kXrs7G3y3Ww1kta9rW398ta4UKw15X34UArs7XFya
 vF90yryjvF4Yy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jWg4DUUUUU=
X-Originating-IP: [114.240.93.195]
X-CM-SenderInfo: 520ts5t0bqili6rwjhhfrp/1tbiqBElxlc7PM4ncwAAsQ
Received-SPF: pass client-ip=123.126.97.3; envelope-from=zxq_yx_007@163.com;
 helo=mail-m973.mail.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 05:06:29
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, berrange@redhat.com,
 armbru@redhat.com, kraxel@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

add options documents changes for -chardev

Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qemu-options.hx | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index e2dca8a4e9..e63cc1b4b4 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2938,7 +2938,7 @@ DEF("chardev", HAS_ARG, QEMU_OPTION_chardev,
     "         [,server][,nowait][,telnet][,websocket][,reconnect=seconds][,mux=on|off]\n"
     "         [,logfile=PATH][,logappend=on|off][,tls-creds=ID][,tls-authz=ID] (tcp)\n"
     "-chardev socket,id=id,path=path[,server][,nowait][,telnet][,websocket][,reconnect=seconds]\n"
-    "         [,mux=on|off][,logfile=PATH][,logappend=on|off] (unix)\n"
+    "         [,mux=on|off][,logfile=PATH][,logappend=on|off][,tight=on|off][,abstract=on|off] (unix)\n"
     "-chardev udp,id=id[,host=host],port=port[,localaddr=localaddr]\n"
     "         [,localport=localport][,ipv4][,ipv6][,mux=on|off]\n"
     "         [,logfile=PATH][,logappend=on|off]\n"
@@ -3105,9 +3105,14 @@ The available backends are:
 
         ``nodelay`` disables the Nagle algorithm.
 
-    ``unix options: path=path``
+    ``unix options: path=path[,tight=on|off][,abstract=on|off]``
         ``path`` specifies the local path of the unix socket. ``path``
         is required.
+	``tight`` whether to set @addrlen to the minimal string length,
+        or the maximum sun_path length. defaults to true. ``tight`` is
+        optional.
+	``abstract`` whether use abstract address. defaults to false.
+	``abstract`` is optional.
 
 ``-chardev udp,id=id[,host=host],port=port[,localaddr=localaddr][,localport=localport][,ipv4][,ipv6]``
     Sends all traffic from the guest to a remote host over UDP.
-- 
2.17.1


