Received: from eggs.gnu.org ([2001:4830:134:3::10]:50855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mkletzan@redhat.com>) id 1eOmqV-0001Yz-Qp
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 10:51:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mkletzan@redhat.com>) id 1eOmqS-0005iz-CQ
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 10:51:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mkletzan@redhat.com>) id 1eOmqS-0005ia-64
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 10:51:48 -0500
Date: Tue, 12 Dec 2017 16:34:17 +0100
From: Martin Kletzander <mkletzan@redhat.com>
Message-ID: <20171212153417.GB5342@wheatley>
References: <581dd612.8002.1604462cfac.Coremail.15700157322@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <581dd612.8002.1604462cfac.Coremail.15700157322@163.com>
Subject: Re: [Qemu-devel] [libvirt-users] Inter Shared Memory ( Ivshmem ) :
 Cannot Bind
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Rogue S.T" <15700157322@163.com>
Cc: qemu-devel@nongnu.org, libvirt-users@redhat.com

On Mon, Dec 11, 2017 at 03:03:34PM +0800, Rogue S.T wrote:
>Hello, friends.
>I encounter a problem when i use ivshmem with my guest, my ivshmem server is not start, and output a error : Example code, do not use in production ,cannot bind.
>
>
>Detail distribution:
>Today, I know ivshmem from a topic "QEMU version 2.10.93 User Documentation",
>Ivshmem: it can create a shared memory that guest device use, so we can use this memory to do something ourselves.
>First, I create host memory backend:
>     -object memory-backend-file,size=1M,share,mem-path=/dev/shm/ivshmem,id=hostmem
>Twice, Bind a shared memory device to my guest:
>    -device ivshmem-plain,memdev=hostmem

You are using plain, but

>Then I boot ivshmem servi
>    ivshmem-server -p /var/run/ivshmem-server.pid  -S /tmp/ivshmem_socket  -M ivshmem -m /dev/shm -l 1M -n 2

You are running a server.  This is not how it works.

Looks like you are playing with something that you don't really need, otherwise
you would do things differetly.  It you are just trying it out, that's fine.
Otherwise make sure it's what you need.  More information on how this hot mess
works is here:

https://git.qemu.org/?p=qemu.git;a=blob;f=docs/specs/ivshmem-spec.txt

>Next time i get this error:
>    *** Example code, do not use in production ***
>    cannot bind
>And i search the problem on google, but nothing to get, hope you can help me solve it.
>following message is my host environment:
>    host:  ubuntu 1604
>    qemu:  version 2.10.90 (v2.11.0-rc0-dirty)
>    libvirt:  libvirtd (libvirt) 3.9.0
>    guest:    window 7 professor
>
>
>Refer:
>    https://qemu.weilnetz.de/doc/qemu-doc.html#Inter_002dVM-Shared-Memory-device (topic qemu documention)
>    https://helpmanual.io/help/ivshmem-server/  ( how to use ivshmem-server )

>_______________________________________________
>libvirt-users mailing list
>libvirt-users@redhat.com
>https://www.redhat.com/mailman/listinfo/libvirt-users
