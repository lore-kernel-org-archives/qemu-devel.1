Received: from eggs.gnu.org ([2001:4830:134:3::10]:42432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1djh8n-0004f3-8I
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 03:28:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1djh8k-000674-3y
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 03:28:53 -0400
Received: from 20.mo3.mail-out.ovh.net ([178.33.47.94]:38282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1djh8j-00066V-Uj
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 03:28:50 -0400
Received: from player797.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id EB2B712C8D9
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 09:28:46 +0200 (CEST)
References: <1503265602-9349-1-git-send-email-minyard@acm.org>
	<1503265602-9349-2-git-send-email-minyard@acm.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <7dc792c5-45b4-d7fa-39a1-f0e659ba54c0@kaod.org>
Date: Mon, 21 Aug 2017 09:28:41 +0200
MIME-Version: 1.0
In-Reply-To: <1503265602-9349-2-git-send-email-minyard@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/3] ipmi: Fix SEL get/set time commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: minyard@acm.org, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Corey Minyard <cminyard@mvista.com>

On 08/20/2017 11:46 PM, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
>=20
> The minimum message size was on the wrong commands, for getting
> the time it's zero and for setting the time it's 6.
>=20
> Signed-off-by: Corey Minyard <cminyard@mvista.com>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  hw/ipmi/ipmi_bmc_sim.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
> index 277c28c..cc068f2 100644
> --- a/hw/ipmi/ipmi_bmc_sim.c
> +++ b/hw/ipmi/ipmi_bmc_sim.c
> @@ -1802,8 +1802,8 @@ static const IPMICmdHandler storage_cmds[] =3D {
>      [IPMI_CMD_GET_SEL_ENTRY] =3D { get_sel_entry, 8 },
>      [IPMI_CMD_ADD_SEL_ENTRY] =3D { add_sel_entry, 18 },
>      [IPMI_CMD_CLEAR_SEL] =3D { clear_sel, 8 },
> -    [IPMI_CMD_GET_SEL_TIME] =3D { get_sel_time, 6 },
> -    [IPMI_CMD_SET_SEL_TIME] =3D { set_sel_time },
> +    [IPMI_CMD_GET_SEL_TIME] =3D { get_sel_time },
> +    [IPMI_CMD_SET_SEL_TIME] =3D { set_sel_time, 6 },
>  };
> =20
>  static const IPMINetfn storage_netfn =3D {
>=20
