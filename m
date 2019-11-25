Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51DAC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 23:42:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AACF220733
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 23:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ojOOHrrE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AACF220733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZO09-0008RI-Tw
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 18:42:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48779)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iZNzB-0007MT-Az
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 18:41:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iZNzA-0002KQ-8B
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 18:41:41 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:60045 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iZNz5-0002Gr-Mv; Mon, 25 Nov 2019 18:41:36 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47MNpb3qMzz9sPV; Tue, 26 Nov 2019 10:41:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574725287;
 bh=Owj2sPwgBBXpnX55ffiLjsTXa1GOZ/cyCYzT8o8kHcg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ojOOHrrE+7uHiuB7Rkkz3I34hvlYEj4Zo8NP48CAoyPQNJWtaxMzLwc/Q+qhaDk6V
 1jlAgV+A/McIEyq1LYo5ttCcQHLvOaj5vD8TrS46DoeZWl8jv2zLgbJSkBvvImChQM
 r6Q/Lnsg2TPKZM9a7wEzBmmrfyYTDCP9Npd07Kd4=
Date: Tue, 26 Nov 2019 10:13:27 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: pannengyuan@huawei.com
Subject: Re: [PATCH V2] ppc/spapr_events: fix potential NULL pointer
 dereference in rtas_event_log_dequeue
Message-ID: <20191125231327.GJ5582@umbus.fritz.box>
References: <1574685291-38176-1-git-send-email-pannengyuan@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="r5zNLCKCFspl+eMg"
Content-Disposition: inline
In-Reply-To: <1574685291-38176-1-git-send-email-pannengyuan@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: kuhn.chenqun@huawei.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 kenny.zhangjun@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--r5zNLCKCFspl+eMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2019 at 08:34:51PM +0800, pannengyuan@huawei.com wrote:
> From: PanNengyuan <pannengyuan@huawei.com>
>=20
> This fixes coverity issues 68911917:
>         360
>     CID 68911917: (NULL_RETURNS)
>         361. dereference: Dereferencing "source", which is known to be
>              "NULL".
>         361        if (source->mask & event_mask) {
>         362            break;
>         363        }
>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: PanNengyuan <pannengyuan@huawei.com>

Applied to ppc-for-4.2, thanks.

> ---
>  hw/ppc/spapr_events.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index 0e4c195..e355e00 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -358,6 +358,7 @@ static SpaprEventLogEntry *rtas_event_log_dequeue(Spa=
prMachineState *spapr,
>              rtas_event_log_to_source(spapr,
>                                       spapr_event_log_entry_type(entry));
> =20
> +        g_assert(source);
>          if (source->mask & event_mask) {
>              break;
>          }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--r5zNLCKCFspl+eMg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3cYBcACgkQbDjKyiDZ
s5JeAg//WG/Xk9QxNIkg5FHg1LKa40JcA4SJ+3E5IUomubJD9I+6KVeho0ercejC
iv0fcXgbUsb7uChE9eHE2WYwwIg9OaA34r+jlON5lpiQ7MGmf5qVmiZjJK/cZIRu
jnn9XWRV3reQf7y/dWVvR7ZStFACXhH77jUkfOaM+MBICVninWaI8VDcmNtdJK6C
eE0fUK/9PHizZVjCY232iwkxVGoE0YmC/+AlW/CwILPrT2IPYwKv568HpsynJtGm
DuakN7apdHnl55ay+gTaObunb1zlXJOM859rISudq0iCdZapF30xWDeEJo+jz6Za
uHT2PYBoO660r7bG1BD62ZIWC61Xq34jym2EYua4r5M5Ddnlspo1H9e8AMn04Lll
/ChXyF8IH1Ql1uhnSyRWG8V5Bk0nXQircA4BVm1895f+9F0v0LwxIlr6D3gHujf1
aZ3naU8ilk3ujxDkrlvF+T3msOqSBJ69NMPDSvLh3FTFTzFZz669Kdwtp4qi+jGa
oBNeZJEbLiPTAW3wGQDzXmg2jo+CxJfr79Ty7/eiprNq7CQOPRwAwKaab7gw7sDm
w4hXObEfMHs5e6i3BNWcnBRNw8air9ilWgRfNd7YExgHWAXep9UwCG+Bl4hcSNb4
QX3w/7rS9nd+SuzYo2eVxTwAr3lKKMpYi1AC/8l85wXxTj4fgns=
=/k7R
-----END PGP SIGNATURE-----

--r5zNLCKCFspl+eMg--

