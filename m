Return-Path: <SRS0=HB7V=X6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB582C3E8AB
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 13:13:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95B64222C8
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 13:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="ZmWk2My6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B64222C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGjru-00050m-IS
	for qemu-devel@archiver.kernel.org; Sat, 05 Oct 2019 09:13:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56748)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1iGjkt-0002kj-HZ
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 09:05:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1iGjks-0005Sc-71
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 09:05:51 -0400
Received: from mout.web.de ([212.227.17.12]:48575)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>)
 id 1iGjkr-0005R7-UR; Sat, 05 Oct 2019 09:05:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1570280731;
 bh=OfJkK2vnGkQe8T1r5KQyutlaZ4TJ+K9pB9jGve8qHNk=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=ZmWk2My6W3rN89JKwpuOhr20MQ7JMNh0Z0ck5HnWsSSLMsrnDK2LhXr7W0CWLlnOA
 CsrrBBecLa49GTYUmfjQtcgNmmnYrfXVESbx7aNAmvfs9ryEd4Myu4TNYMtybgdcD4
 x+/91z9JpClebvHcMJpk37+AOWg3HyyCN3zEXhN0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.231]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MMmx9-1iC3BF3Izf-008a6C; Sat, 05
 Oct 2019 15:05:30 +0200
Date: Sat, 5 Oct 2019 15:05:30 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v6 2/4] tests/test-replication.c: Add test for for secondary
 node continuing replication
Message-ID: <acacb35c86d6abae5c397e2e1953b67485c24d91.1570280098.git.lukasstraub2@web.de>
In-Reply-To: <cover.1570280098.git.lukasstraub2@web.de>
References: <cover.1570280098.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wGo+s/4GRs3tXN8+Khn7ib2ssYy9FPq1Y48rkFPRq4SDS0DANe7
 QIyxfhe65SWwXDOqmVzrKVAYHF1Zobczc+jarW2KcnCN9Mt94en2u/Ql1wUCcIxCP11L5Ya
 nWlbjdAFKL5l4RllFkN5vLujmL9R2PLu7R7RS0/NaVinFIapzaL5JD3/CPumnUQ3jpSFgaY
 7/IBqjKHkoTsZsLy8tg0w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J9pNGHNLzfU=:1EkZSUnsUhk+yYf7VZfJH8
 ZmC73q/QLSSSljflGD9zjj7Ya8Rv7d2Q1H/xzfe6o1cf4SpmAY0A0pO/g/NrOoJ1oPVkTDR+0
 TWQd+77DA+Q/BgYlLCOaBe/SCYEMFRDCj7JnU1ZwGmWz3hlqHmaaF8qqPy0wXYm6LPqqvvZ3r
 tvK233Fh1o0lNsJMJy05wN+/z+H0hDxOc0qcUC1knaAJG2mIdd0SnGJCY9rY+zX21Nw4A6rm/
 TsWKNugxIkSBd2GfcV88v/p5c8EwrMm787vvQV25lJLZl0DqTyvbCNTk8y5QKmA8q9lmPCZAB
 aPvTQZw9r2P+rJbgWTaJV/HE9y7M+2GHwu4sWRbWG97B7KD9R856bZd5b29FN26r4rbwQRejs
 ZenbA3zzE45l1psd9EMOWk3+/W5zEHxDIjoMUzHe6Wawvm8tcYxgZlNn4YAnDPdHZNLGYyKGI
 aLnIiLLIX7iHMCiQD7Y2VejT5bP+vYjnq/t6Q03T+fm8Nq0uQ5PhFrTxGMfqugV6f4M+0L7HA
 sSdi1XV+q82W1dmU8irldDjBfa1dYdKHc3UqR7D2pImV6/bPpfbeP2RNsC+iD42hWfyF9/YgX
 TMRe1Icv1LdIRPH4IupDQix+fBwsdg2F/U+2Z2b73dnANTeY3OtiTJHpnvYvpSinyeeV4QpFa
 kNE41bvAdfU0NJAAGD5SgXLtWjOSCu/Pr99esDwfobLhlCYOmCi2SaHYlR6NSK5dLLHNaUyRW
 /Jd7b1ZF8M1dVfbjxgkgbMEgwIY3ebHlA8qgdBLh7q5fYOFlx1pQN9UmIqU8WmhCwU4X7DWPw
 bbUhc2L/Nifyknhrk91+bhT6a+Bi8f2+V6+AtATifYv6CsgdcLqNBSiXXpfOcekSGTNf6DfY5
 DkwAAbUnzvMhVGiQ01KTrQ1A9Roza6ICPMQGWqVLs8d7mmLE3pWvKuKvqUKvjmovC6Ce8r7ip
 Tn9j1rTb7s+/DupOzXHQwiegXQfn2nDdaVfiSX4Lb6ny1fy1u70DkuT8MykCiJGLRqmAdWmWk
 daOYKwZ0zX2A7szhKJrN4ZyqUxkuTB3RbJoUnX9T0ob3sjh3WjYxpL+YIVWj3n+EtUs9cGhoa
 BYUmHqMIlouZEAe9FP/xZ+cMrxRm1ejh0+0Js6fdFUKpsOALn3ZffCerQBSxfN0f0tW8zBxzI
 1cz+knSFJ/UauKI30ylYzx/LZ7R9YIealTfIsoSUNz5Bagw0AuoPsvVYQS7i5ZEct7pIkM75u
 SaxNJg1MN8ikL1tRXcJkQ2ILrIpWD8Yfi4n9J1n5W8S6v/JmNVv9EJT2ZwWs=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.12
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 Wen Congyang <wencongyang2@huawei.com>, Jason Wang <jasowang@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Zhang Chen <chen.zhang@intel.com>,
 Xie Changlong <xiechanglong.d@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This simulates the case that happens when we resume COLO after failover.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 tests/test-replication.c | 52 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/tests/test-replication.c b/tests/test-replication.c
index f085d1993a..8e18ecd998 100644
=2D-- a/tests/test-replication.c
+++ b/tests/test-replication.c
@@ -489,6 +489,56 @@ static void test_secondary_stop(void)
     teardown_secondary();
 }

+static void test_secondary_continuous_replication(void)
+{
+    BlockBackend *top_blk, *local_blk;
+    Error *local_err =3D NULL;
+
+    top_blk =3D start_secondary();
+    replication_start_all(REPLICATION_MODE_SECONDARY, &local_err);
+    g_assert(!local_err);
+
+    /* write 0x22 to s_local_disk (IMG_SIZE / 2, IMG_SIZE) */
+    local_blk =3D blk_by_name(S_LOCAL_DISK_ID);
+    test_blk_write(local_blk, 0x22, IMG_SIZE / 2, IMG_SIZE / 2, false);
+
+    /* replication will backup s_local_disk to s_hidden_disk */
+    test_blk_read(top_blk, 0x11, IMG_SIZE / 2,
+                  IMG_SIZE / 2, 0, IMG_SIZE, false);
+
+    /* write 0x33 to s_active_disk (0, IMG_SIZE / 2) */
+    test_blk_write(top_blk, 0x33, 0, IMG_SIZE / 2, false);
+
+    /* do failover (active commit) */
+    replication_stop_all(true, &local_err);
+    g_assert(!local_err);
+
+    /* it should ignore all requests from now on */
+
+    /* start after failover */
+    replication_start_all(REPLICATION_MODE_PRIMARY, &local_err);
+    g_assert(!local_err);
+
+    /* checkpoint */
+    replication_do_checkpoint_all(&local_err);
+    g_assert(!local_err);
+
+    /* stop */
+    replication_stop_all(true, &local_err);
+    g_assert(!local_err);
+
+    /* read from s_local_disk (0, IMG_SIZE / 2) */
+    test_blk_read(top_blk, 0x33, 0, IMG_SIZE / 2,
+                  0, IMG_SIZE / 2, false);
+
+
+    /* read from s_local_disk (IMG_SIZE / 2, IMG_SIZE) */
+    test_blk_read(top_blk, 0x22, IMG_SIZE / 2,
+                  IMG_SIZE / 2, 0, IMG_SIZE, false);
+
+    teardown_secondary();
+}
+
 static void test_secondary_do_checkpoint(void)
 {
     BlockBackend *top_blk, *local_blk;
@@ -584,6 +634,8 @@ int main(int argc, char **argv)
     g_test_add_func("/replication/secondary/write", test_secondary_write)=
;
     g_test_add_func("/replication/secondary/start", test_secondary_start)=
;
     g_test_add_func("/replication/secondary/stop",  test_secondary_stop);
+    g_test_add_func("/replication/secondary/continuous_replication",
+                    test_secondary_continuous_replication);
     g_test_add_func("/replication/secondary/do_checkpoint",
                     test_secondary_do_checkpoint);
     g_test_add_func("/replication/secondary/get_error_all",
=2D-
2.20.1


