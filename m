Received: from eggs.gnu.org ([2001:4830:134:3::10]:49569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paddusn@yahoo.com>) id 1dpwWT-0001zs-5E
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:07:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paddusn@yahoo.com>) id 1dpwWO-0001v1-1h
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:07:09 -0400
Received: from sonic315-35.consmr.mail.gq1.yahoo.com ([98.137.65.59]:36924)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paddusn@yahoo.com>) id 1dpwWN-0001tA-Pb
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:07:03 -0400
Date: Thu, 7 Sep 2017 13:02:59 +0000 (UTC)
From: Padmanabhan S N <paddusn@yahoo.com>
Message-ID: <129545317.4985876.1504789379418@mail.yahoo.com>
MIME-Version: 1.0
References: <129545317.4985876.1504789379418.ref@mail.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Converting host virtual addresses to guest physical
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

I'm developing a new block backend driver. Since my Guest RAM is coming out=
 of shared memory (memory-backend-file,mem-path=3D/dev/shmem/foo), while pe=
rforming the IO I would like to pass QEMUIOVector buffers directly to anoth=
er user-space process running on the same host to enable zerocopy. Can some=
one help me understand the different memory regions that are mapped in the =
qemu process address space and how they map to each other ?
1. My guest is configured with 1G RAM. /proc/<pid>/maps on the qemu process=
 shows two 1G regions that are mapped. One of them is /dev/shmem/foo, which=
 I believe corresponds to the guest physical memory. What is the other 1G r=
egion ?=C2=A0
2. The QEMUIOVector buffers point to this 'other' 1G region that I referred=
 above. How do I convert these pointers to locations in the /dev/shmem/foo =
region ? My plan is to convert the QEMUIOVector buffer pointer to a region =
in /dev/shmem/foo and pass that pointer to another userspace process that a=
lso has the /dev/shmem/foo region mapped.
I understand vhost-user might be the right way to approach this problem. Ho=
wever I'm currently working with qemu-2.8 and it looks neither vhost-user-s=
csi nor vhost-user-blk are available in that version. If you believe there =
is a better approach to solve this problem, let me know.

Thanks,Paddy.
