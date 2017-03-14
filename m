Received: from eggs.gnu.org ([2001:4830:134:3::10]:38400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnj1g-0005fD-A0
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 05:45:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnj1d-0004g2-0W
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 05:45:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cnj1c-0004fs-R4
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 05:45:52 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-4-git-send-email-armbru@redhat.com>
	<CAJ+F1CKpSENQk5ifJtk4s4YChPs2N9FO_OcOMioGeM63XaxknQ@mail.gmail.com>
Date: Tue, 14 Mar 2017 10:45:44 +0100
In-Reply-To: <CAJ+F1CKpSENQk5ifJtk4s4YChPs2N9FO_OcOMioGeM63XaxknQ@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 14 Mar 2017
	08:28:24 +0000")
Message-ID: <8737egmbsn.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.9 03/47] qapi: Back out doc comments
 added just to please qapi.py
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Mon, Mar 13, 2017 at 10:36 AM Markus Armbruster <armbru@redhat.com>
> wrote:
>
>> This reverts commit 3313b61's changes to tests/qapi-schema/, except
>> for tests/qapi-schema/doc-*.
>>
>>
> Do we expect those files to change? If not, or not much, I think i't s
> rather better to keep the docs to exercise the parser in various
> situations.

Point taken, but I think the proper way to exercise doc comments is
systematic test cases in qapi-schema-test.json, or perhaps a separate
test schema we create just for exercising doc comments.  Probably should
include a qapi2texi.py run complete with diff to golden .texi.


>             It doesn't reduce the merits of the doc pragma though for oth=
er
> cases, which I wish I would have suggested (but I didn't like the  initial
> series to grow more features)

We were both pretty desperate to get your work in without further delays.
