Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26BFC54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 07:29:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6445B2051A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 07:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="aHb/4n3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6445B2051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSyCN-0006SS-8O
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 03:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jSy6b-0004vI-A9
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 03:23:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jSy6a-0000Oo-AN
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 03:23:05 -0400
Received: from mout.web.de ([212.227.15.14]:34439)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jSy6Z-0000Ij-Mw
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 03:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1587972150;
 bh=oD86HxwRnOdomgVY73HMyhbfT6I3Cg40eLYcBa2ViX0=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=aHb/4n3wIwypQXEzyz3B3QyhSQHX8sqrgPm9APS7AihzhC6lMf2G4M9J/QcoaHnfr
 3cKNgJfKqnCiA/XsNAR/wPQeMwOhNmECK7omRCfW8XOhcGwUHaW68x8J4M/5S/sZKa
 dhJk++GP/PHtU6wxFrAf83FMo3va9IJiUGcep6Kg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.0]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MGAB5-1jNFib2Ya7-00F9H6; Mon, 27
 Apr 2020 09:22:30 +0200
Date: Mon, 27 Apr 2020 09:22:19 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: "Zhang, Chen" <chen.zhang@intel.com>
Subject: Re: [PATCH v3 3/6] net/colo-compare.c: Fix deadlock in
 compare_chr_send
Message-ID: <20200427092219.3af2a348@luklap>
In-Reply-To: <d93e8eb03493417190e9e1cbc2beed7e@intel.com>
References: <cover.1587935686.git.lukasstraub2@web.de>
 <6f3906393aaaf0adf21d45a5bf7a41536c7de205.1587935686.git.lukasstraub2@web.de>
 <d93e8eb03493417190e9e1cbc2beed7e@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lZUgF0sPXKoRIgYtDENY_+V";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:oDfFzg3QXrgTT/fQYNvKKKhDp8s9wW1ke1QED34+941CigKiJzO
 ESS7DC5CrDgkbjBMwyRYf1WVodQJPfjfRyoPhEpDgE4L1T0i6apPV0f64wMAljEXO6Uy2AG
 JMeg7xhT0AipQ6mtHcJ5SZhd2VFeYdfe05W53vEqE1vfz0ucZSwsb+z6ul/pqNmRArl6tOc
 hycVCSps+LrtC+3o0+lTg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tWXNzCOUT9U=:FC5TGZdvGboguycZfbLCYj
 t1X2rtFUCHm3T1VlPduZ3iuiyReuEsiCQ70ijNdtqKzHLFWNNWRptMXO8MwUqx8soKE5anYrv
 Tuo6vgsYzxydijo6asNiefPiklyNuhPIUjWXMj26DYwKowMtxexgNidXx7fIJeBFyFXmAJO1L
 tiCHUOVSIcBCUlgHHhcBohgzV23K+ElNtv4xxGb6X2E3Hjj3fIFHB96KSqnaJd8SzGMUv/8lA
 66Pw26JgX7C5fEf3LJU+jKyHFUa40XlFAdKPsc3o43vzAQ63ZtUurbLKidRdkCmO1NOQNOwIv
 fup/hmZuEMG65Qm4l1y3dkWdtBalHfcNOZlvAMcQ9/aAH6878r5wNhuRZOGR1BOYBqxpiv1J+
 5Bla1PHi/4EmPIRfZvhum5SgHOSPu/UGmrdieIuSmQG/ektbMvInJwbrn0AT95ZehZyQ1QN42
 TFxKaLgjkv01ZxF7VNyXKCBjVl5k9nYAu/KYU0TlswUwjxvZbI0TBdUprx4xB9HN8r5IZlF2p
 h036id3pA3nD9v47W+IbEmq86VX629k2yWtRUL72AJXYQGwclxycFVNhRMJjI8yrQsAj6qliA
 iWiu8DNS/ONEWEmnRIcK0WVt8Vz3fTw8X3sXjc9QdAUB04z0Z7kz+kmoJvgVjp7/Wc8+UUYWs
 IZxHsuusSAc3gB7HL4/m8+axxJD4+8Z6l0/ebsl80435maMoyiImcDOAZhga3DGzxIFp4Sla5
 6pl8W4KXK+/cln6uL29dC42eZaicxW4MzJaNebkj5vN11Wz96NaPL9tTXQg05QdBCLovY1aWe
 wOYE9vA6B3LLXnbfF+U0uECLcwCQedWzFeMAzzZqIq3jh0MPhmU00h/4KX7dh70eU/nArIeHv
 JyIm0ou+tuTRPAbXvpQsXiUBKpdyvdj2SWR/Pkok1ONVVy6SFSD8/Ue9yAS4EstwX2XrR23Uf
 EWnWOxxjzwELevuF82HlPO6/aRVfMkDVu5obR/rrHi3dBnqGYz3iOOC2uHGthsl0YV8iVboyV
 Umhy9zZVEJdC1OcHQeZAGchPHVJ4VeaKf8bVROjr18GJcgHiqJHIy8EZHR/iDipzhScVsjLaH
 vEn3kQD+n2W3c/Wu077qIkK4eQEdqAamfugD41jsHd1xbrVqV93t95mkct3JNCLNOkd9/vPRI
 JCUZ+bLcom3XJUSbA+Lp5Lm52yvfxx4o+XwvVW09VcyayYn8zW3O5tugXLxvUGyZbj8YXMFOs
 skljt+4KT4XsTTgzu
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 03:23:02
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

--Sig_/lZUgF0sPXKoRIgYtDENY_+V
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Apr 2020 03:36:57 +0000
"Zhang, Chen" <chen.zhang@intel.com> wrote:

> > -----Original Message-----
> > From: Lukas Straub <lukasstraub2@web.de>
> > Sent: Monday, April 27, 2020 5:19 AM
> > To: qemu-devel <qemu-devel@nongnu.org>
> > Cc: Zhang, Chen <chen.zhang@intel.com>; Li Zhijian
> > <lizhijian@cn.fujitsu.com>; Jason Wang <jasowang@redhat.com>; Marc-
> > Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>; Paolo Bonzini
> > <pbonzini@redhat.com>
> > Subject: [PATCH v3 3/6] net/colo-compare.c: Fix deadlock in
> > compare_chr_send
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
> > Fix this by converting compare_chr_send to a coroutine and putting the
> > packets in a send queue. Also create a new function notify_chr_send, si=
nce
> > that should be independend.
> >=20
> > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > ---
> >  net/colo-compare.c | 173 ++++++++++++++++++++++++++++++++++-------
> > ----
> >  1 file changed, 130 insertions(+), 43 deletions(-)
> >=20
> > diff --git a/net/colo-compare.c b/net/colo-compare.c index
> > 1de4220fe2..ff6a740284 100644
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
> > +80,20 @@ static int event_unhandled_count;
> >   *                    |packet  |  |packet  +    |packet  | |packet  +
> >   *                    +--------+  +--------+    +--------+ +--------+
> >   */
> > +
> > +typedef struct SendCo {
> > +    Coroutine *co;
> > +    GQueue send_list;
> > +    bool done;
> > +    int ret;
> > +} SendCo;
> > +
> > +typedef struct SendEntry {
> > +    uint32_t size;
> > +    uint32_t vnet_hdr_len;
> > +    uint8_t buf[];
> > +} SendEntry;
> > +
> >  typedef struct CompareState {
> >      Object parent;
> >=20
> > @@ -91,6 +108,7 @@ typedef struct CompareState {
> >      SocketReadState pri_rs;
> >      SocketReadState sec_rs;
> >      SocketReadState notify_rs;
> > +    SendCo sendco;
> >      bool vnet_hdr;
> >      uint32_t compare_timeout;
> >      uint32_t expired_scan_cycle;
> > @@ -126,8 +144,11 @@ enum {
> >  static int compare_chr_send(CompareState *s,
> >                              const uint8_t *buf,
> >                              uint32_t size,
> > -                            uint32_t vnet_hdr_len,
> > -                            bool notify_remote_frame);
> > +                            uint32_t vnet_hdr_len);
> > +
> > +static int notify_chr_send(CompareState *s,
> > +                           const uint8_t *buf,
> > +                           uint32_t size);
> >=20
> >  static bool packet_matches_str(const char *str,
> >                                 const uint8_t *buf, @@ -145,7 +166,7 @@=
 static void
> > notify_remote_frame(CompareState *s)
> >      char msg[] =3D "DO_CHECKPOINT";
> >      int ret =3D 0;
> >=20
> > -    ret =3D compare_chr_send(s, (uint8_t *)msg, strlen(msg), 0, true);
> > +    ret =3D notify_chr_send(s, (uint8_t *)msg, strlen(msg));
> >      if (ret < 0) {
> >          error_report("Notify Xen COLO-frame failed");
> >      }
> > @@ -271,8 +292,7 @@ static void colo_release_primary_pkt(CompareState
> > *s, Packet *pkt)
> >      ret =3D compare_chr_send(s,
> >                             pkt->data,
> >                             pkt->size,
> > -                           pkt->vnet_hdr_len,
> > -                           false);
> > +                           pkt->vnet_hdr_len);
> >      if (ret < 0) {
> >          error_report("colo send primary packet failed");
> >      }
> > @@ -699,63 +719,123 @@ static void colo_compare_connection(void
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
> >      int ret =3D 0;
> > -    uint32_t len =3D htonl(size);
> >=20
> > -    if (!size) {
> > -        return 0;
> > -    }
> > +    while (!g_queue_is_empty(&sendco->send_list)) {
> > +        SendEntry *entry =3D g_queue_pop_tail(&sendco->send_list);
> > +        uint32_t len =3D htonl(entry->size);
> >=20
> > -    if (notify_remote_frame) {
> > -        ret =3D qemu_chr_fe_write_all(&s->chr_notify_dev,
> > -                                    (uint8_t *)&len,
> > -                                    sizeof(len));
> > -    } else {
> >          ret =3D qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)&len, si=
zeof(len));
> > -    }
> >=20
> > -    if (ret !=3D sizeof(len)) {
> > -        goto err;
> > -    }
> > +        if (ret !=3D sizeof(len)) {
> > +            g_free(entry);
> > +            goto err;
> > +        }
> >=20
> > -    if (s->vnet_hdr) {
> > -        /*
> > -         * We send vnet header len make other module(like filter-redir=
ector)
> > -         * know how to parse net packet correctly.
> > -         */
> > -        len =3D htonl(vnet_hdr_len);
> > +        if (s->vnet_hdr) {
> > +            /*
> > +             * We send vnet header len make other module(like filter-r=
edirector)
> > +             * know how to parse net packet correctly.
> > +             */
> > +            len =3D htonl(entry->vnet_hdr_len);
> >=20
> > -        if (!notify_remote_frame) {
> >              ret =3D qemu_chr_fe_write_all(&s->chr_out,
> >                                          (uint8_t *)&len,
> >                                          sizeof(len));
> > +
> > +            if (ret !=3D sizeof(len)) {
> > +                g_free(entry);
> > +                goto err;
> > +            }
> >          }
> >=20
> > -        if (ret !=3D sizeof(len)) {
> > +        ret =3D qemu_chr_fe_write_all(&s->chr_out,
> > +                                    (uint8_t *)entry->buf,
> > +                                    entry->size);
> > +
> > +        if (ret !=3D entry->size) {
> > +            g_free(entry);
> >              goto err;
> >          }
> > +
> > +        g_free(entry);
> >      }
> >=20
> > -    if (notify_remote_frame) {
> > -        ret =3D qemu_chr_fe_write_all(&s->chr_notify_dev,
> > -                                    (uint8_t *)buf,
> > -                                    size);
> > -    } else {
> > -        ret =3D qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)buf, siz=
e);
> > +    sendco->ret =3D 0;
> > +    goto out;
> > +
> > +err:
> > +    while (!g_queue_is_empty(&sendco->send_list)) {
> > +        SendEntry *entry =3D g_queue_pop_tail(&sendco->send_list);
> > +        g_free(entry);
> >      }
> > +    sendco->ret =3D ret < 0 ? ret : -EIO;
> > +out:
> > +    sendco->co =3D NULL;
> > +    sendco->done =3D true;
> > +    aio_wait_kick();
> > +}
> > +
> > +static int compare_chr_send(CompareState *s,
> > +                            const uint8_t *buf,
> > +                            uint32_t size,
> > +                            uint32_t vnet_hdr_len) {
> > +    SendCo *sendco =3D &s->sendco;
> > +    SendEntry *entry;
> > +
> > +    if (!size) {
> > +        return 0;
> > +    }
> > +
> > +    entry =3D g_malloc(sizeof(SendEntry) + size);
> > +    entry->size =3D size;
> > +    entry->vnet_hdr_len =3D vnet_hdr_len;
> > +    memcpy(entry->buf, buf, size);
> > +    g_queue_push_head(&sendco->send_list, entry);
> > +
> > +    if (sendco->done) {
> > +        sendco->co =3D qemu_coroutine_create(_compare_chr_send, s);
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
> > +}
> > + =20
>=20
> Why not make notify_chr_send same as compare_chr_send?

Hello,
The notify chardev_dev is not affected from this deadlock issue and is inde=
pendent from the outdev chardev. So it wouldn't make sense for notify messa=
ges to wait in the queue if the outdev chardev is blocked. Also, the code i=
s easier to understand this way.

Regards,
Lukas Straub

> Thanks
> Zhang Chen
>=20
> > +static int notify_chr_send(CompareState *s,
> > +                           const uint8_t *buf,
> > +                           uint32_t size) {
> > +    int ret =3D 0;
> > +    uint32_t len =3D htonl(size);
> > +
> > +    ret =3D qemu_chr_fe_write_all(&s->chr_notify_dev,
> > +                            (uint8_t *)&len,
> > +                            sizeof(len));
> > +
> > +    if (ret !=3D sizeof(len)) {
> > +        goto err;
> > +    }
> > +
> > +    ret =3D qemu_chr_fe_write_all(&s->chr_notify_dev,
> > +                                (uint8_t *)buf,
> > +                                size);
> >=20
> >      if (ret !=3D size) {
> >          goto err;
> >      }
> >=20
> >      return 0;
> > -
> >  err:
> >      return ret < 0 ? ret : -EIO;
> >  }
> > @@ -1062,8 +1142,7 @@ static void
> > compare_pri_rs_finalize(SocketReadState *pri_rs)
> >          compare_chr_send(s,
> >                           pri_rs->buf,
> >                           pri_rs->packet_len,
> > -                         pri_rs->vnet_hdr_len,
> > -                         false);
> > +                         pri_rs->vnet_hdr_len);
> >      } else {
> >          /* compare packet in the specified connection */
> >          colo_compare_connection(conn, s); @@ -1093,7 +1172,7 @@ static=
 void
> > compare_notify_rs_finalize(SocketReadState *notify_rs)
> >      if (packet_matches_str("COLO_USERSPACE_PROXY_INIT",
> >                             notify_rs->buf,
> >                             notify_rs->packet_len)) {
> > -        ret =3D compare_chr_send(s, (uint8_t *)msg, strlen(msg), 0, tr=
ue);
> > +        ret =3D notify_chr_send(s, (uint8_t *)msg, strlen(msg));
> >          if (ret < 0) {
> >              error_report("Notify Xen COLO-frame INIT failed");
> >          }
> > @@ -1199,6 +1278,9 @@ static void colo_compare_complete(UserCreatable
> > *uc, Error **errp)
> >=20
> >      QTAILQ_INSERT_TAIL(&net_compares, s, next);
> >=20
> > +    s->sendco.done =3D true;
> > +    g_queue_init(&s->sendco.send_list);
> > +
> >      g_queue_init(&s->conn_list);
> >=20
> >      qemu_mutex_init(&event_mtx);
> > @@ -1224,8 +1306,7 @@ static void colo_flush_packets(void *opaque, void
> > *user_data)
> >          compare_chr_send(s,
> >                           pkt->data,
> >                           pkt->size,
> > -                         pkt->vnet_hdr_len,
> > -                         false);
> > +                         pkt->vnet_hdr_len);
> >          packet_destroy(pkt, NULL);
> >      }
> >      while (!g_queue_is_empty(&conn->secondary_list)) { @@ -1281,6
> > +1362,11 @@ static void colo_compare_finalize(Object *obj)
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
> >      qemu_chr_fe_deinit(&s->chr_out, false); @@ -1305,6 +1391,7 @@ stat=
ic
> > void colo_compare_finalize(Object *obj)
> >      g_queue_foreach(&s->conn_list, colo_flush_packets, s);
> >=20
> >      g_queue_clear(&s->conn_list);
> > +    g_queue_clear(&s->sendco.send_list);
> >=20
> >      if (s->connection_track_table) {
> >          g_hash_table_destroy(s->connection_track_table);
> > --
> > 2.20.1 =20
>=20


--Sig_/lZUgF0sPXKoRIgYtDENY_+V
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl6miCsACgkQNasLKJxd
slhMqxAAiBH+KAETm+VVAEiHcRVOQ8QUEIMi1KSFy6HDvRPs9j5fNte3StfEriZE
J/LPh1C6ARzkRhdD6jscSyJswCnDvNE2pAywHHoZIE6SJbkU47o5h19oHlMy6K9q
g6WimCUsTSrEhMho4k70DDD84LHQ7xmGQSu5imDqi9SGaVb5ddC/pUrzqtLjBF/q
sDCZfV0G1Wi6eRjRn50emO0Robv/EMjkLBOCsESKhmYK0jUMURGMuSGtkxzsdGV7
fQ6ekz1vvcn+G6GY5rm8+yjTzygnHDK8JsEaX8N0AiZDk6DXAj2stHhtSXPc/zfy
Aph/LIc41RbJjvBop6Tjgf7+a+TDJj0rxdYAWxZEmoRC9tlHC1BYzhBnhkEoyyaO
oPQPzvS5UEiYIIc4HN0RFF8pgzpaPW2E3FXNWimRjU9A5MIz0q+OQ9tNdtm5BJDr
6dIAnTIEvfE5OL6x4pl1EOCBDeBAAN7eFZZ1FVI8iIAsuVymFWaUNY6k1PUH9S0n
o8WmHvMolopnCBInHFFpJbGZCN8c2wqX6MsKgpscsswz6USQYTrndU2n6lAvK4ut
D/htpoqkmmwz/vyb0KqDhH9+jcoDf6j85iGSxOEY0OddagQAnN7t+UpmVoYVJLa3
NJLkZZlejOlZcd0dXSTVPWrtaJvcH9L4CUMCy5wh22vKso74RTE=
=uxrX
-----END PGP SIGNATURE-----

--Sig_/lZUgF0sPXKoRIgYtDENY_+V--

