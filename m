Received: from eggs.gnu.org ([209.51.188.92]:48973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hCA80-0001Z8-Dc
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 17:42:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hC9uj-0002PZ-FR
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 17:28:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39942)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hC9uj-0002E7-3o
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 17:28:49 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x34LJckX044340
	for <qemu-devel@nongnu.org>; Thu, 4 Apr 2019 17:28:45 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rnqmknp2p-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 04 Apr 2019 17:28:45 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 4 Apr 2019 22:28:44 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <4d41daa4-743e-400b-d350-e89ca93b6c58@redhat.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
	<4d41daa4-743e-400b-d350-e89ca93b6c58@redhat.com>
Date: Thu, 04 Apr 2019 16:28:35 -0500
Message-Id: <155441331505.11138.13889935196434404712@sif>
Subject: Re: [Qemu-devel] [Qemu-stable] [PATCH 00/97] Patch Round-up for
 stable 3.0.1, freeze on 2019-04-08
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cole Robinson <crobinso@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org

Quoting Cole Robinson (2019-04-02 11:22:59)
> On 4/1/19 4:58 PM, Michael Roth wrote:
> > Hi everyone,                                                           =
                                   =

> > =

> > The following new patches are queued for QEMU stable v3.0.1:
> > =

> >   https://github.com/mdroth/qemu/commits/stable-3.0-staging
> > =

> > The release is planned for 2019-04-11:
> > =

> >   https://wiki.qemu.org/Planning/3.0
> > =

> > Please respond here or CC qemu-stable@nongnu.org on any patches you
> > think should be included in the release.
> > =

> > Note that this update falls outside the normal stable release support
> > window (~1 development cycle), but is being release now since it was
> > delayed from its intended release date.
> > =

> > Thanks!
> > =

> =

> Here's some extra patches we are carrying in Fedora 29
> =

> https://bugzilla.redhat.com/show_bug.cgi?id=3DCVE-2018-15746
> 6f2231e9b0 seccomp: use SIGSYS signal instead of killing the thread
> bda08a5764 seccomp: prefer SCMP_ACT_KILL_PROCESS if available
> d0699bd37c configure: require libseccomp 2.2.0
> 70dfabeaa7 seccomp: set the seccomp filter to all threads
> =

> https://bugzilla.redhat.com/show_bug.cgi?id=3DCVE-2018-18849
> e58ccf0396 lsi53c895a: check message length value is valid
> =

> https://bugzilla.redhat.com/show_bug.cgi?id=3DCVE-2019-6778
> a907458ad8 slirp: check data length while emulating ident function
> =

> https://bugzilla.redhat.com/show_bug.cgi?id=3DCVE-2018-18954
> d07945e78e ppc/pnv: check size before data buffer access
> =

> https://bugzilla.redhat.com/show_bug.cgi?id=3DCVE-2018-19364
> 5b76ef50f6 9p: write lock path in v9fs_co_open2()
> 5b3c77aa58 9p: take write lock on fid path updates (CVE-2018-19364)

Thank you for the suggestions so far. I've applied these patches and
backed out:

  target/xtensa: drop num_[core_]regs from dc232b/dc233c configs

Changes have been pushed to staging tree:

  https://github.com/mdroth/qemu/commits/stable-3.0-staging

> =

> Thanks,
> Cole
>=20
