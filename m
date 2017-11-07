Received: from eggs.gnu.org ([2001:4830:134:3::10]:41453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eC78I-0002Zb-RQ
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 11:53:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eC78E-00066l-Mt
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 11:53:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eC78E-00066L-Gc
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 11:53:46 -0500
Date: Tue, 7 Nov 2017 14:53:39 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171107165339.GB3111@localhost.localdomain>
References: <CAJ+F1CKWdxAwuZ-QAvT=AhGMrXd+7c8=eBCMMuKPdbK75NDtiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CKWdxAwuZ-QAvT=AhGMrXd+7c8=eBCMMuKPdbK75NDtiQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] i440/piix and dynamic sysbus check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Stefan Berger <stefanb@linux.vnet.ibm.com>

On Tue, Nov 07, 2017 at 05:40:17PM +0100, Marc-Andr=E9 Lureau wrote:
> Hi,
>=20
> I am working on a TPM CRB device (last sent version:
> https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg02014.html).
> It's a sysbus device, and when starting qemu with i440, I get "Option
> '-device tpm-crb' cannot be handled by this machine".
>=20
> The check comes from machine_init_notify(), checking that the machine
> has_dynamic_sysbus.
>=20
>  Apparently, q35 supports it. But not i440. If I declare
> has_dynamic_sysbus in piix, the device works fine.

Before doing that, I would like to replace has_dynamic_sysbus
with a whitelist, so we don't need to make the machine accept all
other sysbus devices too.

I probably should rebase and resubmit this RFC:
http://mid.mail-archive.com/20170323212848.8492-1-ehabkost@redhat.com
Subject: [Qemu-devel] [RFC 0/4] Replace has_dynamic_sysbus with device ty=
pe  whitelist


>=20
> Marcel, could we do something similar to piix to what you did for q35?:
>=20
> commit bf8d492405feaee2c1685b3b9d5e03228ed3e47f
> Author: Marcel Apfelbaum <marcel@redhat.com>
> Date:   Mon Jun 27 18:38:33 2016 +0300
>=20
>     q35: allow dynamic sysbus
>=20
> thanks
>=20
> --=20
> Marc-Andr=E9 Lureau

--=20
Eduardo
