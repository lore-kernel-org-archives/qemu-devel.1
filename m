Return-Path: <SRS0=nktx=5V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E12C2BA19
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2020 22:37:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83C3420659
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2020 22:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="EY7fcQEQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83C3420659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLDt3-0003Q9-F9
	for qemu-devel@archiver.kernel.org; Sun, 05 Apr 2020 18:37:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59897)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jLDYp-0000L1-Rw
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 18:16:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1jLDYo-0008NS-KT
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 18:16:11 -0400
Received: from mout.web.de ([212.227.15.14]:33503)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1jLDYo-0008JM-8K
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 18:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1586124954;
 bh=+Bj+Rj+nTH9HG2zEKj+rjdbhAT6xiYKvFHTe0iqV/hU=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=EY7fcQEQV3gVPuEICinXR1JAG/ZAXi3+MjnTUO3RNhpArcSJnn1P2N79A6UxM4YaJ
 qFjqtbobIS4tRo+MBmjWYCBCMVxylqW6z8EmWgmhHz+K0i93ytk/8ANj9mqQyusfTA
 Qo0T09eOq3nYHlw7rr/Z4MDfjGotMAXt2Yp95Eu4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.247]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MCZTG-1jTVIO0JBi-009PWR; Mon, 06
 Apr 2020 00:15:54 +0200
Date: Mon, 6 Apr 2020 00:11:54 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Derek Su <dereksu@qnap.com>
Subject: Re: [PATCH v4 2/2] net/colo-compare.c: handling of the full primary
 or secondary queue
Message-ID: <20200406001154.1a7a4e5b@luklap>
In-Reply-To: <20200328124646.7778-3-dereksu@qnap.com>
References: <20200328124646.7778-1-dereksu@qnap.com>
 <20200328124646.7778-3-dereksu@qnap.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bjPiytRO/oQdzCdu_C4vC0G";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:QIfhjw6CU2zyoSBfos5ooBuBuvIUo+HLynz4x3KvaBB2yzYlB65
 nk5CBV3hFQuiGLS9ZAjOPEKQsRNE0MIM9+4cIS+qbIlkmxXuo8d+89KdcoXDTQA/lO6OtfD
 MTF688Pihy7LsUaeN1FwdlMaZtkGN2OsxTVIYP8/76vEVpBVWFlr77CKG4Zu5uGmXtSvngh
 mNCotE4Ip+8mxmRNWOi0w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:goVpkmMjHCA=:E5Z17dignZq5XHxHyXqa3B
 pojU3s+DFW2z2SlbC1gzimJRU0jTAMRQx8Egb5TkqbwMgeMNTAkQHUZK7fNjbezBhQpGStEuR
 SSjO01YkG65NrOv3bZLkM8sCmA80G8+ovL9cmEqMpw72uDzdu6HSFEtwY5JY0w4sNqLcF8oDK
 y3Cq9DOODaSh9ioD9vdI8Kbv69raIvemflPMI+WtaM9I8AvA+ohp0mhDaKf1gfCkrq7HmvMHj
 56qnJ+/bc6zbsu/PxaUSaw4dbp8wq3kQB/Q70cVfAHveIZXb55Bxgp7s6jSpyctFNC8pHiz06
 xi/nJEvodygXcYU5AavAuDyqcakjyRPabQZgb/c7ki3s6E6ZuTNRCOutosld8w0ekXSw5F7wq
 9sAJ9k/DKUhGbHFER5HIj21Gw4jfdmvcgf1emg/dLE4XBdHT28kKECpIcH2YO8dSs00lflfJg
 x0Sempke+sxnq1aN/YKvl9yAjVsvke7fWu+NE6Yi+npKiD+HyoWljakt71gX+02r5/NrdClq8
 UYYX9hpIg3MSUBypijNbQaOg58IoK0JcwQTnGgo5AnuKg9CaAb7hd8eGQG+U9jcAcAUpDsiRl
 LSaznjGJv7a6P2vltYOFnXB5607T+7yrOJqsDuNTCxNX9+m7hSUKhj3pXdST129UzFgk3eQw/
 amwNyvAhAwrHnjCfu0TC9lo//ZhutOoc0L5T6JIDTV3MpCzjuCICOWdf3TL4lXOen6q7DucXE
 98R0AL36yD9mcQrVRvInlSZ27I2nVMRxPTyvAD4qSTfnodQiNYdkItHUxTF6lm8QGoWjZ2Jb7
 DV85v3fq57IsKD4/mT57OH4cs0ySU4jbm9gdA+7eBCDSKj5yB39351LbQr9m497qR4wgjfmr+
 bP1iK371Exma0JcGfL4xq6BSVuNRAT//JDVLcxox3Q8ltU6na0mjeRWW5BosJQpOvlTrOUAJC
 K6kJQ6C82Miflj1wr5bJrbwnJ2qLeyGVFiACqDmjcHqQewPpAWCbD/1A6pbjsQu+k/3RHv260
 Hwi+fxlKQKpfYlnip3hrMeggJh/JXbqlvwIsh7rbjKte4WOMQunrVtIt18fhQP9UwOn/mwjxs
 o/VzAXv60gDnBk5LNCusthaJITBYTZflI9bTE1H31ZatZoSOgeN3w7N97wJs6/ZgAtUzYFoZ5
 7xpV1EfLoE+0Knz4zMdGSii16wUDAjqk6lVGgDkFkwiziCWsdEFFpl/iRnzjC9vw55bwmGhfG
 Pzd3WJqwkozD5gFvn
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
Cc: lizhijian@cn.fujitsu.com, chyang@qnap.com, jasowang@redhat.com,
 qemu-devel@nongnu.org, ctcheng@qnap.com, chen.zhang@intel.com,
 jwsu1986@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/bjPiytRO/oQdzCdu_C4vC0G
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 28 Mar 2020 20:46:46 +0800
Derek Su <dereksu@qnap.com> wrote:

> The pervious handling of the full primary or queue is only dropping
> the packet. If there are lots of clients to the guest VM,
> the "drop" will lead to the lost of the networking connection
> until next checkpoint.
>=20
> To address the issue, this patch drops the packet firstly.
> Then, do checkpoint and flush packets.
>=20
> Signed-off-by: Derek Su <dereksu@qnap.com>

Looks good and works well in my tests.
Reviewed-by: Lukas Straub <lukasstraub2@web.de>
Tested-by: Lukas Straub <lukasstraub2@web.de>

Regards,
Lukas Straub

> ---
>  net/colo-compare.c | 39 ++++++++++++++++++++++++++++-----------
>  1 file changed, 28 insertions(+), 11 deletions(-)
>=20
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index cdd87b2aa8..fe8779cf2d 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -125,6 +125,12 @@ static const char *colo_mode[] =3D {
>      [SECONDARY_IN] =3D "secondary",
>  };
> =20
> +enum {
> +    QUEUE_INSERT_ERR =3D -1,
> +    QUEUE_INSERT_OK =3D 0,
> +    QUEUE_INSERT_FULL =3D 1,
> +};
> +
>  static int compare_chr_send(CompareState *s,
>                              const uint8_t *buf,
>                              uint32_t size,
> @@ -211,8 +217,10 @@ static int colo_insert_packet(GQueue *queue, Packet =
*pkt, uint32_t *max_ack)
>  }
> =20
>  /*
> - * Return 0 on success, if return -1 means the pkt
> - * is unsupported(arp and ipv6) and will be sent later
> + * Return QUEUE_INSERT_OK on success.
> + * If return QUEUE_INSERT_FULL means list is full, and
> + * QUEUE_INSERT_ERR means the pkt is unsupported(arp and ipv6) and
> + * will be sent later
>   */
>  static int packet_enqueue(CompareState *s, int mode, Connection **con)
>  {
> @@ -234,7 +242,7 @@ static int packet_enqueue(CompareState *s, int mode, =
Connection **con)
>      if (parse_packet_early(pkt)) {
>          packet_destroy(pkt, NULL);
>          pkt =3D NULL;
> -        return -1;
> +        return QUEUE_INSERT_ERR;
>      }
>      fill_connection_key(pkt, &key);
> =20
> @@ -258,11 +266,12 @@ static int packet_enqueue(CompareState *s, int mode=
, Connection **con)
>                       "drop packet", colo_mode[mode]);
>          packet_destroy(pkt, NULL);
>          pkt =3D NULL;
> +        return QUEUE_INSERT_FULL;
>      }
> =20
>      *con =3D conn;
> =20
> -    return 0;
> +    return QUEUE_INSERT_OK;
>  }
> =20
>  static inline bool after(uint32_t seq1, uint32_t seq2)
> @@ -995,17 +1004,21 @@ static void compare_pri_rs_finalize(SocketReadStat=
e *pri_rs)
>  {
>      CompareState *s =3D container_of(pri_rs, CompareState, pri_rs);
>      Connection *conn =3D NULL;
> +    int ret;
> =20
> -    if (packet_enqueue(s, PRIMARY_IN, &conn)) {
> +    ret =3D packet_enqueue(s, PRIMARY_IN, &conn);
> +    if (ret =3D=3D QUEUE_INSERT_OK) {
> +        /* compare packet in the specified connection */
> +        colo_compare_connection(conn, s);
> +    } else if (ret =3D=3D QUEUE_INSERT_FULL) {
> +        colo_compare_inconsistency_notify(s);
> +    } else {
>          trace_colo_compare_main("primary: unsupported packet in");
>          compare_chr_send(s,
>                           pri_rs->buf,
>                           pri_rs->packet_len,
>                           pri_rs->vnet_hdr_len,
>                           false);
> -    } else {
> -        /* compare packet in the specified connection */
> -        colo_compare_connection(conn, s);
>      }
>  }
> =20
> @@ -1013,12 +1026,16 @@ static void compare_sec_rs_finalize(SocketReadSta=
te *sec_rs)
>  {
>      CompareState *s =3D container_of(sec_rs, CompareState, sec_rs);
>      Connection *conn =3D NULL;
> +    int ret;
> =20
> -    if (packet_enqueue(s, SECONDARY_IN, &conn)) {
> -        trace_colo_compare_main("secondary: unsupported packet in");
> -    } else {
> +    ret =3D packet_enqueue(s, SECONDARY_IN, &conn);
> +    if (ret =3D=3D QUEUE_INSERT_OK) {
>          /* compare packet in the specified connection */
>          colo_compare_connection(conn, s);
> +    } else if (ret =3D=3D QUEUE_INSERT_FULL) {
> +        colo_compare_inconsistency_notify(s);
> +    } else {
> +        trace_colo_compare_main("secondary: unsupported packet in");
>      }
>  }
> =20


--Sig_/bjPiytRO/oQdzCdu_C4vC0G
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl6KV6oACgkQNasLKJxd
slgKOg//eZUgSJhq1fUJydUl3/GF1GshldE+47sfxfFtC7DkcxmuSsC1qfNJoPWY
I+C0jv2awv4CyH2qHNWwY53ikN1Yley2Gf5t/bfMdbP1HWYlWmws8vmvBM/4Cfd2
Mz2AblEq2dIRpR1vuybm9Ufkv/YUiQ6xS91ZI/cxLkJUqFNySGOfhj+ilLDK77PI
aRugMaDB2k8Ml2eBngY0z9vy0v7ThOFQXUHXX0MtFjv9Y4DOfH9eZCMJXtDeZg1n
mQ3bOoTPugYXZWkNYi6/lNvbDMHgsXAyrcY3fFCsqHPimFLzP0kh47ovA015x2r5
4NqAooc7fHfgAjmcRx9DPu8w7VWCjGxb9/Vj5upgNDd3iITBBgR8bTb64nuViVec
z2bPCN1/bnTtufa5DhU3RdH5r108lFPddgpN4Y9xAxfbBIGMpZjUNS3QQLBY2K0r
P9RHvSz0X3PqnwCg+yZZQkgh5jMinxmLJJuN/GEQe13rhm/Ashcv3w+MMfjVO1mP
h6moD4AMaxw1db5Qy51bEMo152Jf+YkdEJaSEBo6R8gLYEFnHjYT8+3NOowyMscu
0cKbryli7LmTQ8pTqpCiUfORFEEZzaDiahWcNt0qCyHic3WqsIAccUyYhC9JIzP0
+tMPQ9pU6+MSt0C/XiMbq2s6VdP0yNLj+DagyEsPa2s/fr5cHkM=
=46IM
-----END PGP SIGNATURE-----

--Sig_/bjPiytRO/oQdzCdu_C4vC0G--

