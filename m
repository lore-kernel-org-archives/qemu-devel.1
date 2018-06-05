Received: from eggs.gnu.org ([2001:4830:134:3::10]:33517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fQEeD-0001VB-Vd
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:17:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fQEdt-0006gN-2F
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:17:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51662 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fQEds-0006eM-OK
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:17:04 -0400
Date: Tue, 5 Jun 2018 19:16:56 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180605191539-mutt-send-email-mst@kernel.org>
References: <20180603092749.107476-1-marcel.apfelbaum@gmail.com>
	<20180604042928-mutt-send-email-mst@kernel.org>
	<23040757-b561-e0bf-a41d-38d3c44555ee@gmail.com>
	<20180605072746.v6xxabsbewiuw7ka@sirius.home.kraxel.org>
	<20180605084300.GF32286@redhat.com>
	<20180605130646.GF7451@localhost.localdomain>
	<20180605131232.GG32286@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180605131232.GG32286@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] libvirt default machine-type guarantees? (was Re:
 [PATCH RFC] hw/pc: set q35 as the default x86 machine)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, pbonzini@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org, libvir-list@redhat.com

On Tue, Jun 05, 2018 at 02:12:32PM +0100, Daniel P. Berrang=E9 wrote:
> eg old OS versions that only work with PC, or more commonly pre-existin=
g
> cloud disk images that were built against PC can't be assumed to just
> work against q35, even if the OS in the image supports it.

I don't understand that part - when using libvirt domain xml records the
machine type used for the install, so it seems that installed images
won't be affected.

--=20
MST
