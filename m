Received: from eggs.gnu.org ([2001:4830:134:3::10]:53994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dnSYX-0005xr-NG
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 12:43:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dnSYT-0000WY-M5
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 12:43:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46946
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dnSYT-0000WD-GB
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 12:42:57 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7VGel7m117035
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 12:42:56 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cpn9b2x8b-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 12:42:56 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 31 Aug 2017 10:42:55 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <0413bb07-bd76-20fc-f29c-9b0bd60efd1d@redhat.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
	<0413bb07-bd76-20fc-f29c-9b0bd60efd1d@redhat.com>
Date: Thu, 31 Aug 2017 11:42:45 -0500
Message-Id: <150419776518.14429.1701568791442232463@loki>
Subject: Re: [Qemu-devel] [PATCH 00/79] Patch Round-up for stable 2.9.1,
 freeze on 2017-09-04
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org

Quoting Thomas Huth (2017-08-28 21:18:20)
> On 29.08.2017 02:13, Michael Roth wrote:
> > Hi everyone,
> > =

> > The following new patches are queued for QEMU stable v2.9.1:
> > =

> >   https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com_mdr=
oth_qemu_commits_stable-2D2.9-2Dstaging&d=3DDwIDaQ&c=3Djf_iaSHvJObTbx-siA1Z=
Og&r=3DsThPI1c0u5x-3sg5Nw8wNqjg_5Z5xLzfPGC18E94zn8&m=3DId5ItcTzhCqn35tC8Jyn=
LtLuRcfupmsTlJGwTYEDdIg&s=3DfqHIfooeKQPNEWX7AqyC93OMzAs-U-UwZ6Yu0trfn0Y&e=
=3D =

> > =

> > The release is planned for 2017-09-07:
> > =

> >   https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__wiki.qemu.org_P=
lanning_2.9&d=3DDwIDaQ&c=3Djf_iaSHvJObTbx-siA1ZOg&r=3DsThPI1c0u5x-3sg5Nw8wN=
qjg_5Z5xLzfPGC18E94zn8&m=3DId5ItcTzhCqn35tC8JynLtLuRcfupmsTlJGwTYEDdIg&s=3D=
RVxHUyHJDN1hk2AsMfiZmguXpEhz0pFHGijG75NIReY&e=3D =

> > =

> > Please respond here or CC qemu-stable@nongnu.org on any patches you
> > think should be included in the release.
> =

> I'd like to suggest the following patches:
> =

> 601b9a9008c5a612d76073bb - target-s390x: Mask the SIGP order_code ...
> b7da97eef74bf834be244de0 - monitor: Check whether TCG is enabled ...
> 17eb587aeb492fe68f8130b0 - slirp: tftp, copy sockaddr_size
> 99efaa2696caaf6182958e27 - hw/s390x/ipl: Fix crash with ...
> 36bed541ca886da735bef1e8 - fix qemu-system-unicore32 crashing ...
> b190f477e29c7cd03a8fee49 - qemu-system-tricore: segfault when ...
> 8ccccff9dd7ba24c7a788611 - hw/ppc/spapr_rtc: Mark the RTC device ...
> 1f98e55385d11da1dc0de644 - hw/ppc/spapr_iommu: Fix crash when ...
> =

> Not sure, but maybe the following patch should be included, too, since
> there were some bogus files in the old version of the U-Boot sources:
> =

> 73663d71ef2bab201475d58e - PPC: E500: Update u-boot to v2017.07

Do you have more background on any issues caused by these bogus files?
As it stands I think I would opt not to update unless there are specific
user-visible bugs we're trying to address which warrant the risk of any
regressions which might get pulled in in the process.

> =

>  Thomas
>=20
