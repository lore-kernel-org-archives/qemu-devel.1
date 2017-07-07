Received: from eggs.gnu.org ([2001:4830:134:3::10]:44583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dTMX7-00073T-Rf
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 02:14:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dTMX2-0005oS-UR
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 02:14:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dTMX2-0005o7-Nl
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 02:14:24 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1499182263-19139-1-git-send-email-pradeep.jagadeesh@huawei.com>
Date: Fri, 07 Jul 2017 08:14:21 +0200
In-Reply-To: <1499182263-19139-1-git-send-email-pradeep.jagadeesh@huawei.com>
	(Pradeep Jagadeesh's message of "Tue, 4 Jul 2017 11:30:57 -0400")
Message-ID: <87podcrcxu.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 0/6] fsdev: qmp interface for io
 throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Cc: eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>, alberto garcia <berto@igalia.com>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, jani kokkonen <jani.kokkonen@huawei.com>

Pradeep Jagadeesh <pradeepkiruvale@gmail.com> writes:

> These patches provide the qmp interface, to query the io throttle 
> status of the all fsdev devices that are present in a vm.
> also, it provides an interface to set the io throttle parameters of a
> fsdev to a required value. some of the patches also remove the duplicate
> code that was present in block and fsdev files. 
>
> Pradeep Jagadeesh (6):
>   throttle: factor out duplicate code
>   qmp: Create IOThrottle structure
>   throttle: move out function to reuse the code
>   hmp: create a throttle initialization function for code reusability
>   fsdev: hmp interface for throttling
>   fsdev: QMP interface for throttling
>
>  Makefile                        |   4 ++
>  blockdev.c                      |  97 ++-------------------------------
>  fsdev/qemu-fsdev-dummy.c        |  10 ++++
>  fsdev/qemu-fsdev-throttle.c     | 118 ++++++++++++++++++++++++++--------------
>  fsdev/qemu-fsdev-throttle.h     |  13 +++++
>  fsdev/qemu-fsdev.c              |  37 +++++++++++++
>  hmp-commands-info.hx            |  18 ++++++
>  hmp-commands.hx                 |  19 +++++++
>  hmp.c                           |  81 +++++++++++++++++++++++++--
>  hmp.h                           |   4 ++
>  include/qemu/throttle-options.h |   7 +++
>  include/qemu/throttle.h         |   4 +-
>  include/qemu/typedefs.h         |   1 +
>  monitor.c                       |   5 ++
>  qapi-schema.json                |   3 +
>  qapi/block-core.json            |  76 +-------------------------
>  qapi/fsdev.json                 |  84 ++++++++++++++++++++++++++++
>  qapi/iothrottle.json            |  88 ++++++++++++++++++++++++++++++
>  qmp.c                           |  14 +++++
>  util/throttle.c                 | 110 +++++++++++++++++++++++++++++++++++++
>  20 files changed, 577 insertions(+), 216 deletions(-)
>  create mode 100644 qapi/fsdev.json
>  create mode 100644 qapi/iothrottle.json

No test coverage?
