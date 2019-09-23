Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26591C3A5A6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 05:52:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB74A20820
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 05:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB74A20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCHGh-0001ae-1H
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 01:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50299)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iCHFt-00014E-3q
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 01:51:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iCHFr-0007Kp-Ha
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 01:51:25 -0400
Received: from 6.mo173.mail-out.ovh.net ([46.105.43.93]:42312)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iCHFr-0007JY-A9
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 01:51:23 -0400
Received: from player158.ha.ovh.net (unknown [10.109.146.122])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 5A8AC119AF4
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 07:51:21 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player158.ha.ovh.net (Postfix) with ESMTPSA id B1B689FE070A;
 Mon, 23 Sep 2019 05:51:09 +0000 (UTC)
Subject: Re: [PATCH 06/15] ipmi: Add a UUID device property
To: minyard@acm.org, Peter Maydell <peter.maydell@linaro.org>
References: <20190919213924.31852-1-minyard@acm.org>
 <20190919213924.31852-7-minyard@acm.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <ee38f82b-7cb1-b71c-c41d-554f31635209@kaod.org>
Date: Mon, 23 Sep 2019 07:51:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190919213924.31852-7-minyard@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 6726126045514140600
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdejgddutdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.43.93
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
Cc: Corey Minyard <cminyard@mvista.com>, Fam Zheng <famz@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/09/2019 23:39, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
>=20
> Using the UUID that qemu generates probably isn't the best thing
> to do, allow it to be passed in via properties, and use QemuUUID
> for the type.
>=20
> If the UUID is not set, return an unsupported command error.  This
> way we are not providing an all-zero (or randomly generated) GUID
> to the IPMI user.  This lets the host fall back to the other
> method of using the get device id command to determind the BMC
> being accessed.


Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

C.


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
> index 6e6cd1b47d..71e56f3b13 100644
> --- a/hw/ipmi/ipmi_bmc_sim.c
> +++ b/hw/ipmi/ipmi_bmc_sim.c
> @@ -223,7 +223,7 @@ struct IPMIBmcSim {
>      uint8_t restart_cause;
> =20
>      uint8_t acpi_power_state[2];
> -    uint8_t uuid[16];
> +    QemuUUID uuid;
> =20
>      IPMISel sel;
>      IPMISdr sdr;
> @@ -941,8 +941,19 @@ static void get_device_guid(IPMIBmcSim *ibs,
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
> @@ -1986,12 +1997,6 @@ static void ipmi_sim_realize(DeviceState *dev, E=
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
> @@ -2011,6 +2016,7 @@ static Property ipmi_sim_properties[] =3D {
>      DEFINE_PROP_UINT8("fwrev2", IPMIBmcSim, fwrev2, 0),
>      DEFINE_PROP_UINT32("mfg_id", IPMIBmcSim, mfg_id, 0),
>      DEFINE_PROP_UINT16("product_id", IPMIBmcSim, product_id, 0),
> +    DEFINE_PROP_UUID_NODEFAULT("guid", IPMIBmcSim, uuid),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> diff --git a/qemu-options.hx b/qemu-options.hx
> index bbfd936d29..ed9292f65e 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -701,7 +701,7 @@ possible drivers and properties, use @code{-device =
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
> @@ -714,8 +714,8 @@ controllers.  If you don't know what this means, it=
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
> @@ -724,6 +724,10 @@ file containing raw Sensor Data Records (SDR) data=
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
>=20


