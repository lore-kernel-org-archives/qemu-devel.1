Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70907C3B185
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 07:56:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AB4F20733
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 07:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="DCaJOL3Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AB4F20733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j13vv-0003xj-CX
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 02:56:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34919)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j13v4-0002hY-DT
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 02:55:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j13v3-00023N-6o
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 02:55:50 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:56433 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1j13v0-0001ur-Tg
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 02:55:49 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48GJ9p2s9Zz9sPK; Mon, 10 Feb 2020 18:55:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1581321342;
 bh=rC/CRU05fpRGNeS2KTOSMrRaN5CWjWdIpEDuWMVWniE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DCaJOL3QvpdOpaKAx54Nw6F4BH7snfkqzxDqOUgNaNC/ZimQyT2xILfWhNWu3sd6B
 PSrZOsAbIuLghXFTP4cP/qudsQbQkzSxYTYfIKc4sPJI+3e9tk2me5/w/57j056axE
 J2OXcB3ATPSWaeWeEYMf3rbp81yE26VJnDmDURMc=
Date: Mon, 10 Feb 2020 18:30:08 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: VW ELF loader
Message-ID: <20200210073008.GE22584@umbus.fritz.box>
References: <de7e4d34-eb63-904c-3475-7feee154c72c@ozlabs.ru>
 <8420784f-b4c7-9864-8534-b94dbc5f74ff@redhat.com>
 <d63ba962-ffbb-9f27-34fb-657188e90194@ozlabs.ru>
 <CABgObfYwtrh_uy8zFmg2qDjK6iynniN6=jJ9_MKfNxXUaOkPKw@mail.gmail.com>
 <71d1cc16-f07d-481d-096b-17ee326157bb@ozlabs.ru>
 <CABgObfa4tUVBbpBtoY3JFSF8-0mRVxgGbzQokc+JrJGPagwPaQ@mail.gmail.com>
 <20200205060634.GI60221@umbus.fritz.box>
 <62d62fab-46a4-240b-037b-409ba859b93d@redhat.com>
 <47e6a49d-f1c7-aaf6-b9ef-7e81773cff6e@ozlabs.ru>
 <8993c6b4-2a2c-b7e5-8342-4db480d0af9d@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9crTWz/Z+Zyzu20v"
Content-Disposition: inline
In-Reply-To: <8993c6b4-2a2c-b7e5-8342-4db480d0af9d@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: Thomas Huth <thuth@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <conny@cornelia-huck.de>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--9crTWz/Z+Zyzu20v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 07, 2020 at 12:45:20AM +0100, Paolo Bonzini wrote:
> On 07/02/20 00:17, Alexey Kardashevskiy wrote:
> > This is a lot and what is exactly the benefit? My alternative does not
> > need drivers at all.
>=20
> Anything you put in the host is potential attack surface.

Ok, it is attack surface you're concerned about.  That wasn't totally
clear before this point.

> Plus, you're
> not doing a different thing than anyone else and as you've found out it
> may be easy for block device but not for everything else.

Uh.. was that supposed to be "we *are* doing a different thing than
anyone else"?

> Every platform that QEMU supports is just using a firmware to do
> firmware things; it can be U-Boot, EDK-2, SLOF, SeaBIOS, qboot, with
> varying level of complexity.  Some are doing -kernel in QEMU rather than
> firmware, but that's where things end.

Well, yeah, but AIUI those platforms actually have a defined hardware
environment on which the firmware is running.  For PAPR we don't, we
*only* have a specification for the "hardware"+"firmware" environment
as seen by the OS together.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9crTWz/Z+Zyzu20v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5BBn8ACgkQbDjKyiDZ
s5LCNg//QA8kGhF7wcOeFWm7tIsb86gIB+CqqhD4iCV0iR2KSjatBPJZyeL215LC
SuqciXzq8/qXFe+ASXMTeafVO1XSFF0PHNIEF6LH18ss9B+K+O8rQ2aHrT5H3OH1
0WamUAiGERpwGvLlWYE9bkf4cubyJMJipQoH7I7fqCcrDcL7Wt7bTwrP4yqxM/jN
e/Swt3Wz8nrOHu3X1pTBH8Jwj52rCKCPmvLUfsbIABPg1rwuYJoRSIpTcDpDz5LM
UsXqFKtu4y3DPU9dJ8hJMy3PxFpLqxgQVqd7zcsNitd5ys1xBkVPcjvrvNpNpCph
wwLxmN4z0iIfGpQarwPYUz4Zg17rvt8F6l7EBLV5R6I7SjfhTHGPymUpWHdUcrkT
mx0nbX2w8aVkCYtqhHD8odOiopPlHZk34kh57ar6Iv2PK3KIDlZ81Nh9PH5kDiJi
8vaZT5yllB6pcwBvBYzos0L3xoNf8vZg0vwhLpcwHPqyZABSMoKmF+IOXMtH+TCV
ieRF0m5X6M7R5L3+BUSVvx+12QUqDY93ibyctr/YwlCYqGgvIJD+ZdNMQG647C8w
+4Vkx6a2OfKXdMWbp5kKH9UWfV8CZV3+QnhlnoX4ktSf2ymcAmwf9pBq6SLfgWwe
a30y5pEv3GpmaT6jUGhS2JS16V/+tNbJmnHg8gp2PA5f4SF0LAY=
=pikl
-----END PGP SIGNATURE-----

--9crTWz/Z+Zyzu20v--

