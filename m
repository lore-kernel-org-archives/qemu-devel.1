Return-Path: <SRS0=j/lF=6K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC96FC54FCB
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 19:36:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDDF120700
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 19:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="YwWoBmLJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDDF120700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSn4i-0005K8-Ny
	for qemu-devel@archiver.kernel.org; Sun, 26 Apr 2020 15:36:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47706)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jSmud-0001Cu-Rz
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 15:26:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jSmud-0005nJ-Cz
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 15:25:59 -0400
Received: from mout.web.de ([217.72.192.78]:42417)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jSmuc-0005iC-P7
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 15:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1587929140;
 bh=6pc9YXNKhuW8jIo+3vRiEjlLgHIMsoHErd6rjWBDDRk=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=YwWoBmLJDlw2wpSHh/fJOU8LgyEgfCctJzFNUz2fLQgmQDjWXa4p2VbSWVTfp79sn
 Zn/beSM+eQDSPpP5nlMHUJ43SMiIykmao5frkaFpmGjgtokJK8/4n0zdSUL3b7i4uY
 xnWDGDHZpn+z/cnkp3tKiC5Uf6dMRPYyTEJLen3E=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.95]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M09dQ-1jC62K0IlY-00uKv9; Sun, 26
 Apr 2020 21:25:40 +0200
Date: Sun, 26 Apr 2020 21:25:38 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v2 1/6] net/colo-compare.c: Create event_bh with the right
 AioContext
Message-ID: <dc7c5716e1e3367dc96f8496c52490ce7578a678.1587927878.git.lukasstraub2@web.de>
In-Reply-To: <cover.1587927878.git.lukasstraub2@web.de>
References: <cover.1587927878.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/x=njM09_KyZCR5NOU5o5MQ_";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:JlkzBR+7HxwSYRWS4OUWJUhDmB/2kMywrHnAnQ7UBqYh9h9TwMY
 OSN0sM3cSjIbv5pVtUHzVzfsUryRTwkgSOAANyr3ZvMtH3ljmxQpqqLecn5B/C3Mvk141SK
 ifaZBVe+AtJMC1568mz5q32eBGocLXzs2bTCnfPUur13xebqsi+Jp0KZXXdtIn/c7HmpoeH
 0F/C6zP3GV9imHhGfVdZw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6xeLxWDG2qU=:5pgQqo9w8wXgC8tnJlxFYC
 /dWZ6e+qeO2jBe/nxW4tG2AQ/uebqafJwMlowJUgSnh5cDtIOGBEahxSSjd/6bb7rbs+xfPVo
 2aSC2pGBrlrXZRiXYSqSa07XIi8XLWJ3WUVd5i8wzth3lyPRYzYvX1uWrfDf3AloC5K6upfsr
 jDYE1OAlqhGm9x5qSMUfkZwBEm7Y4pcuGYkit5WTqpdr8VdQsero4L7YF2IbLVFlpVEXLgooH
 6pTR6shmTyNuyt/t41GoJdZLKXdQ7bdDUYHxuBmh8O37w4bCs7A/zAy121OzI1KLLaRFrf5VX
 0ylqlCSmYVrgoWbYaiAfdYxjiY3+PR9hSwu21gObkX9yUdrY7+8lWCxN6zsMJ+rXPXCco+iuf
 PhfluGigjxxo9Yx/FLuffR2YzcAITs5S4yearA5GRy9GNaVd3AjaE4sDLmbqWGiZUVeuF8Ico
 13LlgvHfZ800BzHYMy/vpYXkC3F3VUSdDoDTFb9vy50/CFh3NW/ZuddyHFu/tcwUIszTnyj6m
 s4fiQvHSN12EVW8bH47eNCxyLw9LL/mg4hrFQzd4QsOUKpWsVRzN7ga4NIQgdtqQbe2jJF1nm
 96Rq5ONiVqDZjaoJ5GSBTU19jWJ5sJmP0Jv9kej/8TvA4znxz2LnCodHIr7ZKjl4zBSZBs9rj
 foXikZLuNDr68GBLUMdKHVt74Ptj1GKVi2ACmVh+DNtZbhcTnYrE8KL5W1U/b7T8SkCey98AA
 Dz6Q2RiDp/z6hoToPjkA3RdVvBtQO35+XH8vjvhPqifjhnaHp/CpfZH0osvcFlPgvSPHTYthx
 e1YRN3zv4tV7e+m+ws0Z9hXrgiJHguflMMSs65V0HHVCoKG0s2YeJnrbA0OPOjUkeXxJxhj/B
 9MZbqhAbLmIS2ZecFQZfftwrQdE42PjooyOtwIPLHv8Gj+Z06J55sMgctmYGRBPO4k5L6xZ8U
 x3m8+kSeFY8nkCxj5I8HAsOV1ER/n2MkncXiAa0biW9Yby/wuE01UrZ/KGAPTegP4riMkzY0v
 k/S6b7W7vJjvnWdLx+RxT8PcNY83Eu3DhkOW2/ja9SuenoFP+OPHZINlkaQZgflVquqvjOGXm
 ZY9GHH33bhLyW0xERNjVN3XICCbmh7MH1Z9C6/3wPjy37XQoFftpv1zCSp3BUZS48SBIfm2K9
 iXPTQFpeB/YNZ/q3Ot8tkbL28saenzB4uJR2oajld0iq6lmQQXnnV1fT6iMjD018a+MwAbpiT
 7hrqexU+pyMGsAB6s
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 15:25:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.78
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
Cc: Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/x=njM09_KyZCR5NOU5o5MQ_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

qemu_bh_new will set the bh to be executed in the main
loop. This causes crashes as colo_compare_handle_event assumes
that it has exclusive access the queues, which are also
concurrently accessed in the iothread.

Create the bh with the AioContext of the iothread to fulfill
these assumptions and fix the crashes. This is safe, because
the bh already takes the appropriate locks.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Reviewed-by: Zhang Chen <chen.zhang@intel.com>
Reviewed-by: Derek Su <dereksu@qnap.com>
Tested-by: Derek Su <dereksu@qnap.com>
---
 net/colo-compare.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 10c0239f9d..1de4220fe2 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -890,6 +890,7 @@ static void colo_compare_handle_event(void *opaque)
=20
 static void colo_compare_iothread(CompareState *s)
 {
+    AioContext *ctx =3D iothread_get_aio_context(s->iothread);
     object_ref(OBJECT(s->iothread));
     s->worker_context =3D iothread_get_g_main_context(s->iothread);
=20
@@ -906,7 +907,7 @@ static void colo_compare_iothread(CompareState *s)
     }
=20
     colo_compare_timer_init(s);
-    s->event_bh =3D qemu_bh_new(colo_compare_handle_event, s);
+    s->event_bh =3D aio_bh_new(ctx, colo_compare_handle_event, s);
 }
=20
 static char *compare_get_pri_indev(Object *obj, Error **errp)
--=20
2.20.1


--Sig_/x=njM09_KyZCR5NOU5o5MQ_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl6l4DIACgkQNasLKJxd
sli/Qw//ck9gGY1Er61CekXwYNaF89ZkAUNCiSrCM0bX2rKoV5exbreMgV1Vx3wa
MpCJqDcOsIk8izknKGxnmRj5XAFVy9XoLmegx1Agy/9leBO9kGhiDFjdyDTcDLuG
v4F+ttgO46w3F1yLUm1o01GkH6kna5BjBcH8Q2qH8Ue5Z5eZiaz/oZNVfSgd+V1o
s488UobY8bCgKX95hhfhauF/wcmOdxNuAuAbSvK9EJNC7u3ClX+65L9urfUcAzjk
Usb2bjelVfx0g+xyVMs6hhWG4AjKFFhttyz3tl9MM9QVyl45cgY24zDiPALFY7hN
wUIR2W2KzyWa/KE8nZh5KaLENv4KKuxjnXNifIlfXPkDxWqOGQgq1FmUXX/UHN0P
3LHGoSD88CoeCH8QIfoLUK8jAMlCh6ne8qe9thxyw6TlQvKAhuCn1DBQwQgAE1JR
bP2AiX0+9nitcS7MGbTcBfCslQYRxL5CWhh+X99O9vBr97kzoFLVVC50smOi8HNm
Th+JQ5X5uQHIZU0aPPH1FGdA/dS6xuZVi8EJSiP37Ma/O6intGADXs3azbeceiKg
QrpjdFIqAevF+TQVsgcgS9vG0X2E1yYgavsjf1qu+YG2yxyK6dySAxH2NF6/oQTL
IjHverPi3dIX8823boOO/tKPlvqvVu2DbGaGJlK/Har5KdcqrM4=
=UUtZ
-----END PGP SIGNATURE-----

--Sig_/x=njM09_KyZCR5NOU5o5MQ_--

