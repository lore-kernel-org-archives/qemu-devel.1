Received: from eggs.gnu.org ([2001:4830:134:3::10]:49028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gM9EU-0002k6-0D
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 05:14:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gM9EO-00065X-S7
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 05:14:13 -0500
Received: from 11.mo4.mail-out.ovh.net ([46.105.34.195]:53255)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gM9EO-00064D-B9
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 05:14:08 -0500
Received: from player758.ha.ovh.net (unknown [10.109.143.18])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 3A3A01BFE42
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 11:14:05 +0100 (CET)
Date: Mon, 12 Nov 2018 11:13:57 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20181112111357.5f60be3c@bahia.lan>
In-Reply-To: <A02D6AA901860840B46E751C5E9E38B43CC96A5B@DGGEML532-MBX.china.huawei.com>
References: <A02D6AA901860840B46E751C5E9E38B42AFDB13F@DGGEML532-MBX.china.huawei.com>
	<A02D6AA901860840B46E751C5E9E38B43CC96A5B@DGGEML532-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] virtio-9p: qmp interface for set/query
 io throttle for fsdev devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xiezhide <xiezhide@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "eblake@redhat.com" <eblake@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "berto@igalia.com" <berto@igalia.com>, "aneesh.kumar@linux.vnet.ibm.com" <aneesh.kumar@linux.vnet.ibm.com>

On Mon, 12 Nov 2018 01:14:55 +0000
xiezhide <xiezhide@huawei.com> wrote:

> These patches provide the qmp interface, to set/query the io throttle
> status of the all fsdev devices that are present in a vm.
> Some of the patches also remove the
> duplicate code that was present in block and fsdev files.
> 
> Zhide Xie (2):
>   fsdev-qmp: qmp interface for set/query io throttle for fsdev devices.
>   fsdev-qmp: fix coding style issue
> 

Hi Zhide Xie,

This series seems to have some formatting issues, like the broken
indention in the diffstat below for example. Also, no message
threading, weird Sob lines:

Signed-off-by: x00390961 <xiezhide@huawei.com<mailto:xiezhide@huawei.com>>

and finally I couldn't even apply patch 1:

$ pwclient git-am 996225 
Applying patch #996225 using 'git am'
Description: [1/2] virtio-9p: qmp interface to set/query io throttle for fsdev devices
Applying: virtio-9p: qmp interface to set/query io throttle for fsdev devices

error: corrupt patch at line 36 <== this confirms that the patch has formatting issues.

Patch failed at 0001 virtio-9p: qmp interface to set/query io throttle for fsdev devices
Use 'git am --show-current-patch' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
'git am' failed with exit status 128


Not sure what mail client was used to send this (I don't see any indication
in the mail headers), but if it's not the case already, I suggest you use
git format-patch and git send-email.

I don't have much time, so I'll wait for the well-formatted v2 before
starting review :-)

> Makefile                                                |  20 +++-
> Makefile.objs                                       |   8 ++
> block/throttle.c                                   |   6 +-
> blockdev.c                                             |  96 +----------------
> fsdev/qemu-fsdev-dummy.c            |  11 ++
> fsdev/qemu-fsdev-throttle.c            | 144 +++++++++++++++++---------
> fsdev/qemu-fsdev-throttle.h           |   6 +-
> fsdev/qemu-fsdev.c                            |  29 ++++++
> hmp-commands-info.hx                     |  15 +++
> hmp-commands.hx                             |  15 +++
> hmp.c                                                     |  83 +++++++++++++--
> hmp.h                                                     |   4 +
> include/qemu/throttle-options.h    |   3 +-
> include/qemu/throttle.h                   |   4 +-
> include/qemu/typedefs.h                  |   1 +
> monitor.c                                               |   4 +
> qapi/block-core.json                           | 122 +---------------------
> qapi/fsdev.json                                     |  96 +++++++++++++++++
> qapi/qapi-schema.json                       |   1 +
> qapi/tlimits.json                                   |  89 ++++++++++++++++
> qmp.c                                                      |  12 +++
> util/throttle.c                                        | 224 ++++++++++++++++++++++++++--------------
> 22 files changed, 639 insertions(+), 354 deletions(-)
> create mode 100644 qapi/fsdev.json
> create mode 100644 qapi/tlimits.json
> 


> --
> 1.8.3.1
