Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABAEC38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 15:55:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA8FC20659
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 15:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="B+EKfCAZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA8FC20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWirW-0003Iu-QR
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 11:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jWioM-0000kf-Vf
 for qemu-devel@nongnu.org; Thu, 07 May 2020 11:51:46 -0400
Received: from mout.web.de ([212.227.15.3]:51019)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jWioL-0004mz-4D
 for qemu-devel@nongnu.org; Thu, 07 May 2020 11:51:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1588866686;
 bh=8//DoSyclo4nbHJDtfXJ5tq3UeTNQ6qROSeMkC4Ko1Y=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=B+EKfCAZ2UAQNAkzZAFxXLJzRDQhgIITGQyLsnNq+A7Z+DZNhBvFERIIgKCnzG9Yf
 vzfaiD0nDhgNc4gkC4ODTHru2IYN/B5/tAKPk3+b7+PZ/eb2k/CDSbhTceyJk0pbcv
 x5/c2bNLSx4GDjBOii1kU1pnpDW4DDh5+aHoHW6c=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.60]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MlsON-1ipeTm3SHj-00j4v9; Thu, 07
 May 2020 17:51:25 +0200
Date: Thu, 7 May 2020 17:51:07 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: "Zhang, Chen" <chen.zhang@intel.com>
Subject: Re: [PATCH v4 3/6] net/colo-compare.c: Fix deadlock in
 compare_chr_send
Message-ID: <20200507175107.45d5d497@luklap>
In-Reply-To: <c27b4dbdc6834e70b4af738d01f9fae4@intel.com>
References: <cover.1588587700.git.lukasstraub2@web.de>
 <5536749ec95380f18c01789c472324565c060bcc.1588587700.git.lukasstraub2@web.de>
 <c27b4dbdc6834e70b4af738d01f9fae4@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/C=asR51I9Koz/qi5C+./ziu";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:nlM3s8DCDH1KkBxXgz5afp7lwUM5f991OaPkRiPQJl5bGzZegDO
 Zyb2rcCo4CK9Fz3DE8WNnnM50Zfon+ppjfSqwSP/GM4GXZgbP252pogFbTWCFSXm4aGtDAH
 /c1ufmzWL3eA6/SFO9sk9RPeFewSC+zFHp+aSZXjST8EjiqsJReE3siNUhQSpOcmX9ONKDG
 W5XJXOggRcI5rYWRrB+4w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:w92iZs+24og=:slCYtWJ7a58kxNOvV1t/jq
 oMhN76TA7nEy7vSYtNmna1DvhAIkJsHzT35/5EQZ4gmAxp+c4wUGtflRs9eokMDfhiv+67kgh
 koJ918miPf9DxHS9Rgfs+C4blulITyL3wekmh17C6A+zNsrUqB5cNoV+q54ox19xdh19dVCAE
 uFz5JYgctmDSaGN830Bb5VnI1eYXv43d2aWMvVg5Whl4u2mVeOyt4Ck8T5WAMii8LXXnGOwo/
 TySu3uTCTP+1Pnzew2/FyTWMIs/FK9oY2VFyZWaeSRH9Cg7e+tDIscMV1OxwbRNvyTkW9CMNv
 zUURnGHYNTHPa2t6Z3PHaSQWaNqbmrN1jOXz57MDHP2s/aYEakuwWGLqccB+b3LKmJXvzuQ5S
 wr4di0DklKNi83wNzADKg57P6TEV2iEz44NTPxnP8KKcbOt7isY/6hZ+TEY/ECgN2DvcEUD7k
 igVppPQdGJCV6e01keyfHpkB/aX2CoU0lqU57uekp+ZCBIdQXg8sPUuKA1zVkWmWUD9eNz73u
 xfI/Qh/dTbIWQEXypzXghNZgK7uf0kxIgYomcCjZOk6kbwwxJ+JBBJNWNyVlLyUJRJiM4iLYl
 PS536/Hb6U28eMAMN13i8Oj/pBh2rObZnGW8oFCtVjUu26m2q2ASc7PlC8hWhHJg4P0EfbZti
 ITMXIKG5krQGzDvLoCNK5IEM8X6Swu3z6U62HB59zUH6piP6/oIV36uGUtz12hTozYVmFlvcm
 it2UEf1xNSBM9XaxfrZPiDcKS6ftyf5qjSm9QgL58P8rpMEGqWUd7YLZsXuONgxCb7SKmhvWI
 lQL7Z2Ap2gk7vm7/IO8nGEQr1ud6AGTkyXokDHgNgak5p4g/r2vFGeBe5UO4K4vUs6KmY1FZ6
 sLOoPfUIsP10fYdNX6zGcbFEGBpUmJgAAbiQnODR0+4j5lnWxiUXPsF79pwug1fC+tSVqjRDw
 2Rrh2J8+5Mz7dNnQwYwVRtztDI0EJ1Fl14i0jRUqAPQq6/bc4mnfbQwZVN7lwIzwnaV+NkI6Y
 zP8130WGgUQYypZdQ4ugMA+Hjl6D6YjPS/9+maI1WpRShyoJxo1c6u07hmIGq6PLVA+P3RgiN
 GhS90EstlBwREW3aZwjyQYhzyqEx8RKo67oJtGzZOEF3eE39ZVY1D1ntIY9QYcn/dqRH5sL+s
 U5ugZndWrqeJSQa0ZWP+jTXjE845aJau0bLm1iIFMcwLqvdZb/AU3hQ3Cga1Pk0z51EVmnJlp
 6ZUd2GiLPeQQEeCzF
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 11:51:42
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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

--Sig_/C=asR51I9Koz/qi5C+./ziu
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 7 May 2020 11:00:26 +0000
"Zhang, Chen" <chen.zhang@intel.com> wrote:

> > -----Original Message-----
> > From: Lukas Straub <lukasstraub2@web.de>
> > Sent: Monday, May 4, 2020 6:28 PM
> > To: qemu-devel <qemu-devel@nongnu.org>
> > Cc: Zhang, Chen <chen.zhang@intel.com>; Li Zhijian=20
> > <lizhijian@cn.fujitsu.com>; Jason Wang <jasowang@redhat.com>; Marc-=20
> > Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>; Paolo Bonzini=20
> > <pbonzini@redhat.com>
> > Subject: [PATCH v4 3/6] net/colo-compare.c: Fix deadlock in=20
> > compare_chr_send
> >=20
> > The chr_out chardev is connected to a filter-redirector running in the=
=20
> > main loop. qemu_chr_fe_write_all might block here in compare_chr_send=20
> > if the (socket-)buffer is full.
> > If another filter-redirector in the main loop want's to send data to=20
> > chr_pri_in it might also block if the buffer is full. This leads to a=20
> > deadlock because both event loops get blocked.
> >=20
> > Fix this by converting compare_chr_send to a coroutine and putting the=
=20
> > packets in a send queue.
> >=20
> > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > ---
> >  net/colo-compare.c | 187 ++++++++++++++++++++++++++++++++++-------
> > ----
> >  net/colo.c         |   7 ++
> >  net/colo.h         |   1 +
> >  3 files changed, 150 insertions(+), 45 deletions(-)
> >=20
> > diff --git a/net/colo-compare.c b/net/colo-compare.c index=20
> > 1de4220fe2..2a4e7f7c4e 100644
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
> > +80,23 @@ static int event_unhandled_count;
> >   *                    |packet  |  |packet  +    |packet  | |packet  +
> >   *                    +--------+  +--------+    +--------+ +--------+
> >   */
> > +
> > +typedef struct SendCo {
> > +    Coroutine *co;
> > +    struct CompareState *s;
> > +    CharBackend *chr;
> > +    GQueue send_list;
> > +    bool notify_remote_frame;
> > +    bool done;
> > +    int ret;
> > +} SendCo;
> > +
> > +typedef struct SendEntry {
> > +    uint32_t size;
> > +    uint32_t vnet_hdr_len;
> > +    uint8_t *buf;
> > +} SendEntry;
> > +
> >  typedef struct CompareState {
> >      Object parent;
> >=20
> > @@ -91,6 +111,8 @@ typedef struct CompareState {
> >      SocketReadState pri_rs;
> >      SocketReadState sec_rs;
> >      SocketReadState notify_rs;
> > +    SendCo out_sendco;
> > +    SendCo notify_sendco;
> >      bool vnet_hdr;
> >      uint32_t compare_timeout;
> >      uint32_t expired_scan_cycle;
> > @@ -124,10 +146,11 @@ enum {
> >=20
> >=20
> >  static int compare_chr_send(CompareState *s,
> > -                            const uint8_t *buf,
> > +                            uint8_t *buf,
> >                              uint32_t size,
> >                              uint32_t vnet_hdr_len,
> > -                            bool notify_remote_frame);
> > +                            bool notify_remote_frame,
> > +                            bool zero_copy);
> >=20
> >  static bool packet_matches_str(const char *str,
> >                                 const uint8_t *buf, @@ -145,7 +168,7=20
> > @@ static void notify_remote_frame(CompareState *s)
> >      char msg[] =3D "DO_CHECKPOINT";
> >      int ret =3D 0;
> >=20
> > -    ret =3D compare_chr_send(s, (uint8_t *)msg, strlen(msg), 0, true);
> > +    ret =3D compare_chr_send(s, (uint8_t *)msg, strlen(msg), 0, true,=
=20
> > + false);
> >      if (ret < 0) {
> >          error_report("Notify Xen COLO-frame failed");
> >      }
> > @@ -272,12 +295,13 @@ static void
> > colo_release_primary_pkt(CompareState *s, Packet *pkt)
> >                             pkt->data,
> >                             pkt->size,
> >                             pkt->vnet_hdr_len,
> > -                           false);
> > +                           false,
> > +                           true);
> >      if (ret < 0) {
> >          error_report("colo send primary packet failed");
> >      }
> >      trace_colo_compare_main("packet same and release packet");
> > -    packet_destroy(pkt, NULL);
> > +    packet_destroy_partial(pkt, NULL);
> >  }
> >=20
> >  /*
> > @@ -699,65 +723,115 @@ static void colo_compare_connection(void=20
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
> > +    SendCo *sendco =3D opaque;
> > +    CompareState *s =3D sendco->s;
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
> > -        ret =3D qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)&len, si=
zeof(len));
> > -    }
> > +        ret =3D qemu_chr_fe_write_all(sendco->chr, (uint8_t *)&len,=20
> > + sizeof(len));
> >=20
> > -    if (ret !=3D sizeof(len)) {
> > -        goto err;
> > -    }
> > +        if (ret !=3D sizeof(len)) {
> > +            g_free(entry->buf);
> > +            g_slice_free(SendEntry, entry);
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
> > +        if (!sendco->notify_remote_frame && s->vnet_hdr) {
> > +            /*
> > +             * We send vnet header len make other module(like filter-r=
edirector)
> > +             * know how to parse net packet correctly.
> > +             */
> > +            len =3D htonl(entry->vnet_hdr_len);
> >=20
> > -        if (!notify_remote_frame) {
> > -            ret =3D qemu_chr_fe_write_all(&s->chr_out,
> > +            ret =3D qemu_chr_fe_write_all(sendco->chr,
> >                                          (uint8_t *)&len,
> >                                          sizeof(len));
> > +
> > +            if (ret !=3D sizeof(len)) {
> > +                g_free(entry->buf);
> > +                g_slice_free(SendEntry, entry);
> > +                goto err;
> > +            }
> >          }
> >=20
> > -        if (ret !=3D sizeof(len)) {
> > +        ret =3D qemu_chr_fe_write_all(sendco->chr,
> > +                                    (uint8_t *)entry->buf,
> > +                                    entry->size);
> > +
> > +        if (ret !=3D entry->size) {
> > +            g_free(entry->buf);
> > +            g_slice_free(SendEntry, entry);
> >              goto err;
> >          }
> > +
> > +        g_free(entry->buf);
> > +        g_slice_free(SendEntry, entry);
> >      }
> >=20
> > +    sendco->ret =3D 0;
> > +    goto out;
> > +
> > +err:
> > +    while (!g_queue_is_empty(&sendco->send_list)) {
> > +        SendEntry *entry =3D g_queue_pop_tail(&sendco->send_list);
> > +        g_free(entry->buf);
> > +        g_slice_free(SendEntry, entry);
> > +    }
> > +    sendco->ret =3D ret < 0 ? ret : -EIO;
> > +out:
> > +    sendco->co =3D NULL;
> > +    sendco->done =3D true;
> > +    aio_wait_kick();
> > +}
> > +
> > +static int compare_chr_send(CompareState *s,
> > +                            uint8_t *buf,
> > +                            uint32_t size,
> > +                            uint32_t vnet_hdr_len,
> > +                            bool notify_remote_frame,
> > +                            bool zero_copy) {
> > +    SendCo *sendco;
> > +    SendEntry *entry;
> > +
> >      if (notify_remote_frame) {
> > -        ret =3D qemu_chr_fe_write_all(&s->chr_notify_dev,
> > -                                    (uint8_t *)buf,
> > -                                    size);
> > +        sendco =3D &s->notify_sendco;
> >      } else {
> > -        ret =3D qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)buf, siz=
e);
> > +        sendco =3D &s->out_sendco;
> >      }
> >=20
> > -    if (ret !=3D size) {
> > -        goto err;
> > +    if (!size) {
> > +        return 0;
> >      }
> >=20
> > -    return 0;
> > +    entry =3D g_slice_new(SendEntry);
> > +    entry->size =3D size;
> > +    entry->vnet_hdr_len =3D vnet_hdr_len;
> > +    if (zero_copy) {
> > +        entry->buf =3D buf;
> > +    } else {
> > +        entry->buf =3D g_malloc(size);
> > +        memcpy(entry->buf, buf, size);
> > +    }
> > +    g_queue_push_head(&sendco->send_list, entry);
> > +
> > +    if (sendco->done) {
> > +        sendco->co =3D qemu_coroutine_create(_compare_chr_send, sendco=
);
> > +        sendco->done =3D false;
> > +        qemu_coroutine_enter(sendco->co);
> > +        if (sendco->done) {
> > +            /* report early errors */
> > +            return sendco->ret;
> > +        }
> > +    }
> >=20
> > -err:
> > -    return ret < 0 ? ret : -EIO;
> > +    /* assume success */
> > +    return 0;
> >  }
> >=20
> >  static int compare_chr_can_read(void *opaque) @@ -1063,6 +1137,7 @@=20
> > static void compare_pri_rs_finalize(SocketReadState *pri_rs)
> >                           pri_rs->buf,
> >                           pri_rs->packet_len,
> >                           pri_rs->vnet_hdr_len,
> > +                         false,
> >                           false);
> >      } else {
> >          /* compare packet in the specified connection */ @@ -1093,7
> > +1168,7 @@ static void compare_notify_rs_finalize(SocketReadState
> > +*notify_rs)
> >      if (packet_matches_str("COLO_USERSPACE_PROXY_INIT",
> >                             notify_rs->buf,
> >                             notify_rs->packet_len)) {
> > -        ret =3D compare_chr_send(s, (uint8_t *)msg, strlen(msg), 0, tr=
ue);
> > +        ret =3D compare_chr_send(s, (uint8_t *)msg, strlen(msg), 0,=20
> > + true, false);
> >          if (ret < 0) {
> >              error_report("Notify Xen COLO-frame INIT failed");
> >          }
> > @@ -1199,6 +1274,18 @@ static void
> > colo_compare_complete(UserCreatable *uc, Error **errp)
> >=20
> >      QTAILQ_INSERT_TAIL(&net_compares, s, next);
> >=20
> > +    s->out_sendco.s =3D s;
> > +    s->out_sendco.chr =3D &s->chr_out;
> > +    s->out_sendco.notify_remote_frame =3D false;
> > +    s->out_sendco.done =3D true;
> > +    g_queue_init(&s->out_sendco.send_list);
> > +
> > +    s->notify_sendco.s =3D s;
> > +    s->notify_sendco.chr =3D &s->chr_notify_dev;
> > +    s->notify_sendco.notify_remote_frame =3D true;
> > +    s->notify_sendco.done =3D true;
> > +    g_queue_init(&s->notify_sendco.send_list);
> > + =20
>=20
> No need to init the notify_sendco each time, because the notify dev just =
an optional parameter.
> You can use the if (s->notify_dev) here. Just Xen use the chr_notify_dev.

Ok, I will change that and the code below in the next version.

> Overall, make the chr_send job to coroutine is a good idea. It looks good=
 for me.
> And your patch inspired me, it looks we can re-use the compare_chr_send c=
ode on filter mirror/redirector too.

I already have patch for that, but I don't think it is a good idea, because=
 the guest then can send packets faster than colo-compare can process. This=
 leads bufferbloat and the performance drops in my tests:
Client-to-server tcp:
without patch: ~66 Mbit/s
with patch: ~59 Mbit/s
Server-to-client tcp:
without patch: ~702 Kbit/s
with patch: ~328 Kbit/s

Regards,
Lukas Straub

> Tested-by: Zhang Chen <chen.zhang@intel.com>
>=20
>=20
> >      g_queue_init(&s->conn_list);
> >=20
> >      qemu_mutex_init(&event_mtx);
> > @@ -1225,8 +1312,9 @@ static void colo_flush_packets(void *opaque,=20
> > void
> > *user_data)
> >                           pkt->data,
> >                           pkt->size,
> >                           pkt->vnet_hdr_len,
> > -                         false);
> > -        packet_destroy(pkt, NULL);
> > +                         false,
> > +                         true);
> > +        packet_destroy_partial(pkt, NULL);
> >      }
> >      while (!g_queue_is_empty(&conn->secondary_list)) {
> >          pkt =3D g_queue_pop_head(&conn->secondary_list);
> > @@ -1301,10 +1389,19 @@ static void colo_compare_finalize(Object *obj)
> >          }
> >      }
> >=20
> > +    AioContext *ctx =3D iothread_get_aio_context(s->iothread);
> > +    aio_context_acquire(ctx);
> > +    AIO_WAIT_WHILE(ctx, !s->out_sendco.done);
> > +    AIO_WAIT_WHILE(ctx, !s->notify_sendco.done); =20
>=20
> Same as above.
>=20
> > +    aio_context_release(ctx);
> > +
> >      /* Release all unhandled packets after compare thead exited */
> >      g_queue_foreach(&s->conn_list, colo_flush_packets, s);
> > +    AIO_WAIT_WHILE(NULL, !s->out_sendco.done);
> >=20
> >      g_queue_clear(&s->conn_list);
> > +    g_queue_clear(&s->out_sendco.send_list);
> > +    g_queue_clear(&s->notify_sendco.send_list); =20
>=20
> Same as above.
>=20
> >=20
> >      if (s->connection_track_table) {
> >          g_hash_table_destroy(s->connection_track_table);
> > diff --git a/net/colo.c b/net/colo.c
> > index 8196b35837..a6c66d829a 100644
> > --- a/net/colo.c
> > +++ b/net/colo.c
> > @@ -185,6 +185,13 @@ void packet_destroy(void *opaque, void *user_data)
> >      g_slice_free(Packet, pkt);
> >  }
> >=20
> > +void packet_destroy_partial(void *opaque, void *user_data) {
> > +    Packet *pkt =3D opaque;
> > +
> > +    g_slice_free(Packet, pkt);
> > +}
> > +
> >  /*
> >   * Clear hashtable, stop this hash growing really huge
> >   */
> > diff --git a/net/colo.h b/net/colo.h
> > index 679314b1ca..573ab91785 100644
> > --- a/net/colo.h
> > +++ b/net/colo.h
> > @@ -102,5 +102,6 @@ bool connection_has_tracked(GHashTable=20
> > *connection_track_table,  void connection_hashtable_reset(GHashTable
> > *connection_track_table);  Packet *packet_new(const void *data, int=20
> > size, int vnet_hdr_len);  void packet_destroy(void *opaque, void=20
> > *user_data);
> > +void packet_destroy_partial(void *opaque, void *user_data);
> >=20
> >  #endif /* NET_COLO_H */
> > --
> > 2.20.1 =20
>=20


--Sig_/C=asR51I9Koz/qi5C+./ziu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl60LmsACgkQNasLKJxd
slir9w//YO0mtpjJiFOiBv4xnGpT5k861PD22LlhAmBGpuu/Ga1obxq7CRlkTIsS
69DCCdxsyDxKC/ojeoLOxeEYu8k1XeOZO5Ns8UVPGsumbtUjQttdS1VZhMtUH+VK
E7MljPgfrDxwO0U3X8MvXf67fyHBdz1OPfyvAZunUlXwYeUnnLRd0bS4NI484DOF
ZbKka+PhSVT2+7cnZnzSWKzBJ16WTf8PySY5RepOqSloynh7pPvnFZKnvtPmvkxr
z3zB2ghf1N5GFbYSs4FmmVzaU+f3UZ/WHI+AYMiaiWbEyYDH3Ob0BSZvU231ILMd
7jXJc2wLVz0lGgcXmSwzEqyIQvnjE3LwVTsYT33ji0/YjLDdOeI/fAdzn+NGLdrY
6Qs7nQgttBRV8swA6epE7L8RwXfNjGtEEZRdMXzwNqwjy9hothG+q8pcI8GFJiCT
2XdmEKFRs/c4RLLPPBszTPukOWr1/JFpROcA2qrkguxDgPK869A6fTg/yFJKJMsu
2Cv8Yt/PIRzhrpiHBKzsZZqn2q/6b90fvjHwv9X0Gbr0lrcpsfvJVIhFvFMCwiOg
01hwJwUSghg196cU+O3+QuZPEIcNqnL5NemIPWT5zbNuPWuINsJaEz+M535XHNT8
OAZxApkGfaGgMBM2RwbxEeVOzl4WPO/4RyGLabxQaWjKvf9+Qto=
=p01D
-----END PGP SIGNATURE-----

--Sig_/C=asR51I9Koz/qi5C+./ziu--

