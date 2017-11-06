Received: from eggs.gnu.org ([2001:4830:134:3::10]:32879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eBn6s-0000pQ-FG
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:31:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eBn6p-0004bM-Bw
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:31:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1eBn6p-0004ai-5j
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:30:59 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4690861D0E
	for <qemu-devel@nongnu.org>; Mon,  6 Nov 2017 19:30:57 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
	(colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3EF5D5EDE0
	for <qemu-devel@nongnu.org>; Mon,  6 Nov 2017 19:30:57 +0000 (UTC)
Date: Mon, 6 Nov 2017 14:30:56 -0500 (EST)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <1152775610.36873329.1509996656951.JavaMail.zimbra@redhat.com>
In-Reply-To: <ae73f31f-749a-e02e-d04b-1090e350619e@redhat.com>
References: <20171106185411.19551-1-marcandre.lureau@redhat.com>
	<ae73f31f-749a-e02e-d04b-1090e350619e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] .gitignore: remove vscclient
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



----- Original Message -----
> On 11/06/2017 12:54 PM, Marc-Andr=C3=A9 Lureau wrote:
> > It was removed with libcacard.
>=20
> which was back in which commit?  I'm trying to get an idea of how long
> this entry has been stale.

Since:

commit 7b02f5447c64d1854468f758398c9f6fe9e5721f
Author: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Date:   Sun Aug 30 11:48:40 2015 +0200

    libcacard: use the standalone project

>=20
> I'm not opposed to this patch, but I personally like to leave .gitignore
> entries in place for several releases after they are last useful, to
> make incremental builds easier when jumping around between old and new
> branches across the point where the file was removed (as long as the new
> branch still ignores the file, then building the file in the old branch
> doesn't hurt the new branch).  Of course, if I'm that involved in
> backporting madness across branches, I'm also fine updating my own
> .git/info/exclude for cruft that is built in only one of two branches,
> rather than relying on per-branch .gitignore to do it for me.
>=20
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>=20
>=20
