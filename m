Received: from eggs.gnu.org ([2001:4830:134:3::10]:38820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cHSjN-00081e-KX
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 04:53:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cHSjJ-00012f-5x
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 04:53:41 -0500
Received: from mail-wj0-f196.google.com ([209.85.210.196]:35117)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cHSjI-00012N-Vv
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 04:53:37 -0500
Received: by mail-wj0-f196.google.com with SMTP id he10so8792899wjc.2
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 01:53:36 -0800 (PST)
Date: Thu, 15 Dec 2016 09:52:34 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20161215095234.GC2762@stefanha-x1.localdomain>
References: <20161215065041.5A9C310200DE@webmail.sinamail.sina.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5QAgd0e35j3NYeGe"
Content-Disposition: inline
In-Reply-To: <20161215065041.5A9C310200DE@webmail.sinamail.sina.com.cn>
Subject: Re: [Qemu-devel] question about qemu IO process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ousuju@sina.com
Cc: qemu-devel <qemu-devel@nongnu.org>


--5QAgd0e35j3NYeGe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 15, 2016 at 02:50:41PM +0800, ousuju@sina.com wrote:
> I recently try to figure out the the whole IO process in qemu, I have tra=
ced most parts of this process, but I'm still confused about how guest OS n=
otify qemu to handle virtqueue
> I traced to virtio_queue_host_notifier_read -> event_notifier_test_and_cl=
ear, and qemu will read e->rfd, so I assumed that some part of code will wr=
ite to this descriptor, to notify qemu
> Unfortunatelly, I have set some breakpoints but noting catched yet.
> Could someone point it out for me which code write to this descriptor? Or=
 show me the web link about this design?

"The KVM kernel module has a feature known as ioeventfd for taking an
eventfd and hooking it up to a particular guest I/O exit. QEMU userspace
registers an ioeventfd for the VIRTIO_PCI_QUEUE_NOTIFY hardware register
access which kicks the virtqueue."

=46rom http://blog.vmsplice.net/2011/09/qemu-internals-vhost-architecture.h=
tml
(careful the rest of the post is about vhost, not QEMU)

http://blog.allenx.org/2015/07/05/kvm-irqfd-and-ioeventfd

--5QAgd0e35j3NYeGe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYUmfiAAoJEJykq7OBq3PIHtYH/jiiPgy/8Op19AlUhT1urKyF
askINpvH0itaLSyVGm70rf+Ie+5hR05YyBiWpXejNlIiqyh1ndgr+FVmipzA8TqX
dz9O6DcLd4Qo7NN7fjCSW+4xXSdEzEJNZekR5pDxl9DUw/yafzEblloSzKlASSDx
p9oHnzijRAgZUXQG1Ip7tg8yyVpM7YCCZkOgeaUI7mZH5DtiKctgU6+NP+WY6V3v
iLm8IY5feuNjMr9cAfHwCArvZ396qdsz/Hz0TYRDPYfBoOFY/G+iIZLT46Xgvcru
7+QEAnPeJLTLA2p0XodSpWkgYu4dst5QWU2qaIZMoGxbzDU/RIikty5j91lUkv4=
=Ygdb
-----END PGP SIGNATURE-----

--5QAgd0e35j3NYeGe--
