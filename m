Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DABDC0650F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 00:11:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A12C214C6
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 00:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="EbHsC4RQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A12C214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvsVa-0007Bj-CD
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 20:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56589)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hvsUj-0005UX-Eg
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 20:10:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hvsUi-0004os-Ku
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 20:10:57 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:46525 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hvsUe-0004kC-D3; Thu, 08 Aug 2019 20:10:53 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 464Qck63dtz9sBF; Fri,  9 Aug 2019 10:10:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1565309446;
 bh=AN94QMwsieMhIsnCFXfNJtGDm7IVYYOGo4Ng0rCno5g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EbHsC4RQSES79jjCvDvd+K5j/MyZfLaBHkJEUVz3/yvNcDtVlJPPo2u/9UPlgqNlB
 WmG4gp8pFUUJaSSZ3iqtCOI3V0JWZqoRgrSEYjFSyx5fS0TFu14HpKwTlOnfdPWjCt
 QaeIYX14rK1ZLzP4h924b4laNmah7QEJO/YJwVWA=
Date: Thu, 8 Aug 2019 16:47:12 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190808064712.GD5465@umbus.fritz.box>
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
 <20190729145654.14644-6-damien.hedde@greensocs.com>
 <20190731060533.GD2032@umbus.fritz.box>
 <51aa7e6d-3568-8485-4b67-a598a24a1f3d@greensocs.com>
 <e7b05c24-ecd1-a437-7d97-07d69ab759ec@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="KdquIMZPjGJQvRdI"
Content-Disposition: inline
In-Reply-To: <e7b05c24-ecd1-a437-7d97-07d69ab759ec@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v3 05/33] Switch to new api in qdev/bus
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
Cc: fam@euphon.net, peter.maydell@linaro.org, walling@linux.ibm.com,
 dmitry.fleytman@gmail.com, mst@redhat.com, mark.cave-ayland@ilande.co.uk,
 qemu-devel@nongnu.org, kraxel@redhat.com, edgar.iglesias@xilinx.com,
 hare@suse.com, qemu-block@nongnu.org, david@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, marcandre.lureau@redhat.com, thuth@redhat.com,
 ehabkost@redhat.com, alistair@alistair23.me, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, clg@kaod.org, jsnow@redhat.com, rth@twiddle.net,
 Damien Hedde <damien.hedde@greensocs.com>, berrange@redhat.com,
 cohuck@redhat.com, mark.burton@greensocs.com, qemu-ppc@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--KdquIMZPjGJQvRdI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2019 at 01:31:28PM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 7/31/19 11:29 AM, Damien Hedde wrote:
> > On 7/31/19 8:05 AM, David Gibson wrote:
> >> On Mon, Jul 29, 2019 at 04:56:26PM +0200, Damien Hedde wrote:
> >>> Deprecate old reset apis and make them use the new one while they
> >>> are still used somewhere.
> >>>
> >>> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> >>> ---
> >>>  hw/core/qdev.c         | 22 +++-------------------
> >>>  include/hw/qdev-core.h | 28 ++++++++++++++++++++++------
> >>>  2 files changed, 25 insertions(+), 25 deletions(-)
> >>>
> >>> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> >>> index 559ced070d..e9e5f2d5f9 100644
> >>> --- a/hw/core/qdev.c
> >>> +++ b/hw/core/qdev.c
> >>> @@ -312,25 +312,9 @@ static void device_foreach_reset_child(Object *o=
bj, void (*func)(Object *))
> >>>      }
> >>>  }
> >>> =20
> >>> -static int qdev_reset_one(DeviceState *dev, void *opaque)
> >>> -{
> >>> -    device_legacy_reset(dev);
> >>> -
> >>> -    return 0;
> >>> -}
> >>> -
> >>> -static int qbus_reset_one(BusState *bus, void *opaque)
> >>> -{
> >>> -    BusClass *bc =3D BUS_GET_CLASS(bus);
> >>> -    if (bc->reset) {
> >>> -        bc->reset(bus);
> >>> -    }
> >>> -    return 0;
> >>> -}
> >>> -
> >>>  void qdev_reset_all(DeviceState *dev)
> >>>  {
> >>> -    qdev_walk_children(dev, NULL, NULL, qdev_reset_one, qbus_reset_o=
ne, NULL);
> >>> +    device_reset(dev, false);
> >>>  }
> >>> =20
> >>>  void qdev_reset_all_fn(void *opaque)
> >>> @@ -340,7 +324,7 @@ void qdev_reset_all_fn(void *opaque)
> >>> =20
> >>>  void qbus_reset_all(BusState *bus)
> >>>  {
> >>> -    qbus_walk_children(bus, NULL, NULL, qdev_reset_one, qbus_reset_o=
ne, NULL);
> >>> +    bus_reset(bus, false);
> >>>  }
> >>> =20
> >>>  void qbus_reset_all_fn(void *opaque)
> >>> @@ -922,7 +906,7 @@ static void device_set_realized(Object *obj, bool=
 value, Error **errp)
> >>>              }
> >>>          }
> >>>          if (dev->hotplugged) {
> >>> -            device_legacy_reset(dev);
> >>> +            device_reset(dev, true);
> >>
> >> So.. is this change in the device_reset() signature really necessary?
> >> Even if there are compelling reasons to handle warm reset in the new
> >> API, that doesn't been you need to change device_reset() itself from
> >> its established meaning of a cold (i.e. as per power cycle) reset.
> >> Warm resets are generally called in rather more specific circumstances
> >> (often under guest software direction) so it seems likely that users
> >> would want to engage with the new reset API directly.  Or we could
> >> just create a device_warm_reset() wrapper.  That would also avoid the
> >> bare boolean parameter, which is not great for readability (you have
> >> to look up the signature to have any idea what it means).
>=20
> If the boolean is not meaningful, we can use an enum...

That's certainly better, but I'm not seeing a compelling reason not to
have separate function names.  It's just as clear and means less churn.

>=20
> > I've added device_reset_cold/warm wrapper functions to avoid having to
> > pass the boolean parameter. it seems I forgot to use them in qdev.c
> > I suppose, like you said, we could live with
> > + no function with the boolean parameter
> > + device_reset doing cold reset
> > + device_reset_warm (or device_warm_reset) for the warm version
> >=20
> > Damien
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--KdquIMZPjGJQvRdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1LxW0ACgkQbDjKyiDZ
s5Jxfw//WtrJvoUNYAdiXZaOZxpcyKgroiTlPM+S9ursS8mv4OIeIl1MkJiNfw7F
ODFJENo9pbSsq9mDKvowt6O1kmuzRBIsaM3vo0ClFDMl49bYEWkP3W6m+YUDnteD
FLJmJeIXyOAlYmURmvslDWB4fXB1JWDCPKGYU/qjrWe/kP3PKMbsyrSML4GtWyZg
rk9sx/7evi8xTmQpjBqy/Kkbr5eKvSZrd+2gNJpmK9/pBbKxBXeZubIs2yGC9TU0
6e+VxkZYq2TOHoPgWHktU8aj/71oyc0W/IWSKfMqeLdekB1zVW47qEnqz9l4Hg9w
Cz/y6S94habmB/Xi4RERzw4VgYQhNZksyjqgAV5XYTODeDxoELk/hXJMqwtKE/FS
lxU1eyvaU2KPhf5lKmTd2ZaZb8AXYY1wiTvOO5xK7Pq0afISIWzCT3IXutV3HRaZ
pi6dggaAgORM7CbcgB4AAI+woHr8gQXhJn2cnv6fivIK/BrGJ7mPfbHi0r7C9AM3
kdLXDoOQ2hl4vuM49ywREtxCywxzIPt4cht+yVUF+rVkvZIv1RmaFkxJLxtIcsmC
f6cH0Vqdp0JvFmTZ0RVUzjEkK9j53Kd1FUDtWrqNHMAGpXG/ePQqAGgifprm1aE1
Eqw7sTaca+/3n8arKRo+x62y7knpAv/7pzRVKzj+WVS0kUyW6yA=
=wzJJ
-----END PGP SIGNATURE-----

--KdquIMZPjGJQvRdI--

