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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C992EC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 03:16:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E9C32073E
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 03:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="aytXVXQg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E9C32073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZnJp-0005Jy-L9
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 23:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zxq_yx_007@163.com>)
 id 1jZnHB-0001nT-Vk
 for qemu-devel@nongnu.org; Fri, 15 May 2020 23:14:14 -0400
Received: from mail-m975.mail.163.com ([123.126.97.5]:47800)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <zxq_yx_007@163.com>)
 id 1jZnH6-0006YG-7v
 for qemu-devel@nongnu.org; Fri, 15 May 2020 23:14:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=hCZgK
 GmM3go38h6F82LI+M5LNCX0f560o8WdTIqIJRE=; b=aytXVXQgCtTIqEgKc/F+d
 +BXsK3jyP5HttkbxBwl9lPKJSFVL+v/UtLn0BuCZtqbH3Jk9gwBkiPdWrrGWjtqV
 eQihP6aozJ3WFWaho3d864VdL2t0BUpNUbS2qQu91gGKIKEOYO/pOxvVmMuvHTGn
 BKxiNrYaXQsy5VdnwwT47g=
Received: from localhost.localdomain (unknown [114.240.93.195])
 by smtp5 (Coremail) with SMTP id HdxpCgC3FwRcWr9eLYq7AA--.563S4;
 Sat, 16 May 2020 11:13:58 +0800 (CST)
From: xiaoqiang zhao <zxq_yx_007@163.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 2/3] tests/util-sockets: add abstract unix socket cases
Date: Sat, 16 May 2020 11:13:26 +0800
Message-Id: <20200516031327.15305-3-zxq_yx_007@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200516031327.15305-1-zxq_yx_007@163.com>
References: <20200516031327.15305-1-zxq_yx_007@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HdxpCgC3FwRcWr9eLYq7AA--.563S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxZw48GryUCw18JryUtw1fJFb_yoW5Wr1rpF
 yfKa45Kr4rAFsF9w43JayDJF1fGrnYvw4Yy3s3Awn8Ar4DKw1YqFsYyFyUtr17JrW8Jw4S
 9FnI9F10g39xtaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jNtxDUUUUU=
X-Originating-IP: [114.240.93.195]
X-CM-SenderInfo: 520ts5t0bqili6rwjhhfrp/1tbiFhYmxl44Kn2AiAAAsZ
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

add cases to test tight and non-tight for abstract address type

Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/test-util-sockets.c | 92 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/tests/test-util-sockets.c b/tests/test-util-sockets.c
index 5fd947c7bf..2ca1e99f17 100644
--- a/tests/test-util-sockets.c
+++ b/tests/test-util-sockets.c
@@ -227,6 +227,93 @@ static void test_socket_fd_pass_num_nocli(void)
     g_free(addr.u.fd.str);
 }
 
+#ifdef __linux__
+static gchar *abstract_sock_name;
+
+static gpointer unix_server_thread_func(gpointer user_data)
+{
+    SocketAddress addr;
+    Error *err = NULL;
+    int fd = -1;
+    int connfd = -1;
+    struct sockaddr_un un;
+    socklen_t len = sizeof(un);
+
+    addr.type = SOCKET_ADDRESS_TYPE_UNIX;
+    addr.u.q_unix.path = abstract_sock_name;
+    addr.u.q_unix.tight = user_data != NULL;
+    addr.u.q_unix.abstract = true;
+
+    fd = socket_listen(&addr, 1, &err);
+    g_assert_cmpint(fd, >=, 0);
+    g_assert(fd_is_socket(fd));
+
+    connfd = accept(fd, (struct sockaddr *)&un, &len);
+    g_assert_cmpint(connfd, !=, -1);
+
+    close(fd);
+
+    return NULL;
+}
+
+static gpointer unix_client_thread_func(gpointer user_data)
+{
+    SocketAddress addr;
+    Error *err = NULL;
+    int fd = -1;
+
+    addr.type = SOCKET_ADDRESS_TYPE_UNIX;
+    addr.u.q_unix.path = abstract_sock_name;
+    addr.u.q_unix.tight = user_data != NULL;
+    addr.u.q_unix.abstract = true;
+
+    fd = socket_connect(&addr, &err);
+
+    g_assert_cmpint(fd, >=, 0);
+
+    close(fd);
+
+    return NULL;
+}
+
+static void test_socket_unix_abstract_good(void)
+{
+    GRand *r = g_rand_new();
+
+    abstract_sock_name = g_strdup_printf("unix-%d-%d", getpid(),
+                                         g_rand_int_range(r, 100, 1000));
+
+    /* non tight socklen serv and cli */
+    GThread *serv = g_thread_new("abstract_unix_server",
+                                 unix_server_thread_func,
+                                 NULL);
+
+    sleep(1);
+
+    GThread *cli = g_thread_new("abstract_unix_client",
+                                unix_client_thread_func,
+                                NULL);
+
+    g_thread_join(cli);
+    g_thread_join(serv);
+
+    /* tight socklen serv and cli */
+    serv = g_thread_new("abstract_unix_server",
+                        unix_server_thread_func,
+                        (gpointer)1);
+
+    sleep(1);
+
+    cli = g_thread_new("abstract_unix_client",
+                       unix_client_thread_func,
+                       (gpointer)1);
+
+    g_thread_join(cli);
+    g_thread_join(serv);
+
+    g_free(abstract_sock_name);
+}
+#endif
 
 int main(int argc, char **argv)
 {
@@ -265,6 +352,11 @@ int main(int argc, char **argv)
                         test_socket_fd_pass_num_nocli);
     }
 
+#ifdef __linux__
+    g_test_add_func("/util/socket/unix-abstract/good",
+                    test_socket_unix_abstract_good);
+#endif
+
 end:
     return g_test_run();
 }
-- 
2.17.1


