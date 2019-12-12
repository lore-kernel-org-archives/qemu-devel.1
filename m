Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1AEC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 02:41:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEC8A2077B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 02:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="So3xFBmi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEC8A2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifEQG-0002Vs-27
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 21:41:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40408)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ifEPW-0001yK-H8
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 21:41:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ifEPU-00069y-9Y
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 21:41:01 -0500
Received: from ozlabs.org ([203.11.71.1]:42871)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1ifEPT-000639-5b
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 21:41:00 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47YJ1g4VTGz9sPc; Thu, 12 Dec 2019 13:40:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576118423;
 bh=KY5dMiEPHY1QEYsb1yItEs7XP7zYLxEeVCn641ust+8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=So3xFBmieEakD5eTgPvo6STh+qzocgrBzwlPyu1h9rzQeOHG5KHpd8Ix1Ybr4ueHv
 bZ201JkTdkP/Uq5JYNWSYLY5NGWiw1y1RXdOuV/f6J+pjxTn19E+KFc9Kdvaq7w8sF
 DsG0JQO62IlNT6m7FyyOTjeUM+w5KY9uu2nQlQnY=
Date: Thu, 12 Dec 2019 11:37:02 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] object: Improve documentation of interfaces
Message-ID: <20191212003702.GR207300@umbus.fritz.box>
References: <157607116183.174911.9764813135617350231.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="magLDk5D4XGaUXcd"
Content-Disposition: inline
In-Reply-To: <157607116183.174911.9764813135617350231.stgit@bahia.lan>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--magLDk5D4XGaUXcd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2019 at 02:32:41PM +0100, Greg Kurz wrote:
> QOM interfaces allow a limited form of multiple inheritance, at the
> condition of being stateless. That is, they cannot be instantiated
> and a pointer to an interface shouldn't be dereferenceable in any way.
> This is achieved by making the QOM instance type an incomplete type,
> which is, as mentioned by Markus Armbruster, the closest you can get
> to abstract class in C.
>=20
> Incomplete types are widely used to hide implementation details, but
> people usually expect to find at least one place where the type is
> fully defined. The fact that it doesn't happen with QOM interfaces is
> quite disturbing, especially since it isn't documented anywhere as
> recently discussed in this thread:
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg01579.html
>=20
> Amend the documentation in the object.h header file to provide more
> details about why and how to implement QOM interfaces using incomplete
> types.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/qom/object.h |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 128d00c77fd6..5cf98d2c4350 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -200,8 +200,14 @@ typedef struct InterfaceInfo InterfaceInfo;
>   *
>   * Interfaces allow a limited form of multiple inheritance.  Instances a=
re
>   * similar to normal types except for the fact that are only defined by
> - * their classes and never carry any state.  You can dynamically cast an=
 object
> - * to one of its #Interface types and vice versa.
> + * their classes and never carry any state.  As a consequence, a pointer=
 to
> + * an interface instance should always be of incomplete type in order to=
 be
> + * sure it cannot be dereferenced.  That is, you should define the
> + * 'typedef struct SomethingIf SomethingIf' so that you can pass around
> + * 'SomethingIf *si' arguments, but not define a 'struct SomethingIf { .=
=2E. }'.
> + * The only things you can validly do with a 'SomethingIf *' are to pass=
 it as
> + * an argument to a method on its corresponding SomethingIfClass, or to
> + * dynamically cast it to an object that implements the interface.
>   *
>   * # Methods #
>   *
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--magLDk5D4XGaUXcd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3xi6wACgkQbDjKyiDZ
s5LC/hAAgQXjT+zbdJ1yo3O/Y54q/HMwtg4IlSsuxGSJPVEURE3Qe8/PzfI+jMdo
LddsvOZIxpDWIlbU/BfMqm4DNe0sXjDuRUY+2Feuz0iixsIqzVtiM7moLAqvDo7p
aJy5SUz36NMq84nnYrKkJJxpFM4/L2jBCuMEFqj9Ic+iiUCMtwwcR8maonp3WIKe
gWxmnBhi7yMDD3yTDsJvCYw2lahlz9raxuuxIJxGnACiLS8nbbsN+1L6h6RwWhUT
Qmhrkzg8b11zyd4cHuE6/3hUqlRZV7SCuKg3qrIQYwRxI6+xF2rgjZvdCpZFAuOw
6IArJ++1l+/ZUcNzrsnVvXp1QK69NWYyjvNnc2EihlZerpRbPWkshlpWvkDnmUum
w9ELAY3SBax2L8892dLOvzTT2x/YJ9v5rYrwQ/7K3tCyE9031ezPEeqX3jqb+TuO
qDd9Esf+S+GLV86pvRHCUlAG6pQiWgrYId/SUkAS5M0q0X4dAJ6Jq8BejGdDf69j
tInmCGnrpZlAy4jTnxlWYdMfVcCgTLfmXyjvAAd+U9y1doN2j+mKV4hamzOY8pRB
06DmJGyn5HzHZn2P90NYYZ1wXD0ClN/UVzlOx90OHGqArw1ZD0ZvnpRLoQdSB6AW
7BSfcwGIeXI0X5qc3OEhw2oiYIt9BLKPhYb/jDOWErASj3cQ8r0=
=SYcZ
-----END PGP SIGNATURE-----

--magLDk5D4XGaUXcd--

