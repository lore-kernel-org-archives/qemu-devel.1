Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C00C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 10:19:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 961EA2081B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 10:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="KmuhNGzS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 961EA2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7dEi-0004FT-Id
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 06:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55044)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1i7dAt-0001qE-Pw
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 06:15:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1i7dAs-0005Mp-OB
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 06:15:03 -0400
Received: from mout.web.de ([212.227.17.11]:42137)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1i7dAs-0005L3-FF
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 06:15:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1568110484;
 bh=lS0He1ZjyrE6labtN6cAGz+FTFA0a9A2XqfoJ6l9fU0=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=KmuhNGzSSrMt/P+mXLYvXYKmZbJRZEFJ3uQLEAK0vl6KfqpC8et6D5fYxYCboGlIB
 u10r2HsIjgPPolwEjQVoJHSfKBhVNXZIh471yKQWcItfbvEvVpaSQhdZkyT20fMT2G
 jsrV3g5jGDCsIKJYrbTF/iSJnWKgjdqTS9q9orJM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.217]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M7bQ3-1iIwst12Jz-00xIB6; Tue, 10
 Sep 2019 12:14:44 +0200
Date: Tue, 10 Sep 2019 12:14:43 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Message-ID: <e3f1e1ec5b2bd2ce2c9a6c7669284a3fc2fdbaaa.1568110100.git.lukasstraub2@web.de>
In-Reply-To: <cover.1568110100.git.lukasstraub2@web.de>
References: <cover.1568110100.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sruv98jCmnOTW47dHXGQy8xBKNBqgqYaV3jtF5ALZIWASbfo5w/
 MCsusuWPSoEpnw1HNVOHUjzvsarON6tY331MfETg+Rt1GIUfFR2/Wvj1FViDbWmRobWFkMi
 fYfK4j658VTgf0Q8V9/WRogOZHleRtYmPKlE/RuJTIRpQ0+Goju+SLPDH6QNuQzgbjz/RQg
 nErt+bUXjecOcISIS3rlA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5RDTty9+CSM=:2qmcC3/HMH4UBKbTw1AfIM
 rEp8VYC3KtN4Aphf9/frvu7wFR35MQDigzgcmfB9E5IUZH0BhrtZn2PtuyMmtE79sdrdcOezT
 IUA8yOCtJXaZPxAAzimVl+1/cCW46mX8S0xVQAIzlS0PmfuzBeZO99lB+CdfodPWnzsnCpvOv
 aaYyfocmENg11N+rikX94WG9T16Z/N4kVfIVdrTD9WZ/gnb16SCsivG98+sgfbrmFxyU9igz/
 ecZoN4HiQFknrgYqNCMeMDEAX0+6jLE/vMTfsKFVwaBfhKXg7L98kR1SXy5LvrepMOw9RacCT
 rZUcp0QfDsKUnQr86WAdF3QIs+H9OXyLabY0RbHbEbRUglPyagi6ots5lGLb1uZnlFCIwNNrX
 zKr3+aWUffYtkhpdCptkj1UDdI6NZOPHrrh05rrFxgN/GL6eeknGnHD+x8qVuR+xuG3v1dW0p
 ZJGWoSbDFuqpQwJInAYOSxkQ5LsRLveeQr/lYUos7YQUGSgQfJ05CG86Jgyjwva29Av3Eb2HS
 Fk4zCErZNMpwjOWV70CR8TpaUY8dHu66EaxeSMtZDj0DhsgFdDfFjfJe/2l54quP+YFXe6nAl
 Po4GjzYF9AMnGII5tqDalsSFiJwmqTG9Tq3wxTNIQgs+8SQ7eIDDdMQWHIwyHy+U3XivJPr63
 ReAjQksilsYyDToA/yDbuyJCEf9mufFgrTU4yMAVBBW+6lpe3BdFdMuByRRoMKgutXJmWF+sf
 +FYMB8k7Oszv6JCfnlKO6qqMfleNA2IV7XV3ycMYb3Ii+rdVi2+SrVW64Z31njDuCi2xWz5KR
 6WWsg0w6YfGx7N34YOSkVDmoFXWnucsqvKIlkCVO3okYDBVDd1QB0iUALZLyrIw5A81jWaujl
 NkNtrQhxi7FpEFljIlD7J23+eAuY0GPYTSHf/q8SpFPvSzL8BenIKsKmS0CeH0lCuFUOmRjxA
 CgQDV3SJ8B6K36Lg1hymp9mIQoP98QriA3cRwNoJmqdtH6h8HZHYFGfAyK13hxwfbhdyzSruJ
 LQZpkAzQKZGWBlCl+84SgrwLUZ+CbxSkKXDsxarylSdX7k9l6Vuzn2U3yKUFLHYVl0BrnVj+e
 jhUFzzZRzR4V0O4aImvvp2SxrBj/htVHw31nvPoBv5PrQgYOqJGi7ipkTw/x/foI51NgSKYiu
 L8zFvg0cY2s5p1DY98ootyCr9kFTes3s2esr26VLv6Efx0ZEnX1J6oHSmCKIl0Kij7pymqzWl
 45HR3OSxftZYhoVfV
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.11
Subject: [Qemu-devel] [PATCH v4 2/4] tests/test-replication.c: Add test for
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


