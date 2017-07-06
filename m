Received: from eggs.gnu.org ([2001:4830:134:3::10]:48118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dTBJl-0008R6-7X
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 14:15:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dTBJh-0002Bz-7u
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 14:15:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dTBJh-0002A2-2Y
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 14:15:53 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1499182263-19139-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1499182263-19139-6-git-send-email-pradeep.jagadeesh@huawei.com>
Date: Thu, 06 Jul 2017 20:15:47 +0200
In-Reply-To: <1499182263-19139-6-git-send-email-pradeep.jagadeesh@huawei.com>
	(Pradeep Jagadeesh's message of "Tue, 4 Jul 2017 11:31:02 -0400")
Message-ID: <877ezlctyk.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 5/6] fsdev: hmp interface for throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Cc: eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>, qemu-devel@nongnu.org, jani kokkonen <jani.kokkonen@huawei.com>, alberto garcia <berto@igalia.com>, Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Pradeep Jagadeesh <pradeepkiruvale@gmail.com> writes:

> This patch introduces hmp interfaces for the fsdev
> devices.
>
> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>

Fails to compile, first error:

/work/armbru/qemu/hmp.c: In function =E2=80=98hmp_fsdev_set_io_throttle=E2=
=80=99:
/work/armbru/qemu/hmp.c:1791:5: warning: implicit declaration of function =
=E2=80=98qmp_fsdev_set_io_throttle=E2=80=99 [-Wimplicit-function-declaratio=
n]
     qmp_fsdev_set_io_throttle(&throttle, &err);
     ^~~~~~~~~~~~~~~~~~~~~~~~~

Do you need to swap PATCH 5 and 6?
