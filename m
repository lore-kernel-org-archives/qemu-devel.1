Received: from eggs.gnu.org ([209.51.188.92]:60993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hCIoC-0002hr-C7
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 02:58:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hCIoA-00071V-BL
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 02:58:39 -0400
References: <1554388475-18329-1-git-send-email-jjherne@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6cd9fc3c-f5cb-e0fd-6990-d519014bead0@redhat.com>
Date: Fri, 5 Apr 2019 08:58:30 +0200
MIME-Version: 1.0
In-Reply-To: <1554388475-18329-1-git-send-email-jjherne@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 00/16] s390: vfio-ccw dasd ipl support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On 04/04/2019 16.34, Jason J. Herne wrote:
> This is to support booting from vfio-ccw dasd devices. We basically imp=
lement
> the real hardware ipl procedure. This allows for booting Linux guests o=
n
> vfio-ccw devices.
>=20
> vfio-ccw's channel program prefetch algorithm complicates ipl because m=
ost ipl
> channel programs dynamically modify themselves. Details on the ipl proc=
ess and
> how we worked around this issue can be found in docs/devel/s390-dasd-ip=
l.txt.

 Hi Jason,

while running my s390-ccw bios tests, I noticed that network booting
seems to be broken now. This used to work before:

s390x-softmmu/qemu-system-s390x -nographic -accel kvm \
 -bios pc-bios/s390-ccw/s390-ccw.img \
 -global s390-ipl.netboot_fw=3Dpc-bios/s390-ccw/s390-netboot.img \
 -netdev user,id=3Dn1,tftp=3D/boot,bootfile=3Dvmlinuz-4.18.0 \
 -device virtio-net-ccw,netdev=3Dn1,bootindex=3D1

Now it simply fails with "! No IPL device available !".

Could you have a look at it, please?

 Thanks,
  Thomas
