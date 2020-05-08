Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE90DC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 06:11:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA41820746
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 06:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="hX4G/A/I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA41820746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWwEd-0006DQ-GW
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 02:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jWwBX-0004wB-Fp
 for qemu-devel@nongnu.org; Fri, 08 May 2020 02:08:35 -0400
Received: from mout.web.de ([212.227.17.12]:36417)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jWwBW-0001TH-3q
 for qemu-devel@nongnu.org; Fri, 08 May 2020 02:08:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1588918101;
 bh=yin4iF6Xtmfbc+ExJFBOAz3wjXo+5sqvezRvMtLvt3s=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=hX4G/A/IOYToqNWo+GqRrqsnr3pvzePm4H5OqXZ8s7T1OA/unbw9GFvhJI93RSL4U
 Zi9XDeFrgT4P6EKDVuHBL2eo0k6kplRHKhJUsalkAPmkSRrlQiOHk45DLt/uF7NMws
 WYV1eTAuuV2X/N/nTfe4ktz469o+nd+fokRX5BH4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.71]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MzTPW-1jAiQf1Bi4-00vK7b; Fri, 08
 May 2020 08:08:21 +0200
Date: Fri, 8 May 2020 08:08:04 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: "Zhang, Chen" <chen.zhang@intel.com>
Subject: Re: [PATCH v4 3/6] net/colo-compare.c: Fix deadlock in
 compare_chr_send
Message-ID: <20200508080804.6677e210@luklap>
In-Reply-To: <0636ae8fb8a640a0bae59712ca9447dd@intel.com>
References: <cover.1588587700.git.lukasstraub2@web.de>
 <5536749ec95380f18c01789c472324565c060bcc.1588587700.git.lukasstraub2@web.de>
 <c27b4dbdc6834e70b4af738d01f9fae4@intel.com>
 <20200507175107.45d5d497@luklap>
 <0636ae8fb8a640a0bae59712ca9447dd@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/G.BLb1D3=JMBs_g56Rfuhql";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:Bmux0todT36Wkc8cbxUwV3GppqtePEaNTx7UfpqdNvLs2G4nzFQ
 3ZyWbh2+ygEvIRTS0/nsk+jTtJwjidTh/8rnreVhPKmHT3AEf9+UjErKK3jC6BmdqPzqFDU
 q+mCHm3fVxJmrcNrdoNV4MhQaVfyY5Kr3Bc1jQE9P5mmMT4jGgbK1VmYQkQ0ruSxh6Q6XCy
 RjQIrCV11416VQ/tEDx1w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uMo1Y5cz1qE=:8QnZ8cLFkjNFzQvIKvlZ5g
 6zrgusdNM5YAIz4mj8TNKJxfLqwXVvetIg9gGoon/1Vh6pR7wVXFTDHd3jcz/wfbPWhVSiKvF
 95gFwbabtoWzw0eo0VMJZmRtw3mc9qcOGzN2rdq7fTVk/gKNO+hGSGJOL+QGTdfZw/Gu5AKrL
 g9TFgMyYCw2viY+Xo7rbs1VQpdemsD8iqqY4EQwS9PmhS9NZGZsUArehJ3hMQmRmFa99xmNOT
 LTPRgYV3GgdQ3SHW4EBZA78r28Ryiaq5y+uRKWYYRZpUOGvsTDbq7h0wXQKX9AGIehZs69xIN
 +kqQX2Ctm9/AmDyx0T6bCWsAXU62Y6uxofCwWRqCT05c3HNclgguxBbOpil21sZEvPQacI2P0
 Iz5sKpxrhA/GVgj27GYj4ieFhNbzCREo9uXNDWd5C+1yP8RaY9GIZouh2F8jnafIwEMIXacMs
 qRANWDA3GJFecC0sphAGzSr2gg6to1U1hUfYW5QQkw0v50OGIaI/5/fGM8A4fJ3AuWbv9XBk3
 XiJFR9NJMvkEDgwMpF3LzAUFVAcOw8UACVWyfumHFV1PwYNHEzHb5zegfjiP23xOZgRaJBVKg
 zv0O5Gniq5sabI1G2oEaGmeWX8dIL8zWOezNqptngdDvxN+wljJrUHApxBoV7r56YNcBcwPQ9
 V/rp6D7Dd2Lc+7Hx2UeAML2+mDnk9Ns+necTFFfeedcmKQCRb8FV0XLjcm5ScCWazpYlWNvIP
 sGcsVj8CjDnysMe1feETBkzW7BWHK6IJQO79o29h405Dvqgud24v7W0v3yMwCuWx7mv04iKPS
 G8RsxviYR47j0jqDHmY2Q2srtSZFbkO6ZSfmB8yWamDg49ZFmnDS9ERSxP9XT04A9STRaWrrY
 JDq51S1vm0eWT7GAADX4Eg1VSVfskOaJoNrGtuFLAhd1elt67DX61xo4e+qfM+smxGlI6Fz89
 0kZBLR/CzZdn92jMXlWtSXkNO2HxyLF+zMdkcR/JXha01xWjDbnLNaUlTWj1F4Gg5FmOjSewV
 K8nKqoxy/Hw4Dhp7GWSgX1XK/5cZ9m+jRN1sBVRUkSQxeN5MjJMHKWkfn1Pa/45h0vxAjaPpz
 hwbqaE/W+zAA7+yErN5OSrhwG9M7Xo4lKtVlbMyRdiqqnsqvS+GFvz2MjYyp84MApe9KiHVEG
 NbfiFNcdY7ykKqlt1TP0c3g0CTzawGM6lMryazDrhnrnV+dWWZGHmUNURZp/oSnqvc0Qrdo2r
 NMIyvLvPSEgKqIVAA
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 02:08:32
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/G.BLb1D3=JMBs_g56Rfuhql
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 8 May 2020 02:19:00 +0000
"Zhang, Chen" <chen.zhang@intel.com> wrote:
> > > No need to init the notify_sendco each time, because the notify dev j=
ust =20
> > an optional parameter. =20
> > > You can use the if (s->notify_dev) here. Just Xen use the chr_notify_=
dev. =20
> >=20
> > Ok, I will change that and the code below in the next version.
> >  =20
> > > Overall, make the chr_send job to coroutine is a good idea. It looks =
good =20
> > for me. =20
> > > And your patch inspired me, it looks we can re-use the compare_chr_se=
nd =20
> > code on filter mirror/redirector too.
> >=20
> > I already have patch for that, but I don't think it is a good idea, bec=
ause the
> > guest then can send packets faster than colo-compare can process. This =
leads
> > bufferbloat and the performance drops in my tests:
> > Client-to-server tcp:
> > without patch: ~66 Mbit/s
> > with patch: ~59 Mbit/s
> > Server-to-client tcp:
> > without patch: ~702 Kbit/s
> > with patch: ~328 Kbit/s =20
>=20
> Oh, a big performance drop, is that caused by memcpy/zero_copy parts ?=20
>=20
> Thanks
> Zhang Chen

No, there is no memcpy overhead with this patch, see below.

Regards,
Lukas Straub

---
 net/filter-mirror.c | 142 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 106 insertions(+), 36 deletions(-)

diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index d83e815545..6bcd317502 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -20,6 +20,8 @@
 #include "chardev/char-fe.h"
 #include "qemu/iov.h"
 #include "qemu/sockets.h"
+#include "block/aio-wait.h"
+#include "qemu/coroutine.h"
=20
 #define FILTER_MIRROR(obj) \
     OBJECT_CHECK(MirrorState, (obj), TYPE_FILTER_MIRROR)
@@ -31,6 +33,18 @@
 #define TYPE_FILTER_REDIRECTOR "filter-redirector"
 #define REDIRECTOR_MAX_LEN NET_BUFSIZE
=20
+typedef struct SendCo {
+    Coroutine *co;
+    GQueue send_list;
+    bool done;
+    int ret;
+} SendCo;
+
+typedef struct SendEntry {
+    ssize_t size;
+    uint8_t buf[];
+} SendEntry;
+
 typedef struct MirrorState {
     NetFilterState parent_obj;
     char *indev;
@@ -38,59 +52,101 @@ typedef struct MirrorState {
     CharBackend chr_in;
     CharBackend chr_out;
     SocketReadState rs;
+    SendCo sendco;
     bool vnet_hdr;
 } MirrorState;
=20
-static int filter_send(MirrorState *s,
-                       const struct iovec *iov,
-                       int iovcnt)
+static void coroutine_fn _filter_send(void *opaque)
 {
+    MirrorState *s =3D opaque;
+    SendCo *sendco =3D &s->sendco;
     NetFilterState *nf =3D NETFILTER(s);
     int ret =3D 0;
-    ssize_t size =3D 0;
-    uint32_t len =3D 0;
-    char *buf;
-
-    size =3D iov_size(iov, iovcnt);
-    if (!size) {
-        return 0;
-    }
=20
-    len =3D htonl(size);
-    ret =3D qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)&len, sizeof(len=
));
-    if (ret !=3D sizeof(len)) {
-        goto err;
-    }
+    while (!g_queue_is_empty(&sendco->send_list)) {
+        SendEntry *entry =3D g_queue_pop_tail(&sendco->send_list);
+        uint32_t len =3D htonl(entry->size);
=20
-    if (s->vnet_hdr) {
-        /*
-         * If vnet_hdr =3D on, we send vnet header len to make other
-         * module(like colo-compare) know how to parse net
-         * packet correctly.
-         */
-        ssize_t vnet_hdr_len;
+        ret =3D qemu_chr_fe_write_all(&s->chr_out,
+                                    (uint8_t *)&len,
+                                    sizeof(len));
+        if (ret !=3D sizeof(len)) {
+            g_free(entry);
+            goto err;
+        }
=20
-        vnet_hdr_len =3D nf->netdev->vnet_hdr_len;
+        if (s->vnet_hdr) {
+            /*
+             * If vnet_hdr =3D on, we send vnet header len to make other
+             * module(like colo-compare) know how to parse net
+             * packet correctly.
+             */
+
+            len =3D htonl(nf->netdev->vnet_hdr_len);
+            ret =3D qemu_chr_fe_write_all(&s->chr_out,
+                                        (uint8_t *)&len,
+                                        sizeof(len));
+            if (ret !=3D sizeof(len)) {
+                g_free(entry);
+                goto err;
+            }
+        }
=20
-        len =3D htonl(vnet_hdr_len);
-        ret =3D qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)&len, sizeof=
(len));
-        if (ret !=3D sizeof(len)) {
+        ret =3D qemu_chr_fe_write_all(&s->chr_out,
+                                    (uint8_t *)entry->buf,
+                                    entry->size);
+        if (ret !=3D entry->size) {
+            g_free(entry);
             goto err;
         }
-    }
=20
-    buf =3D g_malloc(size);
-    iov_to_buf(iov, iovcnt, 0, buf, size);
-    ret =3D qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)buf, size);
-    g_free(buf);
-    if (ret !=3D size) {
-        goto err;
+        g_free(entry);
     }
=20
-    return 0;
+    sendco->ret =3D 0;
+    goto out;
=20
 err:
-    return ret < 0 ? ret : -EIO;
+    while (!g_queue_is_empty(&sendco->send_list)) {
+        SendEntry *entry =3D g_queue_pop_tail(&sendco->send_list);
+        g_free(entry);
+    }
+    sendco->ret =3D ret < 0 ? ret : -EIO;
+out:
+    sendco->co =3D NULL;
+    sendco->done =3D true;
+    aio_wait_kick();
+}
+
+static int filter_send(MirrorState *s,
+                       const struct iovec *iov,
+                       int iovcnt)
+{
+    SendCo *sendco =3D &s->sendco;
+    SendEntry *entry;
+
+    ssize_t size =3D iov_size(iov, iovcnt);
+    if (!size) {
+        return 0;
+    }
+
+    entry =3D g_malloc(sizeof(SendEntry) + size);
+    entry->size =3D size;
+    iov_to_buf(iov, iovcnt, 0, entry->buf, size);
+    g_queue_push_head(&sendco->send_list, entry);
+
+    if (sendco->done) {
+        sendco->co =3D qemu_coroutine_create(_filter_send, s);
+        sendco->done =3D false;
+        qemu_coroutine_enter(sendco->co);
+        if (sendco->done) {
+            /* report early errors */
+            return sendco->ret;
+        }
+    }
+
+    /* assume success */
+    return 0;
 }
=20
 static void redirector_to_filter(NetFilterState *nf,
@@ -194,6 +250,10 @@ static void filter_mirror_cleanup(NetFilterState *nf)
 {
     MirrorState *s =3D FILTER_MIRROR(nf);
=20
+    AIO_WAIT_WHILE(NULL, !s->sendco.done);
+
+    g_queue_clear(&s->sendco.send_list);
+
     qemu_chr_fe_deinit(&s->chr_out, false);
 }
=20
@@ -201,6 +261,10 @@ static void filter_redirector_cleanup(NetFilterState *=
nf)
 {
     MirrorState *s =3D FILTER_REDIRECTOR(nf);
=20
+    AIO_WAIT_WHILE(NULL, !s->sendco.done);
+
+    g_queue_clear(&s->sendco.send_list);
+
     qemu_chr_fe_deinit(&s->chr_in, false);
     qemu_chr_fe_deinit(&s->chr_out, false);
 }
@@ -224,6 +288,9 @@ static void filter_mirror_setup(NetFilterState *nf, Err=
or **errp)
     }
=20
     qemu_chr_fe_init(&s->chr_out, chr, errp);
+
+    s->sendco.done =3D true;
+    g_queue_init(&s->sendco.send_list);
 }
=20
 static void redirector_rs_finalize(SocketReadState *rs)
@@ -281,6 +348,9 @@ static void filter_redirector_setup(NetFilterState *nf,=
 Error **errp)
             return;
         }
     }
+
+    s->sendco.done =3D true;
+    g_queue_init(&s->sendco.send_list);
 }
=20
 static void filter_mirror_class_init(ObjectClass *oc, void *data)
--=20
2.20.1


--Sig_/G.BLb1D3=JMBs_g56Rfuhql
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl6090QACgkQNasLKJxd
slhlDRAArXtpCJahhy0JcIktIHlWxtTzsGNwK/FLf0UYAO0gikRJadIS/zr/TghA
ezGdJlVUK2mFmNT0SYioanT+AqWezh0t8mh3FtsSbcfaWLa34jcp/Q0fnW2XbGq4
szAmpvhy36L0gRlEvkD/dwWdB6NeEOe/t59hkU9e06W564b8ttl5js0t8ykGpNrP
WRGyRXNrWJ9hSARZj4X34VEn5XOISnxWtwaDATVSW3RIWh2+HA7ycFskyUZL80Jz
tbHmQKDD4apUtzni+xom0SgX49plbyunJURK7ytdBwe/2Y5RTqLwgWzPiQMA3ThR
WxJDuKqqrExYhXZuT3DD7ztLe3EpOpW8QS10dI77kxz7UdhUAFr4TthVfSBNtH45
7HwReZG8vBeacnNpg4wDbicQja94X06YlbGS3xCdU4CNy3ZHt568mtYS3rcr+tCx
qHiAMQXCZvNCotu+iB4p//scBtGhYP5XBTaP7NhMI/BBrGZf1NMg5IJ/qxaf1p2B
V+6Lgm77s32hUUHrQu4spL3uASwlD6QkTcgSKDX1JF5fmsjiQR0p4D97omBCC6Rl
veSGCAqZSGGz016S90WbfchmJinjmWJW9D2Zxr3JECJi5EGBOZ/xWhKpCvKu/nip
HrO/1DQHCPwa/kJY4pWxAKbUU5iV+48qt/Jd0MRBgojDvgi/HzU=
=OJsD
-----END PGP SIGNATURE-----

--Sig_/G.BLb1D3=JMBs_g56Rfuhql--

