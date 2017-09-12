Received: from eggs.gnu.org ([2001:4830:134:3::10]:51298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1drbxK-0007hJ-PP
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 23:33:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1drbxH-0003vA-JE
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 23:33:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1drbxH-0003u6-DC
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 23:33:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 467985D5EB
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 03:33:42 +0000 (UTC)
Date: Tue, 12 Sep 2017 11:33:33 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170912033333.GA29091@pxdev.xzpeter.org>
References: <20170911132627.9505-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170911132627.9505-1-cohuck@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] dump: do not dump non-existent guest memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, berrange@redhat.com, dgilbert@redhat.com

On Mon, Sep 11, 2017 at 03:26:27PM +0200, Cornelia Huck wrote:
> It does not really make sense to dump memory that is not there.
>=20
> Moreover, that fixes a segmentation fault when calling dump-guest-memor=
y
> with no filter for a machine with no memory defined.
>=20
> New behaviour is:
>=20
> (qemu) dump-guest-memory /dev/null
> dump: no guest memory to dump
> (qemu) dump-guest-memory /dev/null 0 4096
> dump: no guest memory to dump
>=20
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>=20
> Another unmaintained file. Joy. cc:ing some more-or-less random folks.

I thought Marc-Andr=C3=A9 had proposed to be the maintainer? But indeed I
didn't see the line in maintainer file.

Anyway, if anyone think I am ok to maintain this single file
(considering that I haven't posted patches on it for 2 years, and I
haven't been working on any kind of maintainer job), please let me
know. I'm glad to start with it (or with Marc-Andr=C3=A9).

Thanks,

--=20
Peter Xu
