Received: from eggs.gnu.org ([2001:4830:134:3::10]:43630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1emOoa-0005Xc-EN
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 14:03:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1emOoW-0004uN-HA
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 14:03:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53796
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1emOoW-0004uF-Ax
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 14:03:24 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1FJ1DaW058070
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 14:03:23 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2g5dujx2t3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 14:03:23 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 15 Feb 2018 12:03:22 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <cc862cab-5d2b-e786-1867-ffdc84b1da34@redhat.com>
References: <20180211004013.10784-1-eblake@redhat.com>
	<20180211004013.10784-3-eblake@redhat.com>
	<87a7wfj1p6.fsf@dusky.pond.sub.org>
	<cc862cab-5d2b-e786-1867-ffdc84b1da34@redhat.com>
Date: Thu, 15 Feb 2018 13:03:10 -0600
Message-Id: <151872139035.15399.14877698834682754885@sif>
Subject: Re: [Qemu-devel] [PATCH 2/3] qapi: Rename QMP and QGA schema files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>

Quoting Eric Blake (2018-02-12 10:12:11)
> On 02/11/2018 03:49 AM, Markus Armbruster wrote:
> > Eric Blake <eblake@redhat.com> writes:
> > =

> >> Having two files in the tree both named qapi-schema.json just adds
> >> confusion.  Rename these files, and relocate them into the common
> >> qapi/ subdirectory.  Update all build rules that refer to the file
> >> names, and adjust other documentation and comment references to
> >> either track the new name or be rewritten so as to not mention
> >> the file name.
> >>
> >> Maintainer-wise, this means that qapi/qga-schema.json continues
> >> to belong to Michael as QGA maintainer, but now also notifies
> >> Markus and Eric as QAPI maintainers, alongside all the other
> >> QMP QAPI files, matching how other .json QAPI modules belong
> >> to multiple maintainer blurbs.
> >>
> >> Signed-off-by: Eric Blake <eblake@redhat.com>
> >> ---
> >>   docs/devel/writing-qmp-commands.txt          | 13 ++++++-----
> >>   docs/interop/qmp-intro.txt                   |  3 ++-
> >>   Makefile                                     | 10 ++++----
> >>   qga/qapi-schema.json =3D> qapi/qga-schema.json |  0
> > =

> > This move is up to the QGA maintainer.  My usual argument for keeping
> > the schema in one place is weak for the QGA schema: it's maintained
> > separately, and ususuall grepped separately, too.
> =

> Michael, your thoughts?

No strong feelings either way, but I can see some utility to giving it
proximity to the other schema files. Some values in qapi/common.json might
be applicable to the qga schema in the future for instance, so it might be
a good idea to manage them in a central location as opposed to having
qga-schema hanging out by itself, so I'd be okay with the patch as is.

> =

> > =

> >>   qapi-schema.json =3D> qapi/qmp-schema.json     | 34 ++++++++++++++--=
------------
> > =

> > While it was certainly created for QMP, it's now used for non-QMP stuff,
> > too.  Do we mind?
> > =

> =

> Well, patch 3 renames it further; having qapi/qapi-schema.qapi sounds =

> redundant, and the fact that the file DOES drive our QMP decisions (even =

> if it has some other types for internal use only) seems reasonable =

> enough.  If anyone has a better name, I'm all ears.
> =

> >>   tpm.c                                        |  2 +-
> >>   MAINTAINERS                                  |  2 +-
> >>   7 files changed, 33 insertions(+), 31 deletions(-)
> >>   rename qga/qapi-schema.json =3D> qapi/qga-schema.json (100%)
> >>   rename qapi-schema.json =3D> qapi/qmp-schema.json (99%)
> > =

> =

> -- =

> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>=20
