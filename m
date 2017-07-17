Received: from eggs.gnu.org ([2001:4830:134:3::10]:51567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dX2XD-0001yg-MF
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:41:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dX2X9-0002uq-RQ
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:41:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:13085)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dX2X9-0002ty-Lx
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:41:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9E9975F7B6
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 09:41:42 +0000 (UTC)
References: <20170717063521.GA7393@lemon>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b718f71c-5208-298a-4fb9-0c2fea3146ec@redhat.com>
Date: Mon, 17 Jul 2017 11:41:38 +0200
MIME-Version: 1.0
In-Reply-To: <20170717063521.GA7393@lemon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Status and RFC of patchew testings on QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

On 17.07.2017 08:35, Fam Zheng wrote:
> Hi all,
>=20
> Today I've included a fourth type of the automatic patchew replies: Fre=
eBSD.
>=20
> So far we have these tests running by patchew on each patch series:
>=20
>   * Docker tests
>     Basically it is
>         make docker-test-quick@centos6 \
>              docker-test-build@min-glib \
>              docker-test-mingw@fedora"
>=20
>   * checkpatch.pl
>     Each patch is fed to ./scripts/checkpatch.pl and all errors are rep=
orted.
>=20
>   * s390x
>     It runs on a machine shared by Fedora team, basically only "./confi=
gure and
>     make", because "make check" hanging is tricky to deal with from an
>     automation perspective. (Ideas?)

Is there any check that could hang "forever"? I think most of the checks
should have a proper timeout of one or two minutes, don't they?

Maybe you could also simply run the "make check" with the "timeout"
command to avoid that it hangs forever?

>   * FreeBSD
>     Like s390x.
>=20
> Q1: In the worst case, you get four individual auto replies from patche=
w. Is
> that too many? Do you prefer one reply with all the results concatenate=
d into
> one?

One result would be nicer, I think.

> Q2: Some think the full log in the mail body is more than necessary. Is=
 it
> better or worse if it is a "tail -n 200" of the log in the body and the=
 full log
> attached?
>=20
> Q3: What other tests do maintainers want? Different hosts? Different co=
nfigure
> combinations?

Not sure, but should we maybe also check compiling with the configure
switches set to non-default values? E.g. --enable-debug --disable-slirp
--enable-tcg-interpreter --disable-tcg etc. ?

 Thomas
