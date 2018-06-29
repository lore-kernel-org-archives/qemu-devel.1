Received: from eggs.gnu.org ([2001:4830:134:3::10]:47366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fYxPy-0000Fm-No
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:42:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fYxPw-0008Nj-N1
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:42:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fYxPw-0008LH-GQ
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:42:44 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com
	[10.5.11.27])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9BFF6811A9
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 17:42:43 +0000 (UTC)
Date: Fri, 29 Jun 2018 14:42:39 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180629174239.GQ7451@localhost.localdomain>
References: <20180628154502.GO3513@redhat.com>
	<20180628195227.GH7451@localhost.localdomain>
	<20180629101417.GB27016@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180629101417.GB27016@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] CPU model versioning separate from machine type
 versioning ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com

On Fri, Jun 29, 2018 at 11:14:17AM +0100, Daniel P. Berrang=E9 wrote:
> On Thu, Jun 28, 2018 at 04:52:27PM -0300, Eduardo Habkost wrote:
[...]
> > I'm not sure what would be the best way to encode two types of
> > information, though:
> >=20
> > * Fallback/alternatives info, e.g.: "It makes sense to use
> >   Haswell-{3.0,2.12,2.5,...} if Haswell-3.1 is not runnable and the
> >   user asked for Haswell".
> >=20
> > * Ordering/preference info, e.g.: "Haswell-3.1 is better than
> >   Haswell-3.0, prefer the latter"
>=20
> The version number of course gives an ordering, but we generally
> tell people not to assume version is numeric.  We could report
> an explicit "priority" in some manner against each.

Makes sense.  "priority" could be included on
query-cpu-definitions to help software choose the best
alternative, and "version" could be just an opaque string that
libvirt needs to save after expanding a CPU model.

--=20
Eduardo
