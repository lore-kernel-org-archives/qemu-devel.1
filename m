Received: from eggs.gnu.org ([2001:4830:134:3::10]:39342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xiezhide@huawei.com>) id 1gMVUf-0004Z6-5P
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 05:00:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xiezhide@huawei.com>) id 1gMVUT-00042F-7k
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 05:00:20 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2288 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <xiezhide@huawei.com>) id 1gMVUS-0003zq-HG
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 05:00:13 -0500
From: xiezhide <xiezhide@huawei.com>
Date: Tue, 13 Nov 2018 09:59:54 +0000
Message-ID: <A02D6AA901860840B46E751C5E9E38B43CC96FA1@DGGEML532-MBX.china.huawei.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v1 0/3] fsdev-throttle-qmp: refactor code for
 qmp interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Eric Blake <eblake@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "groug@kaod.org" <groug@kaod.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "berto@igalia.com" <berto@igalia.com>, "aneesh.kumar@linux.vnet.ibm.com" <aneesh.kumar@linux.vnet.ibm.com>

This patches provide qmp interface to query/set io throttle parameters of a=
 fsdev.
Some of patches also refactor the code and structure that was present in bl=
ock and fsdev files.

x00390961 (3):
  fsdev-throttle-qmp: refactor code for qmp interface for io throttling
  fsdev-throttle-qmp: qmp interface for fsdev io throttling
  fsdev-throttle-qmp: hmp interface for fsdev io throttling

 Makefile                        |  20 +++-
 Makefile.objs                   |   8 ++
 block/throttle.c                |   6 +-
 blockdev.c                      |  96 +----------------
 fsdev/qemu-fsdev-dummy.c        |  11 ++
 fsdev/qemu-fsdev-throttle.c     | 144 +++++++++++++++++---------
 fsdev/qemu-fsdev-throttle.h     |   6 +-
 fsdev/qemu-fsdev.c              |  29 ++++++
 hmp-commands-info.hx            |  15 +++
 hmp-commands.hx                 |  15 +++
 hmp.c                           |  83 +++++++++++++--
 hmp.h                           |   4 +
 include/qemu/throttle-options.h |   3 +-
 include/qemu/throttle.h         |   4 +-
 include/qemu/typedefs.h         |   1 +
 monitor.c                       |  41 ++++----
 qapi/block-core.json            | 122 +---------------------
 qapi/fsdev.json                 |  96 +++++++++++++++++
 qapi/qapi-schema.json           |   1 +
 qapi/tlimits.json               |  89 ++++++++++++++++
 qmp.c                           |  12 +++
 util/throttle.c                 | 224 ++++++++++++++++++++++++++----------=
----
 22 files changed, 654 insertions(+), 376 deletions(-)
 create mode 100644 qapi/fsdev.json
 create mode 100644 qapi/tlimits.json

v0 -> v1:
 Addressed comments from Eric Blake and Greg Kurz.
 Fix patch corrupt issue due to email client change the patch format with c=
opy-to-paster
 Break patch to patches

--
1.8.3.1
