Return-Path: <SRS0=JchA=UW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B6EC43613
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2019 10:17:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1D3420663
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2019 10:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="F+eDGaqS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1D3420663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43858 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hezYc-00057b-VX
	for qemu-devel@archiver.kernel.org; Sun, 23 Jun 2019 06:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51765)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hezWt-0004LV-6V
 for qemu-devel@nongnu.org; Sun, 23 Jun 2019 06:15:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hezWr-0005Le-84
 for qemu-devel@nongnu.org; Sun, 23 Jun 2019 06:15:22 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:40085)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1hezWp-0004x6-01
 for qemu-devel@nongnu.org; Sun, 23 Jun 2019 06:15:19 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45WpFc1bm3z9sBp; Sun, 23 Jun 2019 20:15:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1561284900;
 bh=v0lUron4g3lIrg+nkhpIfFlNzjB/N10qL5gkmuF/1wk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=F+eDGaqSjShosl93ccsBKxhzCDSf9yJtaSegKCGJINzdvARYd19ZsmmpmvvCyJ4Uu
 nuHb0klFB6dkQS/bRoMb/MNMVtceWIZ/E4M4zdDCai1JvgzDWC+PhZBtD3aqfFxlVu
 f5S8ozom9c6zQQhoamEfQcsq4R+0fx2xB25oS3uE=
Date: Sun, 23 Jun 2019 13:09:57 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Fabiano Rosas <farosas@linux.ibm.com>
Message-ID: <20190623030957.GI8232@umbus.BigPond>
References: <20190621220120.15567-1-farosas@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MFZs98Tklfu0WsCO"
Content-Disposition: inline
In-Reply-To: <20190621220120.15567-1-farosas@linux.ibm.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH] vfio-common.h: Remove inaccurate comment
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--MFZs98Tklfu0WsCO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2019 at 07:01:20PM -0300, Fabiano Rosas wrote:
> This is a left-over from "f4ec5e26ed vfio: Add host side DMA window
> capabilities", which added support to more than one DMA window.
>=20
> Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/hw/vfio/vfio-common.h | 5 -----
>  1 file changed, 5 deletions(-)
>=20
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index a88b69b675..9107bd41c0 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -74,11 +74,6 @@ typedef struct VFIOContainer {
>      int error;
>      bool initialized;
>      unsigned long pgsizes;
> -    /*
> -     * This assumes the host IOMMU can support only a single
> -     * contiguous IOVA window.  We may need to generalize that in
> -     * future
> -     */
>      QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
>      QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
>      QLIST_HEAD(, VFIOGroup) group_list;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--MFZs98Tklfu0WsCO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0O7YMACgkQbDjKyiDZ
s5INqg//XMir5S20ojUPArcN1KkruLw51cpzD7LINEHjcbloQVOlBxgOHf7pN8IO
s4hpFyWmm2prFrJ7CEpxq7zpFcK9Xwbte6L3/HNN3wcCUxc2MURgKmwURB0QARFI
TszGLxzYkZi7Rf/p7iad8m7J/JywQxwVO8mFR+09n4vH5jGtJ4f2qLiHc8pOniC1
S7CBGzIqATzdmDU9gbR2SG9b1ZPLCKCSy/Is9zsCPzf24P5TZRRZFa9T48NYQk+U
fzfzGCJYSLJLBlTcheejFvvUdT2JSfTw2IwK1c5SMSBxa8wagldvk9hR9AlvGgGL
PJU+zioS41iVsRcGyNuigd5sZ8MjRk1Ixw/ae5x7RmPgKiCRP7Sc7tOAgwr1+DnE
2DRbBaYg0kzzqZ9Igw1C+Y3RLJh0RGuX1hj2me42puXs+ah+7axqryPX5OKfiSJc
kYuvGq7Miy/jMxO0tH9W2Tdax9/sYJB4gL6ef8039ql/mGfGm9ERThhLEanbPNJb
QOuiyGVUloi9RUwoItikthqBPvNi6AwMO0EKE1pZBthnbcdmQDYm6f6t3ClMtHKw
h62+9I9/C+JhMZWlJjX+pgOeaJ4QUkbs3d0Z6wPrqbgJzsCpImTWO5JboxFCIHwh
D5mJmJzMQ73C50W3lvp+MpXKMqUgSHf2l3qF1oCU1FP9V3n33qc=
=nrUZ
-----END PGP SIGNATURE-----

--MFZs98Tklfu0WsCO--

