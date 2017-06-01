Received: from eggs.gnu.org ([2001:4830:134:3::10]:48988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dGOkM-0006N3-Br
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:58:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dGOkL-0007nr-Fa
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:58:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dGOkL-0007nf-84
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:58:33 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2118880E79
	for <qemu-devel@nongnu.org>; Thu,  1 Jun 2017 11:58:32 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170531135709.345-1-marcandre.lureau@redhat.com>
	<20170531135709.345-8-marcandre.lureau@redhat.com>
Date: Thu, 01 Jun 2017 13:58:28 +0200
In-Reply-To: <20170531135709.345-8-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Wed, 31 May 2017 17:56:31 +0400")
Message-ID: <87tw3zsyvv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 07/45] tests: remove alt num-int cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> From: Markus Armbruster <armbru@redhat.com>
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
>> There are no real users of this case, and it's going to be invalid after
>> merging of QFloat and QInt use the same QNum type in the following patch.
>
> Invalid because our alternate code is insufficiently sophisticated.  In
> other words fixable.  See "[PATCH 4/4] qapi: Reject alternates that
> can't work with keyval_parse()" I just posted.
>
> My patch's commit message describes two related issues, one fixable and
> one unfixable.  The fixable one already exists, but only in QGA.  I
> intend to fix it, but it's not a priority.
>
> Fixing the issue you describe seems even less important.  I considered
> outlawing it in my series (patch appended for your reading pleasure),
> but decided to leave it to yours.  I don't expect you to replace your
> patch.  Perhaps my patch helps you with rebasing yours should that
> become necessary.
>
> Message-Id: <87tw4cn7sh.fsf@dusky.pond.sub.org>

Uh, this got a bit messed up :)

Your original patch only dropped test cases that will become invalid.

In my review, I elaborated a bit on "invalid", and mentioned that I had
considered outlawing such alternates independently of this series, but
refrained.  I appended a patch for reference, and in the hope that it
helps you rebasing your patch.

It looks like you replaced your patch by mine, and the commit message by
my review.  The resulting patch does more than just "tests: remove alt
num-int cases".  It also lacks your S-o-b.

I recommend to drop the change to qapi.py, and restore your original
commit message.  Should effectively be a rebase of your v1.

I further suggest a bit more detail in the commit message, perhaps like
this:

    tests: Remove test cases for alternates of 'number' and 'int'

    Alternates with both a 'number' and an 'int' branch will become
    invalid when the next patch merges of QFloat and QInt into QNum.
    More sophisticated alternate code could keep them valid, but since
    we have no users outside tests, simply drop the tests.

    Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

You can then add
Reviewed-by: Markus Armbruster <armbru@redhat.com>
