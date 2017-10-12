Received: from eggs.gnu.org ([2001:4830:134:3::10]:57875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e2gb5-00063D-Ri
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:44:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e2gb5-0001Q4-4D
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:44:35 -0400
Date: Fri, 13 Oct 2017 00:44:25 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171012164425.GA16319@lemon>
References: <150781692103.288.8938679290451561790@b58463cdfd5f>
	<f8bb407a-9f1b-4679-e630-764b96b79edf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <f8bb407a-9f1b-4679-e630-764b96b79edf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 00/31] Allow configuring the qcow2 L2 cache
 entry size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, no-reply@patchew.org, berto@igalia.com, kwolf@redhat.com, qemu-block@nongnu.org, den@openvz.org, mreitz@redhat.com

On Thu, 10/12 09:11, Eric Blake wrote:
> Fam,
>=20
> On 10/12/2017 09:02 AM, no-reply@patchew.org wrote:
> > Hi,
> >=20
> > This series failed automatic build test. Please find the testing comman=
ds and
> > their output below. If you have docker installed, you can probably repr=
oduce it
> > locally.
> >=20
>=20
> >   CC      block/qed.o
> >   CC      block/qed-l2-cache.o
> > =1B[01m=1B[K/tmp/qemu-test/src/block/qcow2.c:=1B[m=1B[K In function '=
=1B[01m=1B[Kqcow2_update_options_prepare=1B[m=1B[K':
> > =1B[01m=1B[K/tmp/qemu-test/src/block/qcow2.c:899:25:=1B[m=1B[K =1B[01;3=
1m=1B[Kerror: =1B[m=1B[K'=1B[01m=1B[Kl2_cache_entry_size=1B[m=1B[K' may be =
used uninitialized in this function [=1B[01;31m=1B[K-Werror=3Dmaybe-uniniti=
alized=1B[m=1B[K]
> >      r->l2_table_cache =3D =1B[01;31m=1B[Kqcow2_cache_create(bs, l2_cac=
he_size,=1B[m=1B[K
> >                          =1B[01;31m=1B[K^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~=1B[m=1B[K
> >  =1B[01;31m=1B[K                                           l2_cache_ent=
ry_size)=1B[m=1B[K;
> >                                             =1B[01;31m=1B[K~~~~~~~~~~~~=
~~~~~~~~=1B[m=1B[K
>=20
> Any chance we can tweak patchew to tell gcc to NOT use color escape
> sequences on errors?  While useful in an ANSI terminal, it tends to come
> across awkwardly in email clients that don't render ANSI escapes, and
> just adds bulk to the transcript.
>=20

It's odd that three is "TERM=3Dxterm" in this env. I'll check where it is f=
rom.

Fam
