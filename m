Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4139C06511
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 14:28:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 900C0218A4
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 14:28:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 900C0218A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1higF4-0003t9-Rd
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 10:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54849)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1higDj-0002j3-Jn
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 10:26:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1higDb-00046W-Ov
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 10:26:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53850)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1higDZ-00045J-Qx
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 10:26:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8D9B785363;
 Wed,  3 Jul 2019 14:26:35 +0000 (UTC)
Received: from redhat.com (unknown [10.42.17.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 98A8387502;
 Wed,  3 Jul 2019 14:26:27 +0000 (UTC)
Date: Wed, 3 Jul 2019 15:26:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: minyard@acm.org
Message-ID: <20190703142625.GD23082@redhat.com>
References: <20190701183100.7849-1-minyard@acm.org>
 <20190701183100.7849-3-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190701183100.7849-3-minyard@acm.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Wed, 03 Jul 2019 14:26:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 2/2] ipmi: Add a UUID device property
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Corey Minyard <cminyard@mvista.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 01, 2019 at 01:31:00PM -0500, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
>=20
> Using the UUID that qemu generates probably isn't the best thing
> to do, allow it to be passed in via properties, and use QemuUUID
> for the type.

AFAICT, QEMU isn't generating a UUID in the current code.

The device is taking the UUID that the user has set
explicitly via the --uuid argument to QEMU. If --uuid
is not set, then it is leaving it all zeros.

Defaulting to the UUID from --uuid looks quite reasonable
to me & I don't think we should break that current usage.

I can see justification for being able to further override
that default with a device level property though.


> If the UUID is not set, return an unsupported command error.  This
> way we are not providing an all-zero (or randomly generated) GUID
> to the IPMI user.  This lets the host fall back to the other
> method of using the get device id command to determind the BMC
> being accessed.

Reporting an error would be a guest ABI regression from current QEMU
behaviour for anyone who is using the IPMI device right now, without
--uuid.

I'm not sure how much we care about guest ABI preservation for
the IPIMI device right now though ? Does it support migration
at all ?

>=20
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> Cc: C=C3=A9dric Le Goater <clg@kaod.org>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/ipmi/ipmi_bmc_sim.c | 22 ++++++++++++++--------
>  qemu-options.hx        | 10 +++++++---
>  2 files changed, 21 insertions(+), 11 deletions(-)
>=20
> diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
> index 1980536517..007e2c6588 100644
> --- a/hw/ipmi/ipmi_bmc_sim.c
> +++ b/hw/ipmi/ipmi_bmc_sim.c
> @@ -221,7 +221,7 @@ struct IPMIBmcSim {
>      uint8_t restart_cause;
> =20
>      uint8_t acpi_power_state[2];
> -    uint8_t uuid[16];
> +    QemuUUID uuid;
> =20
>      IPMISel sel;
>      IPMISdr sdr;
> @@ -937,8 +937,19 @@ static void get_device_guid(IPMIBmcSim *ibs,
>  {
>      unsigned int i;
> =20
> +    /* An uninitialized uuid is all zeros, use that to know if it is s=
et. */
>      for (i =3D 0; i < 16; i++) {
> -        rsp_buffer_push(rsp, ibs->uuid[i]);
> +        if (ibs->uuid.data[i]) {
> +            goto uuid_set;
> +        }
> +    }
> +    /* No uuid is set, return an error. */
> +    rsp_buffer_set_error(rsp, IPMI_CC_INVALID_CMD);
> +    return;
> +
> + uuid_set:
> +    for (i =3D 0; i < 16; i++) {
> +        rsp_buffer_push(rsp, ibs->uuid.data[i]);
>      }
>  }
> =20
> @@ -1980,12 +1991,6 @@ static void ipmi_sim_realize(DeviceState *dev, E=
rror **errp)
>      ibs->acpi_power_state[0] =3D 0;
>      ibs->acpi_power_state[1] =3D 0;
> =20
> -    if (qemu_uuid_set) {
> -        memcpy(&ibs->uuid, &qemu_uuid, 16);
> -    } else {
> -        memset(&ibs->uuid, 0, 16);
> -    }
> -
>      ipmi_init_sensors_from_sdrs(ibs);
>      register_cmds(ibs);
> =20
> @@ -2005,6 +2010,7 @@ static Property ipmi_sim_properties[] =3D {
>      DEFINE_PROP_UINT8("fwrev2", IPMIBmcSim, fwrev2, 0),
>      DEFINE_PROP_UINT32("mfg_id", IPMIBmcSim, mfg_id, 0),
>      DEFINE_PROP_UINT16("product_id", IPMIBmcSim, product_id, 0),
> +    DEFINE_PROP_UUID_NODEFAULT("guid", IPMIBmcSim, uuid),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 0d8beb4afd..ec56ab8f6f 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -700,7 +700,7 @@ possible drivers and properties, use @code{-device =
help} and
>  @code{-device @var{driver},help}.
> =20
>  Some drivers are:
> -@item -device ipmi-bmc-sim,id=3D@var{id}[,slave_addr=3D@var{val}][,sdr=
file=3D@var{file}][,furareasize=3D@var{val}][,furdatafile=3D@var{file}]
> +@item -device ipmi-bmc-sim,id=3D@var{id}[,slave_addr=3D@var{val}][,sdr=
file=3D@var{file}][,furareasize=3D@var{val}][,furdatafile=3D@var{file}][,=
guid=3D@var{uuid}]
> =20
>  Add an IPMI BMC.  This is a simulation of a hardware management
>  interface processor that normally sits on a system.  It provides
> @@ -713,8 +713,8 @@ controllers.  If you don't know what this means, it=
 is safe to ignore
>  it.
> =20
>  @table @option
> -@item bmc=3D@var{id}
> -The BMC to connect to, one of ipmi-bmc-sim or ipmi-bmc-extern above.
> +@item id=3D@var{id}
> +The BMC id for interfaces to use this device.
>  @item slave_addr=3D@var{val}
>  Define slave address to use for the BMC.  The default is 0x20.
>  @item sdrfile=3D@var{file}
> @@ -723,6 +723,10 @@ file containing raw Sensor Data Records (SDR) data=
. The default is none.
>  size of a Field Replaceable Unit (FRU) area.  The default is 1024.
>  @item frudatafile=3D@var{file}
>  file containing raw Field Replaceable Unit (FRU) inventory data. The d=
efault is none.
> +@item guid=3D@var{uuid}
> +value for the GUID for the BMC, in standard UUID format.  If this is s=
et,
> +get "Get GUID" command to the BMC will return it.  Otherwise "Get GUID=
"
> +will return an error.
>  @end table
> =20
>  @item -device ipmi-bmc-extern,id=3D@var{id},chardev=3D@var{id}[,slave_=
addr=3D@var{val}]
> --=20
> 2.17.1
>=20
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

