Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AA3C33CAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 03:45:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E480A2253D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 03:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="EGSvCzTZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E480A2253D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itkTd-0003tr-LO
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 22:45:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55441)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1itkSE-0002ZL-SC
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 22:43:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1itkSD-0006Hm-Fi
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 22:43:50 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:38347)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1itkSD-00068P-4o; Mon, 20 Jan 2020 22:43:49 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 481vXD48QCz9sPJ; Tue, 21 Jan 2020 14:43:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1579578220;
 bh=GL4rKxgFC0IL9e/w+nFUstr0JkGoXwVFteXdiohUCJY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EGSvCzTZewGhwm4Ypc6QCjJbEMAXgNH07MGBqE4zYW0O/z+M9ojOwSDhJF21hfhyz
 Rm7hIvOLtov6gonbgA8y0T9z91piYYd0aTpw4n92uXsKYzEkJaNwEE3olPxNNdVAef
 TO6e29zyl7gicW3TvjLBICPf6nf/TgcOLzBoi2JA=
Date: Tue, 21 Jan 2020 14:38:00 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 0/2] ppc: add support for Directed Privileged Doorbell
 (non-hypervisor)
Message-ID: <20200121033800.GA265522@umbus.fritz.box>
References: <20200120104935.24449-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <20200120104935.24449-1-clg@kaod.org>
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2020 at 11:49:33AM +0100, C=E9dric Le Goater wrote:
> Hello,
>=20
> The Processor Control facility for POWER8 processors and later
> provides a mechanism for the hypervisor to send messages to other
> threads in the system (msgsnd instruction) and cause hypervisor-level
> exceptions.
>=20
> Privileged non-hypervisor programs can also send messages (msgsndp
> instruction) but are restricted to the threads of the same
> subprocessor and cause privileged-level exceptions. The Directed
> Privileged Doorbell Exception State (DPDES) register reflects the
> state of pending privileged-level doorbell exceptions for all threads
> and can be used to modify that state.
>=20
> If the MSGP facility is not in the HFSCR, a hypervisor facility
> unavailable exception is generated when these instructions are used or
> when the DPDES register is accessed by the supervisor.
>=20
> Based on previous work from Suraj Jitindar Singh.

Applied to ppc-for-5.0, thanks.

>=20
> Thanks,
>=20
> C.
>=20
> Changes since v1:
>=20
>  - removed DBELL_TIRTAG_MASK and simplified helpers as QEMU TCG
>    doesn't support more than on thread per core  =20
>  - simplified book3s_dbell2irq() and renamed it to dbell_type_server()=20
>  - replaced mask LOG_GUEST_ERROR by CPU_LOG_INT to track HV Facility
>    errors
> =20
> C=E9dric Le Goater (2):
>   target/ppc: Add privileged message send facilities
>   target/ppc: add support for Hypervisor Facility Unavailable Exception
>=20
>  target/ppc/cpu.h                |  6 +++
>  target/ppc/helper.h             |  4 ++
>  target/ppc/excp_helper.c        | 79 ++++++++++++++++++++++++++-------
>  target/ppc/misc_helper.c        | 63 ++++++++++++++++++++++++++
>  target/ppc/translate.c          | 26 +++++++++++
>  target/ppc/translate_init.inc.c | 20 +++++++--
>  6 files changed, 178 insertions(+), 20 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4mchgACgkQbDjKyiDZ
s5J6MxAAwpasZPh9JpyKyHw0Qp+t4SMfZng69ZjO2vNRzab6DwbSeXSs8PcOtD/c
+N7CDDz3mpFNn/exOMz1jJhA6lb4U4Ou2QNTIXBhEYo131nVHIJPvQYBjk6/xM/Q
smYrVlLwQufUlHDJ0mtKQueQhAHMso1ExE0uHeEk1py3A1f/6sUb/yYklhTXh94f
V9SsO5XW5OgcYVW7HJtG2C6PS3Vli9V52WNv/pqUo9xS6adKz9Zf9X3oZqQFpq/D
Oqlzs2W8iWbcBygtfa8i7aCNIKQS09m61UeKlZzXC0rJrtMCm7+BffS+mnyu2aZ2
HqQp18OCqsPhdNxThOEds8hflQAOAMyJks22skYlAygobG2GzaHUGbiG2y5jNzpG
nmOsNqhXuPhF44UQnAHX1eRe91MISvx9koj9/eYUTQH3FtcxekU1B8Wtgl9AcZ4Y
4p2FKzeCznN7LEiB6bkVSAkBDn0OMwmwRu4B8bd9gYgMpDC4H0/JnoLT+5d6Yzwy
KpGpM8UywmnczzJ6VMaHRY32oXOM/PLD7XmkyimoQ6Mh7rL10dQo7wiKEgCqSvZW
XIWQ+5H54QuORgh1LftOuOJTINUx6QCVTv7Bl/6a+Gc3Yf0CYzsdN9FoYYUKqR3w
H+INofUE+tcJNqHshj15IpVnVDB6T5BwH5quIh+pQTPJXwUsFzY=
=BNB6
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--

