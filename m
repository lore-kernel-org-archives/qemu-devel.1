Received: from eggs.gnu.org ([2001:4830:134:3::10]:56079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dS4Yq-0005mr-TJ
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:50:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dS4Yp-00013o-K1
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:50:56 -0400
Date: Mon, 3 Jul 2017 18:50:47 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170703165047.GB4936@noname.redhat.com>
References: <20170522211205.14265-1-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170522211205.14265-1-hpoussin@reactos.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/13] vvfat: misc fixes for read-only
 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 22.05.2017 um 23:11 hat Herv=E9 Poussineau geschrieben:
> Hi,
>=20
> This patchset fixes some of issues I encountered when trying to use vvf=
at, and fixes
> bug #1599539: https://bugs.launchpad.net/qemu/+bug/1599539
>=20
> Patch 1 fixes a crash when using 'qemu-img convert'.
> Patches 2 to 6 are code cleanup. No functionnal changes.
> Patches 7 to 13 fix problems detected by disk checking utilities in rea=
d-only mode.
>=20
> With these patches, vvfat creates valid FAT volumes and can be used wit=
h QEMU disk utilities.
>=20
> Read-write mode is still buggy after this patchset, but at least, I was=
 not
> able to crash QEMU anymore.
>=20
> Note that patch 2 doesn't pass checkpatch.pl, as it changes indentation=
 only.

Thanks, fixed the build error in patch 9 (yet unused variables) and
applied to the block branch.

There were a few more minor comments for this series, but it has been on
the list for long enough and I figured that they can be addressed on
top.

Kevin
