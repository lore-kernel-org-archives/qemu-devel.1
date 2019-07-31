Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD7DC433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 06:36:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16590206A3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 06:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="MXEoMv3p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16590206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsiEC-00015U-Cy
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 02:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47188)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hsiBm-0003ph-N8
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 02:34:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hsiBj-0001ML-S5
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 02:34:18 -0400
Received: from ozlabs.org ([203.11.71.1]:58429)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hsiBQ-0000KO-GW; Wed, 31 Jul 2019 02:33:57 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45z3Xl0T85z9sN6; Wed, 31 Jul 2019 16:33:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1564554823;
 bh=lhKFUlcqXUWUHnuDUXNCadW3btjJUEJeC4/cXTJe+QQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MXEoMv3pI5bb7Qoy8jD2Zt1dE9bZVikz1JUiatW+QDy2GxSv3LxsTsCyXxrXMzD47
 bGAGcGj2JQzxKhd7ARSNs3SSOANmr5b9m0kxFNVpVpwzx/t0yxnyd7wFDhcmAYUsLz
 fnUTMn+791Yst2sBlHD/GQcY5Q2CBcKiIalpAIAM=
Date: Wed, 31 Jul 2019 16:30:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <20190731063044.GG2032@umbus.fritz.box>
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
 <20190729145654.14644-10-damien.hedde@greensocs.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gm5TwAJMO0F2iVRz"
Content-Disposition: inline
In-Reply-To: <20190729145654.14644-10-damien.hedde@greensocs.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v3 09/33] add doc about Resettable interface
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


--gm5TwAJMO0F2iVRz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2019 at 04:56:30PM +0200, Damien Hedde wrote:
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> ---
>  docs/devel/reset.txt | 165 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 165 insertions(+)
>  create mode 100644 docs/devel/reset.txt
>=20
> diff --git a/docs/devel/reset.txt b/docs/devel/reset.txt
> new file mode 100644
> index 0000000000..c7a1eb068f
> --- /dev/null
> +++ b/docs/devel/reset.txt
> @@ -0,0 +1,165 @@
> +
> +=3D=3D=3D=3D=3D
> +Reset
> +=3D=3D=3D=3D=3D
> +
> +The reset of qemu objects is handled using the Resettable interface decl=
ared
> +in *include/hw/resettable.h*.
> +As of now DeviceClass and BusClass implement this interface.
> +
> +
> +Triggering reset
> +----------------
> +
> +The function *resettable_reset* is used to trigger a reset on a given
> +object.
> +void resettable_reset(Object *obj, bool cold)
> +
> +The parameter *obj* must implement the Resettable interface.

And what happens if it doesn't?  This function has no way to report an
error.

> +The parameter *cold* is a boolean specifying whether to do a cold or warm
> +reset

This doc really needs to explain the distinction between cold and warm
reset.

> +For Devices and Buses there is also the corresponding helpers:
> +void device_reset(Device *dev, bool cold)
> +void bus_reset(Device *dev, bool cold)

What's the semantic difference between resetting a bus and resetting
the bridge device which owns it?

> +If one wants to put an object into a reset state. There is the
> +*resettable_assert_reset* function.
> +void resettable_assert_reset(Object *obj, bool cold)
> +
> +One must eventually call the function *resettable_deassert_reset* to end=
 the
> +reset state:
> +void resettable_deassert_reset(Object *obj, bool cold)
> +
> +Calling *resettable_assert_reset* then *resettable_deassert_reset* is the
> +same as calling *resettable_reset*.
> +
> +It is possible to interleave multiple calls to
> + - resettable_reset,
> + - resettable_assert_reset, and
> + - resettable_deassert_reset.
> +The only constraint is that *resettable_deassert_reset* must be called o=
nce
> +per *resettable_assert_reset* call so that the object leaves the reset s=
tate.
> +
> +Therefore there may be several reset sources/controllers of a given obje=
ct.
> +The interface handle everything and the controllers do not need to know
> +anything about each others. The object will leave reset state only when =
all
> +controllers released their reset.
> +
> +All theses functions must called while holding the iothread lock.
> +
> +
> +Implementing reset for a Resettable object : Multi-phase reset
> +--------------------------------------------------------------
> +
> +The Resettable uses a multi-phase mechanism to handle some ordering cons=
traints
> +when resetting multiple object at the same time. For a given object the =
reset
> +procedure is split into three different phases executed in order:
> + 1 INIT: This phase should set/reset the state of the Resettable it has =
when is
> +         in reset state. Side-effects to others object is forbidden (suc=
h as
> +         setting IO level).
> + 2 HOLD: This phase corresponds to the external side-effects due to stay=
ing into
> +         the reset state.
> + 3 EXIT: This phase corresponds to leaving the reset state. It have both
> +         local and external effects.
> +
> +*resettable_assert_reset* does the INIT and HOLD phases. While
> +*resettable_deassert_reset* does the EXIT phase.
> +
> +When resetting multiple object at the same time. The interface executes =
the
> +given phase of the objects before going to the next phase. This guarante=
e that
> +all INIT phases are done before any HOLD phase and so on.
> +
> +There is three methods in the interface so must be implemented in an obj=
ect.
> +The methods corresponds to the three phases:
> +```
> +typedef void (*ResettableInitPhase)(Object *obj);
> +typedef void (*ResettableHoldPhase)(Object *obj);
> +typedef void (*ResettableExitPhase)(Object *obj);
> +typedef struct ResettableClass {
> +    InterfaceClass parent_class;
> +
> +    struct ResettablePhases {
> +        ResettableInitPhase init;
> +        ResettableHoldPhase hold;
> +        ResettableExitPhase exit;
> +    } phases;
> +    [...]
> +} ResettableClass;
> +```
> +
> +Theses methods should be updated when specializing an object. For this t=
he
> +helper function *resettable_class_set_parent_reset_phases* can be used to
> +backup parent methods while changing the specialized ones.
> +void resettable_class_set_parent_reset_phases(ResettableClass *rc,
> +                                              ResettableInitPhase init,
> +                                              ResettableHoldPhase hold,
> +                                              ResettableExitPhase exit,
> +
> +For Devices and Buses, some helper exists to know if a device/bus is und=
er
> +reset and what type of reset it is:
> +```
> +bool device_is_resetting(DeviceState *dev);
> +bool device_is_reset_cold(DeviceState *dev);

It's not really clear to me when *_is_reset_cold() would be useful.

> +bool bus_is_resetting(BusState *bus);
> +bool bus_is_reset_cold(BusState *bus);
> +```
> +
> +
> +Implementing the base Resettable behavior : Re-entrance, Hierarchy and C=
old/Warm
> +------------------------------------------------------------------------=
--------
> +
> +There is five others methods in the interface to handle the base mechani=
cs
> +of the Resettable interface. The methods should be implemented in object
> +base class. DeviceClass and BusClass implement them.
> +
> +```
> +typedef bool (*ResettableSetCold)(Object *obj, bool cold);
> +typedef bool (*ResettableSetHoldNeeded)(Object *obj, bool hold_needed);
> +typedef uint32_t (*ResettableGetCount)(Object *obj);
> +typedef uint32_t (*ResettableIncrementCount)(Object *obj);
> +typedef uint32_t (*ResettableDecrementCount)(Object *obj);
> +typedef void (*ResettableForeachChild)(Object *obj, void (*visitor)(Obje=
ct *));
> +typedef struct ResettableClass {
> +    InterfaceClass parent_class;
> +
> +    [...]
> +
> +    ResettableSetCold set_cold;
> +    ResettableSetHoldNeeded set_hold_needed;
> +    ResettableGetCount get_count;
> +    ResettableIncrementCount increment_count;
> +    ResettableDecrementCount decrement_count;
> +    ResettableForeachChild foreach_child;
> +} ResettableClass;
> +```
> +
> +*set_cold* is used when entering reset, before calling the init phase, to
> +indicate the reset type.
> +
> +*set_hold_needed* is used to set/clear and retrieve an "hold_needed" fla=
g.
> +This flag allows to omly execute the hold pahse when required.
> +
> +As stated above, several reset procedures can be concurrent on an object.
> +This is handled with the three methods *get_count*, *increment_count* and
> +*decrement_count*. An object is in reset state if the count is non-zero.
> +
> +The reset hierarchy is handled using the *foreach_child* method. This me=
thod
> +executes a given function on every reset "child".
> +
> +In DeviceClass and BusClass the base behavior is to mimic the legacy qdev
> +reset. Reset hierarchy follows the qdev/qbus tree.
> +
> +Reset control through GPIO
> +--------------------------
> +
> +For devices, two reset inputs can be added: one for the cold, one the wa=
rm
> +reset. This is done using the following function.
> +```
> +typedef enum DeviceResetActiveType {
> +    DEVICE_RESET_ACTIVE_LOW,
> +    DEVICE_RESET_ACTIVE_HIGH,
> +} DeviceResetActiveType;
> +void qdev_init_reset_gpio_in_named(DeviceState *dev, const char *name,
> +                                   bool cold, DeviceResetActiveType type=
);
> +```

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gm5TwAJMO0F2iVRz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1BNZEACgkQbDjKyiDZ
s5LM4w//SL0C4gnI3wMv7jfhk7z2mpqiWd2qrgtrG2CLfc5l0gDrrlTzm7RpRWjj
Ly/tjC/eWLzMceXGF1787Z7WsXuw7y/0eRcHKuRtB2luKyZ77xF11t02Aj9vUERY
989b38kmjmOKdPxGuWhcxa/Dk2P6fsDqHuRxofUZfj7f8w8z+ewZfPh/pJEd3q2e
Atnezbb8JnflvUIGTe+BaXi1Ywhd0Fo5O5aJ1WZdiIohU9vGXK5D5C8GZC9M6OFH
sSR7JsyAjqIR0L4exq9O9R5V2r+F+1z5BtKNcCQQ+tHgrTGpfKVZMWFBX+BAAG1V
YDhgdZ8vqBlr3W52Y0nZOuNc1Xwxx2Z9mCkHDqshfB5JJFRl1kI9N45dm6HcX73h
RqhI22Ox23n4pk5sVNuzkUZ1JLKeoLsLn8GLwnqQkQN4exV+G7fXoSdE+EjEMHi0
3uc8R/Wjr44KKdt/O3trCH0lJAMKzIWXmV/Emv9Orr/X5svLScE0SRjADaZrKUNf
2S5YAgk9Xywnmq51CecTRCf594GsYeEGJIKpxlg8ARF/QFjPcigbFIokgjOUVf2R
D8lhWmsVYg6NDF7eb/4GQnb1f6bD9P4ZkzhWC++9PSg91WcLGpAF95T7FMs/ww7v
GT/Z8fMFr06/VTzDIYb/lyCkwtxD6LqLC7TEbbBoHSdlunlsTfM=
=WVZ4
-----END PGP SIGNATURE-----

--gm5TwAJMO0F2iVRz--

