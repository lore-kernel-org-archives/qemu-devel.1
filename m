Received: from eggs.gnu.org ([2001:4830:134:3::10]:45202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cTXpH-0002ub-Ae
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 12:45:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cTXpE-00048w-3T
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 12:45:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cTXpD-00048N-Nf
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 12:45:39 -0500
Date: Tue, 17 Jan 2017 19:45:32 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170117194321-mutt-send-email-mst@kernel.org>
References: <CAO_EM_kuP9kk55bzxWqNOeuL8yW7gKNnacd1-UVGnJPyx2ZNYw@mail.gmail.com>
	<20160916033402-mutt-send-email-mst@kernel.org>
	<CAO_EM_mHyC7cywV4KUqH_MWwt2vVkK6GEOuaUX0FHpffdfaAuQ@mail.gmail.com>
	<20161006041949-mutt-send-email-mst@kernel.org>
	<D5FCB73B-435E-4423-B21C-BEEF1C1EA2FD@skyportsystems.com>
	<20161211052355-mutt-send-email-mst@kernel.org>
	<FBD67273-74C4-4183-8FCF-8260D13B04D4@skyportsystems.com>
	<20170116161857-mutt-send-email-mst@kernel.org>
	<85C3D50B-7AFD-41E7-AD1B-634A42D04BB2@skyportsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <85C3D50B-7AFD-41E7-AD1B-634A42D04BB2@skyportsystems.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Virtual Machine Generation ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ben Warren <ben@skyportsystems.com>
Cc: Ed Swierk <eswierk@skyportsystems.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Laszlo Ersek <lersek@redhat.com>

On Mon, Jan 16, 2017 at 10:57:42AM -0800, Ben Warren wrote:
> I think we have a misunderstanding here.  I=E2=80=99m storing the VM
> Generation ID __data__ (a GUID) in a fw_cfg blob, not the address.

Yes, I think I gathered this much from the discussion. This is what
I'm saying - don't. Have guest loader reserve guest memory and write the
address into a fw cfg blob, and have qemu write the id at that address.
This way you can update guest memory at any time.

--=20
MST
