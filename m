Return-Path: <SRS0=GetT=XK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A43C4CECD
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 19:24:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4516721479
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 19:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="qPSOLGEh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4516721479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9a83-0005jF-6w
	for qemu-devel@archiver.kernel.org; Sun, 15 Sep 2019 15:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39580)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1i9a4T-0003cC-Gp
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 15:20:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1i9a4S-000135-Db
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 15:20:29 -0400
Received: from mout.web.de ([212.227.17.12]:48195)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1i9a4S-00012p-5O
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 15:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1568575211;
 bh=lS0He1ZjyrE6labtN6cAGz+FTFA0a9A2XqfoJ6l9fU0=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=qPSOLGEhqn6jTwrNrZzeaC+n+e4vH1kbohGQdRd5pGFTTOcCcL0hEYblpm7uacEzO
 zZyD9wmd32hx1IO4Jh/BokEsdbAksFsQssAcEtImJDI0ySAmbUUqWlZDwEPb4SuHDL
 Az+nUc2nBCdp6eL8ZTkPk2Fb1LbglObAzTB34Q/s=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.53]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MEEa4-1huDz92iVM-00FTS3; Sun, 15
 Sep 2019 21:20:11 +0200
Date: Sun, 15 Sep 2019 21:20:07 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Message-ID: <e3f1e1ec5b2bd2ce2c9a6c7669284a3fc2fdbaaa.1568574478.git.lukasstraub2@web.de>
In-Reply-To: <cover.1568574478.git.lukasstraub2@web.de>
References: <cover.1568574478.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Vzl09lb6jnQfDzrpdso9QKB96CqjdVmHW1XbotCrhBPNcCpfiY0
 9gzopBdCbXNDwn6WmmjoCTFL+0EXrH1fTQJrP/JF5sFBBCcAw+6DFbe/9N7VSSHlKujMw7y
 wwAO42bF3qWDz3CAo0QtWXOuBK7HBdyvOumscDbQxSEGmGy1+FgJ7BJJU2iugQFtGwF1rwr
 Krx8wNihHFJqUzu43lZNg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lDJn2w27Pqk=:jiYHm9lNPCyFQH3xwHyU7k
 fUkyGyAQkwcSzsQo4igztbUa/lDN1a/iAf8g3hujgP0J0DUhSOGkoaJ1+lWjb3YZmBqvzESRq
 JJZL22UKzKyAFSnPQZSjd/7JiYJVAfzLJI8c79C/MD+33uDwEFJdOtDRQ7fOpymTHB8rY0/j/
 +ziQIRMLXfZ4M3ZHj1r0+SJA92m3g0fV3JrGhwYlaOEtoAeVELAP9Od7cA9q/ecw/pX3qhbTo
 n+DtqVqjnaq/f8+rPmvES4WhdL02U2srXGiovBeZ2Tvtrn3OJJ6WC6Kxe2k1HaQacjHxRTghg
 J0+KEhRqIpoDjIzlJ1o5+c6PLqrYgoBLogR1RB1dIFLVKaUHw7u8cfv6du1elei98fiC6IAuD
 Jvsf1RLdXql37NR2vJMN7RXfw2RpzXCsnrWifniiJ4Lx7DAcnhflQAyT9eiUkYMk0buqG5tUc
 z+SQ55RR7+ONwYUCJgPSKuZrrtWTjjeEFLcXKNgxlctkrEfcWEB93ivAg3HPnpjlB0ceUErxA
 JlrMeYS/AlICWMhcQ1uxvOxH2ryD5LLpuGVi19lz0m5q6RxLqqmIYEOmqzHm4MWqOVLaUNv00
 vk/TIwMpASRSp7oHc5JwkHIuara8w/RJxsjItdgzKNlQJtsQSL5JuJa2ten3i8p9y2mT7lzaR
 zYHklFeAtqhTc+vHBJRPcTrSu4P+h/2Nj5jAhsXv//KDtwOjiqc3mUnos36QZPS6P8qWAf+Fr
 GI0taiy7cHBgbM05w6sWXYVf5v8xH1E1kaFOupwdXjDu5IJFuYczdyCnAF7A2K429WpsVnVsM
 2J3mldLtc0N/g4It5w29dSffrrtph2gH2F5Rf+8AYZn4YUnHRGOsgCowT6YAA7d07nYP+Dxxe
 Z/669YtxlWDJESIIIFQyNWOISA047PaKJU3oQTUeHh/DiwAJOCVEy50ud/ZRbAUnjuergW0Xk
 qmjcIh/gSabHDdWWJeDfSq4wZUHA9Wkh5/YfioE/Mo9CHE+tDuU0pr2xtSzzTZv0wvHL3/12c
 cUpeE42tosvBD0NGXYVKFkw0xKemhhs51QhvMB4+c1zv8zHVQ1xw7jzvzy8zJeiSq2JH5/+JL
 voAmaXXgcYklBBZaBmozLpWp8sNIfLcubJRUrbwlTnh5AStrtcE8kl7nE1i9MDTPLl3JnUZoq
 lZ/g3RrF9vvjBoN5H1V5nw9+Mgt3rfDHQyeYUDVR212YuQh50NQS3Z7Nm6neLZyw8Q+OV3i+k
 d7XhwXmyuDUJdnphpxC9L8Y4GqhZUaoKfD7puQ9iFLeBD4yWwgOf25MWsctc=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.12
Subject: [Qemu-devel] [PATCH v5 2/4] tests/test-replication.c: Add test for
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
index f085d1993a..5addfc2227 100644
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
+    g_test_add_func("/replication/secondary/failover_then_ignore_requests=
",
+                    test_secondary_failover_then_ignore_requests);
     g_test_add_func("/replication/secondary/do_checkpoint",
                     test_secondary_do_checkpoint);
     g_test_add_func("/replication/secondary/get_error_all",
=2D-
2.20.1


