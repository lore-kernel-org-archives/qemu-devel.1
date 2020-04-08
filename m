Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EDFC2D0F4
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 18:42:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AFE22072F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 18:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="AID12IoX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AFE22072F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMFeq-0008MN-SP
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 14:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58101)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jMFWl-0006fj-57
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 14:34:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1jMFWj-0004bM-EY
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 14:34:19 -0400
Received: from mout.web.de ([212.227.15.14]:45147)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1jMFWi-0004a6-Tb
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 14:34:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1586370838;
 bh=RhytEYIToMDE5YHdnIg0FVpbU4nEuG0hSpwe6f7bLJU=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=AID12IoXhOz6+9wbx67GZ7YWliMxBfdzv5mHrgbxD1gpPWeqGC8X9o/d+Mu936ETq
 jZVFnHieq7ePj8Xn89kQ871GFk39wfJJF6nd5T1lC9i+cwpyHpFf2i2HNFaORwHBPE
 zCx/hQlUMR7i2H+HdltCHBtFKE3FrErmOc6MbXnk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.62]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M6ml2-1j890k1HAi-00wV2b; Wed, 08
 Apr 2020 20:33:58 +0200
Date: Wed, 8 Apr 2020 20:33:57 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH 3/3] net/colo-compare.c: Fix deadlock
Message-ID: <87c2f42b46f93fb89867f82e45aa2689eff98432.1586370737.git.lukasstraub2@web.de>
In-Reply-To: <cover.1586370737.git.lukasstraub2@web.de>
References: <cover.1586370737.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/L+2.h.Ec3Jq0qZHEGzP5U43";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:6P0btB26cQR3S1W4ZnWoZmq2Q1A9azBS5IUKaWKmKtcj4u8oa6i
 cboZDiG6i5kWVsTZnXUy46S3owUkD+RM+ydU9GfyOtStf9RuuIExC2ciDbOx1zg8vDyDamU
 ehLUCpS76hdFsoLajMpX7XzH3gA2HAwGnXSKDiGz9ghcyFj4ymmGlalfbgQF3vsm8K+aJ5C
 SmL7duObJkyGWFadBwNvg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mkh/OnB4Thw=:zlGTC46mkMPzvm9NVyLQFr
 rNSMPiSVRO5WgPjSyvGr9VvOEKFnKv5Z/GI7GBcJfSpMgt6v5deJN1lO8LKpHcjD2yNcBJMXD
 x8SDmI8RKO0UDT7g48VvqU9G8pGyt500fL+8a3wbnjS34je+dRANsGygGvCwFb+T1+7JXYNfz
 CIB9jLJ/ZrJEd0WYtWmE68Tj9x0NsSAoc9cx3twwtmbyT+HoCGwMB9qhLFuMitW9GuIdyhVcV
 JgIU4f6f7+Ik2GZuI7t1vZtkAkn5yiZiGJHZSVxyrfnSQiF10HpoYqYdi+yNgD4hWUhFKm20F
 RBVVSsMkVD5CvNL1G9ftIaNu6Xr4LgfpYiYzR/kwIjkojS2HA2bKRzYQF0SdJ5fInRPu2f25T
 23kccOeNcPD76Gl6qX+86FLXmygXCn1ep2LFW8EUB9TU8oJwpY2pNYIImHDICgEX4nPPXjvcX
 eNflK8lF9ROVP1pHvoLIjDsiO8I2mss+RdkLvMNcHIm8BjLejraGhpPOwamVciFtMmgd2+2Xm
 VR9WOHqjiTiAe3h/+7niB6x4dGLh6jLQFZw+9DwAfb3gLmYWgSFtxVe9pW9ChYrXbGqC2Xlkf
 4eaW261ixYNIq7+J1gTt02Zu1O2pIGk73Ku1D+ZXOTtb/O8nePxrsGEhwiqmJ9Pc5eLZxowd2
 PyU2j/7Z6GPCAuIQMqHe7P0Ybcc3XRcPDr0xdZJhkSEJGqcaUlI8sLxBw96+YvG/oSMwzzvYu
 Pu/mwyYEMeP1pD1+CBZlTHQ08e6bfbkbI4D9CZE9y9jx/q3k8BuLtE3WRwdHh8aK91yXsUaUQ
 fSlOKFSAZrn0grS+cfzywI6P3psKrfRt+ifOG8xmC3XO5JlMpUHcJOqr8vYe3+YIl6HtU1MsG
 IIZstG5grCvD61hQanHML6di/Ss/Aw4QwtbJzSi3P4qVCeIWZQi7BIvK1ff6ZQxDJ7vSjwr3d
 BC5OMpYvw1xmU6n/HHlHfMVlj7lLNtXb1Px5vePZF0EHl23Eu1tbxuk/GAFtOQgHuRV//OL5u
 scLwn//bbr8QWmCHfZAs8ZK1n73bgi+Az0wS6TAyjdkb7s8E42+irc+nJ0tR+F4vnWnmv9qmJ
 UdzfgPWxprVSiEEWO4rSZANEDjJ7YKaNvknyjEnPWValK/Ja27hvmssdWfBgba17bQtlSaeU8
 8tCTTvEf2DEnrXQpcLysXsDlQjfgl2533aG1mOpa1CFO/ZdSiMYmKbxow6SP3VaX64D0l8gxI
 dYrzJcCMN+HXysdVO
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.14
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

--Sig_/L+2.h.Ec3Jq0qZHEGzP5U43
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

The chr_out chardev is connected to a filter-redirector
running in the main loop. qemu_chr_fe_write_all might block
here in compare_chr_send if the (socket-)buffer is full.
If another filter-redirector in the main loop want's to
send data to chr_pri_in it might also block if the buffer
is full. This leads to a deadlock because both event loops
get blocked.

Fix this by converting compare_chr_send to a coroutine
and return error if it is in use.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 net/colo-compare.c | 82 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 71 insertions(+), 11 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 1de4220fe2..82787d3055 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -32,6 +32,9 @@
 #include "migration/migration.h"
 #include "util.h"
=20
+#include "block/aio-wait.h"
+#include "qemu/coroutine.h"
+
 #define TYPE_COLO_COMPARE "colo-compare"
 #define COLO_COMPARE(obj) \
     OBJECT_CHECK(CompareState, (obj), TYPE_COLO_COMPARE)
@@ -77,6 +80,17 @@ static int event_unhandled_count;
  *                    |packet  |  |packet  +    |packet  | |packet  +
  *                    +--------+  +--------+    +--------+ +--------+
  */
+
+typedef struct SendCo {
+    Coroutine *co;
+    uint8_t *buf;
+    uint32_t size;
+    uint32_t vnet_hdr_len;
+    bool notify_remote_frame;
+    bool done;
+    int ret;
+} SendCo;
+
 typedef struct CompareState {
     Object parent;
=20
@@ -91,6 +105,7 @@ typedef struct CompareState {
     SocketReadState pri_rs;
     SocketReadState sec_rs;
     SocketReadState notify_rs;
+    SendCo sendco;
     bool vnet_hdr;
     uint32_t compare_timeout;
     uint32_t expired_scan_cycle;
@@ -699,19 +714,17 @@ static void colo_compare_connection(void *opaque, voi=
d *user_data)
     }
 }
=20
-static int compare_chr_send(CompareState *s,
-                            const uint8_t *buf,
-                            uint32_t size,
-                            uint32_t vnet_hdr_len,
-                            bool notify_remote_frame)
+static void coroutine_fn _compare_chr_send(void *opaque)
 {
+    CompareState *s =3D opaque;
+    SendCo *sendco =3D &s->sendco;
+    const uint8_t *buf =3D sendco->buf;
+    uint32_t size =3D sendco->size;
+    uint32_t vnet_hdr_len =3D sendco->vnet_hdr_len;
+    bool notify_remote_frame =3D sendco->notify_remote_frame;
     int ret =3D 0;
     uint32_t len =3D htonl(size);
=20
-    if (!size) {
-        return 0;
-    }
-
     if (notify_remote_frame) {
         ret =3D qemu_chr_fe_write_all(&s->chr_notify_dev,
                                     (uint8_t *)&len,
@@ -754,10 +767,50 @@ static int compare_chr_send(CompareState *s,
         goto err;
     }
=20
-    return 0;
+    sendco->ret =3D 0;
+    goto out;
=20
 err:
-    return ret < 0 ? ret : -EIO;
+    sendco->ret =3D ret < 0 ? ret : -EIO;
+out:
+    sendco->co =3D NULL;
+    g_free(sendco->buf);
+    sendco->buf =3D NULL;
+    sendco->done =3D true;
+    aio_wait_kick();
+}
+
+static int compare_chr_send(CompareState *s,
+                            const uint8_t *buf,
+                            uint32_t size,
+                            uint32_t vnet_hdr_len,
+                            bool notify_remote_frame)
+{
+    SendCo *sendco =3D &s->sendco;
+
+    if (!size) {
+        return 0;
+    }
+
+    if (sendco->done) {
+        sendco->co =3D qemu_coroutine_create(_compare_chr_send, s);
+        sendco->buf =3D g_malloc(size);
+        sendco->size =3D size;
+        sendco->vnet_hdr_len =3D vnet_hdr_len;
+        sendco->notify_remote_frame =3D notify_remote_frame;
+        sendco->done =3D false;
+        memcpy(sendco->buf, buf, size);
+        qemu_coroutine_enter(sendco->co);
+        if (sendco->done) {
+            /* report early errors */
+            return sendco->ret;
+        } else {
+            /* else assume success */
+            return 0;
+        }
+    }
+
+    return -ENOBUFS;
 }
=20
 static int compare_chr_can_read(void *opaque)
@@ -1146,6 +1199,8 @@ static void colo_compare_complete(UserCreatable *uc, =
Error **errp)
     CompareState *s =3D COLO_COMPARE(uc);
     Chardev *chr;
=20
+    s->sendco.done =3D true;
+
     if (!s->pri_indev || !s->sec_indev || !s->outdev || !s->iothread) {
         error_setg(errp, "colo compare needs 'primary_in' ,"
                    "'secondary_in','outdev','iothread' property set");
@@ -1281,6 +1336,11 @@ static void colo_compare_finalize(Object *obj)
     CompareState *s =3D COLO_COMPARE(obj);
     CompareState *tmp =3D NULL;
=20
+    AioContext *ctx =3D iothread_get_aio_context(s->iothread);
+    aio_context_acquire(ctx);
+    AIO_WAIT_WHILE(ctx, !s->sendco.done);
+    aio_context_release(ctx);
+
     qemu_chr_fe_deinit(&s->chr_pri_in, false);
     qemu_chr_fe_deinit(&s->chr_sec_in, false);
     qemu_chr_fe_deinit(&s->chr_out, false);
--=20
2.20.1

--Sig_/L+2.h.Ec3Jq0qZHEGzP5U43
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl6OGRUACgkQNasLKJxd
slifIQ/7Bd9MoM7cQKU/zp+g74f73NtSsFn7C5K2EFq63kPCdvn/wY/nqJ2tNNv5
sUsBxcFuMdNnRisyEBR+ClJ//cf7WLind7rR1pTDsU1tAJt/IHQDTQTEANpF7Ym6
2JaTZRuWIebbMhklBI3OX/B5LKKTb3qs3cBdV6dKuuG5TSfBAhzvrTjKEKhiJ2dj
EZb1ZroIGqEVTXAw2QTbDm+HcmcM3EoUK5ctfXi+YDat2qDyMMni41j9tXWsqtX1
iLXfp28hMObbwa4Tvb2qKve0KA8LgB9fiFVa5Vvr2As5Hgrxfr5+PSD/6ZldsQAU
loJwzQapTh31Co3g5jxid+3tZIkhYND1KkZ50Ad4Wys9CIubLZH5JYQS9fcWDncF
ITgOtHDW9l9Py35daa6EpwLsQ9yhoL/jyxarvxGXXxx4gtupTScmqXOLRN1d2wwM
VYuPGqulA8c2harNIBuxIMJpErS+zsCnEPke4ACZzNzemEdRixEVo72pRD1qJH+3
16nO9LObWL27GD/8BsYBYinaYJRRjbk+XsGtJgcXJgjem8gD0l7FpSsGJM7lVAom
IdJD1U/ZqKmN2Lvi40ry0dlo2F+ObsSrW9Ga5qSr/RdxX79Ni1FsPsotB/nom7NC
CNbDRfXiMm+O7yYjXjBt47C7vwSk5RtvTDLAFqCcXbykj6YHmjk=
=U53D
-----END PGP SIGNATURE-----

--Sig_/L+2.h.Ec3Jq0qZHEGzP5U43--

