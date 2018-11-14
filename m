Received: from eggs.gnu.org ([2001:4830:134:3::10]:36896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gMulv-0001lv-Ad
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:59:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gMulu-0002FY-9D
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:59:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gMuls-00027J-7Z
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:59:54 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
Date: Wed, 14 Nov 2018 13:59:25 +0100
In-Reply-To: <20181114123643.24091-1-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Wed, 14 Nov 2018 16:36:02 +0400")
Message-ID: <871s7nstle.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 00/41] RFC: slirp: make it again a
 standalone project
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, samuel.thibault@ens-lyon.org, rjones@redhat.com, stefanha@redhat.com, renzo@cs.unibo.it

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Hi,
>
> Based-on: https://people.debian.org/~sthibault/qemu.git/ slirp branch
>
> This series goal is to allow building libslirp as an independent library.
>
> While looking at making SLIRP a seperate running process, I thought
> that having an independent library from QEMU would be a first step.
>
> There has been some attempts to make slirp a seperate project in the past.
> (https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg01092.html)
> Unfortunately, they forked from QEMU and didn't provide enough
> compatibility for QEMU to make use of it (in particular, vmstate
> handling was removed, they lost git history etc). Furthermore, they
> are not maintained as far as I can see.
>
> I would propose to make slirp a seperate project, that can initially
> be used by QEMU as a submodule, keeping Makefile.objs until a proper
> shared library with stability guarantees etc is ready..
>
> The subproject could created by preserving git tags, and cleaning up the =
code style, this way:
>
> git filter-branch --tree-filter "if ls * 1> /dev/null 2>&1; then clang-fo=
rmat -i * /dev/null; fi " -f --subdirectory-filter "slirp" --prune-empty --=
tag-name-filter cat -- --all
> (my clang-format https://gist.github.com/elmarco/cb20c8d92007df0e2fb8a240=
4678ac73)
>
> What do you think?

Has the slirp code been improved to be generally useful?  I still got it
filed under "friends don't let friends use that, except for testing"...
