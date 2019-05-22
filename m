Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968B3C282CE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 00:14:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FB092089E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 00:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Bm1yk7s5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FB092089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54709 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTbMu-0000rp-UO
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 20:14:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hTbLf-00009y-JH
	for qemu-devel@nongnu.org; Wed, 22 May 2019 20:12:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hTbLe-0005Yl-E6
	for qemu-devel@nongnu.org; Wed, 22 May 2019 20:12:43 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:45757)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hTbLc-0005WY-SK; Wed, 22 May 2019 20:12:42 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 458VLm5q1vz9s7h; Thu, 23 May 2019 10:12:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1558570352;
	bh=U4IkFinW+93AMWpQ0Ct5niiltgnUuIrDvy+Nz5vuoU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bm1yk7s5Q0apdPWYpzkmLO6xdlIDrget6HatbN2PfsWyboB9O3IWQbp5qwJ5NGFgU
	wmGcpwkdiyP7d7VNJzYluGDZ01IHy3TfsjpzefpwNT3DL9a7BIo8DBqLuwIPQnQX+K
	lgy+bIyGSPB0pwhkSowG4z4/qXE/paqy9fM7TtzY=
Date: Thu, 23 May 2019 09:29:52 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>
Message-ID: <20190522232952.GN30423@umbus.fritz.box>
References: <20190520204340.832-1-maxiwell@linux.ibm.com>
	<20190520204340.832-2-maxiwell@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hD6P3ib1XCFtz2ni"
Content-Disposition: inline
In-Reply-To: <20190520204340.832-2-maxiwell@linux.ibm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH 1/1] spapr: Do not re-read the clock on
 pre_save handler on migration
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--hD6P3ib1XCFtz2ni
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2019 at 05:43:40PM -0300, Maxiwell S. Garcia wrote:
> This handler was added in the commit:
>   42043e4f1241: spapr: clock should count only if vm is running
>=20
> In a scenario without migration, this pre_save handler is not
> triggered, so the 'stop/cont' commands save and restore the clock
> in the function 'cpu_ppc_clock_vm_state_change.' The SW clock
> in the guest doesn't know about this pause.
>=20
> If the command 'migrate' is called between 'stop' and 'cont',
> the pre_save handler re-read the clock, and the SW clock in the
> guest will know about the pause between 'stop' and 'migrate.'
> If the guest is running a workload like HTC, a side-effect of
> this is a lot of process stall messages (with call traces) in
> the kernel guest.
>=20
> Signed-off-by: Maxiwell S. Garcia <maxiwell@linux.ibm.com>

What affect will this have on the clock for the case of migrations
without a stop/cont around?  The complicated thing here is that for
*explicit* stops/continues we want to freeze the clock, however for
the implicit stop/continue during migration downtime, we want to keep
the clock running (logically), so that the guest time of day doesn't
get out of sync on migration.

> ---
>  hw/ppc/ppc.c | 24 ------------------------
>  1 file changed, 24 deletions(-)
>=20
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index ad20584f26..3fb50cbeee 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -1056,35 +1056,11 @@ void cpu_ppc_clock_vm_state_change(void *opaque, =
int running,
>      }
>  }
> =20
> -/*
> - * When migrating, read the clock just before migration,
> - * so that the guest clock counts during the events
> - * between:
> - *
> - *  * vm_stop()
> - *  *
> - *  * pre_save()
> - *
> - *  This reduces clock difference on migration from 5s
> - *  to 0.1s (when max_downtime =3D=3D 5s), because sending the
> - *  final pages of memory (which happens between vm_stop()
> - *  and pre_save()) takes max_downtime.

Urgh.. this comment is confusing - 5s would be a ludicrously long
max_downtime by modern standards.

> - */
> -static int timebase_pre_save(void *opaque)
> -{
> -    PPCTimebase *tb =3D opaque;
> -
> -    timebase_save(tb);
> -
> -    return 0;
> -}
> -
>  const VMStateDescription vmstate_ppc_timebase =3D {
>      .name =3D "timebase",
>      .version_id =3D 1,
>      .minimum_version_id =3D 1,
>      .minimum_version_id_old =3D 1,
> -    .pre_save =3D timebase_pre_save,
>      .fields      =3D (VMStateField []) {
>          VMSTATE_UINT64(guest_timebase, PPCTimebase),
>          VMSTATE_INT64(time_of_the_day_ns, PPCTimebase),

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--hD6P3ib1XCFtz2ni
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzl228ACgkQbDjKyiDZ
s5LX7RAAp9Yd6mkldZLJ2MHufWZTA7x92LAzF1ZazL5qS7lVCFMaxXrR0dY91aPH
oCcUNHvnGFs1XZTMLp++xWEJFXRPAqoyOLjfCtRjxegzRQTFiQ8arS+QIojH4OCX
Ib7WF+9UP0OW7CCFQve+9zOrZlkLP5C4Gwi2r9LW0XNr9sVmw+p/Y/OAgfZBsLlz
pHibyHWNcqTYuOlqK9jbk66vk2LRwD0RWnp107i9XR3Keeg6COAZF/aI+VYRKMHf
de2zLINSZR+ggJWUDt0TCKjPHp1I2eK3ZPSGI1ro32Cvzr6aMT/3AmJOUR+o7g48
hNUA3YJCPKxRpaVTIz4o4acSYcYqqLNRAXot8nBmOZtXUfY5Mb40Lx2QcvAGcjrb
2D555MISZeJAfavuWOTvslyWOE8AJM34P/gN5EajKNAsdazDeXgPADw9UBcctEvz
NKYpdpmoags4mkYfM7DGJmyhj2VkgQ36ztaShz/ua77Q6O1Wlv2Wf4el+mBHX187
AJSjfVbY8xPoWDkkP0uVIx/Xfk8VMyiiavZpFBZ96LpRTUl1euD2MdxYSanZZkOz
UTt/o0RY8hlYc9/04QNN9EO1fnv58+3PlzVBoyeVa3R6XRVwq+7W0ujsv0VO0ek8
wMgX6wEqLtPnF/QHb1WvDM3Edt3jZnv/5vrbFRzXZSqYizcB8IY=
=cPgN
-----END PGP SIGNATURE-----

--hD6P3ib1XCFtz2ni--

