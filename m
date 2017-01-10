Received: from eggs.gnu.org ([2001:4830:134:3::10]:55849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cQzWv-0004Gm-6g
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 11:44:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cQzWq-0000FT-2D
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 11:44:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47004)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cQzWp-0000FO-PH
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 11:44:07 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0AGhRaS145299
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 11:44:06 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27w18npg88-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 11:44:05 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 10 Jan 2017 09:44:04 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <148406606920.24341.4122999103047828613@loki>
References: <1478772703-28185-1-git-send-email-thuth@redhat.com>
	<1478772703-28185-7-git-send-email-thuth@redhat.com>
	<20170110053133-mutt-send-email-mst@kernel.org>
	<362c2ee4-b230-d407-c3eb-af80fbfafa96@redhat.com>
	<148406606920.24341.4122999103047828613@loki>
Date: Tue, 10 Jan 2017 10:43:54 -0600
Message-Id: <148406663440.24341.5338502676612579198@loki>
Subject: Re: [Qemu-devel] [PULL 6/6] MAINTAINERS: Remove obsolete stable
 branches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

Quoting Michael Roth (2017-01-10 10:34:29)
> Quoting Thomas Huth (2017-01-10 01:54:40)
> > On 10.01.2017 04:32, Michael S. Tsirkin wrote:
> > > On Thu, Nov 10, 2016 at 11:11:43AM +0100, Thomas Huth wrote:
> > >> There are only very old and orphaned stable branches listed
> > >> in the MAINTAINERS file - so this section is pretty useless
> > >> nowadays. Let's remove it.
> > >>
> > >> Reviewed-by: John Snow <jsnow@redhat.com>
> > >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > =

> > > =

> > > Could you add some kind of entry for stable though?
> > > Otherwise people won't know which address to CC.
> > =

> > I think that's a question to Michael Roth - whether such an entry should
> > be added and how it should look like.
> =

> Hmm, not sure how to make this very readable. Something like this
> perhaps?
> =

> Stable branches
> ---------------
> Current M.(N-1) Stable Branch (e.g. v2.8 if latest M.N.0 release was v2.9=
.0)

Heh, that's not even correct. Should be something like:

Current M.N Stable Branch (e.g. v2.8 if latest M.N.0 release was v2.8.0)
M: Michael Roth <mdroth@linux.vnet.ibm.com>
L: qemu-stable@nongnu.org
T: git git://git.qemu-project.org/qemu.git stable-M.N
S: Supported

If that seems reasonable I'll send a proper patch.

> M: Michael Roth <mdroth@linux.vnet.ibm.com>
> L: qemu-stable@nongnu.org
> T: git git://git.qemu-project.org/qemu.git stable-M.(N-1)
> S: Supported
> =

> > =

> >  Thomas
> > =

> > =

> > >> ---
> > >>  MAINTAINERS | 22 ----------------------
> > >>  1 file changed, 22 deletions(-)
> > >>
> > >> diff --git a/MAINTAINERS b/MAINTAINERS
> > >> index d8575ab..4a60579 100644
> > >> --- a/MAINTAINERS
> > >> +++ b/MAINTAINERS
> > >> @@ -1574,28 +1574,6 @@ F: tcg/tci/
> > >>  F: tci.c
> > >>  F: disas/tci.c
> > >>  =

> > >> -Stable branches
> > >> ----------------
> > >> -Stable 1.0
> > >> -L: qemu-stable@nongnu.org
> > >> -T: git git://git.qemu-project.org/qemu-stable-1.0.git
> > >> -S: Orphan
> > >> -
> > >> -Stable 0.15
> > >> -L: qemu-stable@nongnu.org
> > >> -T: git git://git.qemu-project.org/qemu-stable-0.15.git
> > >> -S: Orphan
> > >> -
> > >> -Stable 0.14
> > >> -L: qemu-stable@nongnu.org
> > >> -T: git git://git.qemu-project.org/qemu-stable-0.14.git
> > >> -S: Orphan
> > >> -
> > >> -Stable 0.10
> > >> -L: qemu-stable@nongnu.org
> > >> -T: git git://git.qemu-project.org/qemu-stable-0.10.git
> > >> -S: Orphan
> > >> -
> > >>  Block drivers
> > >>  -------------
> > >>  VMDK
> > >> -- =

> > >> 1.8.3.1
> > >>
> >=20
