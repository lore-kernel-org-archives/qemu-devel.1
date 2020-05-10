Return-Path: <SRS0=vfNf=6Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA56C54E8C
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 08:32:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEC8C20820
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 08:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Csb11ExE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEC8C20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXhNx-0003OJ-UJ
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 04:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zxq_yx_007@163.com>)
 id 1jXhMG-0001cg-LB
 for qemu-devel@nongnu.org; Sun, 10 May 2020 04:30:48 -0400
Received: from mail-m971.mail.163.com ([123.126.97.1]:47411)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zxq_yx_007@163.com>) id 1jXhMB-0006eY-ME
 for qemu-devel@nongnu.org; Sun, 10 May 2020 04:30:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=jzP0oPBFmljOzdAK/L
 GrQkQ/bd75PxvARP1LDCL4ymQ=; b=Csb11ExEelr0NVEFxIVyVEIz38vXFK1xtu
 y2ZEeHstITDT5H53Nb0V8RnY1qqlwRLIoGhSH/8LRzPYQagdhEETEr9Q5POMWF1U
 5UhPBHognxLYD9Ju49ncPJH4SkCYIs/j+LRWNymXOcqgKIipFjNxrf+ysJcuKXb4
 Xxe/vmm8E=
Received: from localhost.localdomain (unknown [111.194.184.25])
 by smtp1 (Coremail) with SMTP id GdxpCgAHJ_UKuLdej37fBA--.10S5;
 Sun, 10 May 2020 16:15:16 +0800 (CST)
From: xiaoqiang zhao <zxq_yx_007@163.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v3 3/3] qemu-options: updates for abstract unix sockets
Date: Sun, 10 May 2020 16:14:53 +0800
Message-Id: <20200510081453.2915-4-zxq_yx_007@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200510081453.2915-1-zxq_yx_007@163.com>
References: <20200510081453.2915-1-zxq_yx_007@163.com>
X-CM-TRANSID: GdxpCgAHJ_UKuLdej37fBA--.10S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw47Zry8ZrW3tw1DGF48JFb_yoW8AFy8pr
 90gF98t34kJ3WFvrsxJ3W8KryFka1kXFs7G3y3Ww1kt39rW398ta4DKwn8Z34UArZ7WFyS
 vrZYyFy2vF4Yy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5l1kUUUUU=
X-Originating-IP: [111.194.184.25]
X-CM-SenderInfo: 520ts5t0bqili6rwjhhfrp/xtbB0h0gxlUMWAK4nQAAsP
Received-SPF: pass client-ip=123.126.97.1; envelope-from=zxq_yx_007@163.com;
 helo=mail-m971.mail.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/10 04:15:21
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 xiaoqiang zhao <zxq_yx_007@163.com>, armbru@redhat.com, kraxel@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

add options documents changes for -chardev

Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
---
 qemu-options.hx | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 292d4e7c0c..ce73014f8e 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2930,7 +2930,7 @@ DEF("chardev", HAS_ARG, QEMU_OPTION_chardev,
     "         [,server][,nowait][,telnet][,websocket][,reconnect=seconds][,mux=on|off]\n"
     "         [,logfile=PATH][,logappend=on|off][,tls-creds=ID][,tls-authz=ID] (tcp)\n"
     "-chardev socket,id=id,path=path[,server][,nowait][,telnet][,websocket][,reconnect=seconds]\n"
-    "         [,mux=on|off][,logfile=PATH][,logappend=on|off] (unix)\n"
+    "         [,mux=on|off][,logfile=PATH][,logappend=on|off][,tight=on|off][,abstract=on|off] (unix)\n"
     "-chardev udp,id=id[,host=host],port=port[,localaddr=localaddr]\n"
     "         [,localport=localport][,ipv4][,ipv6][,mux=on|off]\n"
     "         [,logfile=PATH][,logappend=on|off]\n"
@@ -3097,9 +3097,14 @@ The available backends are:
 
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


