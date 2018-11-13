Received: from eggs.gnu.org ([2001:4830:134:3::10]:46186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gMVwW-00082T-1f
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 05:29:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gMVwQ-0008LE-3f
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 05:29:12 -0500
Received: from 6.mo7.mail-out.ovh.net ([188.165.39.218]:60040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gMVwP-0008Ke-SI
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 05:29:06 -0500
Received: from player779.ha.ovh.net (unknown [10.109.146.168])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 73BA9E9D7B
	for <qemu-devel@nongnu.org>; Tue, 13 Nov 2018 11:29:04 +0100 (CET)
Date: Tue, 13 Nov 2018 11:28:55 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20181113112855.4f3984f8@bahia.lan>
In-Reply-To: <A02D6AA901860840B46E751C5E9E38B43CC96FA1@DGGEML532-MBX.china.huawei.com>
References: <A02D6AA901860840B46E751C5E9E38B43CC96FA1@DGGEML532-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 0/3] fsdev-throttle-qmp: refactor code
 for qmp interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xiezhide <xiezhide@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "berto@igalia.com" <berto@igalia.com>, "aneesh.kumar@linux.vnet.ibm.com" <aneesh.kumar@linux.vnet.ibm.com>

Hi Kidd,

This posting is still broken: no threading and missing leading blanks on
unchanged lines. Also is x00390961 really your name of choice ?

In some other mail, you mentioned copy-paste to an outlook mail client...
please don't do that to post series. Use git format-patch and git send-email
instead and you'll get the formatting and threading right.

Cheers,

--
Greg

On Tue, 13 Nov 2018 09:59:54 +0000
xiezhide <xiezhide@huawei.com> wrote:

> This patches provide qmp interface to query/set io throttle parameters of a fsdev.
> Some of patches also refactor the code and structure that was present in block and fsdev files.
> 
> x00390961 (3):
>   fsdev-throttle-qmp: refactor code for qmp interface for io throttling
>   fsdev-throttle-qmp: qmp interface for fsdev io throttling
>   fsdev-throttle-qmp: hmp interface for fsdev io throttling
> 
>  Makefile                        |  20 +++-
>  Makefile.objs                   |   8 ++
>  block/throttle.c                |   6 +-
>  blockdev.c                      |  96 +----------------
>  fsdev/qemu-fsdev-dummy.c        |  11 ++
>  fsdev/qemu-fsdev-throttle.c     | 144 +++++++++++++++++---------
>  fsdev/qemu-fsdev-throttle.h     |   6 +-
>  fsdev/qemu-fsdev.c              |  29 ++++++
>  hmp-commands-info.hx            |  15 +++
>  hmp-commands.hx                 |  15 +++
>  hmp.c                           |  83 +++++++++++++--
>  hmp.h                           |   4 +
>  include/qemu/throttle-options.h |   3 +-
>  include/qemu/throttle.h         |   4 +-
>  include/qemu/typedefs.h         |   1 +
>  monitor.c                       |  41 ++++----
>  qapi/block-core.json            | 122 +---------------------
>  qapi/fsdev.json                 |  96 +++++++++++++++++
>  qapi/qapi-schema.json           |   1 +
>  qapi/tlimits.json               |  89 ++++++++++++++++
>  qmp.c                           |  12 +++
>  util/throttle.c                 | 224 ++++++++++++++++++++++++++--------------
>  22 files changed, 654 insertions(+), 376 deletions(-)
>  create mode 100644 qapi/fsdev.json
>  create mode 100644 qapi/tlimits.json
> 
> v0 -> v1:
>  Addressed comments from Eric Blake and Greg Kurz.
>  Fix patch corrupt issue due to email client change the patch format with copy-to-paster
>  Break patch to patches
> 
> --
> 1.8.3.1
> 
