Received: from eggs.gnu.org ([2001:4830:134:3::10]:37274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gYqcb-0002Y7-R4
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 05:59:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gYqQo-0001Dp-DE
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 05:47:29 -0500
Received: from 5.mo7.mail-out.ovh.net ([178.32.120.239]:59641)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gYqQn-00013s-77
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 05:47:25 -0500
Received: from player746.ha.ovh.net (unknown [10.109.160.239])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 2350EEDAAF
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 11:47:20 +0100 (CET)
References: <20181211223823.13770-1-clg@kaod.org>
	<20181211223823.13770-13-clg@kaod.org>
	<20181217060750.GJ5597@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <aff3914f-b7f5-78f7-53a7-7c6ae73658ab@kaod.org>
Date: Mon, 17 Dec 2018 11:47:12 +0100
MIME-Version: 1.0
In-Reply-To: <20181217060750.GJ5597@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 12/12] spapr: change default CPU type to
 POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On 12/17/18 7:07 AM, David Gibson wrote:
> On Tue, Dec 11, 2018 at 11:38:23PM +0100, C=E9dric Le Goater wrote:
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> Uh.. this will need something to keep the default at POWER8 for the
> older machine types.

:) Yes. That was an excess of enthusiasm for my part I suppose.

C.

>> ---
>>  hw/ppc/spapr.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 97a5e3c9929f..705d3f4057b0 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -3938,7 +3938,7 @@ static void spapr_machine_class_init(ObjectClass=
 *oc, void *data)
>>      hc->unplug =3D spapr_machine_device_unplug;
>> =20
>>      smc->dr_lmb_enabled =3D true;
>> -    mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power8_v2.0");
>> +    mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power9_v2.0");
>>      mc->has_hotpluggable_cpus =3D true;
>>      smc->resize_hpt_default =3D SPAPR_RESIZE_HPT_ENABLED;
>>      fwc->get_dev_path =3D spapr_get_fw_dev_path;
>=20
