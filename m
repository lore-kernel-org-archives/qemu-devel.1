Received: from eggs.gnu.org ([2001:4830:134:3::10]:53935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1d62wn-0002hJ-Db
	for qemu-devel@nongnu.org; Wed, 03 May 2017 18:40:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1d62wj-0001YR-Be
	for qemu-devel@nongnu.org; Wed, 03 May 2017 18:40:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1d62wj-0001XV-6A
	for qemu-devel@nongnu.org; Wed, 03 May 2017 18:40:33 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3BF5B80C08
	for <qemu-devel@nongnu.org>; Wed,  3 May 2017 22:40:32 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
	(colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 31A7A78DD5
	for <qemu-devel@nongnu.org>; Wed,  3 May 2017 22:40:32 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com
	(zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
	by colo-mx.corp.redhat.com (Postfix) with ESMTP id 289E418523C2
	for <qemu-devel@nongnu.org>; Wed,  3 May 2017 22:40:32 +0000 (UTC)
Date: Wed, 3 May 2017 18:40:31 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <991491953.6691041.1493851231934.JavaMail.zimbra@redhat.com>
In-Reply-To: <20170503223846.6559-1-marcandre.lureau@redhat.com>
References: <20170503223846.6559-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 0/5] Memory leak fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org


This is actually v1 (confused with git-publish)

----- Original Message -----
> Hi,
>=20
> A new series of leaks spotted by ASAN. Mostly after introducing of the
> test-hmp. Would it be useful having a configure --enable-asan, and
> enabled by default with --enable-debug?
>=20
> Marc-Andr=C3=A9 Lureau (5):
>   test-keyval: fix leaks
>   audio: fix capture buffer leaks
>   audio: fix WAVState leak
>   slirp: fix leak
>   dump: fix memory_mapping_filter leak
>=20
>  audio/audio.c       | 2 ++
>  audio/wavcapture.c  | 1 +
>  memory_mapping.c    | 1 +
>  slirp/socket.c      | 3 +++
>  tests/test-keyval.c | 4 ++++
>  5 files changed, 11 insertions(+)
>=20
> --
> 2.12.0.191.gc5d8de91d
>=20
>=20
