Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE90C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 17:50:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 894DE2071B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 17:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="lHB1FfuU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 894DE2071B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHt7j-0004A7-EQ
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 13:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34949)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jHt3y-0003SW-KB
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 13:46:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1jHt3x-0002RA-CZ
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 13:46:34 -0400
Received: from mout.web.de ([217.72.192.78]:53435)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1jHt3w-0002Me-Vk
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 13:46:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1585331162;
 bh=4eXt0tATaAphBWh/+R39BciiDcuPbDdy9fMWMBLy54Q=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=lHB1FfuU/WurpSRDDNQPct/t95Otrxmb1c36I3j/0JGQ7fmJ8QOcxuDr34HFYgrAy
 7hA4K1JyRzsI49j6Lera3QgOrX8pQZEdLke0oxiUi8k2HuthN/wL2MVjCNWsoRJi7i
 AE74XNdSD46TAYL+fF8Qt2/3YRx4TddbBmMe+LXg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.1]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MJTdf-1jFOsc3xLX-0031eK; Fri, 27
 Mar 2020 18:46:02 +0100
Date: Fri, 27 Mar 2020 18:45:49 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: Derek Su <dereksu@qnap.com>
Subject: Re: [PATCH v3 2/2] net/colo-compare.c: handling of the full primary
 or secondary queue
Message-ID: <20200327184549.3802f959@luklap>
In-Reply-To: <20200325094354.19677-3-dereksu@qnap.com>
References: <20200325094354.19677-1-dereksu@qnap.com>
 <20200325094354.19677-3-dereksu@qnap.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/I7=fzM7rsi/1/tXjsdbNBbg";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:JjeieDB+ZsT/sscvdjHltPKo5pxKCsIpehGqsaSL7fCsMOhZ51N
 1tsFCO93OQ8f3nh2bWuNjH+zmo+vGmH2aVW6ZSeDzUQpC8/7g9sBAEp+kOfWDE2DdKwzfF4
 1YUQvhx00f+v6Et9nS8oqEwLFyVqo91+pReGt1w6l8fCMNz9rMJo4i0crkGs8wVB7nVMyBM
 tQUZQhpnTRFDzzAZebGLw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:V+vmvwREi+s=:V7lcjG5pl9g/Dzgm7rVPdy
 SIKXmtAV9lBaHiksthHse8cVcpqWrBFoNAJbXpxlzuBkMAX90Qh5z9VHeiyM989xcPDJJlURw
 KTNMIr4qj/rpIC0/BW0VFNI0oWUKTHUvOZ4E3l5xv+QClIMlimquDwO+REVnI/GtebhGSRJWq
 TFA102Zh8YbmkMEp3J1lWV6vrprlHtW/LxMZTfULe1hJBOpMtQwG7UJxDu4MFKqRS/p1L4Vh3
 3ZQMbavHOSxvoUizpUcUxDkqRXuqDwvYVY8+rwPRsNcLjJP0jEulycUhtpvTEJ9mQ8seg+k04
 rgR+AtBz3joEmU16WaV1mV310eFfTC3qxivTrURj8WfVnuBvBpFDKxt5Ozlfu9nhdFkiDBElU
 +TPAY+mFT50CFhHcbrtNoQlHR5yLsSUbkghlkVxtdxi5LnMXzA3md5kStIqm37Ip2KALxOOT3
 bTF5QBYRV0FoIt1hyIvHqxKk5d9rGoqxOjXtU1cpg40ZNPSWPqUrw3sWU5sTNQznNX4+namxE
 JBPq2XpzJpFhPfAYdgu3UE+5QTnOoOT2d5uTtGEpuUpEYEfgisbZZAiYABpidC1IYaVk4PgNt
 0yClSQro/NX9bYhxJCIOpl3gS53IjWcvMwoP29TaJE2EwYZTDA6oIbtPbTD/DNefMbuEKaPgC
 K0+BkH0MiNoaioRftqgKHMQbX9ap8lx7GW8LuKelij1m+OsNxvOTg0upOv6hUgu18JZjS84Yl
 cEZlQLUfZxu5txdFE2A6i0q0RrHCSIkZmL6Wshu1fCITA6KXqXbtxmTJztmIgw5Yt+zXnH5BJ
 XfWxmD0JfBaBa3fDTjuuLB3zxKiMmUqZK1l57Hry5YzL2AuKbgcx2E0GFDXlMMRh0m7BkkeLB
 m5RgtVQuMmj3U01NOBh+EkohsoJdOoCwlK/5BeGk+fJdN3c7ACeeIabt35UOXMvcTKQIF8PPC
 16XTOp+XkaKpCKxVyjH1Xj4Qt9LWTSQl4JdK/oqzqiH7TdXsCFLL08diHkIqMYG23vqGwrRy9
 FK5Z96nsAhlprdReVCBbAYURL/llZ/hYJmLWakfkOHgV8JJjeiX3J3ESm6R6uw+NotD/fHTUF
 K4047lKLmRXjCIlSqL47Ct0MuXr840fFXlU1r4vsKzFFyOldkThxd/2/wwg87qGl9JnWBkWmP
 X9Lwzb1e9YOFkfDxab/2Stj9KzR59mjySrVJXjOYlhc6hf6lm2BryUzFKjsRyYAwsSc3TJeic
 eLc+nO+y26D82VME7
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.78
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

--Sig_/I7=fzM7rsi/1/tXjsdbNBbg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 25 Mar 2020 17:43:54 +0800
Derek Su <dereksu@qnap.com> wrote:

> The pervious handling of the full primary or queue is only dropping
> the packet. If there are lots of clients to the guest VM,
> the "drop" will lead to the lost of the networking connection
> until next checkpoint.
>=20
> To address the issue, this patch drops the packet firstly.
> Then, send all queued primary packets, remove all queued secondary
> packets and do checkpoint.
>=20
> Signed-off-by: Derek Su <dereksu@qnap.com>
> ---
>  net/colo-compare.c | 41 ++++++++++++++++++++++++++++++-----------
>  1 file changed, 30 insertions(+), 11 deletions(-)
>=20
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index cdd87b2aa8..1a52f50fbe 100644
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
> @@ -995,17 +1004,22 @@ static void compare_pri_rs_finalize(SocketReadStat=
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
> +        g_queue_foreach(&s->conn_list, colo_flush_packets, s);
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
> @@ -1013,12 +1027,17 @@ static void compare_sec_rs_finalize(SocketReadSta=
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
> +        g_queue_foreach(&s->conn_list, colo_flush_packets, s);
> +        colo_compare_inconsistency_notify(s);
> +    } else {
> +        trace_colo_compare_main("secondary: unsupported packet in");
>      }
>  }
> =20

Hi,
I don't think we have to flush here because the (post-)checkpoint event wil=
l flush the packets for us.

Regards,
Lukas Straub

--Sig_/I7=fzM7rsi/1/tXjsdbNBbg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl5+O80ACgkQNasLKJxd
sljQYw/9G4iLQYgZa/61Sx9l/HGZNVLWmPYmJZLIdUXdnKcbYLJlfiCCLPLFTDtE
oM4CZtuqRfQeqgALl30Q8/etgRjxESqLWvwoF1fJAuOx++oMCX2mTBxjRNa6FR8X
RkG8IjlcTjtI9R5YmWFoluxmSxNv0rQjb9dp06iRoMFzDylL+NhhkiiTz13sD0Ye
0x2W92sdOuMi1mB6AkeBipsmiJ4LFdc1s4dFTRNRjg9YAKlp5jJP3u51awdPsw9M
7p8eWhN04i3BzsVV2gzAPNRh0gdWtF8EeBaj7XZC4oVvGBjwVZnu41mXIW5dFyPf
oFwyrflZDbYlAOGwAbw3vS/+iAEEZHBC1HJc+583J5il06RDcmTdHOjAqR95bSYO
zhjTMqGNU1bpXWdpHPAEjm6uwtCnXOmtE+IDjnljITHum4I7qM9ifL2zkdsufK+/
oLKIT5o/tvy49IDQeTwz4tmA6uFioGQscQS4afnlOT9XonktRxQ0YqM2bTDlecDt
PVJFsJVFetK9tyc91FB76ax+teFGOjbc8lAwqfunfiyxUxevSTr+8cnECCucPVKi
kNU2M5PEbdVPBYH0VJiubPt4eWaJW29l9HfQcIU88IczUBLItVL97ovFGKXej4TE
95PfwSqOk3ZU7RbT573pZpHxUyi1jZzUEKW0HyDsx6Ohe1FQxJ4=
=6+Js
-----END PGP SIGNATURE-----

--Sig_/I7=fzM7rsi/1/tXjsdbNBbg--

