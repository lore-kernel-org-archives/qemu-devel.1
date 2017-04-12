Received: from eggs.gnu.org ([2001:4830:134:3::10]:37382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cyE1a-0003mx-Jo
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 04:53:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cyE1X-0008Nl-CV
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 04:53:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38521)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1cyE1X-0008Mv-3a
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 04:53:11 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3C8n4Gl091703
	for <qemu-devel@nongnu.org>; Wed, 12 Apr 2017 04:53:10 -0400
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29s91jhhcp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 12 Apr 2017 04:53:09 -0400
Received: from localhost
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Wed, 12 Apr 2017 14:23:06 +0530
Date: Wed, 12 Apr 2017 14:23:00 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reply-To: bharata@linux.vnet.ibm.com
References: <1491984907-9894-1-git-send-email-bharata@linux.vnet.ibm.com>
	<9e992fd5-8f42-5ec6-2a77-f6d9ce088226@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <9e992fd5-8f42-5ec6-2a77-f6d9ce088226@kaod.org>
Message-Id: <20170412085300.GB1429@in.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] spapr-cpu-core: Release ICPState object
 during CPU unrealization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On Wed, Apr 12, 2017 at 10:47:39AM +0200, C=E9dric Le Goater wrote:
> On 04/12/2017 10:15 AM, Bharata B Rao wrote:
> > Recent commits that re-organized ICPState object missed to destroy
> > the object when CPU is unrealized. Fix this so that CPU unplug
> > doesn't abort QEMU.
>=20
> Indeed.
>=20
> > Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
>=20
> I am wondering if we should not be doing the unparent under=20
> spapr_cpu_destroy() or even xics_cpu_destroy(). Apart from
> that,=20

Thought so, but since object is created in realize routinte itself
(and not in any of its callers), did the object destruction in
unrealize to be symmetrical :)

Regards,
Bharata.
