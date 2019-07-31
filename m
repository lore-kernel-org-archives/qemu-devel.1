Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891EDC32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 06:36:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 519D2206A3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 06:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="mdUmVcay"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 519D2206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38309 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsiDs-0000Mn-FO
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 02:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46724)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hsiBe-0003bX-2X
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 02:34:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hsiBa-00019G-TJ
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 02:34:09 -0400
Received: from ozlabs.org ([203.11.71.1]:45971)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hsiBL-00086J-0A; Wed, 31 Jul 2019 02:33:52 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45z3Xk4z4Vz9sMr; Wed, 31 Jul 2019 16:33:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1564554822;
 bh=GwcyTEln1jYY3LzdIKE7lFauBXJ4alh9w5AgOOIslmY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mdUmVcayDTPOQJ0fRDdXpq07sFs/VI6Ah4Uo+/PP8sWRpgyCM97Icb1vPHK2iikzx
 u2ETDgtGXKSwl2hctvz3giC2d7AhEkkmLO2kjGI7oaHHoERT2l4rTiJfFmyJfIzDHy
 y8x07Qzwvq+UuMLfN1TRAZHmnWVKIPkzk4PZFbUA=
Date: Wed, 31 Jul 2019 16:11:08 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <20190731061108.GF2032@umbus.fritz.box>
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
 <20190729145654.14644-9-damien.hedde@greensocs.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gdTfX7fkYsEEjebm"
Content-Disposition: inline
In-Reply-To: <20190729145654.14644-9-damien.hedde@greensocs.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v3 08/33] Add function to control reset
 with gpio inputs
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


--gdTfX7fkYsEEjebm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2019 at 04:56:29PM +0200, Damien Hedde wrote:
> It adds the possibility to add 2 gpios to control the warm and cold reset.
> With theses ios, the reset can be maintained during some time.
> Each io is associated with a state to detect level changes.
>=20
> Vmstate subsections are also added to the existsing device_reset
> subsection.

This doesn't seem like a thing that should be present on every single
DeviceState.

>=20
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> ---
>  hw/core/qdev-vmstate.c | 15 ++++++++++
>  hw/core/qdev.c         | 65 ++++++++++++++++++++++++++++++++++++++++++
>  include/hw/qdev-core.h | 57 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 137 insertions(+)
>=20
> diff --git a/hw/core/qdev-vmstate.c b/hw/core/qdev-vmstate.c
> index 24f8465c61..72f84c6cee 100644
> --- a/hw/core/qdev-vmstate.c
> +++ b/hw/core/qdev-vmstate.c
> @@ -24,10 +24,23 @@ static int device_vmstate_reset_post_load(void *opaqu=
e, int version_id)
>  {
>      DeviceState *dev =3D (DeviceState *) opaque;
>      BusState *bus;
> +    uint32_t io_count =3D 0;
> +
>      QLIST_FOREACH(bus, &dev->child_bus, sibling) {
>          bus->resetting =3D dev->resetting;
>          bus->reset_is_cold =3D dev->reset_is_cold;
>      }
> +
> +    if (dev->cold_reset_input.state) {
> +        io_count +=3D 1;
> +    }
> +    if (dev->warm_reset_input.state) {
> +        io_count +=3D 1;
> +    }
> +    /* ensure resetting count is coherent with io states */
> +    if (dev->resetting < io_count) {
> +        return -1;
> +    }
>      return 0;
>  }
> =20
> @@ -40,6 +53,8 @@ const struct VMStateDescription device_vmstate_reset =
=3D {
>      .fields =3D (VMStateField[]) {
>          VMSTATE_UINT32(resetting, DeviceState),
>          VMSTATE_BOOL(reset_is_cold, DeviceState),
> +        VMSTATE_BOOL(cold_reset_input.state, DeviceState),
> +        VMSTATE_BOOL(warm_reset_input.state, DeviceState),
>          VMSTATE_END_OF_LIST()
>      },
>  };
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 88387d3743..11a4de55ea 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -450,6 +450,67 @@ void qdev_init_gpio_in(DeviceState *dev, qemu_irq_ha=
ndler handler, int n)
>      qdev_init_gpio_in_named(dev, handler, NULL, n);
>  }
> =20
> +static DeviceResetInputState *device_get_reset_input_state(DeviceState *=
dev,
> +                                                            bool cold)
> +{
> +    return cold ? &dev->cold_reset_input : &dev->warm_reset_input;
> +}
> +
> +static void device_reset_handler(DeviceState *dev, bool cold, bool level)
> +{
> +    DeviceResetInputState *dris =3D device_get_reset_input_state(dev, co=
ld);
> +
> +    if (dris->type =3D=3D DEVICE_RESET_ACTIVE_LOW) {
> +        level =3D !level;
> +    }
> +
> +    if (dris->state =3D=3D level) {
> +        /* io state has not changed */
> +        return;
> +    }
> +
> +    dris->state =3D level;
> +
> +    if (level) {
> +        resettable_assert_reset(OBJECT(dev), cold);
> +    } else {
> +        resettable_deassert_reset(OBJECT(dev));
> +    }
> +}
> +
> +static void device_cold_reset_handler(void *opaque, int n, int level)
> +{
> +    device_reset_handler((DeviceState *) opaque, true, level);
> +}
> +
> +static void device_warm_reset_handler(void *opaque, int n, int level)
> +{
> +    device_reset_handler((DeviceState *) opaque, false, level);
> +}
> +
> +void qdev_init_reset_gpio_in_named(DeviceState *dev, const char *name,
> +                                   bool cold, DeviceResetActiveType type)
> +{
> +    DeviceResetInputState *dris =3D device_get_reset_input_state(dev, co=
ld);
> +    qemu_irq_handler handler;
> +
> +    switch (type) {
> +    case DEVICE_RESET_ACTIVE_LOW:
> +    case DEVICE_RESET_ACTIVE_HIGH:
> +        break;
> +    default:
> +        assert(false);
> +        break;
> +    }
> +
> +    assert(!dris->exists);
> +    dris->exists =3D true;
> +    dris->type =3D type;
> +
> +    handler =3D cold ? device_cold_reset_handler : device_warm_reset_han=
dler;
> +    qdev_init_gpio_in_named(dev, handler, name, 1);
> +}
> +
>  void qdev_init_gpio_out_named(DeviceState *dev, qemu_irq *pins,
>                                const char *name, int n)
>  {
> @@ -1007,6 +1068,10 @@ static void device_initfn(Object *obj)
>      dev->instance_id_alias =3D -1;
>      dev->realized =3D false;
>      dev->resetting =3D 0;
> +    dev->cold_reset_input.exists =3D false;
> +    dev->cold_reset_input.state =3D false;
> +    dev->warm_reset_input.exists =3D false;
> +    dev->warm_reset_input.state =3D false;
> =20
>      object_property_add_bool(obj, "realized",
>                               device_get_realized, device_set_realized, N=
ULL);
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 926d4bbcb1..f724ddc8f4 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -136,6 +136,23 @@ struct NamedGPIOList {
>      QLIST_ENTRY(NamedGPIOList) node;
>  };
> =20
> +typedef enum DeviceResetActiveType {
> +    DEVICE_RESET_ACTIVE_LOW,
> +    DEVICE_RESET_ACTIVE_HIGH,
> +} DeviceResetActiveType;
> +
> +/**
> + * DeviceResetInputState:
> + * @exists: tell if io exists
> + * @type: tell whether the io active low or high
> + * @state: true if reset is currently active
> + */
> +typedef struct DeviceResetInputState {
> +    bool exists;
> +    DeviceResetActiveType type;
> +    bool state;
> +} DeviceResetInputState;
> +
>  /**
>   * DeviceState:
>   * @realized: Indicates whether the device has been fully constructed.
> @@ -143,6 +160,8 @@ struct NamedGPIOList {
>   * used to count how many times reset has been initiated on the device.
>   * @reset_is_cold: If the device is under reset, indicates whether it is=
 cold
>   * or warm.
> + * @cold_reset_input: state data for cold reset io
> + * @warm_reset_input: state data for warm reset io
>   *
>   * This structure should not be accessed directly.  We declare it here
>   * so that it can be embedded in individual device state structures.
> @@ -167,6 +186,8 @@ struct DeviceState {
>      uint32_t resetting;
>      bool reset_is_cold;
>      bool reset_hold_needed;
> +    DeviceResetInputState cold_reset_input;
> +    DeviceResetInputState warm_reset_input;
>  };
> =20
>  struct DeviceListener {
> @@ -372,6 +393,42 @@ static inline void qdev_init_gpio_in_named(DeviceSta=
te *dev,
>  void qdev_pass_gpios(DeviceState *dev, DeviceState *container,
>                       const char *name);
> =20
> +/**
> + * qdev_init_reset_gpio_in_named:
> + * Create a gpio controlling the warm or cold reset of the device.
> + *
> + * @cold: specify whether it triggers cold or warm reset
> + * @type: what kind of reset io it is
> + *
> + * Note: the io is considered created in its inactive state. No reset
> + * is started by this function.
> + */
> +void qdev_init_reset_gpio_in_named(DeviceState *dev, const char *name,
> +                                   bool cold, DeviceResetActiveType type=
);
> +
> +/**
> + * qdev_init_warm_reset_gpio:
> + * Create the input to control the device warm reset.
> + */
> +static inline void qdev_init_warm_reset_gpio(DeviceState *dev,
> +                                             const char *name,
> +                                             DeviceResetActiveType type)
> +{
> +    qdev_init_reset_gpio_in_named(dev, name, false, type);
> +}
> +
> +/**
> + * qdev_init_cold_reset_gpio:
> + * Create the input to control the device cold reset.
> + * It can also be used as a power gate control.
> + */
> +static inline void qdev_init_cold_reset_gpio(DeviceState *dev,
> +                                             const char *name,
> +                                             DeviceResetActiveType type)
> +{
> +    qdev_init_reset_gpio_in_named(dev, name, true, type);
> +}
> +
>  BusState *qdev_get_parent_bus(DeviceState *dev);
> =20
>  /*** BUS API. ***/

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gdTfX7fkYsEEjebm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1BMPwACgkQbDjKyiDZ
s5IINxAA4Vc6I8WjwCTpZSPAI8fdiXVCNWOqdTRWDmIDckrchhPkZ6RorQme66uw
KpvksM8X0u5HcDkTvDiXhLcI2BxlZd5ibI56wgcZlxmAXUW95bwuopS5Nyn4yuWV
UolClo3rwERQX6MjDO8N0aYovFngH9ebF2sYGu28PLNUxDuRrRGX1FhyJQ1eHPnY
UyT8Oh4KbLzJjTTIEFmW4yRVKkg7yCd4R/lXwaQqKFo6xvSsNt/S6PwX8DfTMtf3
qbdnIKjwTxgGyDI4ZdggmDOir33C80J5obC1IPLznXXtWCAwHmvgPcaF36o0wG8Z
ETSBtJY2jVOmfme1Z7UGsIWmxkyDsGSjwG5NSKA94pYdU3BjTSK9UvfwLBil34mP
qjmTS88fW5+6rhG8bTMUyzHfkZnPG1D9quE5EDvFb4iTzVOu5UX1oMrpouVE3nlU
Gp0qK4w58A1mPomC5AMq1sCidK1AD0qILZKYxsnd0J+cu72OfhxUgehZqPkyo16g
SRDendKFvkKEBMm8lUtqUFuDlONfWoJT4MZNM+SlxWNAHx+rMtTHSRHahkqEh6BV
eyP9R45/X7t4ucUtBtm0XNXzxqVPDY5Hg+awVPE8mXH6SVsCIX4rYBJlcXd0AjaY
lb35GPT+0jDVe/Z6+ZAujCEGxqJ0XOqzYtY5pmpVJJhq9bTRL3g=
=p8+m
-----END PGP SIGNATURE-----

--gdTfX7fkYsEEjebm--

