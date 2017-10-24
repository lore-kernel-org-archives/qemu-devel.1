Received: from eggs.gnu.org ([2001:4830:134:3::10]:39302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changlimin@h3c.com>) id 1e6ptd-0004O9-8v
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 23:28:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changlimin@h3c.com>) id 1e6pta-0003OB-5q
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 23:28:53 -0400
Received: from smtp.h3c.com ([60.191.123.56]:21474 helo=h3cmg01-ex.h3c.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changlimin@h3c.com>) id 1e6ptZ-0003Jk-Iq
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 23:28:50 -0400
From: Changlimin <changlimin@h3c.com>
Date: Tue, 24 Oct 2017 03:28:33 +0000
Message-ID: <BC29A004BA570342A4CC0044A3845572CFCE4DB9@H3CMLB12-EX.srv.huawei-3com.com>
Content-Language: zh-CN
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] qemu-img crash when resize a qcow2 file created with
 preallocation=full/falloc .
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi,
I am glad to see that qcow2 file created with preallocation=3Dfull/falloc c=
an be resized. But when I test it, qemu-img crashs.
qemu-img: block/qcow2-refcount.c:530: qcow2_refcount_area: Assertion `!(sta=
rt_offset % s->cluster_size)' failed.

These are commands:
qemu-img create -f qcow2 -o preallocation=3Dfull full.img 1G
qemu-img resize --preallocation=3Dfull full.img +1G

BR
Chang Limin
