Received: from eggs.gnu.org ([2001:4830:134:3::10]:47759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cZaQm-0000Ad-Pp
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 04:45:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cZaQj-0007TB-6l
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 04:45:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cZaQj-0007SF-0H
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 04:45:21 -0500
Date: Fri, 3 Feb 2017 09:45:09 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170203094509.GB10350@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CAAo6VWMJAYeLdtEmyQ43vYeYjvNzCP80Wufe4=eNRUZum0rYdQ@mail.gmail.com>
	<CAJSP0QV7QCLwih+F30hcohmwYQ1Ci+6bMPuCj_Kk9hwbmgWzUA@mail.gmail.com>
	<E05FEFD5-A72D-4FC5-B600-58AAD2900A02@veritas.com>
	<CAJSP0QUWmU_XbB9TGxvL0hH-SCzRSWDciNhpZrarDDcE22RF_w@mail.gmail.com>
	<D1304CAA-9C32-4E42-AA65-27B3277130E8@veritas.com>
	<20170202100728.GA20760@stefanha-x1.localdomain>
	<20170202101537.GE2915@redhat.com>
	<49FDD34F-2649-4437-AC4F-4C1C91FEA15C@veritas.com>
	<231FC4E3-0EEB-4BD5-A541-1ABFAB592EEC@veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <231FC4E3-0EEB-4BD5-A541-1ABFAB592EEC@veritas.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 RFC] block/vxhs: Initial commit to add
 Veritas HyperScale VxHS block device support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ketan Nilangekar <Ketan.Nilangekar@veritas.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Buddhi Madhav <Buddhi.Madhav@veritas.com>, ashish mittal <ashmit602@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <famz@redhat.com>, Ashish Mittal <Ashish.Mittal@veritas.com>, Abhijit Dey <Abhijit.Dey@veritas.com>, "Venkatesha M.G." <Venkatesha.Mg@veritas.com>, Nitin Jerath <Nitin.Jerath@veritas.com>, Gaurav Bhandarkar <Gaurav.Bhandarkar@veritas.com>, Abhishek Kane <Abhishek.Kane@veritas.com>, Ketan Mahajan <Ketan.Mahajan@veritas.com>, Niranjan Pendharkar <Niranjan.Pendharkar@veritas.com>, Nirendra Awasthi <Nirendra.Awasthi@veritas.com>, Rakesh Ranjan <Rakesh.Ranjan@veritas.com>

On Thu, Feb 02, 2017 at 09:22:46PM +0000, Ketan Nilangekar wrote:
>=20
> On 2/2/17, 12:57 PM, "Ketan Nilangekar" <Ketan.Nilangekar@veritas.com> =
wrote:
>        =20
>     [Ketan]
>     Does the QIO interface allow for readv/writev over network for unse=
cure sockets?
>    =20
> [Ketan]
> I checked the qio implementation and it seems that there is a pseudo
> implementation of readv/writev which iterates over the individual
> iovecs to make send/recv syscalls. This can=E2=80=99t be too good for p=
erformance.

I think you looked at the Win32 code - the qio_channel_socket_writev
and qio_channel_socket_readv methods which are built on non-Win32
platforms use recvmsg/sendmsg to handle iovecs in a single operation.

> Are you suggesting we use the qio interface for secure communication on=
ly
> and leave the unsecure communication to libqnio?

If you expect non-QEMU apps to use libqnio, then you could keep support
for plain & TLS sockets in libqnio. Just provide the I/O callbacks facili=
ty
as an alternative approach which can be used by QEMU for secure & insecur=
e
I/O handling.

Regards,
Daniel
--=20
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange=
/ :|
|: http://libvirt.org              -o-             http://virt-manager.or=
g :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr=
/ :|
