Received: from eggs.gnu.org ([2001:4830:134:3::10]:55640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fOkC2-0002QY-Qp
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 09:34:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fOkC2-0002ST-0I
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 09:34:10 -0400
Date: Fri, 1 Jun 2018 21:33:59 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180601133359.GA24752@lemon.usersys.redhat.com>
References: <20180601091835.21620-1-famz@redhat.com>
	<20180601124345.GC3458@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180601124345.GC3458@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] file-posix: Consolidate the locking error
 message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Fri, 06/01 13:43, Daniel P. Berrang=E9 wrote:
> On Fri, Jun 01, 2018 at 05:18:35PM +0800, Fam Zheng wrote:
> > When hot-plugging a block device fails due to image locking errors,
> > users won't see the helpful 'Is another process using the image?'
> > message in QMP because currently the error hint is not carried over
> > there.
> >=20
> > Even though extending QMP to include hint is a conceivably easy task,
> > Libvirt will need some change to consume that data.
> >=20
> > Before that is fully sorted out, let's just do the easy fix by joinin=
g
> > the two lines.
>=20
> There are many places in QEMU which uses error hints and these are all
> invisible to libvirt. Arbitrarily picking one hint to remove, while
> leaving everything else unfixed is not a very satisfactory approach.
>=20
> If QEMU passes the hint in QMP, it is trivial for libvirt to be changed
> to append the hint when reporting its own error message, so can we just
> focus on fixing the root cause instead of special casing file-posix.c

The plan was to work on the QMP change in parallel, while this simple pat=
ch can
mitigate the confusion caused by the relatively vague message (the text i=
tself
is going a bit on the cryptic side for people who don't know QEMU interna=
ls).

Fam
