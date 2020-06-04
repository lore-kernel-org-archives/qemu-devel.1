Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B43EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 06:43:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59C00206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 06:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="B/XRLQ5p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59C00206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgjax-0006KB-LX
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 02:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jgjaD-0004y0-6W; Thu, 04 Jun 2020 02:42:33 -0400
Received: from ozlabs.org ([203.11.71.1]:60285)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jgjaC-0000mm-3S; Thu, 04 Jun 2020 02:42:32 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49cx6B6VvTz9sSn; Thu,  4 Jun 2020 16:42:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1591252946;
 bh=6G/gF3437maKhqjxu2Yk3xugw2aP4N0KazG6x+U1Dfs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=B/XRLQ5p7DfKz9GX83a8grChBaB0/LnOBbK+vpwaijYcdSBw4QTvRU4kSico5gfi6
 dxL7akTHVgNPjsb27akPHzZoEM1tQbRSpy+AE+FROEV4XGQQFo1MfIEFVUPBgqBwba
 Hca1pdSBSyhwEZDwcY3WB1hxOPO0JvHI4npyk0UE=
Date: Thu, 4 Jun 2020 16:25:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [RFC v2 14/18] guest memory protection: Rework the
 "memory-encryption" property
Message-ID: <20200604062515.GH228651@umbus.fritz.box>
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
 <20200521034304.340040-15-david@gibson.dropbear.id.au>
 <4061fcf0-ba76-5124-74eb-401a0b91d900@linaro.org>
 <20200604055638.GF228651@umbus.fritz.box>
 <18d57013-e17d-18c0-25b5-af2b2554f029@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="uJrvpPjGB3z5kYrA"
Content-Disposition: inline
In-Reply-To: <18d57013-e17d-18c0-25b5-af2b2554f029@redhat.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 02:12:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: pair@us.ibm.com, brijesh.singh@amd.com,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 dgilbert@redhat.com, frankja@linux.ibm.com, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, mdroth@linux.vnet.ibm.com,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--uJrvpPjGB3z5kYrA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 04, 2020 at 08:19:41AM +0200, Thomas Huth wrote:
> On 04/06/2020 07.56, David Gibson wrote:
> > On Mon, Jun 01, 2020 at 08:54:42PM -0700, Richard Henderson wrote:
> >> On 5/20/20 8:43 PM, David Gibson wrote:
> >>> +++ b/include/hw/boards.h
> >>> @@ -12,6 +12,8 @@
> >>>  #include "qom/object.h"
> >>>  #include "hw/core/cpu.h"
> >>> =20
> >>> +typedef struct GuestMemoryProtection GuestMemoryProtection;
> >>> +
> >>
> >> I think this needs to be in include/qemu/typedefs.h,
> >> and the other typedef in patch 10 needs to be moved there.
> >>
> >> IIRC, clang warns about duplicate typedefs.
> >=20
> > Not, apparently, with the clang version I have, but I've made the
> > change anyway.
>=20
> FWIW, we got rid of that duplicated typedef problem in commit
> e6e90feedb706b1b92, no need to worry about that anymore.

Ah, right.  I think I'll leave it as is though - it kind of makes
sense to have all the incomplete structure typedefs in one place.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--uJrvpPjGB3z5kYrA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl7Yk8sACgkQbDjKyiDZ
s5IpLhAAwWHyQzsLr9RyJimMwiORUlOZsfAhbZVu7EkIL3kLBvFbyfp0NPiy9TKf
0NnXZcOW43cOnJH/W5cBjOhyoVgAIT3op9CTINXxowRiOErhWzLNSuH6G9TzA2Tt
p9Jbe9i6qzoaptGbs5uSkyJLp/NuKIC7araOVNaVqqVyTQHcdeYhOmaiwEAvqlrA
vw2wQYnOqiFISRFq/HoMyqqYl8FEKC1HgR5sXLl0cqXpPDtBCZYQr7zK5DMY25K9
hE3pS5PW7kce1g4mhrbkBGVnB9JpSpFVjV2KC4OKjaLCq6rFUHbxTKXEDGHB5WKi
K80IkOEF/62gn+xX3sNue1AYkNtm2Ylo8XGpvlfPG0MpwNnWs3tgOFbgFKCdyiKa
VbV9HAdQYC5PfFnqzeWc5ykvbiPFPNbHThqmlpvnLC+zLT1slPNMlslaNXQswxen
IxuiKI+4Ckk0SoI8/QOckrfJ81uT0hsVd1SWkx2XJd/RCCY/lwY7elfPAl4XF/Jb
1KhJlksitH74u11Frc4Z1Ypz75q225XIu3ojzM59nY9wmdxwzu5+G3Xlj02dypT/
n2bGNPscFjytp4zQmtpJJ3od1Aet7GN4hNRyJ58lN2vaOQOZW519FsyCq0dkxtwP
MtV+uMM/o3o8gzIafgeSS1h0fwxJOFBAfh8i+A+71UH3vnZBDf0=
=jYs3
-----END PGP SIGNATURE-----

--uJrvpPjGB3z5kYrA--

