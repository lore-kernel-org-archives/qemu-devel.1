Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276A2C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 20:51:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFC6A20756
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 20:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Icnfj42E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC6A20756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbVgt-0003Tp-P5
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 16:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jbVXp-0005mO-QN
 for qemu-devel@nongnu.org; Wed, 20 May 2020 16:42:29 -0400
Received: from mout.web.de ([212.227.17.11]:46605)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jbVXo-00076d-SV
 for qemu-devel@nongnu.org; Wed, 20 May 2020 16:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1590007341;
 bh=nBz36uKLAVET+svpvOg5XAEq13IOV9YVmFR9/mOLz4w=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=Icnfj42EK4XLxK3Hmpl0O/cZPwrSq8FNGXWw3P38gY8rC28tKiAtAbGvAR+BkTQ1o
 GOAqQtsPM/EgZY+m5iyOn7BOz3P9nnj0myxEZTWQ7+qtIRvHCUFZAplFGSW6yBzaCk
 iL8Pzzjz3HWDvJlzh+Zeqg+oaxeHiQgbwq4zhaqo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.105]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N7gbY-1iyPJX19Fq-014duS; Wed, 20
 May 2020 22:42:21 +0200
Date: Wed, 20 May 2020 22:42:20 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v2 3/6] migration/colo.c: Flush ram cache only after
 receiving device state
Message-ID: <38382499f40a1288d7e7f0fd59173b23660b69d9.1590007004.git.lukasstraub2@web.de>
In-Reply-To: <cover.1590007004.git.lukasstraub2@web.de>
References: <cover.1590007004.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/l8AuOZVOaV9W4.w.EKwRSFx";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:70VK6yf9zPvIdnGLOJ8M2cKJqRj4iOoKXJcVIcnOFJZzPSoVYNj
 /W4B8o6JwdveFklqYkTqR5b8DX2Jmd/q6TZ6zpnb49g/KyBLNyZ/RdZvES+XubtBOqcOBYA
 xU+U/iYWVUM+vGBZyVvH0/63RdogoaPExXThRppJodpg46vA8LJPv7WvLMNHB1RB/GAdNcp
 JCPWaHeq/us8AMnwM9X6g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hJ/Iah1VeIk=:If04k/IPK1QczH/dN7wyaY
 4/g133qSADLa6JuXzXuVIYO9syoAQ3Hp67u8JwDZ6BPbGi+nqICGebFUZorBlVOCpIhxVwoRV
 tVysWrKXE9zpNgPqFLPFvCkbLMdSB7i9e/JYXyd8gy87OO8Qkc/KLK0KegU9NMYFHEVk7uIOC
 IsjBRk+qVTZlxScoQvKhbEjT2ggCambHqtAn30yK5ARH+KSIkCZsT3fPHyFOyw/8lC9z+j3jw
 7X2UBEZJ0L0w9BUCSlkBwoD4BC/Et32lYfcHwf+tYH0ablUAAC9Z0bk91Ust7N1dLf/fgLRBe
 opOhXUsGlb7bRBlzzV6y6tz1n9j4UugIvWxtr0f3ksdXjcjA0xHDulM9335394ji+DRsSYDBu
 hTL+P2ONiTWENM6hCRgg5zaWC1ita8nG2YzOFLHvhLMqEWEeOl2XsCiA9AbnPzFHerub43btI
 EwV7m6H4ir5c17bW7DwQouT+AMobuIu+1zuiVXTdUBb9F4MLkdsGnxCEJvtp3QfX34w6BczDE
 9vxeKDLUIwr2EGkKg03G2iPHZCixo6GNEPSH05m3EoPqFPDVzmRN1gyyZvIFDV57yw8Wn2wvq
 HrbmNw2rUhuemR5l+PK1t7IbNLvI228IaighnD6Anwil+wpWUey0eWLumP7RepNxw72YauecW
 aJJGwwQwSMoCEi9dhqcIh578o8wK9qN8e+Kif6N4aHUKRtXX/f7hoVwvY93b/OZIJdue0HrqP
 LKyHVljomOZ9Ltcnuy0153aLgksKX5jdTSO+iiiSUxUoDPlc5D5Gcuhq3SUssoevvEfTHeACM
 JvQr6N5ZGlNS+NPzY5St+0pq6gUOYRgfcQJDwfiEZf7LndD8K41KSOBYE28stwhB1geHgvpJq
 gqmA+knl+SkhBGxXGTq3rBrc3U6+9yiRRZQ3zW+ba/sK1s8PO/7vh/Wumd3xKQVIfLyGKO3P4
 R1AyMuX7prKHP6VvNv12/2kFGOIl30HUj2TsSSVMhUl2Q/Hcqm1K0CgLArkTC1vc0LGRqpzdH
 HeUo2yfZKixNMmpQ1iHJIJNaVco7nmK35nm74AVhAiao/PARmvdF49U/YtF/dnK//srgMlbi0
 X3eKdXmEIYNQnpi1XiDyR6cYCSn+fApSpvF1UpFxxzknk9O8C+6w2HzIIeArf8Ikg0+NRhPbI
 BHKnpDn7JaIwqkwW2ku9A0L1RaJUT2JcZYveXGADiizGHVyGEoBs67+9vv/c6GAowp+FcVnox
 NZQtkTyB1TbiJWEaU
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

--Sig_/l8AuOZVOaV9W4.w.EKwRSFx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

If we suceed in receiving ram state, but fail receiving the device
state, there will be a mismatch between the two.

Fix this by flushing the ram cache only after the vmstate has been
received.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Reviewed-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
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

-    if (!ret  && migration_incoming_in_colo_state()) {
-        colo_flush_ram_cache();
-    }
     return ret;
 }

diff --git a/migration/ram.h b/migration/ram.h
index 5ceaff7cb4..2eeaacfa13 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -65,6 +65,7 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *=
rb);

 /* ram cache */
 int colo_init_ram_cache(void);
+void colo_flush_ram_cache(void);
 void colo_release_ram_cache(void);
 void colo_incoming_start_dirty_log(void);

--
2.20.1


--Sig_/l8AuOZVOaV9W4.w.EKwRSFx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7FliwACgkQNasLKJxd
slik1g//VQWDDRp+gzSUWmtOGpo0jPKP7A515wv8WvivTEIeVaFpkyQBxdv1QQJ8
iVtAoH4Wga36y1j2nEqwM5dTAxHjX8O/NxBdio8wiiCsy/SBg1KRXwiK5hE/eIQj
s6a5SpMwGz3OasdPwcKmJL4xpJ1ljUnMw0UYhEh6+7KtnIhzNBoinMykKIbgg0VI
cDEOncdsDOYIzC2sHzTnCwEgjcK0aUYH3GP397alOdnIqRbyA/xtdYtAXx2CO2ZA
lMVoEJAC3XEx6Ua291DPfCFrx92VMzgWfdU87eRZcMXro0YJH/GIOMKJNBPDT4Vm
K1PdSZrpRP2MdVZ2xUg6L2t8LBTYGWhqwJwzzyNcU0dBXgRU3krXjtb0eePgFgsY
5n7STaDJFbjXroAgYPJrL7/Vy1r5bu7HGsDVnn3S+N7G2Bf30HZc/g25gZWUQZ/J
ka4fK56ChSBrgkHZZw+O9gJJ0R7C5qnwZ6p3Q9zqf4g1Yw5HOO7wHyiAMeTJXA/e
zWrmNwYoq0cIcX8AL/UfiDZw4vYuEQnqCS3vmOmtZCQ7sJ93hYF73daOPoNJ5wLj
9BUEZ2LPoGNEJhD56eklse8QzYWjKnvn3C+VzaQLGP0lu3NXKe67VWMY2m3DEcFv
Gswu2sLFhKO2uOtXfyGkNvfzJkyWCFLr2iGHNSrAcn7RTglHjXU=
=jLej
-----END PGP SIGNATURE-----

--Sig_/l8AuOZVOaV9W4.w.EKwRSFx--

