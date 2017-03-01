Received: from eggs.gnu.org ([2001:4830:134:3::10]:44971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@us.ibm.com>) id 1cj4Gm-0006zA-DN
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 08:26:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@us.ibm.com>) id 1cj4Gi-0003YZ-DH
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 08:26:16 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34713
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@us.ibm.com>) id 1cj4Gi-0003Wr-5x
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 08:26:12 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v21DPT6O004181
	for <qemu-devel@nongnu.org>; Wed, 1 Mar 2017 08:26:01 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28wxrahmgt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 08:26:00 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@us.ibm.com>;
	Wed, 1 Mar 2017 06:25:53 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
	(b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
	by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 4C69819D803F
	for <qemu-devel@nongnu.org>; Wed,  1 Mar 2017 06:25:02 -0700 (MST)
Received: from b03ledav006.gho.boulder.ibm.com
	(b03ledav006.gho.boulder.ibm.com [9.17.130.237])
	by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id v21DPpVx10224120
	for <qemu-devel@nongnu.org>; Wed, 1 Mar 2017 06:25:51 -0700
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 10317C6047
	for <qemu-devel@nongnu.org>; Wed,  1 Mar 2017 06:25:51 -0700 (MST)
Received: from d50lp03.ny.us.ibm.com (unknown [146.89.104.211])
	by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS id BF146C603E
	for <qemu-devel@nongnu.org>; Wed,  1 Mar 2017 06:25:50 -0700 (MST)
Received: from localhost
	by d50lp03.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@us.ibm.com>;
	Wed, 1 Mar 2017 08:25:50 -0500
Received: from localhost
	by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
	for <qemu-devel@nongnu.org> from <stefanb@us.ibm.com>;
	Wed, 1 Mar 2017 13:25:46 -0000
In-Reply-To: <20170301125414.GD10160@redhat.com>
From: "Stefan Berger" <stefanb@us.ibm.com>
Date: Wed, 1 Mar 2017 08:25:43 -0500
References: <20160120162220.GH13215@redhat.com> <20160121113632.GC2446@work-vm>
	<57FA3A002D66E049AA7792D931B894C7060F5494@MOKSCY3MSGUSRGB.ITServices.sbc.com>
	<945CA011AD5F084CBEA3E851C0AB28894B8C3A14@SHSMSX101.ccr.corp.intel.com>
	<575E92DB.3080904@linux.vnet.ibm.com> <20160615193019.GB7300@work-vm>
	<5761C092.5070702@linux.vnet.ibm.com> <20160616080520.GA2249@work-vm>
	<20160616082517.GC11426@redhat.com>
	<5075d390-a1d1-b707-6b57-deb0154c2e37@linux.vnet.ibm.com>
	<20170301125414.GD10160@redhat.com>
MIME-Version: 1.0
Message-Id: <OF00CA88E0.A7212243-ON002580D6.00498E3C-852580D6.0049CA7A@notes.na.collabserv.com>
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 1/4] Provide support for the CUSE TPM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: "SERBAN, CRISTINA" <cs1731@att.com>, "SHIH, CHING C" <cs1815@att.com>, "Dr.
	David Alan Gilbert" <dgilbert@redhat.com>, "hagen.lauer@huawei.com" <hagen.lauer@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Xu, Quan" <quan.xu@intel.com>, "silviu.vlasceanu@gmail.com" <silviu.vlasceanu@gmail.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>

"Daniel P. Berrange" <berrange@redhat.com> wrote on 03/01/2017 07:54:14=20
AM:

> From: "Daniel P. Berrange" <berrange@redhat.com>
> To: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Berger/
> Watson/IBM@IBMUS, "mst@redhat.com" <mst@redhat.com>, "qemu-
> devel@nongnu.org" <qemu-devel@nongnu.org>, "SERBAN, CRISTINA"=20
> <cs1731@att.com>, "Xu, Quan" <quan.xu@intel.com>,=20
> "silviu.vlasceanu@gmail.com" <silviu.vlasceanu@gmail.com>,=20
> "hagen.lauer@huawei.com" <hagen.lauer@huawei.com>, "SHIH, CHING C"=20
> <cs1815@att.com>
> Date: 03/01/2017 08:03 AM
> Subject: Re: [Qemu-devel] [PATCH v5 1/4] Provide support for the CUSE=20
TPM
>=20
> On Wed, Mar 01, 2017 at 07:25:28AM -0500, Stefan Berger wrote:
> > On 06/16/2016 04:25 AM, Daniel P. Berrange wrote:
> > > On Thu, Jun 16, 2016 at 09:05:20AM +0100, Dr. David Alan Gilbert=20
wrote:
> > > > * Stefan Berger (stefanb@linux.vnet.ibm.com) wrote:
> > > > > On 06/15/2016 03:30 PM, Dr. David Alan Gilbert wrote:
> > > > <snip>
> > > >=20
> > > > > > So what was the multi-instance vTPM proxy driver patch set=20
about?
> > > > > That's for containers.
> > > > Why have the two mechanisms? Can you explain how the=20
multi-instance
> > > > proxy works; my brief reading when I saw your patch series seemed
> > > > to suggest it could be used instead of CUSE for the non-container=20
case.
> > > One of the key things that was/is not appealing about this CUSE=20
approach
> > > is that it basically invents a new ioctl() mechanism for talking to
> > > a TPM chardev. With in-kernel vTPM support, QEMU probably doesn't=20
need
> > > to have any changes at all - its existing driver for talking to TPM
> >=20
> > We still need the control channel with the vTPM to reset it upon VM=20
reset,
> > for getting and setting the state of the vTPM upon=20
snapshot/suspend/resume,
> > changing locality, etc.
>=20
> You ultimately need the same mechanisms if using in-kernel vTPM with
> containers as containers can support snapshot/suspend/resume/etc too.

The vTPM running on the backend side of the vTPM proxy driver is=20
essentially the same as the CUSE TPM used for QEMU. I has the same control =

channel through sockets. So on that level we would have support for the=20
operations but not integrated with anything that would support container=20
migration.

   Stefan


>=20
> Regards,
> Daniel
> --=20
> |: http://berrange.com      -o-   =20
http://www.flickr.com/photos/dberrange/ :|
> |: http://libvirt.org              -o-            =20
http://virt-manager.org :|
> |: http://entangle-photo.org       -o-   =20
http://search.cpan.org/~danberr/ :|
>=20
