Received: from eggs.gnu.org ([209.51.188.92]:40096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1gmixm-0003na-Rp
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:38:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1gmixl-0002iC-WF
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:38:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56768
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1gmixl-0002hP-Nf
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:38:49 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0OHYwxe051543
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 12:38:48 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2q7hr3gpqs-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 12:38:48 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 24 Jan 2019 17:38:47 -0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <nycvar.YSQ.7.76.1901132242500.7480@xnncv>
References: <20190107103426.2669-1-ppandit@redhat.com>
	<nycvar.YSQ.7.76.1901111453590.12783@xnncv>
	<20190111095654.GH18491@redhat.com>
	<nycvar.YSQ.7.76.1901132242500.7480@xnncv>
Date: Thu, 24 Jan 2019 11:38:36 -0600
Message-Id: <154835151690.21382.18106555175919155339@sif>
Subject: Re: [Qemu-devel] [PATCH] qga: check length of command-line &
 environment variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, P J P <ppandit@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, niuguoxiang <niuguoxiang@huawei.com>

Quoting P J P (2019-01-13 11:28:03)
> +-- On Fri, 11 Jan 2019, Daniel P. Berrang=C3=A9 wrote --+
> | qga/commands.c already includes qemu/osdep.h which includs unistd.h.
> |
> | The build problem patchew reported was from *mingw* builds where
> | sysconf does not exist.
> =

> I see; Not sure how to fix it. Maybe with conditional declaration?
> =

> #ifdef __MINGW[32|64]__
> extern long int sysconf (int __name);
> #endif

I would call a helper function like get_args_max() or whatever and have
the posix implementation in qga/commands-posix.c and a stub'd version
in qga/commands-win32.c. There's an article here that might be useful
for figuring out how we would implement get_args_max() it for win32:

  https://blogs.msdn.microsoft.com/oldnewthing/20031210-00/?p=3D41553

> =

> Thank you.
> --
> Prasad J Pandit / Red Hat Product Security Team
> 47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
