Received: from eggs.gnu.org ([2001:4830:134:3::10]:48428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1elcUL-0006cV-8o
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:27:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1elcUK-0002yF-B1
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:27:21 -0500
Date: Tue, 13 Feb 2018 15:27:11 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180213152711.GI2378@work-vm>
References: <20180111130427.GG8326@redhat.com>
	<20180213105024.GC5083@localhost.localdomain>
	<20180213143001.GA2354@rkaganb.sw.ru>
	<20180213143615.GN573@redhat.com>
	<20180213144521.GI5083@localhost.localdomain>
	<20180213144838.GO573@redhat.com> <20180213145913.GE2378@work-vm>
	<6845a694-aa22-90e8-7a9b-ce0283be450c@virtuozzo.com>
	<20180213150503.GF2378@work-vm>
	<20180213151352.GF2307@rkaganb.sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180213151352.GF2307@rkaganb.sw.ru>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block]  [PATCH 1/2] Add save-snapshot,
 load-snapshot and delete-snapshot to QAPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, "Denis V. Lunev" <den@virtuozzo.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Richard Palethorpe <richiejp@f-m.fm>, Qemu-block <qemu-block@nongnu.org>, quintela@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, Max Reitz <mreitz@redhat.com>, rpalethorpe@suse.com, Denis Plotnikov <dplotnikov@virtuozzo.com>, aarcange@redhat.com

* Roman Kagan (rkagan@virtuozzo.com) wrote:
> On Tue, Feb 13, 2018 at 03:05:03PM +0000, Dr. David Alan Gilbert wrote:
> > * Denis V. Lunev (den@virtuozzo.com) wrote:
> > > On 02/13/2018 05:59 PM, Dr. David Alan Gilbert wrote:
> > > > * Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> > > >> That doesn't seem practical unless you can instantaneously write=
 out
> > > >> the entire guest RAM to disk without blocking, or can somehow sn=
apshot
> > > >> the RAM so you can write out a consistent view of the original R=
AM,
> > > >> while the guest continues to dirty RAM pages.
> > > > People have suggested doing something like that with userfault wr=
ite
> > > > mode; but the same would also be doable just by write protecting =
the
> > > > whole of RAM and then following the faults.
> > >=20
> > > nope, userfault fd does not help :( We have tried, the functionalit=
y is not
> > > enough. Better to have small extension to KVM to protect all memory
> > > and notify QEMU with accessed address.
> >=20
> > Can you explain why? I thought the write-protect mode of userfaultfd =
was
> > supposed to be able to do that; cc'ing in Andrea
>=20
> IIRC it would if it worked; it just didn't when we tried.

Hmm that doesn't seem to be the ideal reason to create new KVM
functionality, especially since there were a bunch of people wanting the
userfaultfd-write mode for other uses.

Dave

> Roman.
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
