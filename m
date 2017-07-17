Received: from eggs.gnu.org ([2001:4830:134:3::10]:44744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dX3RK-000509-GH
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:39:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dX3RH-0007iN-9D
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:39:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1dX3RH-0007i8-33
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:39:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9D7D8356C2
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 10:39:41 +0000 (UTC)
Date: Mon, 17 Jul 2017 12:39:37 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170717103937.GD5301@noname.redhat.com>
References: <20170717063521.GA7393@lemon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170717063521.GA7393@lemon>
Subject: Re: [Qemu-devel] Status and RFC of patchew testings on QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org

Am 17.07.2017 um 08:35 hat Fam Zheng geschrieben:
> Hi all,
> 
> Today I've included a fourth type of the automatic patchew replies: FreeBSD.
> 
> So far we have these tests running by patchew on each patch series:
> 
>   * Docker tests
>     Basically it is
>         make docker-test-quick@centos6 \
>              docker-test-build@min-glib \
>              docker-test-mingw@fedora"
> 
>   * checkpatch.pl
>     Each patch is fed to ./scripts/checkpatch.pl and all errors are reported.
> 
>   * s390x
>     It runs on a machine shared by Fedora team, basically only "./configure and
>     make", because "make check" hanging is tricky to deal with from an
>     automation perspective. (Ideas?)
> 
>   * FreeBSD
>     Like s390x.
> 
> Q1: In the worst case, you get four individual auto replies from patchew. Is
> that too many? Do you prefer one reply with all the results concatenated into
> one?

checkpatch.pl is different enough from the other build/test errors that
I would prefer keeping a separate reply for that one.

But it seems that if your code doesn't compile (e.g. with different
configure options than on the developer's machine), chances are that all
three other tests fail, and then one reply for all of them is good
enough.

> Q2: Some think the full log in the mail body is more than necessary. Is it
> better or worse if it is a "tail -n 200" of the log in the body and the full log
> attached?

If you would attach the full log anyway, I'd say keep it in the body.
The other option is what others proposed in this thread, 'tail -n 200'
in the body and then include just a link to the full log in a web
interface.

> Q3: What other tests do maintainers want? Different hosts? Different configure
> combinations?

Would running qemu-iotests (at least the 'quick' group) be possible or
would that take too many resources?

Only today I noticed again that two recently merged pull requests broke
qemu-iotests cases, so I must assume that apart from some block
maintainers, nobody runs it regularly.

Kevin
