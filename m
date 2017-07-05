Received: from eggs.gnu.org ([2001:4830:134:3::10]:51408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dScoO-0006zv-C3
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 01:25:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dScoK-00079X-Dr
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 01:25:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dScoK-00078P-87
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 01:25:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3D9B94E4CA
	for <qemu-devel@nongnu.org>; Wed,  5 Jul 2017 05:25:10 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
Date: Wed, 05 Jul 2017 07:25:06 +0200
In-Reply-To: <20170704220346.29244-1-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Wed, 5 Jul 2017 00:03:11 +0200")
Message-ID: <87a84jfob1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/35] RFC: coroutine annotations & clang
 check
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

> Hi,
>
> After investigating a bit using clang-tidy to do some coroutine checks
> (and hitting a wall as there are no pre-processor info in the AST), it
> was suggested to me on the clang mailing list to try to use
> -Wthread-safety. I had to modify clang a bit to make it work on qemu
> code base (annotations on function typedef etc,
> https://github.com/elmarco/clang qemu-ta branch - very hackish state).

Hardcore!

Are your clang modifications upstreamable once cleaned up?

> The analysis simply checks that coroutine_fn are called from a
> coroutine "context" (or "role"). I couldn't find any misuse in qemu
> code base, however, a number of coroutine_fn annotations are missing.
>
> (I think it would make sense to squash all the "mark coroutine_fn"
> commits if we apply them, I tried to split them by domains/maintainer
> to ease review)
[...]
>  49 files changed, 299 insertions(+), 132 deletions(-)

"A number of coroutine_fn annotations are missing" seems to be an
understatement :)
