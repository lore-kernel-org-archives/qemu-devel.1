Received: from eggs.gnu.org ([2001:4830:134:3::10]:36979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dAeIA-0004tr-1z
	for qemu-devel@nongnu.org; Tue, 16 May 2017 11:21:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dAeI5-0006na-HW
	for qemu-devel@nongnu.org; Tue, 16 May 2017 11:21:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dAeI5-0006nH-B5
	for qemu-devel@nongnu.org; Tue, 16 May 2017 11:21:37 -0400
Date: Tue, 16 May 2017 18:21:16 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170516181925-mutt-send-email-mst@kernel.org>
References: <1494578148-102868-1-git-send-email-wei.w.wang@intel.com>
	<149458139950.351.4946794492742335975@c05f1edc8ed1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <149458139950.351.4946794492742335975@c05f1edc8ed1>
Subject: Re: [Qemu-devel] [PATCH v2 00/16] Vhost-pci for inter-VM
 communication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: wei.w.wang@intel.com, famz@redhat.com, stefanha@gmail.com, marcandre.lureau@gmail.com, jasowang@redhat.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org

On Fri, May 12, 2017 at 02:30:00AM -0700, no-reply@patchew.org wrote:
> In file included from =1B[01m=1B[K/tmp/qemu-test/src/include/hw/virtio/vh=
ost-pci-slave.h:4:0=1B[m=1B[K,
>                  from =1B[01m=1B[K/tmp/qemu-test/src/vl.c:132=1B[m=1B[K:
> =1B[01m=1B[K/tmp/qemu-test/src/linux-headers/linux/vhost.h:13:25:=1B[m=1B=
[K =1B[01;31m=1B[Kfatal error: =1B[m=1B[Klinux/types.h: No such file or dir=
ectory
>  #include <linux/types.h>
>                          =1B[01;31m=1B[K^=1B[m=1B[K
> compilation terminated.
> /tmp/qemu-test/src/rules.mak:69: recipe for target 'vl.o' failed
> make: *** [vl.o] Error 1
> make: *** Waiting for unfinished jobs....
> tests/docker/Makefile.include:118: recipe for target 'docker-run' failed
> make[1]: *** [docker-run] Error 2
> make[1]: Leaving directory '/var/tmp/patchew-tester-tmp-9tacbi6p/src'
> tests/docker/Makefile.include:149: recipe for target 'docker-run-test-min=
gw@fedora' failed
> make: *** [docker-run-test-mingw@fedora] Error 2
> =3D=3D=3D OUTPUT END =3D=3D=3D

That's because you are
- pulling in linux-specific vhost.h which you shouldn't need to
- including vhost-pci-slave.h in vl.c which you shouldn't need to

--=20
MST
