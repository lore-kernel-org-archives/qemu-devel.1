Return-Path: <SRS0=nktx=5V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F88C2BA19
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2020 22:24:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABFA420678
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2020 22:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="JWAPv4i9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABFA420678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLDhB-0001hj-Im
	for qemu-devel@archiver.kernel.org; Sun, 05 Apr 2020 18:24:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59895)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jLDYp-0000L0-Nc
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 18:16:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1jLDYo-0008NN-KK
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 18:16:11 -0400
Received: from mout.web.de ([212.227.15.4]:40549)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1jLDYo-0008JA-7P
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 18:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1586124953;
 bh=JXYMp8pazXI11hd0+Q9TK6emGBgKfWYw0VD4QGWIcaE=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=JWAPv4i93m6oeTkvfVmuab3DqLMyqcbBI1Jvqu3BVznQN63VOSIFP2B5fjjSDMSId
 0SQ6Ozmm71A0Q6SZ0NmgckNGq/99qtxrnE+4XkDxhW/PvxTR+Hxus7AnPXhdAsGRLn
 5zJyLUP26ZqQ1gKwDjh0r1xkw0fCLymT+advCYf4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.247]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MKrC4-1jLDYX21Oy-0001qv; Mon, 06
 Apr 2020 00:15:53 +0200
Date: Mon, 6 Apr 2020 00:12:05 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Derek Su <dereksu@qnap.com>
Subject: Re: [PATCH v4 1/2] net/colo-compare.c: Fix memory leak in
 packet_enqueue()
Message-ID: <20200406001205.14e986d3@luklap>
In-Reply-To: <20200328124646.7778-2-dereksu@qnap.com>
References: <20200328124646.7778-1-dereksu@qnap.com>
 <20200328124646.7778-2-dereksu@qnap.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/25roaMhot7+K6hCCq2vhIpe";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:/qGJ4rcHCOSCEre8RXoE7m5GHcZhPtrx6L7UwS757OE+8gsiKTp
 2tiIadxdx6d1u8K72vklqwfBYHrNuWl2K6cHlJUt5t8ZFHkVXQL36AU4fBIubX5v3zqhWb3
 Ki1Pntw6lNgvE3wwjmXgDQWjyMI1CNK6CoG6Z5eRpj+jrIzPIloBwQ3y/SKZYWN9+/y5N8v
 J+KnARrr6enrOb6UhRtdg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RQavvZzAlP4=:8IeD0OHPAUIId9U9KIgKgP
 ybiv+ysZrxaHELCKIWvHp64SAv/AQOruFEnhh4LE1zdV8ty4xKdYcWh8cIHU/E3qKEBsAv0jV
 iy0JkANifUOLVzTdlvlgl8tSwGVXGHe95NpMDoRPuLjOzl9wOBy9XJTYDRpvYvJWShepYu3ll
 QxBIjjLhx2Aj5QMEQxhK9mFOwSBvDxrv+6DTWih4RAtpaoNRDHuydBZ1bHTU5fhS0/gD2BdVi
 zRd1Jl0yPp/5FrU5JTP7VmZWRkAcrnEG5QytOMa60PuKnXZCW6SDnXBBGKR3DOZ11NzldkzQ7
 1rwQjQX35cioXzyeITkE4GM8wqAAVuuTe3ppPQDt9AT6Xxs5kuf4vGE455BzYEkRIinmaYvGk
 MMdBBC27wS/CZx9wjWsnA+cRfzJaCWyLLQba/K/rZoWllk5Z8jaFvFeeYnUgt9s7ZcxAaBpf0
 FiaTvhGVa28fkj80nC+A5PsR69c504vmEixjzADXFzV1enTcuvcH9xtS5CyvAQKYyJLpDwd7k
 Xqc8DWGaM9mw+X5tRzh0RvyW+dFVX6Qw/t+yRMTMwo+KJoglA2PEc3PO1xaviYAq0aozfMk3b
 Qx/yver8b6uNtdvc3oEWNLG93HieP7Wt7sZ51SZgN/ESuMuBpIfqiZXhC+PGyC3HtTkDSUtG0
 keyM/4R5s3EY1nj1cpxS+vX387wA0HdTxNSJNxrNhLiGxT0OtaDBZBEuX7iEm8gbvyQ1VE10c
 7nFj5wyOYUN2pz7fYLQsetmT9n99hg/fliZzCD2uEKNahNsTGdX/Z2hBL9Qy0DG8xv0dtOUdH
 cCdaBD/ExdICSc+D47vbuEJ3jqFxsTd5F6hPTOUF1rPs6MLRiHCArCqjVZf+gFh5yMK9seOOH
 bZneodIJ/9MwWslp8DY9jQAXbLjfh0GCdtL7R+2fgN02uz+pteqer9IfZjIj8PlxRPY1cuqv/
 vDK1MVW6IAfzKdclYPl7CR9AC4F65Lx3ndxtqIgvLJVlOMbx9RAfEbZLgdJeTv4Yt4nKF/FbH
 h50S5cxwex1/ijqsUR61sqtL5NebqrHjhiLhe76+ZU50kjNrZsYZazKe6JlW3t7nYCHNoKHAP
 qUyK84X9U58RtKoQ9AgNMtnNYf4Nj4eRhRPR1TXKnMuvjalM6+5ora/YLnV/47bViaxvlzwR9
 BhoxQney4EuU9YwB8xEdaDycZIiy0uo9p3XVIcS7G7VCZSEHAEVeJnGYeLL+KrSxydZ/ghuv0
 ATm8/0C9jatfXH8Bh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.4
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
Cc: lizhijian@cn.fujitsu.com, chyang@qnap.com, jasowang@redhat.com,
 qemu-devel@nongnu.org, ctcheng@qnap.com, chen.zhang@intel.com,
 jwsu1986@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/25roaMhot7+K6hCCq2vhIpe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 28 Mar 2020 20:46:45 +0800
Derek Su <dereksu@qnap.com> wrote:

> The patch is to fix the "pkt" memory leak in packet_enqueue().
> The allocated "pkt" needs to be freed if the colo compare
> primary or secondary queue is too big.
>=20
> Signed-off-by: Derek Su <dereksu@qnap.com>

Looks good and works well in my tests.
Reviewed-by: Lukas Straub <lukasstraub2@web.de>
Tested-by: Lukas Straub <lukasstraub2@web.de>

Regards,
Lukas Straub

> ---
>  net/colo-compare.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>=20
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index 7ee17f2cf8..cdd87b2aa8 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -120,6 +120,10 @@ enum {
>      SECONDARY_IN,
>  };
> =20
> +static const char *colo_mode[] =3D {
> +    [PRIMARY_IN] =3D "primary",
> +    [SECONDARY_IN] =3D "secondary",
> +};
> =20
>  static int compare_chr_send(CompareState *s,
>                              const uint8_t *buf,
> @@ -215,6 +219,7 @@ static int packet_enqueue(CompareState *s, int mode, =
Connection **con)
>      ConnectionKey key;
>      Packet *pkt =3D NULL;
>      Connection *conn;
> +    int ret;
> =20
>      if (mode =3D=3D PRIMARY_IN) {
>          pkt =3D packet_new(s->pri_rs.buf,
> @@ -243,16 +248,18 @@ static int packet_enqueue(CompareState *s, int mode=
, Connection **con)
>      }
> =20
>      if (mode =3D=3D PRIMARY_IN) {
> -        if (!colo_insert_packet(&conn->primary_list, pkt, &conn->pack)) {
> -            error_report("colo compare primary queue size too big,"
> -                         "drop packet");
> -        }
> +        ret =3D colo_insert_packet(&conn->primary_list, pkt, &conn->pack=
);
>      } else {
> -        if (!colo_insert_packet(&conn->secondary_list, pkt, &conn->sack)=
) {
> -            error_report("colo compare secondary queue size too big,"
> -                         "drop packet");
> -        }
> +        ret =3D colo_insert_packet(&conn->secondary_list, pkt, &conn->sa=
ck);
>      }
> +
> +    if (!ret) {
> +        error_report("colo compare %s queue size too big,"
> +                     "drop packet", colo_mode[mode]);
> +        packet_destroy(pkt, NULL);
> +        pkt =3D NULL;
> +    }
> +
>      *con =3D conn;
> =20
>      return 0;


--Sig_/25roaMhot7+K6hCCq2vhIpe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl6KV7UACgkQNasLKJxd
slicdw//VZ56PdkoS5QDNVayyjMOttNkCsHp7qgl6+DkMWjEp7+YPaU1EIQtXA1B
j8VTScHQZEhdoO5jLaJK4iu0qMH5eOtysbmzLSp4JO7sbZrOp7kp8YTqjbVlC7++
P7xeHOcgEyUY2Z+6CDSdemviW5XA9Om5pMVNMT+z8qCn4TtzukiZo/7/byKv92if
pILw/tEsup172u+gn4FHpO6ZkEtcoWJtyCF8gu3X6CDcTCe5giBRtnufRTWfylLc
Gpn0etmDQ1ZjrzALVv0GMuEBzH8b76LEEMRXHw5tfrLIRoVTxDyeGf+BvTv9L+Vj
1NkM0qb8qJedoAupPogjIvZROYP+d5GJbBCFsjgnfM6HUUunfY8qm5Wypz+Dxfzz
VL25nK6GmSzU6xBRRci7Qwv7rL6RmJjsRBFNbWMb5JjLsCEJc2JbfEyFGDeIVA/M
hC8kLS2Hpx2QO+lns6IfA5AP62PSHSSegBpwN8xYbAOBWfZxro81X6y14rI7v/gX
ESndO0z704Y/vuLdTolUJLo+BL2Xv6P/o43AvRRh9SRCP1OJSPXZm3pFX5Wv9RZo
STecAA7Ah+ElGrVLMUAM1G8WthjVuqfI+m/GaFi7OUx/dfkLU9mawm9TkNusvBBL
9r/qjm8eN3HvDyZE1eL/ycR3C4K16vt8ZW9qDwR0lUFYgLhLmrk=
=EJcH
-----END PGP SIGNATURE-----

--Sig_/25roaMhot7+K6hCCq2vhIpe--

