Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B703C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 08:02:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43FDB2073E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 08:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="eEm3HNBo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43FDB2073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jThgB-0003R7-7J
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 04:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49848)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jThXW-0006IG-Gi
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:57:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jThVK-0003p5-0e
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:53:54 -0400
Received: from mout.web.de ([212.227.15.3]:57731)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jThVJ-0003ke-7D
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1588146679;
 bh=zKSI8LSS/bDC25M86GX/4Uoa7Sze0fUwIYQXpTiGb4w=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=eEm3HNBoRRxlmQTfXo00shUE0dhndwi5ZwEOZ9yJZ+ZtZQrXt/i2zJIEevqo3oX0w
 S2LJS28TF4swRHwvhqJ5DykEVTs3rv38uFiI0OrQdAJ5EfWOUavwIvuLJJccMLf1et
 a9br2eweIByEc0iqBI+9mdQnH6blItM8QtUNhFX8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.32]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mfc8y-1iwpaR06lU-00fxI9; Wed, 29
 Apr 2020 09:51:19 +0200
Date: Wed, 29 Apr 2020 09:51:09 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: "Zhang, Chen" <chen.zhang@intel.com>
Subject: Re: [PATCH v3 3/6] net/colo-compare.c: Fix deadlock in
 compare_chr_send
Message-ID: <20200429095109.200f2b5b@luklap>
In-Reply-To: <c2a9bf3c2fe74723bddf84ccd6779a1e@intel.com>
References: <cover.1587935686.git.lukasstraub2@web.de>
 <6f3906393aaaf0adf21d45a5bf7a41536c7de205.1587935686.git.lukasstraub2@web.de>
 <d93e8eb03493417190e9e1cbc2beed7e@intel.com>
 <20200427092219.3af2a348@luklap>
 <c2a9bf3c2fe74723bddf84ccd6779a1e@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/U_OzEJjOf=2HFiHY6w1YPBa";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:svRcFnU9oJkRKiVOGEk28drcxqfxjl3BK43gTEK00vlxewDQpbm
 Ken+sdgdgz42Fu5ZnV/HdBqYxVvjkd25wIgOopldyANqfF1jn/lhnyujwwG5tfzND0APtaZ
 Dz7VYmhpaEdrcUyhSa+k7ng999Zrne4+HcDKjQe1CRzuopWNgBLX3L/xKJLVnaV+Cnso7Bi
 nr4ENG7aeLyMdCNp0Tx1A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WuMZMBTmiEc=:P4PaKxXMUCBqhPF+Tf/NZ7
 Hy44Dq63eA+PSolVQFnJb4h/G6rbO+QvxMOWXBrBZWXvVtAPwnLfeygGzjISs5fJRp+drgdLV
 8oHf4YEmA9M7jGLr2KL6ajuHYE1Z1UPHjSH05GJzZWW1+OlkS7OOhEJpqDQAs1kxkodeL2cxc
 63vsSRgF/2hzVONMw82e5uuDgcWR345LQT7YKXYrDMIrvZgHkBFMolIlnRRcRgYMVCfCE+YDC
 cMuEpd6Llk9Xiu+0IxTOFdHTkqIlKIzlw3ZgGwbyD5DEQQksS+l8bWGNH/XT8qGCt6v4VSGI5
 cZBJiByI2GL5vTUf2F9TdvCqgD8xtBAfWMF3XqUI9iypzcpJHTxmjB1iaP+FPlVJE5fz6yOjN
 Uz/rGjmZ2iUpX33rUamhr8E/7lPGMj/ffcU2QyCic2c7uSRq76C/jj9Z9hK71L0BsomK5TVIq
 HXDPnBiEnYKXhLLvkOH58nbwK5pRSmZe5ZtJ5HbqFlVnA6QbcBGoDXoNz4oxw4PsG8in0Q19L
 Uu9cQp5SNgr0x7qsv7Vf+39+ISKuHVUpyo6Bs1Ss7y+A3tKZoXp8mCoZPeG7LQ96xSiWD0eLy
 3Y22bIQzgVgKT9Mic2YrfM2lscH2pXri5JYrnCDb0RPzdWRjlhGnRHfN9/YJbqHkc1XHqQrLD
 nsoeRgfbHwOzGp3zRWYi+6S3jhSBMp9/WGpE6O1RVe7FHeUjZbPo+evCqiFbrwVTwIt9bV+L5
 9JurmmbdOewPrIEcMyIfYrw0gnAXQIDbg1yvcsMjolYHhKS4IuD+P0Jj8A89LC3aAJ5Ib3SRW
 g25bEAFGg2XDr15OljYMw50m7wXzsD40JqXVPdvK2Np4LwR/H/om8OwUeqstYxvP9wXoPDIMn
 4O+XkRs2AIGDN9n75H3fXn9JFwEK6MZHGDldrt4OzMhNEJGNz/cJvuHdDp4oaCATmFyOn/HDP
 BSHL7lQW1bv1v3Mx0vfxT/aL1uiupTS0UHJRo24sPGgvILEkdRCchwLqGytqT9Y95QHZK6OWz
 NviIqQjXJiqHlFuBBbqrlVb1/mUeJqREj9JJxLjV6PAKu/rtd8zdJ4vOtUZ/wgRZf+opp5ST3
 3si/kkWv9zOK6gR73lCM61aZkZ7kIIiygvMh/X2G9ocWEn4FZO3zgpVYBYD4qhel8pzgsCcFy
 sh1KktJklCmPRv3kEiKua6fcB1bqnDR/ZDdNjLQ/H6XVQjVaRVckDtVYZOAnnhUmqwrzayOC3
 WlXuBiHcbuRKDrUHx
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 03:51:34
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Received-From: 212.227.15.3
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

--Sig_/U_OzEJjOf=2HFiHY6w1YPBa
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 29 Apr 2020 05:37:17 +0000
"Zhang, Chen" <chen.zhang@intel.com> wrote:

> > -----Original Message-----
> > From: Lukas Straub <lukasstraub2@web.de>
> > Sent: Monday, April 27, 2020 3:22 PM
> > To: Zhang, Chen <chen.zhang@intel.com>
> > Cc: qemu-devel <qemu-devel@nongnu.org>; Li Zhijian
> > <lizhijian@cn.fujitsu.com>; Jason Wang <jasowang@redhat.com>; Marc-
> > Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>; Paolo Bonzini
> > <pbonzini@redhat.com>
> > Subject: Re: [PATCH v3 3/6] net/colo-compare.c: Fix deadlock in
> > compare_chr_send
> >=20
> > On Mon, 27 Apr 2020 03:36:57 +0000
> > "Zhang, Chen" <chen.zhang@intel.com> wrote:
> >  =20
> > > > -----Original Message-----
> > > > From: Lukas Straub <lukasstraub2@web.de>
> > > > Sent: Monday, April 27, 2020 5:19 AM
> > > > To: qemu-devel <qemu-devel@nongnu.org>
> > > > Cc: Zhang, Chen <chen.zhang@intel.com>; Li Zhijian
> > > > <lizhijian@cn.fujitsu.com>; Jason Wang <jasowang@redhat.com>; Marc-
> > > > Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>; Paolo Bonzini
> > > > <pbonzini@redhat.com>
> > > > Subject: [PATCH v3 3/6] net/colo-compare.c: Fix deadlock in
> > > > compare_chr_send
> > > >
> > > > The chr_out chardev is connected to a filter-redirector running in
> > > > the main loop. qemu_chr_fe_write_all might block here in
> > > > compare_chr_send if the (socket-)buffer is full.
> > > > If another filter-redirector in the main loop want's to send data to
> > > > chr_pri_in it might also block if the buffer is full. This leads to
> > > > a deadlock because both event loops get blocked.
> > > >
> > > > Fix this by converting compare_chr_send to a coroutine and putting
> > > > the packets in a send queue. Also create a new function
> > > > notify_chr_send, since that should be independend.
> > > >
> > > > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > > > ---
> > > >  net/colo-compare.c | 173 ++++++++++++++++++++++++++++++++++--- =20
> > ---- =20
> > > > ----
> > > >  1 file changed, 130 insertions(+), 43 deletions(-)
> > > >
> > > > diff --git a/net/colo-compare.c b/net/colo-compare.c index
> > > > 1de4220fe2..ff6a740284 100644
> > > > --- a/net/colo-compare.c
> > > > +++ b/net/colo-compare.c
> > > > @@ -32,6 +32,9 @@
> > > >  #include "migration/migration.h"
> > > >  #include "util.h"
> > > >
> > > > +#include "block/aio-wait.h"
> > > > +#include "qemu/coroutine.h"
> > > > +
> > > >  #define TYPE_COLO_COMPARE "colo-compare"
> > > >  #define COLO_COMPARE(obj) \
> > > >      OBJECT_CHECK(CompareState, (obj), TYPE_COLO_COMPARE) @@ - =20
> > 77,6 =20
> > > > +80,20 @@ static int event_unhandled_count;
> > > >   *                    |packet  |  |packet  +    |packet  | |packet=
  +
> > > >   *                    +--------+  +--------+    +--------+ +------=
--+
> > > >   */
> > > > +
> > > > +typedef struct SendCo {
> > > > +    Coroutine *co;
> > > > +    GQueue send_list;
> > > > +    bool done;
> > > > +    int ret;
> > > > +} SendCo;
> > > > +
> > > > +typedef struct SendEntry {
> > > > +    uint32_t size;
> > > > +    uint32_t vnet_hdr_len;
> > > > +    uint8_t buf[];
> > > > +} SendEntry;
> > > > +
> > > >  typedef struct CompareState {
> > > >      Object parent;
> > > >
> > > > @@ -91,6 +108,7 @@ typedef struct CompareState {
> > > >      SocketReadState pri_rs;
> > > >      SocketReadState sec_rs;
> > > >      SocketReadState notify_rs;
> > > > +    SendCo sendco;
> > > >      bool vnet_hdr;
> > > >      uint32_t compare_timeout;
> > > >      uint32_t expired_scan_cycle;
> > > > @@ -126,8 +144,11 @@ enum {
> > > >  static int compare_chr_send(CompareState *s,
> > > >                              const uint8_t *buf,
> > > >                              uint32_t size,
> > > > -                            uint32_t vnet_hdr_len,
> > > > -                            bool notify_remote_frame);
> > > > +                            uint32_t vnet_hdr_len);
> > > > +
> > > > +static int notify_chr_send(CompareState *s,
> > > > +                           const uint8_t *buf,
> > > > +                           uint32_t size);
> > > >
> > > >  static bool packet_matches_str(const char *str,
> > > >                                 const uint8_t *buf, @@ -145,7 +166,7
> > > > @@ static void notify_remote_frame(CompareState *s)
> > > >      char msg[] =3D "DO_CHECKPOINT";
> > > >      int ret =3D 0;
> > > >
> > > > -    ret =3D compare_chr_send(s, (uint8_t *)msg, strlen(msg), 0, tr=
ue);
> > > > +    ret =3D notify_chr_send(s, (uint8_t *)msg, strlen(msg));
> > > >      if (ret < 0) {
> > > >          error_report("Notify Xen COLO-frame failed");
> > > >      }
> > > > @@ -271,8 +292,7 @@ static void
> > > > colo_release_primary_pkt(CompareState
> > > > *s, Packet *pkt)
> > > >      ret =3D compare_chr_send(s,
> > > >                             pkt->data,
> > > >                             pkt->size,
> > > > -                           pkt->vnet_hdr_len,
> > > > -                           false);
> > > > +                           pkt->vnet_hdr_len);
> > > >      if (ret < 0) {
> > > >          error_report("colo send primary packet failed");
> > > >      }
> > > > @@ -699,63 +719,123 @@ static void colo_compare_connection(void
> > > > *opaque, void *user_data)
> > > >      }
> > > >  }
> > > >
> > > > -static int compare_chr_send(CompareState *s,
> > > > -                            const uint8_t *buf,
> > > > -                            uint32_t size,
> > > > -                            uint32_t vnet_hdr_len,
> > > > -                            bool notify_remote_frame)
> > > > +static void coroutine_fn _compare_chr_send(void *opaque)
> > > >  {
> > > > +    CompareState *s =3D opaque;
> > > > +    SendCo *sendco =3D &s->sendco;
> > > >      int ret =3D 0;
> > > > -    uint32_t len =3D htonl(size);
> > > >
> > > > -    if (!size) {
> > > > -        return 0;
> > > > -    }
> > > > +    while (!g_queue_is_empty(&sendco->send_list)) {
> > > > +        SendEntry *entry =3D g_queue_pop_tail(&sendco->send_list);
> > > > +        uint32_t len =3D htonl(entry->size);
> > > >
> > > > -    if (notify_remote_frame) {
> > > > -        ret =3D qemu_chr_fe_write_all(&s->chr_notify_dev,
> > > > -                                    (uint8_t *)&len,
> > > > -                                    sizeof(len));
> > > > -    } else {
> > > >          ret =3D qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)&len=
, =20
> > sizeof(len)); =20
> > > > -    }
> > > >
> > > > -    if (ret !=3D sizeof(len)) {
> > > > -        goto err;
> > > > -    }
> > > > +        if (ret !=3D sizeof(len)) {
> > > > +            g_free(entry);
> > > > +            goto err;
> > > > +        }
> > > >
> > > > -    if (s->vnet_hdr) {
> > > > -        /*
> > > > -         * We send vnet header len make other module(like filter-r=
edirector)
> > > > -         * know how to parse net packet correctly.
> > > > -         */
> > > > -        len =3D htonl(vnet_hdr_len);
> > > > +        if (s->vnet_hdr) {
> > > > +            /*
> > > > +             * We send vnet header len make other module(like filt=
er- =20
> > redirector) =20
> > > > +             * know how to parse net packet correctly.
> > > > +             */
> > > > +            len =3D htonl(entry->vnet_hdr_len);
> > > >
> > > > -        if (!notify_remote_frame) {
> > > >              ret =3D qemu_chr_fe_write_all(&s->chr_out,
> > > >                                          (uint8_t *)&len,
> > > >                                          sizeof(len));
> > > > +
> > > > +            if (ret !=3D sizeof(len)) {
> > > > +                g_free(entry);
> > > > +                goto err;
> > > > +            }
> > > >          }
> > > >
> > > > -        if (ret !=3D sizeof(len)) {
> > > > +        ret =3D qemu_chr_fe_write_all(&s->chr_out,
> > > > +                                    (uint8_t *)entry->buf,
> > > > +                                    entry->size);
> > > > +
> > > > +        if (ret !=3D entry->size) {
> > > > +            g_free(entry);
> > > >              goto err;
> > > >          }
> > > > +
> > > > +        g_free(entry);
> > > >      }
> > > >
> > > > -    if (notify_remote_frame) {
> > > > -        ret =3D qemu_chr_fe_write_all(&s->chr_notify_dev,
> > > > -                                    (uint8_t *)buf,
> > > > -                                    size);
> > > > -    } else {
> > > > -        ret =3D qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)buf,=
 size);
> > > > +    sendco->ret =3D 0;
> > > > +    goto out;
> > > > +
> > > > +err:
> > > > +    while (!g_queue_is_empty(&sendco->send_list)) {
> > > > +        SendEntry *entry =3D g_queue_pop_tail(&sendco->send_list);
> > > > +        g_free(entry);
> > > >      }
> > > > +    sendco->ret =3D ret < 0 ? ret : -EIO;
> > > > +out:
> > > > +    sendco->co =3D NULL;
> > > > +    sendco->done =3D true;
> > > > +    aio_wait_kick();
> > > > +}
> > > > +
> > > > +static int compare_chr_send(CompareState *s,
> > > > +                            const uint8_t *buf,
> > > > +                            uint32_t size,
> > > > +                            uint32_t vnet_hdr_len) {
> > > > +    SendCo *sendco =3D &s->sendco;
> > > > +    SendEntry *entry;
> > > > +
> > > > +    if (!size) {
> > > > +        return 0;
> > > > +    }
> > > > +
> > > > +    entry =3D g_malloc(sizeof(SendEntry) + size);
> > > > +    entry->size =3D size;
> > > > +    entry->vnet_hdr_len =3D vnet_hdr_len;
> > > > +    memcpy(entry->buf, buf, size);
> > > > +    g_queue_push_head(&sendco->send_list, entry);
> > > > +
> > > > +    if (sendco->done) {
> > > > +        sendco->co =3D qemu_coroutine_create(_compare_chr_send, s);
> > > > +        sendco->done =3D false;
> > > > +        qemu_coroutine_enter(sendco->co);
> > > > +        if (sendco->done) {
> > > > +            /* report early errors */
> > > > +            return sendco->ret;
> > > > +        }
> > > > +    }
> > > > +
> > > > +    /* assume success */
> > > > +    return 0;
> > > > +}
> > > > + =20
> > >
> > > Why not make notify_chr_send same as compare_chr_send? =20
> >=20
> > Hello,
> > The notify chardev_dev is not affected from this deadlock issue and is
> > independent from the outdev chardev. So it wouldn't make sense for noti=
fy
> > messages to wait in the queue if the outdev chardev is blocked. Also, t=
he
> > code is easier to understand this way.
> >  =20
>=20
> Yes, I means maybe the deadlock issue will also occur in Xen COLO side, w=
e can resolve the potential problem here.

Ok,
I will change it in the next version.

> Thanks
> Zhang Chen
>=20
> > Regards,
> > Lukas Straub
> >  =20
> > > Thanks
> > > Zhang Chen
> > > =20
> > > > +static int notify_chr_send(CompareState *s,
> > > > +                           const uint8_t *buf,
> > > > +                           uint32_t size) {
> > > > +    int ret =3D 0;
> > > > +    uint32_t len =3D htonl(size);
> > > > +
> > > > +    ret =3D qemu_chr_fe_write_all(&s->chr_notify_dev,
> > > > +                            (uint8_t *)&len,
> > > > +                            sizeof(len));
> > > > +
> > > > +    if (ret !=3D sizeof(len)) {
> > > > +        goto err;
> > > > +    }
> > > > +
> > > > +    ret =3D qemu_chr_fe_write_all(&s->chr_notify_dev,
> > > > +                                (uint8_t *)buf,
> > > > +                                size);
> > > >
> > > >      if (ret !=3D size) {
> > > >          goto err;
> > > >      }
> > > >
> > > >      return 0;
> > > > -
> > > >  err:
> > > >      return ret < 0 ? ret : -EIO;
> > > >  }
> > > > @@ -1062,8 +1142,7 @@ static void
> > > > compare_pri_rs_finalize(SocketReadState *pri_rs)
> > > >          compare_chr_send(s,
> > > >                           pri_rs->buf,
> > > >                           pri_rs->packet_len,
> > > > -                         pri_rs->vnet_hdr_len,
> > > > -                         false);
> > > > +                         pri_rs->vnet_hdr_len);
> > > >      } else {
> > > >          /* compare packet in the specified connection */
> > > >          colo_compare_connection(conn, s); @@ -1093,7 +1172,7 @@
> > > > static void compare_notify_rs_finalize(SocketReadState *notify_rs)
> > > >      if (packet_matches_str("COLO_USERSPACE_PROXY_INIT",
> > > >                             notify_rs->buf,
> > > >                             notify_rs->packet_len)) {
> > > > -        ret =3D compare_chr_send(s, (uint8_t *)msg, strlen(msg), 0=
, true);
> > > > +        ret =3D notify_chr_send(s, (uint8_t *)msg, strlen(msg));
> > > >          if (ret < 0) {
> > > >              error_report("Notify Xen COLO-frame INIT failed");
> > > >          }
> > > > @@ -1199,6 +1278,9 @@ static void
> > > > colo_compare_complete(UserCreatable
> > > > *uc, Error **errp)
> > > >
> > > >      QTAILQ_INSERT_TAIL(&net_compares, s, next);
> > > >
> > > > +    s->sendco.done =3D true;
> > > > +    g_queue_init(&s->sendco.send_list);
> > > > +
> > > >      g_queue_init(&s->conn_list);
> > > >
> > > >      qemu_mutex_init(&event_mtx);
> > > > @@ -1224,8 +1306,7 @@ static void colo_flush_packets(void *opaque,
> > > > void
> > > > *user_data)
> > > >          compare_chr_send(s,
> > > >                           pkt->data,
> > > >                           pkt->size,
> > > > -                         pkt->vnet_hdr_len,
> > > > -                         false);
> > > > +                         pkt->vnet_hdr_len);
> > > >          packet_destroy(pkt, NULL);
> > > >      }
> > > >      while (!g_queue_is_empty(&conn->secondary_list)) { @@ -1281,6
> > > > +1362,11 @@ static void colo_compare_finalize(Object *obj)
> > > >      CompareState *s =3D COLO_COMPARE(obj);
> > > >      CompareState *tmp =3D NULL;
> > > >
> > > > +    AioContext *ctx =3D iothread_get_aio_context(s->iothread);
> > > > +    aio_context_acquire(ctx);
> > > > +    AIO_WAIT_WHILE(ctx, !s->sendco.done);
> > > > +    aio_context_release(ctx);
> > > > +
> > > >      qemu_chr_fe_deinit(&s->chr_pri_in, false);
> > > >      qemu_chr_fe_deinit(&s->chr_sec_in, false);
> > > >      qemu_chr_fe_deinit(&s->chr_out, false); @@ -1305,6 +1391,7 @@
> > > > static void colo_compare_finalize(Object *obj)
> > > >      g_queue_foreach(&s->conn_list, colo_flush_packets, s);
> > > >
> > > >      g_queue_clear(&s->conn_list);
> > > > +    g_queue_clear(&s->sendco.send_list);
> > > >
> > > >      if (s->connection_track_table) {
> > > >          g_hash_table_destroy(s->connection_track_table);
> > > > --
> > > > 2.20.1 =20
> > > =20
>=20


--Sig_/U_OzEJjOf=2HFiHY6w1YPBa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl6pMe0ACgkQNasLKJxd
sljlhw//f8TPTl2R3Q1CvhsJtMMXLVZ3jysHmXN6TcjnVn1SMq06XbAUl7Ay23pd
tTw48mpe+EZp2+E43Vq6Q/UUnNTkD+mtwsvqcQhEqVINkRta0MWslvVsqzlUNQsw
W2RX3nL7gCv1sjiV09cmS8zi+B7Lav9O1VaPgSO5C5oNXKp4ExuEmF5Vom20mxkx
dJLJrbJ/UVGitdlsZlYZF0+x6JT059pc/5b2q6Ay6oxTRJ5sF0f17tOIRMgVucPw
ZiFPm8zFqpW9Dyy0PpqlUM7159q37mKX50++qTG6Ew9qh7e/j3pD4Ugh0JsWL3Be
jhQ0XRY4vZhvz2MubYe9OfF5jmd35xQG7USzyN+mYRDAMGYaDE3EFrm5hH+W/GCc
AJlqoKebpm9zmHsRxEHPboxxHbVCb7iW7NkxIuNPf7iHHGCzTT7+cLxljILpQy2q
FDKjPH3NzA6nhuQCfvUwZWjNc2TwAcvIfz2G0yUIyw5lehPTcQJg18SG1F/VqWDt
uJJBicu41r2VEZ5htsT3WHffS1osSAu8K2MDAjD7ZoibvAEn3qagYEMd/00zvJL9
gRk53mjpuBiIvOlh1DOwZHdgJlfIoty5/E70JM9WPtMv0qpV0WatRgDbXKKM0Fxf
EHtGTk3aejDfwdHLVbkN0x4wFFlB2hrlYC2x5qw+yJb/HmTC9AY=
=Gfqx
-----END PGP SIGNATURE-----

--Sig_/U_OzEJjOf=2HFiHY6w1YPBa--

