Received: from eggs.gnu.org ([2001:4830:134:3::10]:44007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xiezhide@huawei.com>) id 1gL1pr-0008JQ-U6
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 03:08:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xiezhide@huawei.com>) id 1gL1pe-0005MK-66
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 03:08:03 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2286 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <xiezhide@huawei.com>) id 1gL1pY-0005AO-8U
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 03:07:54 -0500
From: xiezhide <xiezhide@huawei.com>
Date: Fri, 9 Nov 2018 08:07:33 +0000
Message-ID: <A02D6AA901860840B46E751C5E9E38B42AFDB13F@DGGEML532-MBX.china.huawei.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/2] virtio-9p: qmp interface for set/query io
 throttle for fsdev devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "eblake@redhat.com" <eblake@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "groug@kaod.org" <groug@kaod.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "berto@igalia.com" <berto@igalia.com>"dgilbert@redhat.com" <dgilbert@redhat.com>"armbru@redhat.com" <armbru@redhat.com>, "aneesh.kumar@linux.vnet.ibm.com" <aneesh.kumar@linux.vnet.ibm.com>

These patches provide the qmp interface, to set/query the io throttle
status of the all fsdev devices that are present in a vm.
Some of the patches also remove the
duplicate code that was present in block and fsdev files.

Zhide Xie (2):
  fsdev-qmp: qmp interface for set/query io throttle for fsdev devices.
  fsdev-qmp: fix coding style issue

Makefile                                                |  20 +++-
Makefile.objs                                       |   8 ++
block/throttle.c                                   |   6 +-
blockdev.c                                             |  96 +-------------=
---
fsdev/qemu-fsdev-dummy.c            |  11 ++
fsdev/qemu-fsdev-throttle.c            | 144 +++++++++++++++++---------
fsdev/qemu-fsdev-throttle.h           |   6 +-
fsdev/qemu-fsdev.c                            |  29 ++++++
hmp-commands-info.hx                     |  15 +++
hmp-commands.hx                             |  15 +++
hmp.c                                                     |  83 +++++++++++=
++--
hmp.h                                                     |   4 +
include/qemu/throttle-options.h    |   3 +-
include/qemu/throttle.h                   |   4 +-
include/qemu/typedefs.h                  |   1 +
monitor.c                                               |   4 +
qapi/block-core.json                           | 122 +---------------------
qapi/fsdev.json                                     |  96 +++++++++++++++++
qapi/qapi-schema.json                       |   1 +
qapi/tlimits.json                                   |  89 ++++++++++++++++
qmp.c                                                      |  12 +++
util/throttle.c                                        | 224 ++++++++++++++=
++++++++++++--------------
22 files changed, 639 insertions(+), 354 deletions(-)
create mode 100644 qapi/fsdev.json
create mode 100644 qapi/tlimits.json

--
1.8.3.1
