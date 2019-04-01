Received: from eggs.gnu.org ([209.51.188.92]:39333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB6Lo-0003f9-6Z
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 19:28:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB6Lm-0001ug-5Z
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 19:28:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39348
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB6Lj-0001oY-IX
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 19:28:20 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31NNbFS131996
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 19:28:13 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rkskgygxn-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 19:28:13 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 2 Apr 2019 00:28:12 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <CAMo8BfLMM7RSXMcvA-jPJFUzt23fCGU-q=3fXZBv_=S_6UszSQ@mail.gmail.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
	<20190401210011.16009-60-mdroth@linux.vnet.ibm.com>
	<CAMo8BfLMM7RSXMcvA-jPJFUzt23fCGU-q=3fXZBv_=S_6UszSQ@mail.gmail.com>
Date: Mon, 01 Apr 2019 18:28:03 -0500
Message-Id: <155416128371.3333.10200489776884563434@sif>
Subject: Re: [Qemu-devel] [PATCH 59/97] target/xtensa: drop num_[core_]regs
 from dc232b/dc233c configs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>

Quoting Max Filippov (2019-04-01 16:19:59)
> Hi Michael,
> =

> On Mon, Apr 1, 2019 at 2:04 PM Michael Roth <mdroth@linux.vnet.ibm.com> w=
rote:
> > From: Max Filippov <jcmvbkbc@gmail.com>
> >
> > Now that xtensa_count_regs does the right thing, remove manual
> > initialization of these fields from the affected configurations and let
> > xtensa_finalize_config initialize them. Add XTREG_END to terminate
> > register lists.
> >
> > Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> > (cherry picked from commit 7da9111e77b9cdb3a927dcd47642b7ffff9de636)
> > Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> =

> I'm curious why this change was picked for stable, it wasn't marked for i=
t.
> I'm pretty sure it's not going to work without the corresponding change
> in the xtensa_count_regs, which is pretty big.

Looks like an earlier patch was tagged for stable:

  https://patchwork.kernel.org/patch/10666423/

Since patches are often referred to qemu-stable via actual email Cc: and
often don't get tagged in the commit I don't rely too much on the
"Cc: qemu-stable@nongnu.org" tags in the commit messages currently.

I should probably take note next time a tag is explicitly removed from the
final commit though, but the safest way to avoid this if a patch ends up
getting Cc'd to qemu-stable at some point is to reply to the patch on why
it should be kept out, since I'll usually see those.

I'll make sure to back the patch out, thanks for checking!

> =

> -- =

> Thanks.
> -- Max
>=20
