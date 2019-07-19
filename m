Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8CBC76195
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 15:43:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92EA9205F4
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 15:43:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92EA9205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoV2X-0005D0-RJ
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 11:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34677)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hoV2N-0004lZ-I4
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 11:43:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hoV2J-0003wl-Cl
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 11:43:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49218)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1hoV1u-0003Gv-8E; Fri, 19 Jul 2019 11:42:46 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DAC992EED0A;
 Fri, 19 Jul 2019 15:41:22 +0000 (UTC)
Received: from localhost (ovpn-117-223.ams2.redhat.com [10.36.117.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF5116A233;
 Fri, 19 Jul 2019 15:41:16 +0000 (UTC)
Date: Fri, 19 Jul 2019 16:41:15 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Aarushi Mehta <mehta.aaru20@gmail.com>
Message-ID: <20190719154115.GG24412@stefanha-x1.localdomain>
References: <20190719133530.28688-1-mehta.aaru20@gmail.com>
 <20190719133530.28688-12-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BzCohdixPhurzSK4"
Content-Disposition: inline
In-Reply-To: <20190719133530.28688-12-mehta.aaru20@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Fri, 19 Jul 2019 15:41:22 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 11/14] qemu-io: adds option to use aio
 engine
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
Cc: Fam Zheng <fam@euphon.net>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-block@nongnu.org, Sergio Lopez <slp@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, saket.sinha89@gmail.com,
 Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefan@redhat.com>,
 Julia Suvorova <jusual@mail.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--BzCohdixPhurzSK4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2019 at 07:05:27PM +0530, Aarushi Mehta wrote:
> Use -i AIOMODE instead of -k.
>=20
> Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
> ---
>  qemu-io.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
>=20
> diff --git a/qemu-io.c b/qemu-io.c
> index f64eca6940..3cee06248e 100644
> --- a/qemu-io.c
> +++ b/qemu-io.c
> @@ -130,7 +130,7 @@ static void open_help(void)
>  " -C, -- use copy-on-read\n"
>  " -n, -- disable host cache, short for -t none\n"
>  " -U, -- force shared permissions\n"
> -" -k, -- use kernel AIO implementation (on Linux only)\n"
> +" -i, -- use AIO mode (threads, native or io_uring)"

Please keep the existing option for backwards compatibility.  Existing
command-lines must continue to work so we don't inconvenience users.

--BzCohdixPhurzSK4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0x5JsACgkQnKSrs4Gr
c8jjaQgAo7Sqrhd/UzLtdqKJThIgSK5Ejk3s38hx7ASal0mQPWsqtvukDn1r41sN
nPFf9FYpO1YWaNZ/xCm7Y5RkIxAXMjGES+2M5yLbTpYl0PMm0yq278xH9dNNk4rG
/9Lj/qm0Ctx/R3TWPkhCB5qKnQ7WWTY2fAtv0cYAF2RbBVrZAwvxrIVdb+L2MQUC
2zOa7Uo4hIwGN+8yDY17rbIcRuKlMMW3mT+eAwmwljBM3xq+4xkUT/hrOOP9WgOE
CJdJ63lFvJK2i42XEiV6+2NRJPDVg7PszgpgFCvNYRvKZqTq3Q0Mf/t3Mhf5cMty
3Z/pjPBuT86e+lV/cJPo/n45QmJAZA==
=3D9G
-----END PGP SIGNATURE-----

--BzCohdixPhurzSK4--

