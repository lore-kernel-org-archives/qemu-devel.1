Received: from eggs.gnu.org ([2001:4830:134:3::10]:59185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1clARH-00022M-VR
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 03:25:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1clARC-0006Ex-57
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 03:25:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:65481)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1clARB-0006Ep-VP
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 03:25:42 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4F8C1C04B93B
	for <qemu-devel@nongnu.org>; Tue,  7 Mar 2017 08:25:41 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1488702958-24336-1-git-send-email-armbru@redhat.com>
	<1488702958-24336-4-git-send-email-armbru@redhat.com>
	<cb0e29f7-149a-cde1-2569-68de0190e3b8@redhat.com>
Date: Tue, 07 Mar 2017 09:25:37 +0100
In-Reply-To: <cb0e29f7-149a-cde1-2569-68de0190e3b8@redhat.com> (Eric Blake's
	message of "Mon, 6 Mar 2017 10:23:51 -0600")
Message-ID: <87a88xijcu.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 03/27] qmp-test: New,
 covering basic QMP protocol
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

Eric Blake <eblake@redhat.com> writes:

> On 03/05/2017 02:35 AM, Markus Armbruster wrote:
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> Message-Id: <1488544368-30622-4-git-send-email-armbru@redhat.com>
>> ---
>>  MAINTAINERS            |   1 +
>>  tests/Makefile.include |   5 +-
>>  tests/libqtest.c       |  17 ++++--
>>  tests/libqtest.h       |   8 +++
>>  tests/qmp-test.c       | 139 ++++++++++++++++++++++++++++++++++++++++++=
+++++++
>>  5 files changed, 164 insertions(+), 6 deletions(-)
>>  create mode 100644 tests/qmp-test.c
>
> Just now noticing (so a followup patch is fine, no need to stall the
> pull request), but this should probably tweak .gitignore for the new
> test

Covered by the *-test line there.  Whether it's a good idea is a
separate question.  I don't really like such globs in .gitignore myself.
In Makefiles even less.

>      (or maybe we should revive Marc-Andr=C3=A9's proposal to generate
> .gitignore at make time).

Maintaining .gitignore for generated files manually is tiresome, so
automation would be nice, if we can pull it off -- writing into the
source tree is a bit tricky to get right.
