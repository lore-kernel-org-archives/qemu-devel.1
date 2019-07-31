Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1692C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 06:35:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C8B0206A3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 06:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="SU9i6s74"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C8B0206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsiDJ-0007CN-Tm
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 02:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46830)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hsiBi-0003eo-Qf
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 02:34:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hsiBe-0001Gv-35
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 02:34:11 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:35643 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hsiBQ-00085z-5t; Wed, 31 Jul 2019 02:33:56 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45z3Xk2LDVz9sML; Wed, 31 Jul 2019 16:33:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1564554822;
 bh=QF9Nd2npC2WAxnuebDxf6Zkv7OFBLQc2pmE8vZfTVI4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SU9i6s74fl0gzjtJN90B7nMt+O8UWrDtxG1qDxnU0juN49O7WOep8Y4u7O7z8KYTZ
 noxU0GPsygJLsoECkc6HzkA1soFpasmCqvXSFUjXphvGBzZ+KtAbfFutK0v6hBSrKS
 AvTb7gmLPn5tPR/5masRoJ1iTG9jb441cE+8RdEM=
Date: Wed, 31 Jul 2019 16:05:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <20190731060533.GD2032@umbus.fritz.box>
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
 <20190729145654.14644-6-damien.hedde@greensocs.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="u65IjBhB3TIa72Vp"
Content-Disposition: inline
In-Reply-To: <20190729145654.14644-6-damien.hedde@greensocs.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
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
 berrange@redhat.com, cohuck@redhat.com, mark.burton@greensocs.com,
 qemu-ppc@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--u65IjBhB3TIa72Vp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2019 at 04:56:26PM +0200, Damien Hedde wrote:
> Deprecate old reset apis and make them use the new one while they
> are still used somewhere.
>=20
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> ---
>  hw/core/qdev.c         | 22 +++-------------------
>  include/hw/qdev-core.h | 28 ++++++++++++++++++++++------
>  2 files changed, 25 insertions(+), 25 deletions(-)
>=20
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 559ced070d..e9e5f2d5f9 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -312,25 +312,9 @@ static void device_foreach_reset_child(Object *obj, =
void (*func)(Object *))
>      }
>  }
> =20
> -static int qdev_reset_one(DeviceState *dev, void *opaque)
> -{
> -    device_legacy_reset(dev);
> -
> -    return 0;
> -}
> -
> -static int qbus_reset_one(BusState *bus, void *opaque)
> -{
> -    BusClass *bc =3D BUS_GET_CLASS(bus);
> -    if (bc->reset) {
> -        bc->reset(bus);
> -    }
> -    return 0;
> -}
> -
>  void qdev_reset_all(DeviceState *dev)
>  {
> -    qdev_walk_children(dev, NULL, NULL, qdev_reset_one, qbus_reset_one, =
NULL);
> +    device_reset(dev, false);
>  }
> =20
>  void qdev_reset_all_fn(void *opaque)
> @@ -340,7 +324,7 @@ void qdev_reset_all_fn(void *opaque)
> =20
>  void qbus_reset_all(BusState *bus)
>  {
> -    qbus_walk_children(bus, NULL, NULL, qdev_reset_one, qbus_reset_one, =
NULL);
> +    bus_reset(bus, false);
>  }
> =20
>  void qbus_reset_all_fn(void *opaque)
> @@ -922,7 +906,7 @@ static void device_set_realized(Object *obj, bool val=
ue, Error **errp)
>              }
>          }
>          if (dev->hotplugged) {
> -            device_legacy_reset(dev);
> +            device_reset(dev, true);

So.. is this change in the device_reset() signature really necessary?
Even if there are compelling reasons to handle warm reset in the new
API, that doesn't been you need to change device_reset() itself from
its established meaning of a cold (i.e. as per power cycle) reset.
Warm resets are generally called in rather more specific circumstances
(often under guest software direction) so it seems likely that users
would want to engage with the new reset API directly.  Or we could
just create a device_warm_reset() wrapper.  That would also avoid the
bare boolean parameter, which is not great for readability (you have
to look up the signature to have any idea what it means).

>          }
>          dev->pending_deleted_event =3D false;
> =20
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index eeb75611c8..1670ae41bb 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -109,6 +109,11 @@ typedef struct DeviceClass {
>      bool hotpluggable;
> =20
>      /* callbacks */
> +    /*
> +     * Reset method here is deprecated and replaced by methods in the
> +     * resettable class interface to implement a multi-phase reset.
> +     * TODO: remove once every reset callback is unused
> +     */
>      DeviceReset reset;
>      DeviceRealize realize;
>      DeviceUnrealize unrealize;
> @@ -455,19 +460,22 @@ bool bus_is_resetting(BusState *bus);
>   */
>  bool bus_is_reset_cold(BusState *bus);
> =20
> -void qdev_reset_all(DeviceState *dev);
> -void qdev_reset_all_fn(void *opaque);
> -
>  /**
> - * @qbus_reset_all:
> - * @bus: Bus to be reset.
> + * qbus/qdev_reset_all:
> + * @bus/dev: Bus/Device to be reset.
>   *
> - * Reset @bus and perform a bus-level ("hard") reset of all devices conn=
ected
> + * Reset @bus/dev and perform a bus-level reset of all devices/buses con=
nected
>   * to it, including recursive processing of all buses below @bus itself.=
  A
>   * hard reset means that qbus_reset_all will reset all state of the devi=
ce.
>   * For PCI devices, for example, this will include the base address regi=
sters
>   * or configuration space.
> + *
> + * Theses functions are deprecated, please use device/bus_reset or
> + * resettable_reset_* instead
> + * TODO: remove them when all occurence are removed
>   */
> +void qdev_reset_all(DeviceState *dev);
> +void qdev_reset_all_fn(void *opaque);
>  void qbus_reset_all(BusState *bus);
>  void qbus_reset_all_fn(void *opaque);
> =20
> @@ -489,9 +497,17 @@ void qdev_machine_init(void);
>   * device_legacy_reset:
>   *
>   * Reset a single device (by calling the reset method).
> + *
> + * This function is deprecated, please use device_reset() instead.
> + * TODO: remove the function when all occurences are removed.
>   */
>  void device_legacy_reset(DeviceState *dev);
> =20
> +/**
> + * device_class_set_parent_reset:
> + * TODO: remove the function when DeviceClass's reset method
> + * is not used anymore.
> + */
>  void device_class_set_parent_reset(DeviceClass *dc,
>                                     DeviceReset dev_reset,
>                                     DeviceReset *parent_reset);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--u65IjBhB3TIa72Vp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1BL60ACgkQbDjKyiDZ
s5IuMg//csf/rxm79GuZqdHu/zHP22hy4xbuuEa69eZihEv69seSmfAu78oqgrI8
DQGiwqgkoY0eULMmbaqYXxuluO2CNnrFPQuqA9weFZwii80uyLgXME1nHFtSBZok
9b9gLF9KERqPTMPdbNdMOLzagAbajljIB866Lrz/DT8EIuILhUE5S61DkrQiywrs
TZVMCxkKDEE+5IgC6UzmSyNBabGEzaktzyUDFelwZmF3EA2QSa8wQ032nleE2vEf
YEp872mIR18eAWgGBh/3ERHcd2+BsPQXmQUQRDWx13ezUSos2KT3JtzlOqYqBvxK
3azBaopqoZaWOucZKAlm1IhH+jvX6qnGRiOu8reUNcLLyRqw9d3EEx0JRCJn0i8D
QQ7iuNdjY2TjfD5lFl0kPEENEiHfQToO+yREpQVhRID+2o4arBxapmSb0IZqVYFk
JTaP3B3286zVJXmyL4Bz4MyUCtebUR95OUspzWnfQDt8klqKeqdzZrS2b3LxU1sm
iYsSgYTFLOSrFizrB4iDXk2aEJBq9cBIZUEUBYU5hK6up73PBz3X8r8p2D+s8n+h
gv1e25c5OYdDHKUU4vqukikt8Cf0jikJcm2Mx09iXmqsWdIBEgxHR5kjG0lpltNJ
iqwBVkuzPCSi9YVQZf+NHtxyQvI/qBOuh7NSUiRndOH+AygsCng=
=te1n
-----END PGP SIGNATURE-----

--u65IjBhB3TIa72Vp--

