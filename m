Received: from eggs.gnu.org ([2001:4830:134:3::10]:49941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpT3T-0004By-7L
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 01:39:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpT3Q-0004pP-2d
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 01:39:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dpT3P-0004oj-Ss
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 01:39:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9B7FEC0587C6
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 05:39:10 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170901153758.8628-1-armbru@redhat.com>
	<20170901153758.8628-14-armbru@redhat.com>
	<7c233ab0-b316-2cc0-ef6c-a9dc562ea5f0@redhat.com>
Date: Wed, 06 Sep 2017 07:39:06 +0200
In-Reply-To: <7c233ab0-b316-2cc0-ef6c-a9dc562ea5f0@redhat.com> (Eric Blake's
	message of "Tue, 5 Sep 2017 15:38:15 -0500")
Message-ID: <87o9qofksl.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 13/47] tests/check-qlit: New,
 covering qobject/qlit.c
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

> On 09/01/2017 10:37 AM, Markus Armbruster wrote:
>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>=20
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Message-Id: <20170825105913.4060-11-marcandre.lureau@redhat.com>
>> [Copyright notice correction squashed in, commit message tweaked]
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  tests/Makefile.include |  5 +++-
>>  tests/check-qlit.c     | 64 +++++++++++++++++++++++++++++++++++++++++++=
+++++++
>>  2 files changed, 68 insertions(+), 1 deletion(-)
>>  create mode 100644 tests/check-qlit.c
>
> Adds a new file that is not covered by tests/.gitignore when doing an
> in-tree build

Easy enough to fix.

>               (and is one of our few check-* names that stands out in
> comparison to the bulk of the tests named test-* or *-test).

It's called check-lit.c because to match the related tests check-qlit.c
check-qdict.c check-qnull.c check-qstring.c check-qjson.c check-qnum.c
check-qlist.c.

> Of course, the point may be moot if we take the patch for
> auto-generating tests/.gitignore on an in-tree build...
