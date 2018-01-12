Received: from eggs.gnu.org ([2001:4830:134:3::10]:53533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ea2X3-0004iZ-0g
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 11:50:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ea2X2-0002KL-26
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 11:50:17 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:32805)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1ea2X1-0002I2-S0
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 11:50:15 -0500
Received: by mail-wr0-x243.google.com with SMTP id p6so5862156wrd.0
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 08:50:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1512682213-4354-2-git-send-email-minyard@acm.org>
References: <1512682213-4354-1-git-send-email-minyard@acm.org>
	<1512682213-4354-2-git-send-email-minyard@acm.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 12 Jan 2018 17:50:12 +0100
Message-ID: <CAJ+F1CJUwTdp3_MnfPNE1MAuKWE8F7aJkXcPy6Mb8jCEmFRpRA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/8] ipmi: Fix SEL get/set time commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Corey Minyard <minyard@acm.org>
Cc: QEMU <qemu-devel@nongnu.org>, Corey Minyard <cminyard@mvista.com>

On Thu, Dec 7, 2017 at 10:30 PM,  <minyard@acm.org> wrote:
> From: Corey Minyard <cminyard@mvista.com>
>
> The minimum message size was on the wrong commands, for getting
> the time it's zero and for setting the time it's 6.
>
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  hw/ipmi/ipmi_bmc_sim.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
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
>
>  static const IPMINetfn storage_netfn =3D {
> --
> 2.7.4
>
>



--=20
Marc-Andr=C3=A9 Lureau
