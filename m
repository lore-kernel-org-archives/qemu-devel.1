Received: from eggs.gnu.org ([2001:4830:134:3::10]:35153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cS1Ku-0005ba-5L
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 07:52:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cS1Kq-0002Mp-W2
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 07:52:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cS1Kq-0002Mk-Q7
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 07:52:00 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1481822644-617-1-git-send-email-mdroth@linux.vnet.ibm.com>
Date: Fri, 13 Jan 2017 13:51:57 +0100
In-Reply-To: <1481822644-617-1-git-send-email-mdroth@linux.vnet.ibm.com>
	(Michael Roth's message of "Thu, 15 Dec 2016 11:24:02 -0600")
Message-ID: <87fuknruky.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 0/2] Fixes/tests for hmp_object_del()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>

Andreas, please have a look.  Feel free to ask me to take it through my
tree.

Michael Roth <mdroth@linux.vnet.ibm.com> writes:

> hmp_object_del() followed by a subsequent hmp_object_add() can trigger a
> duplicate ID error if the previous object shared the same ID and was added
> via the command-line. Please see patch 2/2 for more details.
>
> This patchset fixes the issue in question and adds some general unit tests
> for object created via -object, which we later extend to verify the fix in
> question.
>
> Changes since v3:
>
>   - Fixed up comment formating (Markus)
>   - Instead of segfaulting, use &error_abort if assumptions about
>     'object' property group existence change (Markus)
>   - Use g_assert_null in place of g_assert(... == NULL) (Markus)
>
> Changes since v2:
>
>   - Moved the generic unit tests ahead of the fix patch, with a FIXME
>     in place of the actual check for the failure addressed in patch
>     2/2 (Daniel/Markus)
>   - Dropped check for existence of objects' QemuOptsList (Markus)
>   - Dropped unintended whitespace removal in PATCH 1/2
>   - Slight rewording of commit messages to reflect the changes and fix
>     minor grammar errors.
>
> Changes since v1:
>
>   - Moved QemuOpt cleanup out of {qmp,hmp}_object_del() and into common
>     user_creatable_del() path (Daniel, David)
>   - Added corresponding test case in check-qom-proplist
