Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65172C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 02:52:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E9AE222AD
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 02:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="A/d6Q2HH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E9AE222AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWtcd-0006wT-Ax
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 21:52:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41592)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iWtbw-0006HJ-HQ
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 21:51:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iWtbs-0005jN-Ei
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 21:51:24 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:41459)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iWtbj-0005dw-SD; Mon, 18 Nov 2019 21:51:12 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47H9Lf4QsLz9sPZ; Tue, 19 Nov 2019 13:51:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574131866;
 bh=Io8NkImnh9AdZNZoBfrONNL2FoNsbKtSbbX7y66QYaM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=A/d6Q2HHwXzLiaLlFtcf6FC57hEX7K+A1sKZpGrSKyoPNFqTukEPUwysQvt9PMP5E
 eD9tb88lhApqH/89Hg9KONW0nAFxyOofo30ImpSRMvJreiENYDhIMxaas34VF7WbRx
 xC5Cv1JbT5V1oQBFa4rArr09NoF++kFNPVff2prs=
Date: Tue, 19 Nov 2019 13:50:58 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: pannengyuan@huawei.com
Subject: Re: [Qemu-devel][PATCH] ppc/spapr_events: fix potential NULL pointer
 dereference in rtas_event_log_dequeue
Message-ID: <20191119025058.GN5582@umbus.fritz.box>
References: <1574041813-35408-1-git-send-email-pannengyuan@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lRF4gxo9Z9M++D0O"
Content-Disposition: inline
In-Reply-To: <1574041813-35408-1-git-send-email-pannengyuan@huawei.com>
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
Cc: kuhn.chenqun@huawei.com, qemu-arm@nongnu.org, kenny.zhangjun@huawei.com,
 qemu-devel@nongnu.org, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--lRF4gxo9Z9M++D0O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2019 at 09:50:13AM +0800, pannengyuan@huawei.com wrote:
> From: PanNengyuan <pannengyuan@huawei.com>
>=20
> source is being dereferenced before it is null checked, hence there is a
> potential null pointer dereference.
>=20
> This fixes:
>         360
>     CID 68911917: (NULL_RETURNS)
>         361. dereference: Dereferencing "source", which is known to be
>         "NULL".
>         361        if (source->mask & event_mask) {
>         362            break;
>         363        }
>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: PanNengyuan <pannengyuan@huawei.com>

I don't think this is the right solution.  The only events we ever
generated are LOG_TYPE_EPOW and LOG_TYPE_HOTPLUG, so in fact source
should never be NULL.

I think the correct way to satisfy Coverity here is to have
rtas_event_log_to_source() do an assert(), rather than returning NULL
for other event types.

> ---
>  hw/ppc/spapr_events.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index 0e4c195..febd2ef 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -358,7 +358,7 @@ static SpaprEventLogEntry *rtas_event_log_dequeue(Spa=
prMachineState *spapr,
>              rtas_event_log_to_source(spapr,
>                                       spapr_event_log_entry_type(entry));
> =20
> -        if (source->mask & event_mask) {
> +        if (source && (source->mask & event_mask)) {
>              break;
>          }
>      }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--lRF4gxo9Z9M++D0O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3TWJIACgkQbDjKyiDZ
s5L6EhAAjbCe7FFJrWWbJe/cSwnSQ25e9aO+lPxny0T1elJbRhQGt1HpWW7TXnHZ
/eYvgFRKZuXJKKpRyNbpSENWQc8mP2YVh6phNan++NRLLIPVBAz0SsXc1Nd6r/kP
53OYhDCLUQ8DxWl/tyPJCg4BNYtNvmSAJfQkDrOByMnNYQ/GzrzsBbPo7OKgcm9Z
yHr5ZS1EV3zgXBYR54BGdK7kRWw5/eUyNFBmnHUeACIld7gHxBAtvNPakh/byDxC
i3y9MiN9iKqCsENMbO/0374duSlG6JdI8liAd5TBelM7212jJcNWBa/J2v5L9t8u
PQFOo4EK2oBgr64FewTCDfHp+lloYvigfUuFQ1myV6HtuJZXro21tfQ03Bmhj3a5
GKFX0HAfwHV7WjJAL3BFG3BkjCLE41g5SXOXvXeqlQH7OEwOdYEWTyrlgzdeu6IL
GkLNrJJ9b9Run1maA1ZDn/jfNeNrhfNAsZfifOQq0KaDaBhh0CTbRZN/I7H8VKQv
MufRT0OOqiyt56JwPdnCFKSuLCaXFeh0sZ4+DW0HM03voru6QMrGFZ1I7+WbdngL
o0LcI60y1hf4uiCfrdtFNx7HLHZ6u2rDxgmWeae79WcC8ayE7SdFiUha1xBUg1pA
ZjnRwliensFeICZfnM8dyRsOC+XF7SvuGWdEXsKPQrJoIMpv2sY=
=Cx4x
-----END PGP SIGNATURE-----

--lRF4gxo9Z9M++D0O--

