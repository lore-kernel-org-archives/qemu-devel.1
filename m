Received: from eggs.gnu.org ([2001:4830:134:3::10]:37478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fzOCK-0008Ue-Ed
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 11:33:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fzNxo-0004Yy-I7
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 11:18:57 -0400
Date: Mon, 10 Sep 2018 17:18:48 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180910151848.GJ4901@dhcp-200-186.str.redhat.com>
References: <20180809213528.14738-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180809213528.14738-1-mreitz@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.1 v10 00/31] block: Fix some filename
 generation issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>

Am 09.08.2018 um 23:34 hat Max Reitz geschrieben:
> Once more, I=E2=80=99ll spare both me and you another iteration of the =
cover
> letter, so see here:
>=20
> http://lists.nongnu.org/archive/html/qemu-block/2017-09/msg01030.html
>=20
> (Although this series no longer includes a @base-directory option.)
>=20
> In regards to the last version, the biggest change is that I dropped
> backing_overridden and instead try to compare the filename from the
> image header with the filename of the actual backing BDS to find out
> whether the backing file has been overridden.
>=20
> In order that this doesn=E2=80=99t break whenever the header contains a=
 slightly
> unusual (=E2=80=9Cnon-canonical=E2=80=9D) backing filename (e.g. =E2=80=
=9Cfile:foo.qcow2=E2=80=9D or
> =E2=80=9Cnbd:localhost:10809=E2=80=9D instead of =E2=80=9Cnbd://localho=
st:10809=E2=80=9D, i.e. something
> different from what bdrv_refresh_filename() would generate), when the
> reference filename in the BDS (auto_backing_file) is used to open the
> backing file, it is updated from the backing BDS's resulting filename.

This doesn't seem to apply cleanly any more.

Kevin
