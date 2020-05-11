Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92ED9C54E8D
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 11:26:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61DBA208DB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 11:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="rnCHsad+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61DBA208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY6Zt-0000P6-Ev
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 07:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jY6Kw-00055l-KD
 for qemu-devel@nongnu.org; Mon, 11 May 2020 07:11:06 -0400
Received: from mout.web.de ([212.227.17.12]:39059)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jY6Kv-0005lO-NO
 for qemu-devel@nongnu.org; Mon, 11 May 2020 07:11:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1589195456;
 bh=EV7r9FZuq8i6pX8Ttb/SNRCCkrj7ZvzZ76JW02y6FPQ=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=rnCHsad+hzi9CutGZdmaLco+8cp1G+mpmJ4dyufRofOpssevpWO1hN30tbQDgzxzP
 /o4q13lc3uDDFDe0Je5ANXy2n07dHXUg4GhGnOGouirC8XSPtP75/t6a/hg0a3tu79
 5jtu+aaWBJuKs2IwOrinGksTnb/DCxizJ7IYeihY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.192]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M9GJ0-1jOjDa2EjW-00Cicd; Mon, 11
 May 2020 13:10:56 +0200
Date: Mon, 11 May 2020 13:10:55 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH 4/6] migration/colo.c: Relaunch failover even if there was
 an error
Message-ID: <f60b0a8e2fadaaec792e04819dfc46951842d6ba.1589193382.git.lukasstraub2@web.de>
In-Reply-To: <cover.1589193382.git.lukasstraub2@web.de>
References: <cover.1589193382.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5taWeC3ChStsrq15K23dUhX";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:7t20dbAXEYDPneRBQEpebmd6MPQzBRiQBeLEm5/A3d/W32BBy84
 zDueejoiv0hXboAgz9rWD5TZVQ/l1jJRt7n+tlfTJEZ+xxVX0xbG39u8eTrwaxNYX+KkhgI
 AnMRNINaiUE9joSecuptKsD2uEonxEGsR+2ad/BA5f+fboVQDt7ovyBelGnvYwctKa29Uqa
 QHnlkFZE8W3hjdLwSyaPg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HoRpwYGd9tE=:hgXAaKlW4x2gJ26aVGnx7D
 vCpkUHJtnZfmA67h31GbyqixkJzvb65M450Wfcqpx0qp4U2Fk3mHQ1FECY1t4Bqd3UR0ouafm
 0bpWd19I2SHvcbqw7GdGK7QLC0kCIURjkVO6DmPSw1RHRE+VM7xjyTNuP//B3LgwiIh+T2N7U
 r6xxiVNKqRegOy3Mhs7BdZ/sqWcENc9GxlW+YukTUg9pPX/bEnSx1x7QInpGXtN2DXbvilh0U
 u6FTpXblXK2rmzyArx3dOh4msDSuQ4FuywIiBhxZYF3c1/nszxLRXKhI9WuaM194PoGRR7SNx
 3SG60of3zOUQ3YhjjyIX+q4EBB5GiSNs+r/xuUBEhC7L9TL+q0xxIBEp/41uzKQiyUcAAGte8
 7eU+Tq1Q3biZanIFw1KDudmunfxtsWCwNDEwaMn1+SIRgpvlay10LFMSr54z/LvBVurjKa4hs
 gz60wh0kern8St/1FWG/+jzOFqfWYwc61QfXC4+DE7Hd6N4ErDUcSHLQFcYkrQ4PuOGVxpcxM
 hDqOesapwYlb5kpoWLmhhkCg2amOFcQFCNLjjYFhgHaGZferCKf+8r7tBJPu1CVSfm0Q6beIA
 1+WsX6jFL8gUObgfdB4tSFQTsIP1ng2yVQOwhlwSW6E9scWBRBmbnVUqtc9jMaY/QMyktUR91
 L/J8bSP60MqsgB5BnejplGlQnhfN6OqxvfmwLCJpMNovIkasAmLiesSPgNuSFX0Z+e0y/zfn7
 vp2Jekwmmba4zftSfTqmQahDlWE7ewloTWieAoiWpmOrFn5kL0Tf5VE2AP2NcoNryITXWz8UB
 upAD2OAGpzqRDR0gqWrjar5j5Oev0PRgQGSprEFwYxxJuqn4ED+l+/kvcN6GpOkzWSZ6r0Mnp
 0OQscmNAUXyQmjbo0asZDKZJabfis0xWNjm1MSi0tQgMXxAoW5PPVxYEF34vUJWCw2aRxSK0X
 KRuuvDcZlDVS0RJxMZhD34fg6kC+T9bQLKOtruVFnKI8BTtzl012w0wO/Xj6cPf7c296gVk9E
 Yhx8EGWe9fFEjtezJ/0bis/z543TAyOkPzFGRZPChMqNCCIFlWyo78qtS017Apr+DfIiSjGyX
 Li6MZzuNTLPFf5cmrJMsmQyoc39HsVK0j6yUt8oN8s+5hbWJHWQleSzSN6lfa5TaRTYc1Sx6X
 8y9Ootv1U2vxWJGlHhr6o/gvXl0Sv5zimUv2KXe59tSPcgBTFKpQhTywscbQc0+1m8YyqKuSR
 FQgHaBcQd5UOB3PJ1
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 07:10:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Hailiang Zhang <zhang.zhanghailiang@huawei.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/5taWeC3ChStsrq15K23dUhX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

If vmstate_loading is true, secondary_vm_do_failover will set failover
status to FAILOVER_STATUS_RELAUNCH and return success without initiating
failover. However, if there is an error during the vmstate_loading
section, failover isn't relaunched. Instead we then wait for
failover on colo_incoming_sem.

Fix this by relaunching failover even if there was an error. Also,
to make this work properly, set vmstate_loading to false when
returning during the vmstate_loading section.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 migration/colo.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index 2947363ae5..a69782efc5 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -743,6 +743,7 @@ static void colo_incoming_process_checkpoint(MigrationI=
ncomingState *mis,
     ret =3D qemu_load_device_state(fb);
     if (ret < 0) {
         error_setg(errp, "COLO: load device state failed");
+        vmstate_loading =3D false;
         qemu_mutex_unlock_iothread();
         return;
     }
@@ -751,6 +752,7 @@ static void colo_incoming_process_checkpoint(MigrationI=
ncomingState *mis,
     replication_get_error_all(&local_err);
     if (local_err) {
         error_propagate(errp, local_err);
+        vmstate_loading =3D false;
         qemu_mutex_unlock_iothread();
         return;
     }
@@ -759,6 +761,7 @@ static void colo_incoming_process_checkpoint(MigrationI=
ncomingState *mis,
     replication_do_checkpoint_all(&local_err);
     if (local_err) {
         error_propagate(errp, local_err);
+        vmstate_loading =3D false;
         qemu_mutex_unlock_iothread();
         return;
     }
@@ -770,6 +773,7 @@ static void colo_incoming_process_checkpoint(MigrationI=
ncomingState *mis,
=20
     if (local_err) {
         error_propagate(errp, local_err);
+        vmstate_loading =3D false;
         qemu_mutex_unlock_iothread();
         return;
     }
@@ -780,9 +784,6 @@ static void colo_incoming_process_checkpoint(MigrationI=
ncomingState *mis,
     qemu_mutex_unlock_iothread();
=20
     if (failover_get_state() =3D=3D FAILOVER_STATUS_RELAUNCH) {
-        failover_set_state(FAILOVER_STATUS_RELAUNCH,
-                        FAILOVER_STATUS_NONE);
-        failover_request_active(NULL);
         return;
     }
=20
@@ -881,6 +882,14 @@ void *colo_process_incoming_thread(void *opaque)
             error_report_err(local_err);
             break;
         }
+
+        if (failover_get_state() =3D=3D FAILOVER_STATUS_RELAUNCH) {
+            failover_set_state(FAILOVER_STATUS_RELAUNCH,
+                            FAILOVER_STATUS_NONE);
+            failover_request_active(NULL);
+            break;
+        }
+
         if (failover_get_state() !=3D FAILOVER_STATUS_NONE) {
             error_report("failover request");
             break;
@@ -888,8 +897,6 @@ void *colo_process_incoming_thread(void *opaque)
     }
=20
 out:
-    vmstate_loading =3D false;
-
     /*
      * There are only two reasons we can get here, some error happened
      * or the user triggered failover.
--=20
2.20.1


--Sig_/5taWeC3ChStsrq15K23dUhX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl65Mr8ACgkQNasLKJxd
sljHig/+MuuQKqEfLh3i6r6ITGOyR2OQ3OLpKTA7EMXj7tel924arbrgAMrqn/od
vcfUM3J8D2k11HMoNpMcL9bvAoxqEpi7Xjl4e8/qm6IrFH0ujfej/C9JNppj5N6J
UANmZmkW08nU/g+1CbC0qWxhh8Qn4y8BuN6qbhKglj23Jkg3dSJcjeYN/DxVv3ro
4uc7yhYVVESU/Xe2yPNkkM45NS+BJMe2hPzOCzHpxNdekXhaCJiR1HGnTxWSd3b5
l0zhjZ9nlGekYfy6J6tSmxXnsGh6uaYzEKWUh3uw6yulmJZyU0WImXtVPcfEV8Am
mxUOV5BuD8p0geWixuil9eUvf99DI0dGdfGDN+8OdE7NDBK+a/SNcG7XEhQq8wJG
fp9OUbZ7HJZdIMpawHxHvzJtxBGITG1EkOkTLWJ26vsnj8XJxCJxRWvWhCcb1ELj
WAuLCnWqEbispIVcNK0dRBp871qgfiMbbjn1bOawMp8geykDme9sREqo74HfPYmh
0zC1DKNCrotk2MG8LZt9VsCjmzJfOBcgSz+yMJ+NOL49QAumde/CoM5C/P4/E6uM
YsHb6uRLVieQ1SOwrJlvilg6fb+T9JOgkF7GyevT0p2oJG3OCtiMssjc8PH2LB+v
8SSY4Cr5L3zgCzAAtdByj+SqHmJGozOADtj6NtMiiK+LCq3v2n4=
=teLf
-----END PGP SIGNATURE-----

--Sig_/5taWeC3ChStsrq15K23dUhX--

