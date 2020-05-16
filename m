Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAD2C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 03:15:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19C662073E
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 03:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nl6hMOIq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19C662073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZnIV-00034o-1w
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 23:15:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zxq_yx_007@163.com>)
 id 1jZnHC-0001nm-VV
 for qemu-devel@nongnu.org; Fri, 15 May 2020 23:14:15 -0400
Received: from mail-m975.mail.163.com ([123.126.97.5]:47804)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <zxq_yx_007@163.com>)
 id 1jZnH6-0006YF-E1
 for qemu-devel@nongnu.org; Fri, 15 May 2020 23:14:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ARwOF
 WwGoEST4bDFAMhg9fjPavitdnXh7TxDzLc0OgM=; b=nl6hMOIqFChu0vRmG26ul
 pqpM/yJ2DnVqF4KCTPyy1BVyMdRJz8U5B08/l2SW/tIsmDdGxe6MF+C66MaFxzev
 NaUwO/07kdaga1k+rIM5Y6ZN0jlXCoSaeqYa1GgrE0bOzmETjlcYQW4S27xz55NI
 7R/JNpjEDmbuGRptIhs9IQ=
Received: from localhost.localdomain (unknown [114.240.93.195])
 by smtp5 (Coremail) with SMTP id HdxpCgC3FwRcWr9eLYq7AA--.563S5;
 Sat, 16 May 2020 11:13:58 +0800 (CST)
From: xiaoqiang zhao <zxq_yx_007@163.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 3/3] qemu-options: updates for abstract unix sockets
Date: Sat, 16 May 2020 11:13:27 +0800
Message-Id: <20200516031327.15305-4-zxq_yx_007@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200516031327.15305-1-zxq_yx_007@163.com>
References: <20200516031327.15305-1-zxq_yx_007@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HdxpCgC3FwRcWr9eLYq7AA--.563S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw45AryfWrWDGry8tF43Jrb_yoW8CrWfpr
 9YkF9xt34kJ3WFvrsrt3WDKr4rKw1kXFs7G39xuw1kKa9rW398ta4UKw15Z34UArs7WryS
 vFWFkry2vF4Yy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07b0txDUUUUU=
X-Originating-IP: [114.240.93.195]
X-CM-SenderInfo: 520ts5t0bqili6rwjhhfrp/xtbB0hYmxlUMWJZqSQAAsQ
Received-SPF: pass client-ip=123.126.97.5; envelope-from=zxq_yx_007@163.com;
 helo=mail-m975.mail.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 23:02:07
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
 qemu-options.hx | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index e2dca8a4e9..4ee7e6c772 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2938,7 +2938,7 @@ DEF("chardev", HAS_ARG, QEMU_OPTION_chardev,
     "         [,server][,nowait][,telnet][,websocket][,reconnect=seconds][,mux=on|off]\n"
     "         [,logfile=PATH][,logappend=on|off][,tls-creds=ID][,tls-authz=ID] (tcp)\n"
     "-chardev socket,id=id,path=path[,server][,nowait][,telnet][,websocket][,reconnect=seconds]\n"
-    "         [,mux=on|off][,logfile=PATH][,logappend=on|off] (unix)\n"
+    "         [,mux=on|off][,logfile=PATH][,logappend=on|off][,abstract=on|off][,tight=on|off] (unix)\n"
     "-chardev udp,id=id[,host=host],port=port[,localaddr=localaddr]\n"
     "         [,localport=localport][,ipv4][,ipv6][,mux=on|off]\n"
     "         [,logfile=PATH][,logappend=on|off]\n"
@@ -3105,9 +3105,13 @@ The available backends are:
 
         ``nodelay`` disables the Nagle algorithm.
 
-    ``unix options: path=path``
+    ``unix options: path=path[,abstract=on|off][,tight=on|off]``
         ``path`` specifies the local path of the unix socket. ``path``
         is required.
+	``abstract`` specifies the use of the abstract socket namespace,
+        rather than the filesystem.  Optional, defaults to false.
+	``tight`` sets the socket length of abstract sockets to their minimum,
+        rather than the full sun_path length.  Optional, defaults to true.
 
 ``-chardev udp,id=id[,host=host],port=port[,localaddr=localaddr][,localport=localport][,ipv4][,ipv6]``
     Sends all traffic from the guest to a remote host over UDP.
-- 
2.17.1


