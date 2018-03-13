Received: from eggs.gnu.org ([2001:4830:134:3::10]:46832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1evZKg-0001UX-5l
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 22:06:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1evZKd-0007CQ-0Y
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 22:06:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42896 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1evZKc-0007C3-Sg
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 22:06:26 -0400
Date: Tue, 13 Mar 2018 10:06:03 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180313020603.GE11787@xz-mi>
References: <20180309090006.10018-1-peterx@redhat.com>
	<f5782600-6a2f-0548-2d33-a1d70283403a@redhat.com>
	<20180312125528.GQ3493@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180312125528.GQ3493@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 00/23] QMP: out-of-band (OOB) execution
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Mon, Mar 12, 2018 at 12:55:28PM +0000, Daniel P. Berrang=C3=A9 wrote:
> On Mon, Mar 12, 2018 at 07:01:50AM -0500, Eric Blake wrote:
> > On 03/09/2018 02:59 AM, Peter Xu wrote:
> > > Based-on: <20180306053320.15401-1-peterx@redhat.com>
> > >=20
> > > The series is based on the following series:
> > >=20
> > >    [PATCH v2 0/9] chardev: qio related non-default context support
> > >    (actually patch 9 is based on version 2.1, Dan's version)
> >=20
> > I see Dan already submitted a pull request for (some of) your qio wor=
k; see
> > commit 3ef91576.  Are there any more outstanding qio patches that hav=
e to
> > land first?
>=20
> AFAIK, there isn't anymore qio stuff pending merge - just the chardev
> series Paolo has queued.

Yes, there are still chardev patches that used the new QIO code queued
in Paolo's tree.  There can be either 8/9 patches there, dpending on
whether Paolo has queued the 9th patch from Dan.

Thanks,

--=20
Peter Xu
