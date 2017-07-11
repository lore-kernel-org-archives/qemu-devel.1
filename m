Received: from eggs.gnu.org ([2001:4830:134:3::10]:46296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dUwSn-0005wR-94
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:48:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dUwSh-0002qv-JH
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:48:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dUwSh-0002qX-Cl
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:48:27 -0400
Date: Tue, 11 Jul 2017 11:47:52 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170711144752.GO12152@localhost.localdomain>
References: <5233eee1-a017-ccae-3458-762c9e86902c@redhat.com>
	<20170707133949.GH10776@localhost.localdomain>
	<20170707181642-mutt-send-email-mst@kernel.org>
	<20170707180358.GA12152@localhost.localdomain>
	<626ce419-8418-a4a2-88d3-b61bf20bbb32@redhat.com>
	<20170710135943.GG12152@localhost.localdomain>
	<20170710194345-mutt-send-email-mst@kernel.org>
	<20170710174730.GL12152@localhost.localdomain>
	<063778b8-d517-dcac-3c83-95076604a16c@redhat.com>
	<1499760785.8257.5.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1499760785.8257.5.camel@redhat.com>
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
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>, libvir-list@redhat.com, qemu-devel@nongnu.org, Chao Peng <chao.p.peng@linux.intel.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Laine Stump <laine@redhat.com>

On Tue, Jul 11, 2017 at 10:13:05AM +0200, Gerd Hoffmann wrote:
>   Hi,
>=20
> >=A0Concerning QEMU, could we maybe simply emit a warning a la
> >=20
> > =A0"you did not specify a machine type with the -M option, so you are
> > =A0 currently running the the 'pc' machine type. Please note that
> > future
> > =A0 versions of QEMU might use the 'q35' machine type instead. If you
> > =A0 require the 'pc' machine type for your setting, then please speci=
fy
> > =A0 it with the -M option."
>=20
> Warnings tend to get ignored until things are actually break, so I
> don't think this helps much.  I think simply not having a default
> machine type (as already suggested elsewhere in this thread) is the
> best way to deal with this.  That way we don't silently change
> behavior.  It also is in line with what we have on arm where we already
> require the user to explicitly pick a machine type.

If we do that, we probably should wait for libvirt to adapt and
choose its own default.  Current libvirt would pick an arbitrary
machine-type (the first one in the query-machines list) as the
default.

--=20
Eduardo
