Received: from eggs.gnu.org ([2001:4830:134:3::10]:44931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1can8S-0002dh-Le
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 12:31:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1can8P-0005Zk-Hr
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 12:31:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36882)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1can8P-0005Y7-CL
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 12:31:25 -0500
Date: Mon, 6 Feb 2017 19:31:24 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170206192919-mutt-send-email-mst@kernel.org>
References: <cover.1486285434.git.ben@skyportsystems.com>
	<2bb2dd455ea355b279867a312924add82ae685e4.1486285434.git.ben@skyportsystems.com>
	<20170206165517-mutt-send-email-mst@kernel.org>
	<65C02079-7702-4819-8852-1EB294B701FF@skyportsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <65C02079-7702-4819-8852-1EB294B701FF@skyportsystems.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 02/10] linker-loader: Add new 'write
 pointer' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ben Warren <ben@skyportsystems.com>
Cc: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>, imammedo@redhat.com

On Mon, Feb 06, 2017 at 09:16:25AM -0800, Ben Warren wrote:
> >> @@ -257,8 +263,11 @@ void bios_linker_loader_add_pointer(BIOSLinker =
*linker,
> >>     const BiosLinkerFileEntry *source_file =3D
> >>         bios_linker_find_file(linker, src_file);
> >>=20
> >> -    assert(dst_patched_offset < dst_file->blob->len);
> >> -    assert(dst_patched_offset + dst_patched_size <=3D dst_file->blo=
b->len);
> >> +    /* dst_file need not exist if writing back */
> >=20
> > Why not?
> Because WRITE_POINTER can be called without having first called
> ALLOCATE.  In the Vm Generation ID example, there=E2=80=99s no reason f=
or BIOS
> to allocate memory for the address fw_cfg, since it=E2=80=99s a constru=
ct that
> only matters to QEMU.  This is something that was requested by Laszlo.

Well all other commands require you to first allocate.
How does bios know e.g. which zone to put it in then?

I don't like the asymmetry ... Laszlo?

--=20
MST
