Received: from eggs.gnu.org ([2001:4830:134:3::10]:41253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1fZ4xr-0007MI-G6
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 21:46:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1fZ4xo-0000C4-Dy
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 21:46:15 -0400
Received: from [45.249.212.255] (port=55175 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arei.gonglei@huawei.com>)
	id 1fZ4xn-0008QP-Vi
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 21:46:12 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Sat, 30 Jun 2018 01:45:29 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DB03024F@dggeml511-mbx.china.huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] about live memory snapshot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "peterx@redhat.com" <peterx@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi Peter,

As we discussed in LC3 China, the current scheme of "migration to file"=20
can't fit on production environment, which will cause the snapshot file big=
ger=20
and bigger when the guest is under enough memory pressure. We can't
assume what size the snapshot file is.
=20
Pls have a look if we have a simple method to resolve the problem. :)

PS: the below link is zhanghailiang's scheme based on userfaultfd.

https://lists.gnu.org/archive/html/qemu-devel/2016-01/msg00664.html


Thanks,
-Gonglei
=20
