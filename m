Received: from eggs.gnu.org ([2001:4830:134:3::10]:34332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cT2Lo-0003Wd-6S
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 03:09:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cT2Ll-0000em-21
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 03:09:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cT2Lk-0000eh-SC
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 03:09:08 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7950EC05680F
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 08:09:08 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1484325849-18314-1-git-send-email-armbru@redhat.com>
	<0423b2d9-fa4f-86d5-ae08-b5851301120c@redhat.com>
Date: Mon, 16 Jan 2017 09:09:05 +0100
In-Reply-To: <0423b2d9-fa4f-86d5-ae08-b5851301120c@redhat.com> (Eric Blake's
	message of "Fri, 13 Jan 2017 13:27:48 -0600")
Message-ID: <87o9z7ctpa.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 000/180] QAPI patches for 2017-01-13
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 01/13/2017 10:44 AM, Markus Armbruster wrote:
>> This is Marc-Andr=C3=A9's "[PATCH v8 00/21] qapi doc generation (whole
>> version, squashed)" with a few commit messages tweaked, and "[PATCH v8
>> 14/21] (SQUASHED) move doc to schema" unsquashed into 161 patches.
>>=20
>> We did all the respins with in this squashed form to reduce noise.
>> However, since the unsquashed form is better suited for review, and
>> probably nicer if we have to revisit this part of the work down the
>> road, I'm proposing to merge this unsquashed.
>>=20
>> If you want me to post the unsquashed patches, I'm happy to redo this
>> pull request.
>>=20
>> If you'd rather pull the squashed version, likewise.
>>=20
>> I'm afraid this is a bit of a doc conflict magnet.  The sooner we can
>> get it in, the easier for Marc-Andr=C3=A9 and me.
>
> Indeed - there's already a merge conflict with commit e1ff3c6, which
> landed between the time you created the pull request and now.
>
> Also, in trying to merge your branch locally, I get a rejection message
> from my git hooks:
>
> $ git commit
> tests/qapi-schema/comments.out:7: new blank line at EOF.
> tests/qapi-schema/event-case.out:8: new blank line at EOF.
> tests/qapi-schema/ident-with-escape.out:10: new blank line at EOF.
> tests/qapi-schema/include-relpath.out:7: new blank line at EOF.
> tests/qapi-schema/include-repetition.out:7: new blank line at EOF.
> tests/qapi-schema/include-simple.out:7: new blank line at EOF.
> tests/qapi-schema/indented-expr.out:13: new blank line at EOF.
> tests/qapi-schema/qapi-schema-test.out:446: new blank line at EOF.
>
> Worth respinning to fix those issues?

Since I have to respin anyway, why not.

>>       qmp-commands: move 'query-memdev' doc to schema
>
> This one is the conflict with current master.

Thanks for the heads-up, v2 coming.
