Received: from eggs.gnu.org ([2001:4830:134:3::10]:51324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1fg58H-0002yP-HE
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 05:21:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1fg58D-0004Ff-IZ
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 05:21:57 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2399 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <linzhecheng@huawei.com>)
	id 1fg58C-0004EO-PF
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 05:21:53 -0400
From: linzhecheng <linzhecheng@huawei.com>
Date: Thu, 19 Jul 2018 09:21:36 +0000
Message-ID: <D9DE8DBB19F2A24080482022C1DE758302CC60EF@DGGEMM529-MBX.china.huawei.com>
Content-Language: zh-CN
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] issue about numa configure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "ehabkost@redhat.com" <ehabkost@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: weifuqiang <weifuqiang@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>

Hi, all
I found that qemu has a constraint in function numa_node_parse now:
     If (node->has_memdev !=3D have_memdevs) {
         Error_setg(errp, "qemu: memdev option must be specified for either=
 "
                    "all or no nodes");
         Return;
     }
This restricts us from being able to configure an empty numa node (without =
memory and cpus). But if I delete these codes, I can start a VM with cmdlin=
e:
qemu-system-x86_64 --enable-kvm  -m size=3D2G,slots=3D256,maxmem=3D300G -sm=
p 2,maxcpus=3D4,sockets=3D4,cores=3D1,threads=3D1 -numa node,nodeid=3D0,cpu=
s=3D0-1,mem=3D2048 -numa node,nodeid=3D1,cpus=3D2-3 ...
We can see only one numa node inside the VM(I have tested both linux and wi=
ndows) after beginning.
And if I hot-plug the dimm memory devices into the empty node, vm will pres=
ent a new numa node inside and the new memory is online then.
I'm wondering if you have any related issue before? Or can we remove this c=
onstraint?
Looking forward to your answers, thanks.
