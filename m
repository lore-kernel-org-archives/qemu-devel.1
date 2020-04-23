Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7A9C54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 14:10:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97FEA20857
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 14:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="aUgPQKOk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97FEA20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRcYE-0001ej-Dx
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 10:10:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51176)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jRcSQ-00078w-RW
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 10:04:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jRcSP-0004xp-Ua
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 10:04:02 -0400
Received: from mout.web.de ([212.227.15.14]:36123)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jRcSP-0004wg-5v
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 10:04:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1587650617;
 bh=mYA4dXMvlHLD6GmgymCFbnegRXtrWft+ANv0SCCd7z4=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=aUgPQKOke8b4ry+RfCaugHZlbm1oiRbn0rbBtI0sN134R6/OPNHKyBPhyYvnRp+Fw
 ScyCfKfqFgPoRt/aFr/ktxAqcVgmqLk2bYAHqi19VIK6hA7AM6DEXQgfZypeN6zucU
 FncX8qubGNOOupylCcdIdENxiv+mwPJj1ea0oT7Q=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.165]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LtX9Q-1j2Dro2ro4-010xsz; Thu, 23
 Apr 2020 16:03:36 +0200
Date: Thu, 23 Apr 2020 16:03:25 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: "Zhang, Chen" <chen.zhang@intel.com>
Subject: Re: [PATCH 3/3] net/colo-compare.c: Fix deadlock
Message-ID: <20200423160325.205248ae@luklap>
In-Reply-To: <43db66be4b41426e97cf086b0a5d4784@intel.com>
References: <cover.1586370737.git.lukasstraub2@web.de>
 <87c2f42b46f93fb89867f82e45aa2689eff98432.1586370737.git.lukasstraub2@web.de>
 <43db66be4b41426e97cf086b0a5d4784@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4MtrbM1F+h9ogk4ItjIXQdl";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:aV9pQZHmY6gXJxPPxJNkxXgZQP8+7enAcnMqrHRxd/W275ID5/9
 tND8iI07o2srP6YDVKY9HGuXcrntT20v2HkU4og5r4TNJ8lS98Hn0ZY2RzJVjEGKuF+6njM
 PEeJznR3b8eIp6+ohqgH/ab7mHrhBEo9iBDfsi0alBeGW61ymHGcfDgtGxLKkfm2J/x2S3H
 qpjAlG7ibZSLK9v7EpiYQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:H0B8K6l0CWc=:vjXenPBTha1QI2TYa87JSl
 B0oFykJAxeaJD7yPUopF2LNP/yLRBM1iIuO75g+WHP1XmHOpaYtNBcIFYzMRvGqvKlQEzdAeS
 fTwXkLYzu2R5hH5NDHNzUGt+gtkx03NiONV2KlttJZH3IqIYulvaPiCAH7UcGvuMDOSOd8fFv
 Tqr2rZ0TWu4KgmUaNoLjFW85yNhyRK9PxeEDNYNWlOoAcbME1dJd0QwdXsBul/YkeC7ctXAxH
 e7Ue6rYBjtmZtRefwKO5eG5XsuvIWPpA5AOqe0Wrpb9TJVMuG7g6zDMwLYpiOrkWfLZYgYTk4
 M5FoAqWSE8AtK15yVgzyKYFYY4OidNIsjGRSnhZ9RIWzubsH8PKfwKQDgMgBhRSfYCDgmPnUb
 mjLt/HtI+T4V6QaiHtHfyVe/EwVyC5BpJOPPaU6BEiGOwfyUxCzov5Poo/POFzP9RGQpF234C
 6MT/ILEErKsLsRYkxMHdNc7W1Pfl5ZyiIwx2k2ioiCbsCF3ctD5SydHjTEZ60Xf7pQ+z6yfCo
 p/pgU6x01H+qH/fESmfHTyD1sZvkpdIpubImtrGqwpExQk4gf1Lzy9sczrfdvS/Ida1dWoCWf
 0Qt6+yClWO0cySvw/TM8Aw8mWCIdV4QJ9mhhXG8WNzdBMWZNRrfa7xM6cqvGPRyXOzqLFrHL5
 2m4s1h/FLTQpBrKmsm3elDFNx1mh1kOWkWdg5oDkAUp5/WFLTjUhVLMUzMTpKIL31R3pB+XBz
 wDiFYNHJZ33zUYEblz7BD5pbn8PKviY5nKOv4WUwDeADc3CJ3ZKMhRL9TqXD0G2EGW7ddWoZ4
 CXN2UvfA/8B8+TwDLPVKDnRbu8jgxWHBVL5cgPflbsTjuMg2YRerI4z2hZSS0n/aLnj6Ma+MJ
 BJZFnVrQ4Ndjp6Jxqxbuh+KCxyIqJtnF6WidrGdNHySMAQXcF1OJoimKdsbZMTjHmfHGZEbR3
 ZToFtA1YQHh/exOyHab8L9fP7c6g6Y2P62tvxzJQRf15htZRjSrD92KKWnItCY9guCbUhEw8w
 NYAvv8bglLsEWoGczN6YHpYciWxyaPL7pw5GBnCIGI0ASCe5aBouVEvdAO/dlPVizPBZtu3aP
 gt8w9p2xg5v3i2GytaeEaX11Uqo/8Jf2q2IL0iUUVVj9bJW3pAQJPVZKKpYlDwgEjlqOYTP5u
 b8DjaEIDnAztOx4hwlx8YrQg0FJonDcBvR3CBMJ79UEGFdym5c2v5TahDgc9uYEjv/+GwzQJV
 jzXuGcLxl8NzjGtTu
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 10:03:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/4MtrbM1F+h9ogk4ItjIXQdl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 22 Apr 2020 08:40:40 +0000
"Zhang, Chen" <chen.zhang@intel.com> wrote:

> > -----Original Message-----
> > From: Lukas Straub <lukasstraub2@web.de>
> > Sent: Thursday, April 9, 2020 2:34 AM
> > To: qemu-devel <qemu-devel@nongnu.org>
> > Cc: Zhang, Chen <chen.zhang@intel.com>; Li Zhijian
> > <lizhijian@cn.fujitsu.com>; Jason Wang <jasowang@redhat.com>; Marc-
> > Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>; Paolo Bonzini
> > <pbonzini@redhat.com>
> > Subject: [PATCH 3/3] net/colo-compare.c: Fix deadlock
> >=20
> > The chr_out chardev is connected to a filter-redirector running in the =
main
> > loop. qemu_chr_fe_write_all might block here in compare_chr_send if the
> > (socket-)buffer is full.
> > If another filter-redirector in the main loop want's to send data to ch=
r_pri_in
> > it might also block if the buffer is full. This leads to a deadlock bec=
ause both
> > event loops get blocked.
> >=20
> > Fix this by converting compare_chr_send to a coroutine and return error=
 if it
> > is in use.
> >  =20
>=20
> I have tested this series, running fine currently.
> Can you share performance data after this patch?
>=20
> Thanks
> Zhang Chen

Hello,
Here are the results (using iperf3):
Client-to-server tcp:
without patch: ~64.2 Mbit/s
with patch: ~28.9 Mbit/s
Server-to-client tcp:
without patch: 360 Kbit/s (when it doesn't deadlock :)
with patch: 220 Kbit/s

Yeah, it hurts performance somewhat, but the deadlock happens often with lo=
ts
of server-to-client traffic. (It deadlocked in 2 of 4 runs)

Do you have a better idea to solve this issue?

Regards,
Lukas Straub

> > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > ---
> >  net/colo-compare.c | 82
> > +++++++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 71 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/net/colo-compare.c b/net/colo-compare.c index
> > 1de4220fe2..82787d3055 100644
> > --- a/net/colo-compare.c
> > +++ b/net/colo-compare.c
> > @@ -32,6 +32,9 @@
> >  #include "migration/migration.h"
> >  #include "util.h"
> >=20
> > +#include "block/aio-wait.h"
> > +#include "qemu/coroutine.h"
> > +
> >  #define TYPE_COLO_COMPARE "colo-compare"
> >  #define COLO_COMPARE(obj) \
> >      OBJECT_CHECK(CompareState, (obj), TYPE_COLO_COMPARE) @@ -77,6
> > +80,17 @@ static int event_unhandled_count;
> >   *                    |packet  |  |packet  +    |packet  | |packet  +
> >   *                    +--------+  +--------+    +--------+ +--------+
> >   */
> > +
> > +typedef struct SendCo {
> > +    Coroutine *co;
> > +    uint8_t *buf;
> > +    uint32_t size;
> > +    uint32_t vnet_hdr_len;
> > +    bool notify_remote_frame;
> > +    bool done;
> > +    int ret;
> > +} SendCo;
> > +
> >  typedef struct CompareState {
> >      Object parent;
> >=20
> > @@ -91,6 +105,7 @@ typedef struct CompareState {
> >      SocketReadState pri_rs;
> >      SocketReadState sec_rs;
> >      SocketReadState notify_rs;
> > +    SendCo sendco;
> >      bool vnet_hdr;
> >      uint32_t compare_timeout;
> >      uint32_t expired_scan_cycle;
> > @@ -699,19 +714,17 @@ static void colo_compare_connection(void
> > *opaque, void *user_data)
> >      }
> >  }
> >=20
> > -static int compare_chr_send(CompareState *s,
> > -                            const uint8_t *buf,
> > -                            uint32_t size,
> > -                            uint32_t vnet_hdr_len,
> > -                            bool notify_remote_frame)
> > +static void coroutine_fn _compare_chr_send(void *opaque)
> >  {
> > +    CompareState *s =3D opaque;
> > +    SendCo *sendco =3D &s->sendco;
> > +    const uint8_t *buf =3D sendco->buf;
> > +    uint32_t size =3D sendco->size;
> > +    uint32_t vnet_hdr_len =3D sendco->vnet_hdr_len;
> > +    bool notify_remote_frame =3D sendco->notify_remote_frame;
> >      int ret =3D 0;
> >      uint32_t len =3D htonl(size);
> >=20
> > -    if (!size) {
> > -        return 0;
> > -    }
> > -
> >      if (notify_remote_frame) {
> >          ret =3D qemu_chr_fe_write_all(&s->chr_notify_dev,
> >                                      (uint8_t *)&len, @@ -754,10 +767,5=
0 @@ static int
> > compare_chr_send(CompareState *s,
> >          goto err;
> >      }
> >=20
> > -    return 0;
> > +    sendco->ret =3D 0;
> > +    goto out;
> >=20
> >  err:
> > -    return ret < 0 ? ret : -EIO;
> > +    sendco->ret =3D ret < 0 ? ret : -EIO;
> > +out:
> > +    sendco->co =3D NULL;
> > +    g_free(sendco->buf);
> > +    sendco->buf =3D NULL;
> > +    sendco->done =3D true;
> > +    aio_wait_kick();
> > +}
> > +
> > +static int compare_chr_send(CompareState *s,
> > +                            const uint8_t *buf,
> > +                            uint32_t size,
> > +                            uint32_t vnet_hdr_len,
> > +                            bool notify_remote_frame) {
> > +    SendCo *sendco =3D &s->sendco;
> > +
> > +    if (!size) {
> > +        return 0;
> > +    }
> > +
> > +    if (sendco->done) {
> > +        sendco->co =3D qemu_coroutine_create(_compare_chr_send, s);
> > +        sendco->buf =3D g_malloc(size);
> > +        sendco->size =3D size;
> > +        sendco->vnet_hdr_len =3D vnet_hdr_len;
> > +        sendco->notify_remote_frame =3D notify_remote_frame;
> > +        sendco->done =3D false;
> > +        memcpy(sendco->buf, buf, size);
> > +        qemu_coroutine_enter(sendco->co);
> > +        if (sendco->done) {
> > +            /* report early errors */
> > +            return sendco->ret;
> > +        } else {
> > +            /* else assume success */
> > +            return 0;
> > +        }
> > +    }
> > +
> > +    return -ENOBUFS;
> >  }
> >=20
> >  static int compare_chr_can_read(void *opaque) @@ -1146,6 +1199,8 @@
> > static void colo_compare_complete(UserCreatable *uc, Error **errp)
> >      CompareState *s =3D COLO_COMPARE(uc);
> >      Chardev *chr;
> >=20
> > +    s->sendco.done =3D true;
> > +
> >      if (!s->pri_indev || !s->sec_indev || !s->outdev || !s->iothread) {
> >          error_setg(errp, "colo compare needs 'primary_in' ,"
> >                     "'secondary_in','outdev','iothread' property set");=
 @@ -1281,6
> > +1336,11 @@ static void colo_compare_finalize(Object *obj)
> >      CompareState *s =3D COLO_COMPARE(obj);
> >      CompareState *tmp =3D NULL;
> >=20
> > +    AioContext *ctx =3D iothread_get_aio_context(s->iothread);
> > +    aio_context_acquire(ctx);
> > +    AIO_WAIT_WHILE(ctx, !s->sendco.done);
> > +    aio_context_release(ctx);
> > +
> >      qemu_chr_fe_deinit(&s->chr_pri_in, false);
> >      qemu_chr_fe_deinit(&s->chr_sec_in, false);
> >      qemu_chr_fe_deinit(&s->chr_out, false);
> > --
> > 2.20.1 =20


--Sig_/4MtrbM1F+h9ogk4ItjIXQdl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl6hoC0ACgkQNasLKJxd
sliiRQ/+JAAuuQoWxjFLGrGOXk4PPKFh6cYWmTMM6v4E5iBgyV+Q13VFCKFWyPBD
up7JaIyOCmS8ueh1FZOMTieylo8uiD8xlJmqcV34lzgijbnAAvh1CvXa3SzxrnmL
ZvHq2+74G9jGDE1iJXPrUDZBaoiMpjxt0/nq8S+XwsaGBwdUzDAdd2WOGq9EOSIE
0C48113JoeNWrGOELlnhyTqzncnv0zWBAQ4Epa5xgOPUHbUyVa4Mk4BV3Y21vQLA
1XQ6Pvh00CrbCsiVnh2LYp4OFck6jegJ+YxSmW+SOUh0ZqNRepl0diQv+lJsBZgi
Yuw0EV5SfqnFt3MXEW8KOygYkMp+V9vo1xzuwoHT9Te53GS1/El2DEWFECPg78k1
C4LavLeAx6KnzLHp1qNdSsztTkatFpD9D1H5XYB56U2PbVAsQKd4ZCoDo4Jb5va0
eYoEibZmG67Ch00AfKYzFDoqPVxNYFTPXoSW4QT+MN/sNobgcwPgZ6P4vbqhaxNZ
6FzHMq3FzDggjxPLJLau+9sAcpu4P4ybrdm0zk+Rq/P5i2rtq3pus4/eVYJNo0TM
AXrSK43vO6Q3qZOrrnn5U1y6f5iQx56qNb8dCefWV0HCGPyXNyHA8JI2OF5dJZj/
uNef6st+sv0zG2gGxlujf8iJYcZnf+nqzcMyHr+iGbBq27PXMoo=
=d/7U
-----END PGP SIGNATURE-----

--Sig_/4MtrbM1F+h9ogk4ItjIXQdl--

