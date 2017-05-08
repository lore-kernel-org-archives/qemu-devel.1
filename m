Received: from eggs.gnu.org ([2001:4830:134:3::10]:44157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d7pai-00032n-HM
	for qemu-devel@nongnu.org; Mon, 08 May 2017 16:49:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d7pad-0004zt-Mx
	for qemu-devel@nongnu.org; Mon, 08 May 2017 16:49:12 -0400
Date: Mon, 8 May 2017 17:49:01 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170508204901.GA26597@thinpad.lan.raisama.net>
References: <1483049536-21548-1-git-send-email-hpoussin@reactos.org>
	<1483049536-21548-7-git-send-email-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1483049536-21548-7-git-send-email-hpoussin@reactos.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 6/6] prep: add IBM RS/6000 7020 (40p)
 machine emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>
Cc: qemu-devel@nongnu.org, Giancarlo Teodori <gteodori@gmail.com>, Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Gerd Hoffmann <kraxel@redhat.com>

Hi,

I stumbled upon this code while working on arch_init.c cleanups:

On Thu, Dec 29, 2016 at 11:12:16PM +0100, Herv=E9 Poussineau wrote:
[...]
> +static void ibm_40p_init(MachineState *machine)
> +{
[...]
> +    /* initialize audio subsystem */
> +    audio_init();

Why exactly did you need this, if main() already calls
audio_init()?

[...]
> +static void ibm_40p_machine_init(MachineClass *mc)
> +{
> +    mc->desc =3D "IBM RS/6000 7020 (40p)",
> +    mc->init =3D ibm_40p_init;
> +    mc->max_cpus =3D 1;
> +    mc->pci_allow_0_address =3D true;
> +    mc->default_ram_size =3D 128 * M_BYTE;
> +    mc->block_default_type =3D IF_SCSI;
> +    mc->default_display =3D "std"; /* FIXME: should be S3 Trio */
> +    mc->default_boot_order =3D "c";
> +}
> +
> +DEFINE_MACHINE("40p", ibm_40p_machine_init)
>  DEFINE_MACHINE("prep", prep_machine_init)
> --=20
> 2.1.4
>=20
>=20

--=20
Eduardo
