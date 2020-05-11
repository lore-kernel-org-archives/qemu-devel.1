Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7BEC54E4B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 11:21:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ADDC208DB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 11:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="BU0YYEY8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ADDC208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY6Uy-0004lP-Gv
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 07:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jY6Ks-00050F-F7
 for qemu-devel@nongnu.org; Mon, 11 May 2020 07:11:02 -0400
Received: from mout.web.de ([212.227.15.3]:34051)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jY6Kr-0005l1-Ir
 for qemu-devel@nongnu.org; Mon, 11 May 2020 07:11:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1589195453;
 bh=dZ8rX0irz/4KH8600VHSFn1CNdmEGizP4s4ww9kK2Ho=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=BU0YYEY81LWwOVoniojx3ZwInETAbh5nNx3nTJs79IxHNK2BjKXmIj8JGEE22yHcN
 hk7LaR1/k1fxIvmaZsoCMtCcKL7qnRseFWkwTB9mFXZeBVm5MW2sD5LX2jXyMPvBgo
 AUjtoJcga/XkTBbaUc0T4dufWUhKTszzo+5j943I=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.192]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mhnvw-1iuciC44J6-00dpwi; Mon, 11
 May 2020 13:10:53 +0200
Date: Mon, 11 May 2020 13:10:51 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH 3/6] migration/colo.c: Flush ram cache only after receiving
 device state
Message-ID: <3289d007d494cb0e2f05b1cf4ae6a78d300fede3.1589193382.git.lukasstraub2@web.de>
In-Reply-To: <cover.1589193382.git.lukasstraub2@web.de>
References: <cover.1589193382.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/YGLy3le0j4dB+FCgjFRYPzU";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:Q43gYz642FHDiJiOKUcWlXH5M8tCMurNfc9+BrsFD4f//0Cl3r0
 xOcLddf14yOmnxbkR8uaLWB5YbHmgNxwVUaWsAi0Hp0952L5A3n4mhnWQw402KvYWX2N19L
 aucJojiHjtXA+AMztvOMsH8CZ9CVF1i+Z0weSWMaEODLj3TnDh1HinCJ02kskNb7KDw9Sat
 ZWeG0x2dTrqJzD3H3HwQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+mUVSYNyHrg=:wVx8sGujcmxz0dEFzpXZ8C
 +ZHuteoBY98PsfVuNeLzp2tQuZxhKk6VZPYj9Z2E3fcWsw85fQnN78HpMTojTk95GilLPcc+1
 9SIdwgbsII3iNnbR+BW2BWWNKYDX6oYubx/DRP7uqIkGKpX790PkUqxr05N4I0EG7sm6uxj9F
 7Oc7NOV4V3AN6Lhtp81X7fdP16JOoTUPrsEy/7FM8Rrvo9+e+tieB+J9G9tAHLUb9I6345NSa
 VlzBonzSAYh+A4KoiXFkP6rNq4TV24iRyGh2c6lXyN5vvmfykxHqvnNeyqvS+fNZaIFsOsWdm
 ih25IYuCPj14jZZ79H+BEiwsY+oRkKHdL3fa1WKTsNjnafDSO+YQCzDuIndlT2qNh2ONBpy0q
 XNvXukOwAf+xafOHfZVhTqoeBneRLa9pDTwsfisTbqVc43xUDcV/iFycBpIUP3Nq9ZdS6KYau
 +e/BvVtRtoBJj90YpzCi3faxzJRhOqmcvIN916gRDhuMqe0M2Pl/83nPntqpoWQzaZoTGlAg4
 ikX564Jl5+oPlfton6+KAvybkuK5KSIvb1dXjCbPz5w8FXPASsZf2GZEOgw3CFqmOQY00LiHC
 ScqMHDXES/McqT7Xm1kAwv3HE8pxmVepP5GFDJd6afQP2gwy4lhGNoWYpF7eLuyeu443WdI5b
 G59o3nm908MAqwwbx2zTFtVltcqYpqQQl1ZITgVA3b1LxnVz0/i15TpcJu9areuKzS5LaQI8s
 m8WT/xoMinE9CgxIYs2a4Eddaf42bt5AU5q48HM/hTpt+DENWHNKEKc7jckMfYCylfPSzBZeF
 a4NOJA/URxuBJo8QHQQaBiqxVPlky0RfFIFgTKok/ash2rLzkFoQGTVLzo75pIVrvATV7aKK5
 4JkX5EhnaTLkVLKWKt9Rn3JQb+f5CiLAV3KCuzkBaaKUNI9a9iE1fLG+AVSdJWdGti6E4clIB
 cFREDTqYh5ZCc6k1VpmkZkv1MLEn2PaLqP/nkx1ULzUreXa9dhZbTTELONsi0/fkarTYMQgGJ
 Vb+pxilye2H7Xsgny3lJUtmogONKDaUQ6ugqiAdZsJVD1leCLqbVlQmNvKu80c0DCKk4RBBkG
 GmnW5zZ3fmZD+q4WNjtDSZWXj179oULGveRd2XsOmVQ5oXPY+jIqnxdR/QdKDzZS2W7hIg0OP
 zAnGu2cYrHT99BlPZQNdVES7nWg/WPOXhZUsYNVP5xMPTYvlZTnPTjPgfahSBGszCkJqdgGuE
 s2xD1JQ7GZ+/is1J1
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 07:11:00
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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

--Sig_/YGLy3le0j4dB+FCgjFRYPzU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

If we suceed in receiving ram state, but fail receiving the device
state, there will be a mismatch between the two.

Fix this by flushing the ram cache only after the vmstate has been
received.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 migration/colo.c | 1 +
 migration/ram.c  | 5 +----
 migration/ram.h  | 1 +
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index 6b2ad35aa4..2947363ae5 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -739,6 +739,7 @@ static void colo_incoming_process_checkpoint(MigrationI=
ncomingState *mis,
=20
     qemu_mutex_lock_iothread();
     vmstate_loading =3D true;
+    colo_flush_ram_cache();
     ret =3D qemu_load_device_state(fb);
     if (ret < 0) {
         error_setg(errp, "COLO: load device state failed");
diff --git a/migration/ram.c b/migration/ram.c
index 04f13feb2e..5baec5fce9 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3313,7 +3313,7 @@ static bool postcopy_is_running(void)
  * Flush content of RAM cache into SVM's memory.
  * Only flush the pages that be dirtied by PVM or SVM or both.
  */
-static void colo_flush_ram_cache(void)
+void colo_flush_ram_cache(void)
 {
     RAMBlock *block =3D NULL;
     void *dst_host;
@@ -3585,9 +3585,6 @@ static int ram_load(QEMUFile *f, void *opaque, int ve=
rsion_id)
     }
     trace_ram_load_complete(ret, seq_iter);
=20
-    if (!ret  && migration_incoming_in_colo_state()) {
-        colo_flush_ram_cache();
-    }
     return ret;
 }
=20
diff --git a/migration/ram.h b/migration/ram.h
index 5ceaff7cb4..2eeaacfa13 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -65,6 +65,7 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *=
rb);
=20
 /* ram cache */
 int colo_init_ram_cache(void);
+void colo_flush_ram_cache(void);
 void colo_release_ram_cache(void);
 void colo_incoming_start_dirty_log(void);
=20
--=20
2.20.1


--Sig_/YGLy3le0j4dB+FCgjFRYPzU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl65MrwACgkQNasLKJxd
slgaWA//X62eufDz6UIimQuZI0Yn5HbpsyKWJcvS66I3Z5V2O+0Rihnq4KQDSb30
gT6WotIv0JOB9X64l5W+LDxsbbwG8hBiMg1eEtAaCYTTSMn7oxiX8OOp6t7p0a/S
l8IZvxmvMoSQIlC6V/mVFkdPwZrJK3v/kQWWXFdjuYgufRaCc4f8etyebtzTROjQ
tuL5oPGx3r8x0XOEBjpbxnXhl8Gb71aUWoK+z3aNoKj5wr4NynjJGeaJYXjq6dAP
8UZBGFAFLQGl54tMv8OnQCT9WfooJDUX4v3BRuXkkD6AkGqmqbMACPYkgNKsaCwf
c7mLjg3+wMAfZFXNGb4JY3Hbviirgkqi0bXoEHeSrbhO/f7gG58ld8gS/1Oif8rQ
aAd3/Bcn9zHg+SePFxZ+4CfumWBfY8BjjYa0/Ar6NHleyop2VD33S3KgW4Akhp8c
M1FKAUwAMe+feSF288RMn85S8SgDB8iig3UrOUWPQWUNIDSm3vpoLMfEhzUtyRis
WWD5uwOfQx+Qu8S0T1VIGh4Y/2WEc9gfhTKEEcjsPXbgS/eHyVKebWfZWvw/tap3
Hsr5OpzV/jiqWQYyrQphVRiBR8T7hmBce9zR+GLoHhHRtcHMvoEFx9UL8mcJkh1Q
tMcK+8z+IxS3vCgUjYLe1YXZO/nv+P3Cqs1dbyFiyKlAneYg/qc=
=lqJv
-----END PGP SIGNATURE-----

--Sig_/YGLy3le0j4dB+FCgjFRYPzU--

