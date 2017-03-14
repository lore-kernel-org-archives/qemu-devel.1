Received: from eggs.gnu.org ([2001:4830:134:3::10]:57154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cngr5-0004JI-Qc
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 03:26:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cngr2-0005JL-OM
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 03:26:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cngr2-0005J8-IP
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 03:26:48 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-4-git-send-email-armbru@redhat.com>
	<13570a92-1727-f8b1-cbe5-48c53170fa8c@redhat.com>
Date: Tue, 14 Mar 2017 08:26:45 +0100
In-Reply-To: <13570a92-1727-f8b1-cbe5-48c53170fa8c@redhat.com> (Eric Blake's
	message of "Mon, 13 Mar 2017 16:13:55 -0500")
Message-ID: <8737egqpxm.fsf@dusky.pond.sub.org>
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
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

Eric Blake <eblake@redhat.com> writes:

> On 03/13/2017 01:18 AM, Markus Armbruster wrote:
>> This reverts commit 3313b61's changes to tests/qapi-schema/, except
>> for tests/qapi-schema/doc-*.
>>=20
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
> Tested by doing:
>
> $ git checkout 3313b61
> $ git cherry-pick 07c7b92 # the current id on your qapi-doc branch
> $ git diff HEAD^^ --stat tests/qapi-schema | grep -v /doc-
>  72 files changed, 164 insertions(+)
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
>
>>  200 files changed, 92 insertions(+), 1074 deletions(-)
>
> It's a shame we did that much busywork adding test documentation in the
> first place.  But it was incomplete (as I found out when trying to
> convert some existing tests of failures into new tests of success, by
> adding features like anonymous bases to flat unions), and indeed does
> not add much value.

Marc-Andr=C3=A9 initially reported missing documentation errors only in
qapi2texi.py.  I asked why in review of v5, he pointed to tests, I said
"good point" and asked to put the explanation in the commit message.
Got back "I fixed the tests instead (after all, we have complete control
on what to accept or not. that was boring but now it's done)", felt a
bit bad, and then felt bad some more when I made this patch.
