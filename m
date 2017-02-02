Received: from eggs.gnu.org ([2001:4830:134:3::10]:38207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cZE4o-0004Ip-My
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 04:53:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cZE4n-00089P-O4
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 04:53:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cZE4n-00088w-I9
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 04:53:13 -0500
Date: Thu, 2 Feb 2017 09:53:02 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170202095302.GC2915@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CAAo6VWMJAYeLdtEmyQ43vYeYjvNzCP80Wufe4=eNRUZum0rYdQ@mail.gmail.com>
	<CAJSP0QV7QCLwih+F30hcohmwYQ1Ci+6bMPuCj_Kk9hwbmgWzUA@mail.gmail.com>
	<E05FEFD5-A72D-4FC5-B600-58AAD2900A02@veritas.com>
	<CAJSP0QUWmU_XbB9TGxvL0hH-SCzRSWDciNhpZrarDDcE22RF_w@mail.gmail.com>
	<D1304CAA-9C32-4E42-AA65-27B3277130E8@veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D1304CAA-9C32-4E42-AA65-27B3277130E8@veritas.com>
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

On Wed, Feb 01, 2017 at 11:59:53PM +0000, Ketan Nilangekar wrote:
> Patch for secure implementation in libqnio is available for review here:
> 
> https://github.com/VeritasHyperScale/libqnio/pull/12

IMHO, we really don't want libqnio to be doing the SSL handling
itself. QEMU has a standardized API for doing SSL that the vxhs
layer should be using, so that its behaviour & configuration is
exactly the same as other bits of QEMU using SSL.

To do this, libqnio would have to delegate all socket I/O to
QEMU, by providing a set of callback APIs that QEMU can provide
implementations for.

The QEMU block driver for vxhs would use qio_channel_socket and
qio_channel_tls APIs to setup the socket & do SSL handshakes,
etc.


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
