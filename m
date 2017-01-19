Received: from eggs.gnu.org ([2001:4830:134:3::10]:56867)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1cUFbX-0001HO-Lh
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 11:30:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1cUFbU-0002tT-Gd
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 11:30:27 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:39571 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1cUFbU-0002sk-7u
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 11:30:24 -0500
From: Peter Lieven <pl@kamp.de>
Message-ID: <0bb184fe-d348-a1d4-ac14-0f02f070c287@kamp.de>
Date: Thu, 19 Jan 2017 17:30:20 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] qemu-img: complains about missing iscsi option group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu block <qemu-block@nongnu.org>
Cc: pbonzini@redhat.com, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Hi all,


since commit f57b4b5 (blockdev: prepare iSCSI block driver for dynamic loading)

qemu-img complains about a missing option group several times.


~/git/qemu$ ./qemu-img info iscsi://172.21.200.56:3260/iqn.2001-05.com.equallogic:0-8a0906-69d384e0a-aa3004e55e15878d-00lieven-data/0
qemu-img: There is no option group 'iscsi'
qemu-img: There is no option group 'iscsi'
qemu-img: There is no option group 'iscsi'
qemu-img: There is no option group 'iscsi'
image: iscsi://172.21.200.56:3260/iqn.2001-05.com.equallogic:0-8a0906-69d384e0a-aa3004e55e15878d-00lieven-data/0
file format: raw
virtual size: 25G (26848788480 bytes)
disk size: unavailable
cluster_size: 15728640

I don't know whats the proper way to fix this?


Thanks,

Peter
