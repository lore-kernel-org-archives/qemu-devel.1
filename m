Received: from eggs.gnu.org ([2001:4830:134:3::10]:41273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1fOMZr-0008MF-5i
	for qemu-devel@nongnu.org; Thu, 31 May 2018 08:21:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1fOMZq-0007hN-74
	for qemu-devel@nongnu.org; Thu, 31 May 2018 08:21:11 -0400
Message-Id: <5B0FE8AD020000480007AD4C@prv-mh.provo.novell.com>
Date: Thu, 31 May 2018 06:21:01 -0600
From: "Bruce Rogers" <brogers@suse.com>
References: <20180531004323.4611-1-jsnow@redhat.com>
In-Reply-To: <20180531004323.4611-1-jsnow@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: Re: [Qemu-devel] [PATCH 0/3] ahci: fix completion race condition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, qemu-devel@nongnu.org, jsnow@redhat.com

>>> On 5/30/2018 at 6:43 PM, John Snow <jsnow@redhat.com> wrote:
> Commit d759c951f changed the main thread lock release/reacquisition,
> and in so doing apparently jostled loose a race condition in the AHCI
> code.
>=20
> Patch 2 should be sufficient to fix this, and patches 1 and 3 are just
> little trivial fixes.
>=20
> This might be sufficient to fix the bug as reported at
> https://bugs.launchpad.net/qemu/+bug/1769189=20
> but the nature of the timing changes make it difficult to confirm,
> so I am posting this patchset for the reporters to help test.
>=20
> John Snow (3):
>   ahci: trim signatures on raise/lower
>   ahci: fix PxCI register race
>   ahci: don't schedule unnecessary BH
>=20
>  hw/ide/ahci.c | 24 +++++++++++=E2=80=91=E2=80=91=E2=80=91=E2=80=91=E2=80=
=91=E2=80=91=E2=80=91=E2=80=91=E2=80=91=E2=80=91=E2=80=91=E2=80=91=E2=80=91=

>  1 file changed, 11 insertions(+), 13 deletions(=E2=80=91)
>=20
> =E2=80=91=E2=80=91=20
> 2.14.3

In my case, I applied these 3 patches on top of v2.12 qemu under which
I can fairly reliably reproduce Windows10 disk delays. With these patches,
after quite a number of attempts, I no longer can reproduce the failure
case, so from my perspective it solves the issue.

Thanks!

Bruce
