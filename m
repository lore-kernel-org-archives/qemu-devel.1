Received: from eggs.gnu.org ([2001:4830:134:3::10]:47229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eYyA6-0004UX-2Z
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 12:58:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eYyA1-0007Cm-Nq
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 12:58:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40780)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eYyA1-0007CI-GV
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 12:58:05 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w09Htpij024801
	for <qemu-devel@nongnu.org>; Tue, 9 Jan 2018 12:58:04 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fd0x854f6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 12:58:03 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 9 Jan 2018 10:58:02 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <25942882-8dfd-87f4-7822-3d46ee303370@redhat.com>
References: <20180108055348.20444-1-david@gibson.dropbear.id.au>
	<CAFEAcA_vmTqHdjL6QfKtn-Khg2RHBA7Vs3QxreXwe2J_7mhGAQ@mail.gmail.com>
	<20180109121653.GN2131@umbus.fritz.box>
	<CAFEAcA-Mzyf2S3yW04LNVy7pAZ6gmzXo3aiFdPxrbWAAAX7N0Q@mail.gmail.com>
	<151551377581.2579.2269090053428846143@sif>
	<25942882-8dfd-87f4-7822-3d46ee303370@redhat.com>
Date: Tue, 09 Jan 2018 11:57:44 -0600
Message-Id: <151552066431.27287.14137170642148809559@sif>
Subject: Re: [Qemu-devel] [PULL 00/12] ppc-for-2.12 queue 20180108
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, surajjs@au1.ibm.com

Quoting Paolo Bonzini (2018-01-09 11:34:48)
> On 09/01/2018 17:02, Michael Roth wrote:
> >> so you can see it's already diverged because it prints out
> >> a different value for the name of the pci node and the
> >> SCSI line has 8200000000000000 vs 00000000.
> > FYI I actually see this with a raspberry pi 3 too
> =

> Is this an arm32 or aarch64 install?  From Peter's report, I am tempted
> to blame the ARM backend (I tested 32-bit x86 and it works).  But a bug
> in both 32-bit ARM and aarch64 would be less likely.

In my case it's a 32-bit kernel/userspace:

pi@rpi-office:~/dev/qemu-build $ uname -a
Linux rpi-office 4.4.38-v7+ #938 SMP Thu Dec 15 15:22:21 GMT 2016 armv7l
GNU/Linux
pi@rpi-office:~/dev/qemu-build $ file ppc64-softmmu/qemu-system-ppc64 =

ppc64-softmmu/qemu-system-ppc64: ELF 32-bit LSB executable, ARM, EABI5
version 1 (GNU/Linux), dynamically linked, interpreter
/lib/ld-linux-armhf.so.3, for GNU/Linux 2.6.32,
BuildID[sha1]=3D4e3e0c8ddbab91a672e4c29b5bfcee9d22459cf7, not stripped

> =

> Paolo
> =

> > , with repeating spaces
> > as well. I didn't notice it before since in my case the
> > ufd_version_check() in test-migration.c was failing so the migration te=
sts
> > were reporting success but were actually just getting skipped.
> > =

>=20
