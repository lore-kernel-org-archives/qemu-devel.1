Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19495CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:46:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF0E220684
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="lGQgBB/F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF0E220684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNfJh-0006rr-HP
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 11:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38932)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1iNe4B-0008QB-Vs
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:26:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1iNe4A-0002oC-Nf
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:26:19 -0400
Received: from mout.web.de ([212.227.15.4]:46739)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>)
 id 1iNe47-0002hh-QU; Thu, 24 Oct 2019 10:26:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1571927145;
 bh=OfJkK2vnGkQe8T1r5KQyutlaZ4TJ+K9pB9jGve8qHNk=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=lGQgBB/FqY7YomFrbayzQXuH0TFlk1D6pOdg3MMZBzvSOpUKRJ5Ry/6AjD0gbQ2/+
 i2FDuGDcMBi3vALQypOB54Yl1bmxe2rsH23IYFiCLldK8Ehr0L3/WMpbFb4fm9Kvod
 TpmAtoMZIZR6XAk4zvqmsf3F75Myo5RAJJLHQ3VM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.150]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M6V2p-1i430c1cYF-00yT6q; Thu, 24
 Oct 2019 16:25:45 +0200
Date: Thu, 24 Oct 2019 16:25:44 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v7 2/4] tests/test-replication.c: Add test for for secondary
 node continuing replication
Message-ID: <60b4c574f996824210f7b2282eac030dbe9f9e41.1571925699.git.lukasstraub2@web.de>
In-Reply-To: <cover.1571925699.git.lukasstraub2@web.de>
References: <cover.1571925699.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V5s0lVOsEJp343Q4r+2aot8a5KDekal2vhV757BxhU3szgkIQkk
 Ca1LIXE/QxcdcWzTALMks8Tc5IOs6LJ1NayoFVk1Ab8qShiZ9UlPxVnIgyf03Z8S8sybf0H
 NrRtBysges0FuD41IzzWHByVvjcq26AOVYhbc+FESFqdrtNlAEbikvvG3Wq20+IsDx4Rkum
 UeD1wpNg3cMfSytJoTPSw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uLNgf5N+nB8=:HLa0Py9yOmgtio6ntdlwv3
 GkaWct/MAScNOCPofH445DxjJLIbCgte+ZxZneDz5uTKyh1m194AMveo7pwi06N/8NfUCi+Se
 FGH31cJolgPzmj3wz36sZ2w3uG/y6Qo6iCgiU5D9lVAgnTad1mfjzKjjKHkWpZ1Nsab/bUHdd
 k85gLY82DqedgsFYv7O0KdfwXquaV6Gh19vh7TFWIgzGX8B6eAvpFErAqxfQbOWT3fKmOY73r
 VehWk5IFK5DcVjs7uM/sCSkKei4IhuK5syKMy4TKJzq/7F541V+53GIKKZ9GXTuMKLreEvMxG
 fzSNaud/910YYBMrfAbU4AMzGXKrwwtUErs+GyFsz4Hf2OLWeWWSz6PCjjg+9Z/qYr/tF/Hnh
 NWgNQdx6QiNXYofyjEGp88y8TvqFY5O8FyP7Mlz1MSGXZf4FyE7Y+L3HxDa5wclJFm0HXk5k7
 dF5DpuBznILwENzmvI9XJbdPvgQXjxIdYFy9mMlOOYb6UYKjipoU0rSzSFS837ilJrmAaMQS6
 4I964NqijpDJtCm7970FwKPJjhtb6QCBs5z/ABeTZ7TnX/GGrO6Mr0774vUBUUe60yC8nuNck
 KmmqUAnsRa0CbY1nb9L4/MAWxNQjGt6mYjy5hyAC3VTY+w3taSI3X8qzWINs05fM3DxwBMO3h
 i/yQIr7ZnN72d3rK8deWl3q1wzCnAWJ247waCP3DgFz4/5vIaZ8gf5ySIVudPA59n9i5Jf0bc
 Kntd333/fNDzQlMTaUzMoa8WTMhhx5Pfw5ucCGcA7c/p3M+ghOTNtBPA51JpCdZQAi0sC010U
 Wzx37j7nVgOxJRtzWO3UYte1QwpkDXcG9fRa16Etk+emALczQiKs3g+s3VBfQEaGJ9rhTmAJf
 oA4M8eWakrzsEfBw01pXLlGyEsJ6RODD+G8EWvR5UODNI2BY0DrumYmOdKU3k1JDd5etKfSz8
 vkj77pGQNQhOVOIz9FRaOiTs5sMDtlESukmT42lXYZQCHvGR6UR0y3/bQQyM2ggHNp0FVA+Mq
 eTNircCbTClk4GlLlLgJmEmAgEJFudVOnPI5f6B3eoC0tPDy/6YbMa1yxGAAwaICqv66VhVmS
 eL9Xvy+14rRQlBwjC5iIHOxMdNjT04csCMCSQd3rX7iTs+p1X8jr4EHIwQb8O28oLQ3v1SO8P
 Vhp7VESMdmMgPe5+fODNKz7RZCFVQJt1EZe6IC6Oev7qP2i6yyKVntJ8vAQZCib+YrRzpCnyH
 WiVOeWvSLoq5KnAMlKsxK71OowocDJwzx/hmvgq3hnThmM0N+DxwDKi3gOq4=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.15.4
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
 Wen Congyang <wency@cn.fujitsu.com>, Wen Congyang <wencongyang2@huawei.com>,
 Jason Wang <jasowang@redhat.com>, Max Reitz <mreitz@redhat.com>,
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


