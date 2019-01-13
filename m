Received: from eggs.gnu.org ([209.51.188.92]:44122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gijYR-00007e-MZ
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 12:28:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gijYR-000558-2a
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 12:28:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41078)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gijYQ-00054B-Se
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 12:28:10 -0500
Date: Sun, 13 Jan 2019 22:58:03 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <20190111095654.GH18491@redhat.com>
Message-ID: <nycvar.YSQ.7.76.1901132242500.7480@xnncv>
References: <20190107103426.2669-1-ppandit@redhat.com>
	<nycvar.YSQ.7.76.1901111453590.12783@xnncv>
	<20190111095654.GH18491@redhat.com>
MIME-Version: 1.0
Content-ID: <nycvar.YSQ.7.76.1901132246170.7480@xnncv>
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: quoted-printable
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
To: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, niuguoxiang <niuguoxiang@huawei.com>

+-- On Fri, 11 Jan 2019, Daniel P. Berrang=E9 wrote --+
| qga/commands.c already includes qemu/osdep.h which includs unistd.h.
|
| The build problem patchew reported was from *mingw* builds where
| sysconf does not exist.

I see; Not sure how to fix it. Maybe with conditional declaration?

#ifdef __MINGW[32|64]__
extern long int sysconf (int __name);
#endif

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
