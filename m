Received: from eggs.gnu.org ([2001:4830:134:3::10]:57015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dUqII-0000ZW-OE
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:13:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dUqIF-0008De-Jo
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:13:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dUqIF-0008DF-Db
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:13:15 -0400
Message-ID: <1499760785.8257.5.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 11 Jul 2017 10:13:05 +0200
In-Reply-To: <063778b8-d517-dcac-3c83-95076604a16c@redhat.com>
References: <1499237876.3041.4.camel@linux.intel.com>
	<6ad73f55-c48a-c083-e0ef-b8ac162ec989@redhat.com>
	<5233eee1-a017-ccae-3458-762c9e86902c@redhat.com>
	<20170707133949.GH10776@localhost.localdomain>
	<20170707181642-mutt-send-email-mst@kernel.org>
	<20170707180358.GA12152@localhost.localdomain>
	<626ce419-8418-a4a2-88d3-b61bf20bbb32@redhat.com>
	<20170710135943.GG12152@localhost.localdomain>
	<20170710194345-mutt-send-email-mst@kernel.org>
	<20170710174730.GL12152@localhost.localdomain>
	<063778b8-d517-dcac-3c83-95076604a16c@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] change x86 default machine type to Q35?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, libvir-list@redhat.com, qemu-devel@nongnu.org, Chao Peng <chao.p.peng@linux.intel.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>

  Hi,

>=C2=A0Concerning QEMU, could we maybe simply emit a warning a la
>=20
> =C2=A0"you did not specify a machine type with the -M option, so you ar=
e
> =C2=A0 currently running the the 'pc' machine type. Please note that
> future
> =C2=A0 versions of QEMU might use the 'q35' machine type instead. If yo=
u
> =C2=A0 require the 'pc' machine type for your setting, then please spec=
ify
> =C2=A0 it with the -M option."

Warnings tend to get ignored until things are actually break, so I
don't think this helps much.  I think simply not having a default
machine type (as already suggested elsewhere in this thread) is the
best way to deal with this.  That way we don't silently change
behavior.  It also is in line with what we have on arm where we already
require the user to explicitly pick a machine type.

We probably want a more verbose error message on x86 though, suggesting
to pick 'pc' for compatibility with old qemu versions and for old
guests, and q35 otherwise.

cheers,
  Gerd
