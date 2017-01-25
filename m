Received: from eggs.gnu.org ([2001:4830:134:3::10]:35494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1cWBQR-0004mV-9b
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 19:27:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1cWBQO-0001yC-58
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 19:26:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sam.bobroff@au1.ibm.com>)
	id 1cWBQN-0001y4-RS
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 19:26:56 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0P0PTMj117292
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 19:26:53 -0500
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	by mx0a-001b2d01.pphosted.com with ESMTP id 286ahtyn4y-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 19:26:53 -0500
Received: from localhost
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sam.bobroff@au1.ibm.com>;
	Wed, 25 Jan 2017 10:26:50 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id DCBFE2BB0045
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 11:26:48 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v0P0Qe1h16318614
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 11:26:48 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v0P0QG10004243
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 11:26:16 +1100
Date: Wed, 25 Jan 2017 11:25:51 +1100
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
References: <20170124043941.GA12671@tungsten.ozlabs.ibm.com>
	<CAJ+F1C+fnnFtmjhf6eSS3aO+_fQmi-yETj0V7DmLb2Gb9Mi_WA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1C+fnnFtmjhf6eSS3aO+_fQmi-yETj0V7DmLb2Gb9Mi_WA@mail.gmail.com>
Message-Id: <20170125002551.GA2895@tungsten.ozlabs.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] update-linux-headers.sh fails on clean kernel dir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org

On Tue, Jan 24, 2017 at 10:32:36AM +0000, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> On Tue, Jan 24, 2017 at 8:41 AM Sam Bobroff <sam.bobroff@au1.ibm.com> w=
rote:
>=20
> > Hi QEMU developers,
> >
> > If I run scripts/update-linux-headers.sh from a clean checkout of QEM=
U
> > and point it at a clean checkout of a recent linux kernel (4.10-rc1 o=
r
> > later), it fails:
> >
> > $ scripts/update-linux-headers.sh ~/tmp/linux/
> >
> > ...
> >
> > scripts/Makefile.headersinst:62: *** Missing generated UAPI file
> > ./arch/arm/include/generated/uapi/asm/unistd-common.h.  Stop.
> >
> > This seems to be because the script passes the arch to the kernel
> > makefile using "SRCARCH" rather than "ARCH".
> >
> > (SRCARCH seems to be intended as an internal value, and setting it do=
es
> > not propagate the setting to ARCH. Because ARCH is left empty, the
> > prerequisites that should generate unistd-common.h fail. If ARCH is s=
et,
> > SRCARCH is set automatically and everything works.)
> >
> > Changing the script to use "ARCH" seems to fixe the problem.
> >
>=20
> That's also what Documentation/kbuild/headers_install.txt documents.
>=20
>=20
> > (Note: when testing this be careful: unistd-common.h is not removed b=
y
> > "make clean" in the kernel directory.)
> >
> > Does this seem correct?
> >
> > Should I send a patch even though it's a very small change?
> >
> >
> I think so, thanks

Thanks for the quick answer, I'll post a patch ASAP.

Perhaps you wouldn't mind commenting on this followup issue, since that
fix isn't enough to get the script working nicely...

With that fixed, update-linux-headers.sh still doesn't work as I would
expect. It seems that since commit
7e71da7f124fc47a2f2bc1fbfb32f0e8ee3e7d44
QEMU makes use of virtio_mmio.h but that file isn't installed by the
kernel's "install_headers" target so running update-linux-headers.sh
causes virtio_mmio.h to be deleted from the QEMU source rather than
updated.

(It looks like virtio_mmio.h was manually added by commit
5878b13642ddf8da44186ef93ac91319ff53668b )

It looks like the reason virtio_mmio.h isn't installed is that it's not
a uapi header and the reason this causes the deletion is that the file
has been placed in include/standard-headers/...

So, it seems there are several possible approaches:
(1) Move QEMU's copy of the file out of standard-headers.
(2) Ask the kernel to make virtio_mmio.h a uapi header.
(3) Change update-linux-headers.sh to manually copy that file.
(4) Manually copy that file in after running the script.

(1) seems to be the easiest to me, and (2) possibly the cleanest, but
what would you recommend? Should I try posting a patch for this too?

Thanks,
Sam.
