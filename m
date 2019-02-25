Received: from eggs.gnu.org ([209.51.188.92]:60222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1gyNFP-00075B-3I
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 15:53:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1gyNFO-0004kb-AA
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 15:53:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33202)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <muriloo@linux.ibm.com>)
	id 1gyNFN-0004iT-VB
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 15:53:10 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1PKiCWq131844
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 15:53:06 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qvn8cr00g-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 15:53:05 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <muriloo@linux.ibm.com>;
	Mon, 25 Feb 2019 20:53:05 -0000
Date: Mon, 25 Feb 2019 17:52:57 -0300
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
References: <20190225170155.1972-1-muriloo@linux.ibm.com>
	<5b70e0f2-0464-cda6-9f3f-3add525fa6bc@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <5b70e0f2-0464-cda6-9f3f-3add525fa6bc@kaod.org>
Message-Id: <20190225205257.GA30778@kermit.br.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 0/3] ppc/pnv: increase kernel
 size limit to 256MiB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Murilo Opsfelder Araujo <mopsfelder@gmail.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>

On Mon, Feb 25, 2019 at 07:58:06PM +0100, C=E9dric Le Goater wrote:
> On 2/25/19 6:01 PM, Murilo Opsfelder Araujo wrote:
> > First patch increases kernel size limit to 256MiB to fit images gener=
ated with
> > CONFIG_DEBUG_INFO.
> >
> > Second patch just fixes a misleading comment regarding initrd size li=
mit.
> >
> > Third patch uses IEC prefixes to represent size constants.
>
> They look fine.
>
> Have you tried these patches on a P9 machine ? You will need to use
> the powernv-4.0 branch on my github for that.

I had actually smoke-tested it on my laptop:

[    0.000000] Linux version 5.0.0-rc8-panda (muriloo@localhost) (gcc ver=
sion 6.4.0 (Buildroot 2018.02-rc2-00006-g39101b7)) #1 SMP Mon Feb 25 11:0=
0:15 -03 2019
[    0.000000] Found initrd at 0xc000000060000000:0xc0000000601e6cfc
[    0.000000] OPAL: Found non-mapped LPC bus on chip 0
[    0.000000] Using PowerNV machine description
[    0.000000] printk: bootconsole [udbg0] enabled
[    0.000000] CPU maps initialized for 1 thread per core
[    0.000000]  (thread shift is 0)
[    0.000000] Allocated 3336 bytes for 1 pacas

My patches apply smoothly on top of your powernv-4.0 branch, in case you'=
re
willing to give it a try.

Let's chat offline to get it tested on a p9 machine.

Thanks for the review!

--
Murilo
