Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DEFC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 09:28:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F6AD22CF8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 09:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="YGP6XdIy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F6AD22CF8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i557Q-0005st-BV
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 05:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33559)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1i54zc-00088z-2i
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 05:20:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1i54zX-0002S5-Je
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 05:20:51 -0400
Received: from mout.web.de ([212.227.15.14]:35421)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1i54zX-0002Qe-7o
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 05:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1567502430;
 bh=fyxFW0jLN+bdzNxHGPogdBIgIPlW9CiQAqsYYHE4l04=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=YGP6XdIyXYRMvlYOqKlSQc0BNCkYQM8oKX3GrnurXm8xsRpDC3F/Ha9+iAv0f4qL3
 FeLSwUoSsgcJYYPZ6OUhYkHzlsjhVxe4wYvjNp7jl3399wKqVclgXUT5ZwOavsTDz9
 dDufNJdwX4zn2TUROVWjrv+aldGNLaEMxFPe2U8Y=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.78]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MfYTr-1hpT6b04ol-00P9Gd; Tue, 03
 Sep 2019 11:20:30 +0200
Date: Tue, 3 Sep 2019 11:20:29 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Message-ID: <b9383e7b7697ec1f1eb963449d14f2e44724b907.1567500411.git.lukasstraub2@web.de>
In-Reply-To: <cover.1567500411.git.lukasstraub2@web.de>
References: <cover.1567500411.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HQvkqKwr0+u8BVTtVfw182Wcoesbz4BDN99+KV9I8lVtiWk7G5e
 qErAIk4TL+Oj4gCwT3U0b5XGA7d0hUGLgURQueQN5o5iEEDQNJ3mfSUi+VfQrpyZduO/DYx
 anD1ZEEWGE/HmioJqR3sM5qB2HGZPWRlGA9bQWL5RyFwrhu3SQDWwg7gFCwf3F40h1nA9nT
 YllVMRT0pw6EjhDthB66Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W9NIws5o3KI=:S9EnPoIpybIiD5SllAhvy6
 BeiBn2eULnHlFSH/vEfdSmWd4dJF0vL0cGb5eGdHI1e/z4YG0sTaQzrcZrxLL3VtmUtyJTtij
 WJ96nLxvV2HVDIaF/T+xgbvsRuoruvhoWqiex1xiua7llnNTYn2TYXm5JCbxIMMTkYLzwuv4b
 HfLPvmeG0Or1g3GY9nPGpODfPlNtPN5o9pOp1l/Vmm97IbMSOjRA2G6/THly1Wrl6bpVduPTO
 FI6umKACgid9TGH4cjpmflugTnrurS8XdZd5ajOgWptHKSO0tJZIxK4rD6P9bqEDJKyp63I/J
 P9kKVn1kGZXfuC07ntTcj+QUmUCqQpQlzEGrPGkk2nNJKMUY3GCj+Ip5fM6vCxvBbZSjL/cag
 CSS3AVDzNhiFxT1Z0nWwDDlcqgg8JThDSAN34AWR0JfCETgacnzmrEroNi4ee6BfNKfoPHr8P
 pdZAQ26bRjR1J4FEx1JfumUpsmp6OIohpZuLvH77TyfA8YdiM+EnjEfhJ1ycjExzj+SAiO9rB
 BtI5gtm6MilTmbou3l25UBRqTBU0b0Q9fWY3xiKaEwpEtPeHKoCg8534JqVW6MzNBXFsW5Pkr
 NlzMrxa6/sSg1ElvJB/EXABYSkhi4DGm17ZSMtQPWWhaK6T5adK1OeDs3Awx0D6d1HDDxHPqL
 iaL2IayBCvC1GJougZhJyKsN1QOG0FI+ZfmzMYV3mcpPcHMT6URSGKnuzY6Wdxwp7aTGKzxVq
 j6/qAdjSamyTLOdzIEmdVUujWy9KYlA96akoJ0pob6kSg9aTU2aD60gHPMqyp64olXqDnXfrf
 /+vVHG69IL4OBjvS7aTin6TsqpHPhacnwUyPxnozOlnOX/pIB34i5algcOItaG1O31+wdp/qt
 6tw/GPXiD0QY8AycJWvAERckyaY8eMxbnysDKGVWawT/CyqenjnbPAmtejPrNyCOn0Q4NSifJ
 KSNuDJWrRtiEsSs6a014dIw+cxcZJiWT7RbQO5tC3U3hX+uOPM45zX1d0VhUVDKQ6G/MN/sMO
 WoKgG1rTVKl4EiE1u55yR2enFFe5W10YfoF8vwdAhWPhhvKmQirXauSxnqYyAVpzOP2+YNxtg
 I8orKupUbq+gNtIQrovP0G5OLCKuxJ7/b09xGy67Zc5ebmwgzOLK5yRyzwWVOPCYcY9mJxT+g
 65ehy42odFUAbp5BE+NL48m41ozkyuoDi3R4F7gygdR1XoYQ==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.14
Subject: [Qemu-devel] [PATCH v3 2/4] tests/test-replication.c: Add test for
 ignoring requests after failover
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
Cc: kwolf@redhat.com, Wen Congyang <wencongyang2@huawei.com>,
 Jason Wang <jasowang@redhat.com>, mreitz@redhat.com,
 Zhang Chen <chen.zhang@intel.com>, Xie Changlong <xiechanglong.d@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This simulates the case that happens when we resume COLO after failover.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 tests/test-replication.c | 52 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/tests/test-replication.c b/tests/test-replication.c
index f085d1993a..4502a6f816 100644
=2D-- a/tests/test-replication.c
+++ b/tests/test-replication.c
@@ -489,6 +489,56 @@ static void test_secondary_stop(void)
     teardown_secondary();
 }

+static void test_secondary_failover_then_ignore_requests(void)
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
+    replication_stop_all( true, &local_err);
+    g_assert(!local_err);
+
+    /* it should ignore all requests from now on */
+
+    /* start after failover */
+    replication_start_all(REPLICATION_MODE_SECONDARY, &local_err);
+    g_assert(!local_err);
+
+    /* checkpoint */
+    replication_do_checkpoint_all(&local_err);
+    g_assert(!local_err);
+
+    /* stop */
+    replication_stop_all( true, &local_err);
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
+    g_test_add_func("/replication/secondary/failover_then_ignore_requests=
",
+                    test_secondary_failover_then_ignore_requests);
     g_test_add_func("/replication/secondary/do_checkpoint",
                     test_secondary_do_checkpoint);
     g_test_add_func("/replication/secondary/get_error_all",
=2D-
2.20.1


