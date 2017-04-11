Received: from eggs.gnu.org ([2001:4830:134:3::10]:56681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cxzmh-0000DV-G5
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 13:40:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cxzmc-0003rW-Dr
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 13:40:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32966
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cxzmc-0003r9-7v
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 13:40:50 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3BHcrZN023514
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 13:40:49 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29rj2w6qv0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 13:40:48 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 11 Apr 2017 13:40:48 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <c2e13b99-77e3-b889-1edd-b52053e270ba@redhat.com>
References: <20170411125205.23121-1-sameeh@daynix.com>
	<c2e13b99-77e3-b889-1edd-b52053e270ba@redhat.com>
Date: Tue, 11 Apr 2017 12:40:40 -0500
Message-Id: <149193244047.15312.8438512061271732679@loki>
Subject: Re: [Qemu-devel] [PATCH for-2.9?] qga-win: Enable 'can-offline'
 field in 'guest-get-vcpus' reply
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Sameeh Jubran <sameeh@daynix.com>, qemu-devel@nongnu.org
Cc: Yan Vugenfirer <yan@daynix.com>, qemu-stable@nongnu.org

Quoting Eric Blake (2017-04-11 08:25:06)
> On 04/11/2017 07:52 AM, Sameeh Jubran wrote:
> > The QGA schema states:
> > =

> > @can-offline: Whether offlining the VCPU is possible. This member
> >                is always filled in by the guest agent when the structure
> >                is returned, and always ignored on input (hence it can be
> >                omitted then).
> > =

> > Currently 'can-offline' is missing entirely from the reply. This causes
> > errors in libvirt which is expecting the reply to be compliant with the
> > schema docs.
> > =

> > BZ#1438735: https://bugzilla.redhat.com/show_bug.cgi?id=3D1438735
> > =

> > Signed-off-by: Sameeh Jubran <sameeh@daynix.com>
> > ---
> >  qga/commands-win32.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> Appropriate as a bug fix in 2.9 if there is still time for the
> maintainer to submit a pull request, although we are late enough that if
> it slips into 2.10 it is not a big deal.
> =

> Reviewed-by: Eric Blake <eblake@redhat.com>

Yah, agreed, the final planned RC looks to have been tagged already though
so I think it'll have to wait for 2.10/2.9.1. Thanks for the heads up.

Cc: qemu-stable@nongnu.org

> =

> -- =

> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>=20
