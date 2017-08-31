Received: from eggs.gnu.org ([2001:4830:134:3::10]:43883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dnTuq-0001MT-Ju
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 14:10:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dnTul-0003cg-Bf
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 14:10:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59922
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dnTul-0003cP-6Q
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 14:10:03 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7VI9eoZ028675
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 14:10:02 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cpkxk2yj5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 14:10:02 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 31 Aug 2017 14:10:01 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <CAFEAcA8XQ+=N9k2QNEXHz9dJMwzw5emg1ff0Cijtv9mii74FGQ@mail.gmail.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
	<0413bb07-bd76-20fc-f29c-9b0bd60efd1d@redhat.com>
	<150419776518.14429.1701568791442232463@loki>
	<CAFEAcA8XQ+=N9k2QNEXHz9dJMwzw5emg1ff0Cijtv9mii74FGQ@mail.gmail.com>
Date: Thu, 31 Aug 2017 13:09:52 -0500
Message-Id: <150420299214.14429.1669328876087601158@loki>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>

Quoting Peter Maydell (2017-08-31 12:07:08)
> On 31 August 2017 at 17:42, Michael Roth <mdroth@linux.vnet.ibm.com> wrot=
e:
> > Quoting Thomas Huth (2017-08-28 21:18:20)
> >> Not sure, but maybe the following patch should be included, too, since
> >> there were some bogus files in the old version of the U-Boot sources:
> >>
> >> 73663d71ef2bab201475d58e - PPC: E500: Update u-boot to v2017.07
> >
> > Do you have more background on any issues caused by these bogus files?
> > As it stands I think I would opt not to update unless there are specific
> > user-visible bugs we're trying to address which warrant the risk of any
> > regressions which might get pulled in in the process.
> =

> These are the relevant threads:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.gnu.org_arch=
ive_html_qemu-2Ddiscuss_2017-2D07_msg00005.html&d=3DDwIBaQ&c=3Djf_iaSHvJObT=
bx-siA1ZOg&r=3DsThPI1c0u5x-3sg5Nw8wNqjg_5Z5xLzfPGC18E94zn8&m=3DQzqXTgvEiqKK=
SlIJgVfNCEiYXPQ5oVFxHFdUcgtf_L8&s=3D4BVFXlpHawdLmHljZCHMSNEVaj8JzUuNJw6HgKZ=
zvn0&e=3D =

> and
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.gnu.org_arch=
ive_html_qemu-2Ddevel_2017-2D07_msg02956.html&d=3DDwIBaQ&c=3Djf_iaSHvJObTbx=
-siA1ZOg&r=3DsThPI1c0u5x-3sg5Nw8wNqjg_5Z5xLzfPGC18E94zn8&m=3DQzqXTgvEiqKKSl=
IJgVfNCEiYXPQ5oVFxHFdUcgtf_L8&s=3DiO72EaulRM4jy_9QBnIcqH5K_hIWtAmBOMqy6QORs=
2M&e=3D =

> =

> The summary is
> (1) one of the u-boot source files which is distributed as part
> of the QEMU tarball has a comment which makes it a bit unclear
> whether it's something that's redistributable (the source file
> isn't actually used in the u-boot target we care about)
> (2) the u-boot binary blob we were shipping doesn't correspond
> to the sources we were shipping
> =

> and we fixed those in master by updating the blob and the
> submodule to the most recent u-boot.
> =

> I guess the low-risk fix for the stable branch would be to
> update the u-boot submodule to 79c884d7e4 as suggested in
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.gnu.org_arch=
ive_html_qemu-2Ddevel_2017-2D07_msg03174.html&d=3DDwIBaQ&c=3Djf_iaSHvJObTbx=
-siA1ZOg&r=3DsThPI1c0u5x-3sg5Nw8wNqjg_5Z5xLzfPGC18E94zn8&m=3DQzqXTgvEiqKKSl=
IJgVfNCEiYXPQ5oVFxHFdUcgtf_L8&s=3DWY3VTHQGDP63Rw7hykVtVSbAqb8db-of8rkUG3hrl=
Ug&e=3D =

> which would bring the distributed sources into line with
> the binary blob in stable, so no need to change the
> blob we're distributing. I think it makes sense to do that
> for stable.

Thanks for the background/suggestion, I think I'll take this
approach.

> =

> thanks
> -- PMM
>=20
