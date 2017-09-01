Received: from eggs.gnu.org ([2001:4830:134:3::10]:57294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1dnrEN-0004MW-0w
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 15:03:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1dnrEJ-0004qK-3u
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 15:03:51 -0400
Message-Id: <59A9AF0E0200004800148CAB@prv-mh.provo.novell.com>
Date: Fri, 01 Sep 2017 13:03:42 -0600
From: "Bruce Rogers" <brogers@suse.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: Re: [Qemu-devel] [Qemu-stable] [PATCH 00/79] Patch Round-up for
 stable 2.9.1, freeze on 2017-09-04
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org

>>> On 8/28/2017 at 6:13 PM, <mdroth@linux.vnet.ibm.com> wrote:
> Hi everyone,
>=20
> The following new patches are queued for QEMU stable v2.9.1:
>=20
>   https://github.com/mdroth/qemu/commits/stable-2.9-staging=20
>=20
> The release is planned for 2017-09-07:
>=20
>   http://wiki.qemu.org/Planning/2.9=20
>=20
> Please respond here or CC qemu-stable@nongnu.org on any patches you
> think should be included in the release.
>=20

In addition to ones already mentioned by others might I also suggest the
following which we are carrying in our v2.9.0 based qemu for SUSE / =
openSUSE
releases, which seem to be stable material:

d54fddea xhci: only update dequeue ptr on completed transfers
04bf2526 exec: use qemu_ram_ptr_length to access guest ram

This second patch has a follow on due to negatively affecting xen usage:
f5aa69bd exec: Add locking parameter to qemu_ram_ptr_length

Thanks.

Bruce Rogers
