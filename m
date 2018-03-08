Received: from eggs.gnu.org ([2001:4830:134:3::10]:42434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ettge-0002eg-Gi
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:26:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ettgd-0004yr-BN
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:26:16 -0500
Date: Thu, 8 Mar 2018 12:25:57 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180308112557.GA4911@localhost.localdomain>
References: <20180307185946.29366-1-kwolf@redhat.com>
	<20180308102153.GH4718@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180308102153.GH4718@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 00/37] x-blockdev-create for protocols
 and qcow2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-block@nongnu.org, jdurgin@redhat.com, pkrempa@redhat.com, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, namei.unix@gmail.com

Am 08.03.2018 um 11:21 hat Daniel P. Berrang=E9 geschrieben:
> On Wed, Mar 07, 2018 at 07:59:09PM +0100, Kevin Wolf wrote:
> > This series implements a minimal QMP command that allows to create an
> > image file on the protocol level or an image format on a given block
> > node.
> >=20
> > Eventually, the interface is going to change to some kind of an async
> > command (possibly a (non-)block job), but that will require more work=
 on
> > the job infrastructure first, so let's first QAPIfy image creation in
> > the block drivers. In this series, I'm going for a synchronous comman=
d
> > that is prefixed with x- for now.
> >=20
> > This series converts qcow2 and all protocol drivers that allow an act=
ual
> > image creation. This means that drivers which only check if the alrea=
dy
> > existing storage is good enough are not converted (e.g. host_device,
> > iscsi). The old behaviour was useful because 'qemu-img create' wants =
to
> > create both protocol and format layer, but with the separation in QMP=
,
> > you can just leave out the protocol layer creation when the device
> > already exists.
>=20
> Are you going to convert the other format drivers in later versions of
> this series, or leave it upto individual maintaniers to convert the
> rest ? (personally thinking of the luks driver of course)

In a follow-up series, actually, or perhaps one series per format. This
one is already much longer than I hoped it would become. The longer a
series is, the harder it becomes to get it fully reviewed, address
reviews all over the place and somehow deal with merge conflict. Had I
known how many changes some protocols drivers need, I would probably
have split it into two.

luks happens to be the one format driver that I did first (because it's
alphabetically the first one that supports image creation), so if you
want to look at the patches, they are contained here:

    http://repo.or.cz/qemu/kevin.git/shortlog/refs/heads/blockdev-create

The branch probably doesn't build at the moment, but if you cherry-pick
the luks patches, that should work. I'm going to send them once this
series with the basic support is at least in my block branch (maybe
already later today?)

Kevin
