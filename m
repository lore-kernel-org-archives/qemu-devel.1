Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B70C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 20:46:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FCC220823
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 20:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="hY5T4AC0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FCC220823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbVbH-000870-6L
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 16:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jbVXn-0005kD-LM
 for qemu-devel@nongnu.org; Wed, 20 May 2020 16:42:27 -0400
Received: from mout.web.de ([212.227.17.11]:54509)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jbVXm-00074z-Ik
 for qemu-devel@nongnu.org; Wed, 20 May 2020 16:42:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1590007334;
 bh=AjMQkHOf6lMrzLOXJDOiR2XIYx1RZkeSv1cRQw5pyuA=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=hY5T4AC0KLL2wO40rGwXvNj0+egoPPHBKR0CumQkCsSQGduih+7bZFmMEA7H/5nr1
 3bspMl4bVCrBpPggEQopdz6fVLnSPqBSCMtCdgaGCpGRZ/lltTbFN7sbPNC3I1hJjK
 pR9v/LC0dOm0xSKF5wLq+FE6igEHPLxv/Towbeoo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.105]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MRF3W-1jNFwo139Y-00NMzx; Wed, 20
 May 2020 22:42:14 +0200
Date: Wed, 20 May 2020 22:42:13 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v2 1/6] migration/colo.c: Use event instead of semaphore
Message-ID: <1a13487e3f1ea3e378497cdefb5c9bb6a29f3bfc.1590007004.git.lukasstraub2@web.de>
In-Reply-To: <cover.1590007004.git.lukasstraub2@web.de>
References: <cover.1590007004.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/E6Qd9X_eYkwRUWgG6bEtlsx";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:OhSQ4c25roRjnkblBc3E55EWt8WdTAbhzil+XSV9VcNgKwW6JOX
 Te198ldL+Xncxr+TUoVOUzUBXVMzd1yUC7wyJ4M/u8E9rLKHi4b83vFp+bzB+GrdDxWvQnQ
 xMPYDJuLW53vl//jrABpD5j0k+ZFgk9rAffbknbznczKasEfXesGpNNMYnACW7EMNT++YL6
 K0wT/n1kIBn0rBaPw/hsw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FBI/0iZnJ7I=:j47IYbGm8PrUKbtHmLS/r6
 VDjvIHCK+v3bbolt4VTOIxVNBndA3l0Qy1HC/E0wGcfo0qo9/RN5tijq+aBWlUwIyQ0Zq+mn4
 V9GWpJKLS1l3jW02CzTKVxXMRVTs34AVX9oIOeyrtLMssVOid34yHay+S9XtuyuQaqU1yS6GC
 QxOv2cedRBc6mCitNGySuzniG0yxHxr/PRbsxzLtBLsD1Q0NTD5gkh0XGN77k6tjWH6+hT2Ov
 Yyr6ctdtUZnXo90aJTVhiDxWZoW+k5KHByhbXYadSPQKXcEimoRnnWHGN7fhZ7c3X5R2o/l1p
 sXUdMTzbnxkOa5Uq3QUinH4Rl216jqsNDCmmooK9aq7fgfsasYO0181xYHM3oKBQzucFaZ+At
 qzOQNtWK/jqzdHwJ7lgncQqlTgef5o6VfwdgLktAMP9Mo55GDCyQJGdQ7A/vsoNT8UAVYQdzn
 5WyRFlub3CIxv01H3ZVK40y2XvvubR3bdJ29x80UW3SAx+OJwrAXICt/vPvgQi/Riuwb8sF4f
 h1Fk9BY64dgoqBBuMJST03SgdhMhCUTrKi3IXEiIqvaJykycW/xs2YXrPpSUBhEuGipOBoGEk
 8Ujhqu5aCletXLtu+BCCQA6s6U5mPg22yqDCdzERP0V7KVIgnnrNp5fWOTa3x8u4aXLNpLds5
 nRzZI5tpMPIXGlEgH7n/zrVNUDySzE7IbETfWiCmlHS/i5RdnKzsFlaCXoaJjoum4Y5MLTuBy
 pvLFVDZtUBCasm+ubl38Wy2WASzwrWJiTQDqaPnJqZDDGMXWTjj6UJy01JdeYb0mH84qIJ6eJ
 ttHJ5cB4vM4tv7Hoci0qJk2HBfVCuGM7d3lUae5KkyfDmEFkQd9Szlkbj4+IWvz6vLYdnip/+
 7ioW93mqJf/W1ipmbFqoSJH/IPX6NS18SOvuYdZvPY54+kzQkYWX2lhFou/y2OR7e9+f786Ca
 q9HQQFnSiQ7qyr+jiQv75K/QmWaCS4m16N6HI2vRy2pQXDeaF+BOSb+CDKqRurqkpp+2WnZTz
 7eg+WZVNRnzCuDnxIiy6AvUpEEr3UWSzrM8ZgNeegP5/7xe99t5srwiKhTQxA+HZqHNeLYbKi
 jJE2WGnglh9ceG4wwqin9ntmTb8Ya+h/AM+FpMlIc4ctExXsUTZ591fiY7QdsO4BAtPLijyyR
 Rsezzoe29tKBajqGeZ4QMij6oj1MJ5Pg9uVN2oCGhfN0NECGKbUZzwSWVlXMpj+tdoyKd6uIN
 8FYf7uI21juzFwh+I
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 16:42:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

--Sig_/E6Qd9X_eYkwRUWgG6bEtlsx
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
Reviewed-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
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

+    qemu_event_reset(&s->colo_checkpoint_event);
     colo_notify_compares_event(NULL, COLO_EVENT_CHECKPOINT, &local_err);
     if (local_err) {
         goto out;
@@ -580,7 +581,7 @@ static void colo_process_checkpoint(MigrationState *s)
             goto out;
         }

-        qemu_sem_wait(&s->colo_checkpoint_sem);
+        qemu_event_wait(&s->colo_checkpoint_event);

         if (s->state !=3D MIGRATION_STATUS_COLO) {
             goto out;
@@ -628,7 +629,7 @@ out:
     colo_compare_unregister_notifier(&packets_compare_notifier);
     timer_del(s->colo_delay_timer);
     timer_free(s->colo_delay_timer);
-    qemu_sem_destroy(&s->colo_checkpoint_sem);
+    qemu_event_destroy(&s->colo_checkpoint_event);

     /*
      * Must be called after failover BH is completed,
@@ -645,7 +646,7 @@ void colo_checkpoint_notify(void *opaque)
     MigrationState *s =3D opaque;
     int64_t next_notify_time;

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

diff --git a/migration/migration.h b/migration/migration.h
index 507284e563..f617960522 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -215,8 +215,8 @@ struct MigrationState
     /* The semaphore is used to notify COLO thread that failover is finish=
ed */
     QemuSemaphore colo_exit_sem;

-    /* The semaphore is used to notify COLO thread to do checkpoint */
-    QemuSemaphore colo_checkpoint_sem;
+    /* The event is used to notify COLO thread to do checkpoint */
+    QemuEvent colo_checkpoint_event;
     int64_t colo_checkpoint_time;
     QEMUTimer *colo_delay_timer;

--
2.20.1


--Sig_/E6Qd9X_eYkwRUWgG6bEtlsx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7FliUACgkQNasLKJxd
slhiPw//XcibcUc+vYAkhMfmFhQxgKReCHWRsOMBM7I09QUGJwj0Q6nqEUVjH8uF
PdDi5UUqXEU0hE5eQJS/9RZNvWTOhE1LK/WDAlTJSaRjAZvlGOnxbo2Et7IAACYi
yICNyh+gVhTLkH2NpkvyLh6enOaF9hdk61wXsOK2bBEGB4Sr01yWdmg1WRhgUKd5
NpuxLJ2zsUSlkmerylLuipO3vyyl6PugapI4QUA2/EZ1VctM5GhQNE6DzivmI8rO
IsmIxwM8hByJ7bgBDMdpZURDOOsq6Z1SzWZOovCz1m5eTQ8LvOrEv1abt304ggCB
E8lQIpdwjCkqqOn25UxJLR0nIftSbK4IeFToCHpAW6PesIOOGTg7zUiB00EjATry
BPqZD/cRCZdAAsgL9b1ACcOUp2u5V2TN2YtgyRYA69PngLGJpOR/p+NYpVPkxXsT
0PFbTtVv2j83pLFbTQES9Vk9rbjHapVf5n32oVErfbSfJ5DhOTtln13QvT9saqhF
WShy1IumnQ71x/0i+ksJ2JUTnjBKFn0NFmdGPf3VUCrCcTGLnha6/CXzQH2zILov
/jl75VPkFBzwxj5sttJf4PTvC4fhSqpJ3EXmiTF2T+R4KhRy0bzv9+4As+P4sgCs
CntyttechriID4ElBEftR+Jk5MLeF1AHuF1VMlJplh7y4+jmpKk=
=uHKy
-----END PGP SIGNATURE-----

--Sig_/E6Qd9X_eYkwRUWgG6bEtlsx--

