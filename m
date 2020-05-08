Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D454CC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 08:00:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68978206B8
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 08:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Uiw2qNL4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68978206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWxvM-0006UF-95
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 04:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jWxsT-0005dS-4Z
 for qemu-devel@nongnu.org; Fri, 08 May 2020 03:57:01 -0400
Received: from mout.web.de ([212.227.15.14]:47027)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jWxsR-0001Id-9Z
 for qemu-devel@nongnu.org; Fri, 08 May 2020 03:57:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1588924598;
 bh=ZJxRBf8Tjl8pnSQVJ1jWoe1KmfCPbe2M7kos3mxZEts=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=Uiw2qNL4W/MQBCJBrdf6+CdzEG3iTzp9zmil1RcE+90xLybEP81ytG7tuQpZnLGCv
 Z/L2dYkhXdUhKG5ExmrZYzjaUcrtG182353aJ2bx/4zB4DhqjDCVyy9ZIj1N3URnC/
 JZkzOT15k1j9u2d+/0Dxbf3Sjz+3rFXSfvDEHjlU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.71]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MALeR-1jQgbW3l6J-00BtnN; Fri, 08
 May 2020 09:56:37 +0200
Date: Fri, 8 May 2020 09:56:26 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: "Zhang, Chen" <chen.zhang@intel.com>
Subject: Re: [PATCH v4 3/6] net/colo-compare.c: Fix deadlock in
 compare_chr_send
Message-ID: <20200508095626.6b200ee5@luklap>
In-Reply-To: <274606df46bb49a4bf9d6fa58b1f9689@intel.com>
References: <cover.1588587700.git.lukasstraub2@web.de>
 <5536749ec95380f18c01789c472324565c060bcc.1588587700.git.lukasstraub2@web.de>
 <c27b4dbdc6834e70b4af738d01f9fae4@intel.com>
 <20200507175107.45d5d497@luklap>
 <0636ae8fb8a640a0bae59712ca9447dd@intel.com>
 <20200508080804.6677e210@luklap>
 <274606df46bb49a4bf9d6fa58b1f9689@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jykEuqkFZlXud6VdtXHJY0Y";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:QErZ4XJZGS5YipQsgzlJnX3h8S4DTtDvAa0d2Udt90fHR3CKCbS
 m7xDLi+zrJoSkBqNOanvk/jSze9b8UT/d7adN60AuPdR880Ad28GP0wkyrpnLwNL2Ot/qsd
 DxI3XL5Hal73LObQv2/dfTjG6tlEWL5D/2iMgTkuSpuf9a1vKM5cvLLq3IP3llICjOSFbfa
 ZeuOYey2N1ZxB3in+Md9g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rBe/yZU4bO8=:WZVXMePhoNGPEyftjGB7/G
 QpFVrlP3hvIaAxfqAnqbP2c4r2PTvlnZbdP/713LeZ1OQD4L6M63FsRrE0Fomyi4OkP7vfG64
 0hqnvd4VXfvTWlT9wppOYL68Gbn8hFNQGRKQ4+U/7m1eurEBNE1csaZtQTCuQbMXWurtnmdOH
 BNuhElol3jFKLEcyzPxqVjQTk5mUM9uqzEtc9ceJnBzs2fRsSSfLNYNEaN2sHb1ue1jXHoFTU
 SRh5+sYm4HMsstCcogq7ltapjVvlretdNJLeCjNY3hKQvfuYSUl/hroTj5vazs2jU7JagXUGV
 KphvqMmttDxJr71El1+y9NG9wm8VTiFdImH/olmwV3avnM6kAR6B0SY7cfvM3v3vjk02Gygor
 B+F/4bPRbTQDxlC1tuAc6QcgRBzb7nw2418GkfOuph5ILgRigmibbk/8RXh5SIsBro9rXKhqo
 CLw2QdzWDijML16bzLsFB92Cde4+MTjHQ6HS959YrzgZbxApWM3wAm44VynH7CqirVoXpiy8R
 FBfLCqD2tpeuQbcvZn0p0PedwPNkzO3QoopifDF6VUfCStmgB+urbvrMt4YCoPkxeALWvwt4x
 866kQ5NazKBOLOeSDslivfoMPeO4RSKvvFtH8Pa6FkXeb+Fwhwavkyg9z2dSP9imQu2YJBKV+
 OK9bzlArw5V9ujIssuTNbdL6z0OidJF0yUZsLfLn7wS6lxnqjL3UfXyw79BR9rbRNMmx6pNnz
 MB2VTOAgeex34FJrawT300oKraaH89i2UsDSvs/PV36lPZFN17bQ1DOFIIuXGwWIKNsbl41na
 xBZu/+o/EtxLE3vE+PXyUbx8kC5kM0DpOk8qjTi3EkJEXVhCpSMLurg/Ti+7rK1pzllOdDY/p
 0QYNLGMkB3dl9S018LACgl+ZISwKKHeUpRz7T3CPHlfOl0aevzSMrgEE55V79kWpyWosrI6j+
 Ub/En3piexxTdasTE+XeghkjapIYVK2rgRRf16Vz84B6Fwl/3qe07cXsotMT5WTOxgOCb+Te0
 3z2Et/V8izGqUWsSJySQb/9Zcq+VZeWioB7wuzKD9KLIGkw/Ko7ShYz2LScIs+KPb/MCBlLv2
 /hEhDhumNO9YDWM5dQYSxbFw53juGIrs2R/jftyatLA4heIyb9OSjKyPEq+p2RlluGSICuOnX
 tMW2tASQROTbqw5dzfFinp+1JzQH7vjeZK+J/aXzpglS9dpfhl/n4/lkbbOpGpxLjfrG7b12o
 nGHnVU7RsioZa0W5/
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 03:56:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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

--Sig_/jykEuqkFZlXud6VdtXHJY0Y
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 8 May 2020 06:28:45 +0000
"Zhang, Chen" <chen.zhang@intel.com> wrote:

> > -----Original Message-----
> > From: Lukas Straub <lukasstraub2@web.de>
> > Sent: Friday, May 8, 2020 2:08 PM
> > To: Zhang, Chen <chen.zhang@intel.com>
> > Cc: qemu-devel <qemu-devel@nongnu.org>; Li Zhijian
> > <lizhijian@cn.fujitsu.com>; Jason Wang <jasowang@redhat.com>; Marc-
> > Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>; Paolo Bonzini
> > <pbonzini@redhat.com>
> > Subject: Re: [PATCH v4 3/6] net/colo-compare.c: Fix deadlock in
> > compare_chr_send
> >=20
> > On Fri, 8 May 2020 02:19:00 +0000
> > "Zhang, Chen" <chen.zhang@intel.com> wrote: =20
> > > > > No need to init the notify_sendco each time, because the notify
> > > > > dev just =20
> > > > an optional parameter. =20
> > > > > You can use the if (s->notify_dev) here. Just Xen use the =20
> > chr_notify_dev. =20
> > > >
> > > > Ok, I will change that and the code below in the next version.
> > > > =20
> > > > > Overall, make the chr_send job to coroutine is a good idea. It
> > > > > looks good =20
> > > > for me. =20
> > > > > And your patch inspired me, it looks we can re-use the
> > > > > compare_chr_send =20
> > > > code on filter mirror/redirector too.
> > > >
> > > > I already have patch for that, but I don't think it is a good idea,
> > > > because the guest then can send packets faster than colo-compare can
> > > > process. This leads bufferbloat and the performance drops in my tes=
ts:
> > > > Client-to-server tcp:
> > > > without patch: ~66 Mbit/s
> > > > with patch: ~59 Mbit/s
> > > > Server-to-client tcp:
> > > > without patch: ~702 Kbit/s
> > > > with patch: ~328 Kbit/s =20
> > >
> > > Oh, a big performance drop, is that caused by memcpy/zero_copy parts ?
> > >
> > > Thanks
> > > Zhang Chen =20
> >=20
> > No, there is no memcpy overhead with this patch, see below. =20
>=20
> I means for the filter mirror/redirector parts why coroutine will lead hu=
ge performance drop?

It's because having a additional buffer before the network bottleneck (colo=
-compare in our case) confuses TCP's congestion-control:
TCP will speed up the data transfer until packets start to drop (or the net=
work interface is blocked). This feedback has to be quick so TCP can select=
 a suitable transfer speed. But with the patch, the guest will fill the buf=
fer as fast as it can (it does not "see" the slow bandwidth of colo-compare=
 behind the buffer) until it it hits against the TCP congestion window. At =
this point TCP drastically reduces its transfer speed and it stays low beca=
use the full buffer delays the packets so it doesn't receive ACK's so it ca=
n't speed up the transfer again. Until the buffer is empty again (can take =
up to a second in my tests). Then this cycle repeats.

Regards,
Lukas Straub

> Thanks
> Zhang Chen
>=20
> >=20
> > Regards,
> > Lukas Straub
> >=20
> > ---
> >  net/filter-mirror.c | 142 +++++++++++++++++++++++++++++++++-----------
> >  1 file changed, 106 insertions(+), 36 deletions(-)
> >=20
> > diff --git a/net/filter-mirror.c b/net/filter-mirror.c index
> > d83e815545..6bcd317502 100644
> > --- a/net/filter-mirror.c
> > +++ b/net/filter-mirror.c
> > @@ -20,6 +20,8 @@
> >  #include "chardev/char-fe.h"
> >  #include "qemu/iov.h"
> >  #include "qemu/sockets.h"
> > +#include "block/aio-wait.h"
> > +#include "qemu/coroutine.h"
> >=20
> >  #define FILTER_MIRROR(obj) \
> >      OBJECT_CHECK(MirrorState, (obj), TYPE_FILTER_MIRROR) @@ -31,6
> > +33,18 @@  #define TYPE_FILTER_REDIRECTOR "filter-redirector"
> >  #define REDIRECTOR_MAX_LEN NET_BUFSIZE
> >=20
> > +typedef struct SendCo {
> > +    Coroutine *co;
> > +    GQueue send_list;
> > +    bool done;
> > +    int ret;
> > +} SendCo;
> > +
> > +typedef struct SendEntry {
> > +    ssize_t size;
> > +    uint8_t buf[];
> > +} SendEntry;
> > +
> >  typedef struct MirrorState {
> >      NetFilterState parent_obj;
> >      char *indev;
> > @@ -38,59 +52,101 @@ typedef struct MirrorState {
> >      CharBackend chr_in;
> >      CharBackend chr_out;
> >      SocketReadState rs;
> > +    SendCo sendco;
> >      bool vnet_hdr;
> >  } MirrorState;
> >=20
> > -static int filter_send(MirrorState *s,
> > -                       const struct iovec *iov,
> > -                       int iovcnt)
> > +static void coroutine_fn _filter_send(void *opaque)
> >  {
> > +    MirrorState *s =3D opaque;
> > +    SendCo *sendco =3D &s->sendco;
> >      NetFilterState *nf =3D NETFILTER(s);
> >      int ret =3D 0;
> > -    ssize_t size =3D 0;
> > -    uint32_t len =3D 0;
> > -    char *buf;
> > -
> > -    size =3D iov_size(iov, iovcnt);
> > -    if (!size) {
> > -        return 0;
> > -    }
> >=20
> > -    len =3D htonl(size);
> > -    ret =3D qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)&len, sizeof=
(len));
> > -    if (ret !=3D sizeof(len)) {
> > -        goto err;
> > -    }
> > +    while (!g_queue_is_empty(&sendco->send_list)) {
> > +        SendEntry *entry =3D g_queue_pop_tail(&sendco->send_list);
> > +        uint32_t len =3D htonl(entry->size);
> >=20
> > -    if (s->vnet_hdr) {
> > -        /*
> > -         * If vnet_hdr =3D on, we send vnet header len to make other
> > -         * module(like colo-compare) know how to parse net
> > -         * packet correctly.
> > -         */
> > -        ssize_t vnet_hdr_len;
> > +        ret =3D qemu_chr_fe_write_all(&s->chr_out,
> > +                                    (uint8_t *)&len,
> > +                                    sizeof(len));
> > +        if (ret !=3D sizeof(len)) {
> > +            g_free(entry);
> > +            goto err;
> > +        }
> >=20
> > -        vnet_hdr_len =3D nf->netdev->vnet_hdr_len;
> > +        if (s->vnet_hdr) {
> > +            /*
> > +             * If vnet_hdr =3D on, we send vnet header len to make oth=
er
> > +             * module(like colo-compare) know how to parse net
> > +             * packet correctly.
> > +             */
> > +
> > +            len =3D htonl(nf->netdev->vnet_hdr_len);
> > +            ret =3D qemu_chr_fe_write_all(&s->chr_out,
> > +                                        (uint8_t *)&len,
> > +                                        sizeof(len));
> > +            if (ret !=3D sizeof(len)) {
> > +                g_free(entry);
> > +                goto err;
> > +            }
> > +        }
> >=20
> > -        len =3D htonl(vnet_hdr_len);
> > -        ret =3D qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)&len, si=
zeof(len));
> > -        if (ret !=3D sizeof(len)) {
> > +        ret =3D qemu_chr_fe_write_all(&s->chr_out,
> > +                                    (uint8_t *)entry->buf,
> > +                                    entry->size);
> > +        if (ret !=3D entry->size) {
> > +            g_free(entry);
> >              goto err;
> >          }
> > -    }
> >=20
> > -    buf =3D g_malloc(size);
> > -    iov_to_buf(iov, iovcnt, 0, buf, size);
> > -    ret =3D qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)buf, size);
> > -    g_free(buf);
> > -    if (ret !=3D size) {
> > -        goto err;
> > +        g_free(entry);
> >      }
> >=20
> > -    return 0;
> > +    sendco->ret =3D 0;
> > +    goto out;
> >=20
> >  err:
> > -    return ret < 0 ? ret : -EIO;
> > +    while (!g_queue_is_empty(&sendco->send_list)) {
> > +        SendEntry *entry =3D g_queue_pop_tail(&sendco->send_list);
> > +        g_free(entry);
> > +    }
> > +    sendco->ret =3D ret < 0 ? ret : -EIO;
> > +out:
> > +    sendco->co =3D NULL;
> > +    sendco->done =3D true;
> > +    aio_wait_kick();
> > +}
> > +
> > +static int filter_send(MirrorState *s,
> > +                       const struct iovec *iov,
> > +                       int iovcnt)
> > +{
> > +    SendCo *sendco =3D &s->sendco;
> > +    SendEntry *entry;
> > +
> > +    ssize_t size =3D iov_size(iov, iovcnt);
> > +    if (!size) {
> > +        return 0;
> > +    }
> > +
> > +    entry =3D g_malloc(sizeof(SendEntry) + size);
> > +    entry->size =3D size;
> > +    iov_to_buf(iov, iovcnt, 0, entry->buf, size);
> > +    g_queue_push_head(&sendco->send_list, entry);
> > +
> > +    if (sendco->done) {
> > +        sendco->co =3D qemu_coroutine_create(_filter_send, s);
> > +        sendco->done =3D false;
> > +        qemu_coroutine_enter(sendco->co);
> > +        if (sendco->done) {
> > +            /* report early errors */
> > +            return sendco->ret;
> > +        }
> > +    }
> > +
> > +    /* assume success */
> > +    return 0;
> >  }
> >=20
> >  static void redirector_to_filter(NetFilterState *nf, @@ -194,6 +250,10=
 @@
> > static void filter_mirror_cleanup(NetFilterState *nf)  {
> >      MirrorState *s =3D FILTER_MIRROR(nf);
> >=20
> > +    AIO_WAIT_WHILE(NULL, !s->sendco.done);
> > +
> > +    g_queue_clear(&s->sendco.send_list);
> > +
> >      qemu_chr_fe_deinit(&s->chr_out, false);  }
> >=20
> > @@ -201,6 +261,10 @@ static void filter_redirector_cleanup(NetFilterSta=
te
> > *nf)  {
> >      MirrorState *s =3D FILTER_REDIRECTOR(nf);
> >=20
> > +    AIO_WAIT_WHILE(NULL, !s->sendco.done);
> > +
> > +    g_queue_clear(&s->sendco.send_list);
> > +
> >      qemu_chr_fe_deinit(&s->chr_in, false);
> >      qemu_chr_fe_deinit(&s->chr_out, false);  } @@ -224,6 +288,9 @@ sta=
tic
> > void filter_mirror_setup(NetFilterState *nf, Error **errp)
> >      }
> >=20
> >      qemu_chr_fe_init(&s->chr_out, chr, errp);
> > +
> > +    s->sendco.done =3D true;
> > +    g_queue_init(&s->sendco.send_list);
> >  }
> >=20
> >  static void redirector_rs_finalize(SocketReadState *rs) @@ -281,6 +348=
,9
> > @@ static void filter_redirector_setup(NetFilterState *nf, Error **errp)
> >              return;
> >          }
> >      }
> > +
> > +    s->sendco.done =3D true;
> > +    g_queue_init(&s->sendco.send_list);
> >  }
> >=20
> >  static void filter_mirror_class_init(ObjectClass *oc, void *data)
> > --
> > 2.20.1 =20
>=20


--Sig_/jykEuqkFZlXud6VdtXHJY0Y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl61EKoACgkQNasLKJxd
slgDwg/8DsYjJ6S6AVURVz34gJpDs7vU4MIAXvIa0y7ULOTExL1ehb8V6eK+buB/
xg9aEiSt32WL9q4/heVBNafoq1e1iuV2NRB4qgudb8ZrUR6GyeLQEcuPDShZJ7h5
A5HmdjwWEmdsDaQRy8fpgnoU+QC5LAlSGA7V6cMbESWyA1xFqOJvA0X9ogIJoNNX
QAjVvBhk1zyFA3HX9PNN1Z1KjK7ThshX9bBrnXGAhWhn+R7dTW4Yv3klCxBH9HrC
UdPCPluMx3Q4R23oSjAZutxGpNfe7pa5OUXKFOt0IskkkEGphBAIeqiuXNCYOE8W
VSmNp6gEerg9iZn0tFNEcfFQC1ECsSfLmUcE38/KTUSY9FtVGZcahPcPXbj03aID
Na5awJxwvrnRWgWs5GG0U9q+G2Z3qb4K+ZSfKKcqncbt28RWJguze7v49RQ8/R5k
l6FUhUgctJprUS4H9845ZWBNLffdk8FF664a0vcywCZ8HSNx/cA110sYuHfUxO9A
Cs3VmHDxCEmYrwKYX3O79tyiyhTCezOVXrzB/QKGaSwgCaR4dilfCgYiZ2TvTjGn
SAjptOC5/X3NGS8K9bz3fgX3YCqoSARO27MiWi8cq2sGSVKrxRT8wRcJO8kRlavb
I8LGI1u7NdEfEWGwlo8VglO/haucQ/MxwtLCRDJ79enCbv2CGrs=
=b6+E
-----END PGP SIGNATURE-----

--Sig_/jykEuqkFZlXud6VdtXHJY0Y--

