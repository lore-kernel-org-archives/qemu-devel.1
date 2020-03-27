Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BFEC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:33:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5381B20737
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="ErF2kQPl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5381B20737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHtn7-0003IW-4O
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 14:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43386)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jHtio-0002fK-BJ
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:28:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1jHtim-0001cR-Uy
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:28:46 -0400
Received: from mout.web.de ([212.227.17.11]:46545)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1jHtim-0001bU-HH
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:28:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1585333696;
 bh=qob3+YCwO4A8KmOzFMnt914xc3pti955IR5mYwhB14U=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=ErF2kQPl+rc6VQC4+LtKZUhVN7CtWuuiV4TdLezpTGnx7m3pRRumPvN42XeDRZOFE
 nL0OS5O5JglCtOt6L5t2SUtXWSMBUEklCRYguVGA8ypoqzwk/ULtd3oQhgzA+XqNDm
 T4XSw9FDO5lr0NeAhbgJLQndVMxVWmR4rzcw8sVM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.1]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LyUgM-1jKlUc2Ar8-015rnE; Fri, 27
 Mar 2020 19:28:16 +0100
Date: Fri, 27 Mar 2020 19:28:07 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: Derek Su <jwsu1986@gmail.com>
Subject: Re: [PATCH v3 2/2] net/colo-compare.c: handling of the full primary
 or secondary queue
Message-ID: <20200327192807.121412ab@luklap>
In-Reply-To: <CAFKS8hUUC4LCDJDdRmiHXa2VHdhrcytJGyXFFxz85h4p1hiJRw@mail.gmail.com>
References: <20200325094354.19677-1-dereksu@qnap.com>
 <20200325094354.19677-3-dereksu@qnap.com>
 <20200327184549.3802f959@luklap>
 <CAFKS8hUUC4LCDJDdRmiHXa2VHdhrcytJGyXFFxz85h4p1hiJRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/agWQaIwuM4wNECznfh0ZGXb";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:08TkCdWPEw6dIcuOyXMSgoxW0aHWfDFLYXjH6/LI3HaXHVV87mW
 hCS/Vi17TasP4e+vJtUe36u5EfSlH4ca9iMa426xGuWajwQij8MNHJOzP3RAUfl6liuJT7p
 GSBlAn59uhHv+bD9kqB5Cl6Mgwj68mI/43oWEm6ouikka73/u1OHy1W0ngk5oMUKWVtdEM7
 78NzP6n00Df+hBQQLCKRg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/pFDlUHs6IQ=:db8tUAdsjJaQHZEgTM3rnV
 so01umYz1BoEAwrLGySCfvWBF51KF5BuY+JzfdjdFUCid5xJ9GjzxvuyQ13QyzPp/pIxzROKq
 i0rb8/2oNeLxWrRaRAuSRyvNi1qWFI2sG9LJiqCA4URzGw+24YVBUfNVvYfDrkfbwvk67+pVY
 mnCpDVzwHKdAFEkvU0+4FvFysiSzQU5ONLwuUi9FuxjLZVEq6+RhyVrVBz0saUVdkd/Rld7L9
 BUcsXHLa/5l7uwXKgTlQrmIT8T6hLEAH4yTXPTKmEywKsW7f70mSU82cCBmRzgdqGHm/Do9D1
 +ICu1kFoc5T6NNI3z9YKQhKatmAb5ydURTWk1umX8Zh9N6hlopDjhzf0BbAfiyHPr/t2pUGcU
 j0DNHc+x7xGMPY8zWD6PvYfXNLuqBtmoKMb5EG++60EvXUH54Y7/dPyBQa+keWu2f7ak/xycj
 9E3Zg0a9L77A5lsYGJv9PbG+4eQUy5OnvIv2ot8qT2+hP3CxjOyv2eEkQtRvX4K8X70tnkVwj
 k3VKnP/vujX5oNFzn9QZIzFmGA8lzwUY7D04VJ7XKanM0MO7Pn7aVQnRg2mJeWHVb8EA3algx
 WsbaEatTz+jzyxBt+czUV8gojP/Qt6MkhWe2cN93rz2GE42Nyc3ENWTbivVjiWaQvS84rJoMk
 UPnFwmXmT433rQ/R5vmZlp+SWicYXfs+89e+dUwpt7/Uot2+NadMDoOJ4ZFe9ESNTK3WVZ6so
 yXDyVpRZUAnDNFaL+7smVTbyqQXWCdJ/C8oQj57gAL+/pb93gYb73cML0EfbRze2Raqa1aBJ1
 DxBXS25QshwZkbQyFFSvk2OqWut/t3W2lk9s7N5kb72cQPKFj3tGUwhFC3Njs2wh/EwkRcWRy
 m5+VG3r46j8DBjI2fB6q+h0blhwkcWhnlt0ACVwsefQ6qIjGwO2sL45s9iWo9iDVLQ9xnvqEc
 80Ejgusiv5YcU3IZvbeSI/X62RlMBBOvFGwfjzQ6gZkLrP/8xrCO/1M1PEhrX95xv9p4+jJHE
 yfDCQKJPNA/dZMER6V9+V+LevEi4J6yPxq+IngVNiEV5WVPfKfqdsu8Q1ubltERTrCU4FPckk
 PGQAbSXWJjiuV+IQoG7u769zantgoyg0i6CnwHvFuE4X9xtxWyXHC/Z+1x9IqkfU8aAVhxet6
 OBrp9qTo5lgm8APDZVERxtCnGGYUFyHfXwzwNDHa8MMPjuwSYRknzcPLY9e+1t+t4gbWRp38r
 n0+r9Afn/h2tLLeYP
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.11
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
Cc: lizhijian@cn.fujitsu.com, chyang@qnap.com, Derek Su <dereksu@qnap.com>,
 jasowang@redhat.com, qemu-devel@nongnu.org, ctcheng@qnap.com, "Zhang,
 Chen" <chen.zhang@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/agWQaIwuM4wNECznfh0ZGXb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 28 Mar 2020 02:20:21 +0800
Derek Su <jwsu1986@gmail.com> wrote:

> Lukas Straub <lukasstraub2@web.de> =E6=96=BC 2020=E5=B9=B43=E6=9C=8828=E6=
=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=881:46=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > On Wed, 25 Mar 2020 17:43:54 +0800
> > Derek Su <dereksu@qnap.com> wrote:
> > =20
> > > The pervious handling of the full primary or queue is only dropping
> > > the packet. If there are lots of clients to the guest VM,
> > > the "drop" will lead to the lost of the networking connection
> > > until next checkpoint.
> > >
> > > To address the issue, this patch drops the packet firstly.
> > > Then, send all queued primary packets, remove all queued secondary
> > > packets and do checkpoint.
> > >
> > > Signed-off-by: Derek Su <dereksu@qnap.com>
> > > ---
> > >  net/colo-compare.c | 41 ++++++++++++++++++++++++++++++-----------
> > >  1 file changed, 30 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/net/colo-compare.c b/net/colo-compare.c
> > > index cdd87b2aa8..1a52f50fbe 100644
> > > --- a/net/colo-compare.c
> > > +++ b/net/colo-compare.c
> > > @@ -125,6 +125,12 @@ static const char *colo_mode[] =3D {
> > >      [SECONDARY_IN] =3D "secondary",
> > >  };
> > >
> > > +enum {
> > > +    QUEUE_INSERT_ERR =3D -1,
> > > +    QUEUE_INSERT_OK =3D 0,
> > > +    QUEUE_INSERT_FULL =3D 1,
> > > +};
> > > +
> > >  static int compare_chr_send(CompareState *s,
> > >                              const uint8_t *buf,
> > >                              uint32_t size,
> > > @@ -211,8 +217,10 @@ static int colo_insert_packet(GQueue *queue, Pac=
ket *pkt, uint32_t *max_ack)
> > >  }
> > >
> > >  /*
> > > - * Return 0 on success, if return -1 means the pkt
> > > - * is unsupported(arp and ipv6) and will be sent later
> > > + * Return QUEUE_INSERT_OK on success.
> > > + * If return QUEUE_INSERT_FULL means list is full, and
> > > + * QUEUE_INSERT_ERR means the pkt is unsupported(arp and ipv6) and
> > > + * will be sent later
> > >   */
> > >  static int packet_enqueue(CompareState *s, int mode, Connection **co=
n)
> > >  {
> > > @@ -234,7 +242,7 @@ static int packet_enqueue(CompareState *s, int mo=
de, Connection **con)
> > >      if (parse_packet_early(pkt)) {
> > >          packet_destroy(pkt, NULL);
> > >          pkt =3D NULL;
> > > -        return -1;
> > > +        return QUEUE_INSERT_ERR;
> > >      }
> > >      fill_connection_key(pkt, &key);
> > >
> > > @@ -258,11 +266,12 @@ static int packet_enqueue(CompareState *s, int =
mode, Connection **con)
> > >                       "drop packet", colo_mode[mode]);
> > >          packet_destroy(pkt, NULL);
> > >          pkt =3D NULL;
> > > +        return QUEUE_INSERT_FULL;
> > >      }
> > >
> > >      *con =3D conn;
> > >
> > > -    return 0;
> > > +    return QUEUE_INSERT_OK;
> > >  }
> > >
> > >  static inline bool after(uint32_t seq1, uint32_t seq2)
> > > @@ -995,17 +1004,22 @@ static void compare_pri_rs_finalize(SocketRead=
State *pri_rs)
> > >  {
> > >      CompareState *s =3D container_of(pri_rs, CompareState, pri_rs);
> > >      Connection *conn =3D NULL;
> > > +    int ret;
> > >
> > > -    if (packet_enqueue(s, PRIMARY_IN, &conn)) {
> > > +    ret =3D packet_enqueue(s, PRIMARY_IN, &conn);
> > > +    if (ret =3D=3D QUEUE_INSERT_OK) {
> > > +        /* compare packet in the specified connection */
> > > +        colo_compare_connection(conn, s);
> > > +    } else if (ret =3D=3D QUEUE_INSERT_FULL) {
> > > +        g_queue_foreach(&s->conn_list, colo_flush_packets, s);
> > > +        colo_compare_inconsistency_notify(s);
> > > +    } else {
> > >          trace_colo_compare_main("primary: unsupported packet in");
> > >          compare_chr_send(s,
> > >                           pri_rs->buf,
> > >                           pri_rs->packet_len,
> > >                           pri_rs->vnet_hdr_len,
> > >                           false);
> > > -    } else {
> > > -        /* compare packet in the specified connection */
> > > -        colo_compare_connection(conn, s);
> > >      }
> > >  }
> > >
> > > @@ -1013,12 +1027,17 @@ static void compare_sec_rs_finalize(SocketRea=
dState *sec_rs)
> > >  {
> > >      CompareState *s =3D container_of(sec_rs, CompareState, sec_rs);
> > >      Connection *conn =3D NULL;
> > > +    int ret;
> > >
> > > -    if (packet_enqueue(s, SECONDARY_IN, &conn)) {
> > > -        trace_colo_compare_main("secondary: unsupported packet in");
> > > -    } else {
> > > +    ret =3D packet_enqueue(s, SECONDARY_IN, &conn);
> > > +    if (ret =3D=3D QUEUE_INSERT_OK) {
> > >          /* compare packet in the specified connection */
> > >          colo_compare_connection(conn, s);
> > > +    } else if (ret =3D=3D QUEUE_INSERT_FULL) {
> > > +        g_queue_foreach(&s->conn_list, colo_flush_packets, s);
> > > +        colo_compare_inconsistency_notify(s);
> > > +    } else {
> > > +        trace_colo_compare_main("secondary: unsupported packet in");
> > >      }
> > >  }
> > > =20
> >
> > Hi,
> > I don't think we have to flush here because the (post-)checkpoint event=
 will flush the packets for us.
> > =20
>=20
> Hi,
> Yes, the periodical checkpoint can flush the packets.
>=20
> But, if many clients send many packets to the vm,
> there is a high probability that packets are dropped because the
> primary/secondary queues are always full.
> It causes lots of re-transmission between clients and vm and
> deteriorate service response to clients.
>=20
> Sincerely,
> Derek Su

I mean that we can still initiate a checkpoint here, but not do the flushin=
g here.

Regards,
Lukas Straub

> > Regards,
> > Lukas Straub =20


--Sig_/agWQaIwuM4wNECznfh0ZGXb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl5+RbcACgkQNasLKJxd
slg0+A//edDlwRkLEbI3gx6S0g2YhNShU6tKkeAHc+iKrtBj2O9uPKZejXZXuV14
hdpw1co8Zf9sEy+EOjtP96N58pjldzgk2gD0/Ndb/TONs4wT0ucKoX+OMSgl5YLS
9BHFUQhHcDqDkrEQQW+Ybprhhki3JdazdNfbCG+9+uppzf7BqoTr7F0oDC25E6NQ
HYlvwtuCDPobAZDE8bNX7anqwsmp0Bp3PTkqfilHweIpHuWVB0g1rmhqMX2xBpJZ
uoCbgZlkziwJtjf1WIDY84AVpe2IrK6mIWCFUhzWupcn+qYgIIJqD44ntJvKcS1+
hLvpeKrp+jV2N1dNpWf+rH2I/uUHrfytYXSRL75QMJiMJ0zjYZlj1f4D6JLeyFoy
xHGLm31nGBRciWUp72lFX8i5lQQh4lCS5Ibv6kiq+ELSKxM8R+ERsuO40fQLO0kr
+TRRTgQtU9QvtnabbU2SUEIivxchD6DFeEnb6q06vxHb7QXvkdnjpvqsnsV7H0+Y
q9kAh5pDR2yDVBuY1ea4tfTNC8kC9DqKMyI3L0tK34Hih6ITUR2oWkVOwVsWLuXH
t+5kSmI6fISSoVTOPfmQUmImMRnGVUW1hnYuGTsGPR0515CRxN6aK9GXfYgDDt8u
4gisfqWiK8f5pxjQZhnworqicHEBg66ZGVa/d4qXhwd0Ghxdtfk=
=Crfs
-----END PGP SIGNATURE-----

--Sig_/agWQaIwuM4wNECznfh0ZGXb--

