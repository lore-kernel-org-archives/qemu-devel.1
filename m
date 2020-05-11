Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC211C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 11:15:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8599A20722
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 11:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="FrZNULWn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8599A20722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY6Ow-0008Bx-HU
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 07:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jY6Km-0004pX-S6
 for qemu-devel@nongnu.org; Mon, 11 May 2020 07:10:56 -0400
Received: from mout.web.de ([212.227.15.14]:37461)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jY6Kl-0005kY-Ui
 for qemu-devel@nongnu.org; Mon, 11 May 2020 07:10:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1589195446;
 bh=lr/pPkNofIIuTpKiKjKXeB6X0Y9xXQrBIpptsOBfeRk=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=FrZNULWnieRFZbW0K0iphENSVAphL2UkQG73vpDD3Iewos0HO4wv6rq7GScYCM4uP
 VSWYlFArTUOcG6SFyImx9cf7WqdFSbEcUcW+H6k4oby0eP/BK8Gh1lcwE8LmtjfTxW
 9tJWstkk0gD7bwemTmJZEzPFY7cjcU9teL2OtM5M=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.192]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MP384-1jkGUc0NX2-00PJnB; Mon, 11
 May 2020 13:10:46 +0200
Date: Mon, 11 May 2020 13:10:44 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH 1/6] migration/colo.c: Use event instead of semaphore
Message-ID: <fd601ba1beb524aada54ba66e87ebfc12cf4574b.1589193382.git.lukasstraub2@web.de>
In-Reply-To: <cover.1589193382.git.lukasstraub2@web.de>
References: <cover.1589193382.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Kna/+rVkdeScDMcGFaah8Ao";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:IgsUpe26+RxTYtih8/sHO9Aaw+7fLFEYesdd2zvwqcfQnmTUF/S
 cVX+5scOUPDxUiGgZuJVXn58se/h+sKUaWxARTWDKY0tkqbAAd1bs9jMdyHN6nBF3viRRtK
 ZyDCjN59WsLUtTU73X/J7BUUCLRMo4Hdk5Np+ayMYettrE6Wo3L7NYdEIZ+q6d1QCw43zxE
 lR0+Q9zW1Vrf0JY70gNMw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:a5BOynFPUX0=:2WH5QN2UOyxl1OeG14MS5e
 gL+KaVxRx+wKnoslNzOx5Yf2O97mxSrzLQxz28Se6p5gp0Gok2lY/HnTHkqntrlAasdrT2mHn
 LTrYvdtoKywcC8e21aYM8qNToDqeBAfiz9zMrUyg8GX7oIbBuyUVJBLfzhJEAb0RW0pxp90V4
 oABcKtlF5xdvUwwc6d6tZ3C+5fz7CBe/nvNBlvaBe7g9tQrdMJZUKbgOy80AVi9dLf+QhfYcy
 AAAxzlS32rrw+4lgodySlwlqXo8ljfEru7jsfR8EbXayqXOpZoo+cOcQ+3BGKw6ygKM9DdPSB
 Eps6YeWwAn/ecZZIdUklbcpd9SWkIC5FcQzDmZmneoV7SEwt7XsNu44H1szCAkDrEbKE7Iun3
 kk1miM0xUFUkgh13em3Ptbn80O92adpUQ5HJefc/h55lEHODJ2jAPyjCDnGZEhWI3TLJmWAXh
 LNI80l7tLbdBCVDtyZZ5voRl27vmm1OlJBWUnYPSMUonUgeRp6JCJt7XHOfutkEGdJF0yO1ML
 gYGoIZ59w7Msp2/wCwTv85Y8VErQDaBtucjB8uF+7ODl1P4oJTf9faKbOPYi1ndow6HKgHhY/
 BTV7Fb70EX6y4ox7XinSJOBiDRJsuz490XJLVoNeixVwKobvDttKn0YKIflG0AaKHk4J6ym15
 AnXQpbj5kBommwkEOEHFO0x5KnN2WqQOaGnL/Q3j/ad2bR2b3zSKS8dsJLHxzHtVxrCGYnP0W
 ogorghPzBxGEmUg3VjxsJloW+o08U6pBmMH7TFKUIJbWG+sgy9xEF/HVjMvNji11cgujGkTzV
 oKrYIbYi5iD7LOjOy3OYgwshTTRysjk2Q9lkvEiAAWki0H67XDwN5Tt+1HLcOv+sQr5fV8XkI
 HF4NRnxJgOA95u6glZ7tqSGflq69aD8YLFfyIaXiJOtP8OwHbfR8WsN/Z3dyN3wr2YXcqSNOP
 eXmcJc1V76jSOwb6JQrgwR8HD1nqvR8DfvhTiKcvJAOSDOAw998LST4sN0LpCGXp9wE5J1RfS
 X9l92snOanDL7u756NIbUTR2T5QvoVvd4dmQp/ZFB9N4dTF9tZG6AYiJqGUtfUvCiJnZZcEXZ
 ++4ATsTnTycROL/2frnlsqLuVl48g4Kj10ndjT7k/HfjazhqZA8vQVfGION88P4Y5RBq1cH6D
 p5e4VN3Q1rWEC3T1RDaffe6OqMzqLQFFT5XUE9yYuCmMuOctuSNOWS1JS0Zd5MEoQh0W91Nvs
 i5SK+GcAMUYGfvmoD
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 07:10:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Hailiang Zhang <zhang.zhanghailiang@huawei.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/Kna/+rVkdeScDMcGFaah8Ao
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

If multiple packets miscompare in a short timeframe, the semaphore
value will be increased multiple times. This causes multiple
checkpoints even if one would be sufficient.

Fix this by using a event instead of a semaphore for triggering
checkpoints. Now, checkpoint requests will be ignored until the
checkpoint event is sent to colo-compare (which releases the
miscompared packets).

Benchmark results (iperf3):
Client-to-server tcp:
without patch: ~66 Mbit/s
with patch: ~61 Mbit/s
Server-to-client tcp:
without patch: ~702 Kbit/s
with patch: ~16 Mbit/s

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 migration/colo.c      | 9 +++++----
 migration/migration.h | 4 ++--
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index a54ac84f41..09168627bc 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -430,6 +430,7 @@ static int colo_do_checkpoint_transaction(MigrationStat=
e *s,
         goto out;
     }
=20
+    qemu_event_reset(&s->colo_checkpoint_event);
     colo_notify_compares_event(NULL, COLO_EVENT_CHECKPOINT, &local_err);
     if (local_err) {
         goto out;
@@ -580,7 +581,7 @@ static void colo_process_checkpoint(MigrationState *s)
             goto out;
         }
=20
-        qemu_sem_wait(&s->colo_checkpoint_sem);
+        qemu_event_wait(&s->colo_checkpoint_event);
=20
         if (s->state !=3D MIGRATION_STATUS_COLO) {
             goto out;
@@ -628,7 +629,7 @@ out:
     colo_compare_unregister_notifier(&packets_compare_notifier);
     timer_del(s->colo_delay_timer);
     timer_free(s->colo_delay_timer);
-    qemu_sem_destroy(&s->colo_checkpoint_sem);
+    qemu_event_destroy(&s->colo_checkpoint_event);
=20
     /*
      * Must be called after failover BH is completed,
@@ -645,7 +646,7 @@ void colo_checkpoint_notify(void *opaque)
     MigrationState *s =3D opaque;
     int64_t next_notify_time;
=20
-    qemu_sem_post(&s->colo_checkpoint_sem);
+    qemu_event_set(&s->colo_checkpoint_event);
     s->colo_checkpoint_time =3D qemu_clock_get_ms(QEMU_CLOCK_HOST);
     next_notify_time =3D s->colo_checkpoint_time +
                     s->parameters.x_checkpoint_delay;
@@ -655,7 +656,7 @@ void colo_checkpoint_notify(void *opaque)
 void migrate_start_colo_process(MigrationState *s)
 {
     qemu_mutex_unlock_iothread();
-    qemu_sem_init(&s->colo_checkpoint_sem, 0);
+    qemu_event_init(&s->colo_checkpoint_event, false);
     s->colo_delay_timer =3D  timer_new_ms(QEMU_CLOCK_HOST,
                                 colo_checkpoint_notify, s);
=20
diff --git a/migration/migration.h b/migration/migration.h
index 507284e563..f617960522 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -215,8 +215,8 @@ struct MigrationState
     /* The semaphore is used to notify COLO thread that failover is finish=
ed */
     QemuSemaphore colo_exit_sem;
=20
-    /* The semaphore is used to notify COLO thread to do checkpoint */
-    QemuSemaphore colo_checkpoint_sem;
+    /* The event is used to notify COLO thread to do checkpoint */
+    QemuEvent colo_checkpoint_event;
     int64_t colo_checkpoint_time;
     QEMUTimer *colo_delay_timer;
=20
--=20
2.20.1


--Sig_/Kna/+rVkdeScDMcGFaah8Ao
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl65MrQACgkQNasLKJxd
sliVcw/8D50GNVwZPQNWlOZYCw3KdAv/+sqNEICRAfB4eY/1ZJxTOjp1au/hr+6Y
ohtp1Gqu+EBONR2LuXrjB1uxsRfFOcJwFPQaolcnqr45Gs7FcpTlc6iHl2DXUx9U
VoNmL7LUd5N8HgmSlLIIapFdCyf4dt4pbRlrx8VLSQQYUXHBHr5HLXEhTTOloyd8
Oj6zE5H8pA7+1OnDuSxcwZLACEg1nbgB5Dx2RFWddv7fwPgdaH7sGpEv8REkhzcX
pp0P0OGfz1ToQTUY/+9SZn1JoY7aveUor0PYXQkglo0pcU9+R7nzJNNQQN5DXYIk
mQXAyWTOQP11oZR8VYLVVGdq+9Vh4+6B2pRv4kCektomyzMTDkWkDCCHdO+x9S3G
0rJV9GnSsyrHtUrns3T1f/fLUnu+IMU37X4N2BXBmHzUy/3yopUjOAPJRprrxwn3
gGQ5F4bMrUlb+6MU/1w7CbNRCc2NP0PvJX/CildtOQLcZvWceaU/Z4YWqOsEKAyg
JyDSbeEXDFhbXR65znJPqyO8tSuNTmt/IeLuyqASSChvOxBp6lxl7bChn8ibIKOn
NJ8gAYCMHNH+vJat5L0gIEYdAnovv1BU8qvYLkllk2dYjEQoWJDSeGM+QCerE5aA
Pj8CyxOFLbepVPsKrN7NcC9X9sRoByuHz8wx2Y5sLvmpF/5eI/A=
=BbpI
-----END PGP SIGNATURE-----

--Sig_/Kna/+rVkdeScDMcGFaah8Ao--

