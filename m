Received: from eggs.gnu.org ([209.51.188.92]:46445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gmjBk-0001y2-D9
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:53:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gmjBh-0007P4-BC
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:53:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gmjBh-0007Nv-2p
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:53:13 -0500
Date: Thu, 24 Jan 2019 23:23:06 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <154835151690.21382.18106555175919155339@sif>
Message-ID: <nycvar.YSQ.7.76.1901242322020.6343@xnncv>
References: <20190107103426.2669-1-ppandit@redhat.com>
	<nycvar.YSQ.7.76.1901111453590.12783@xnncv>
	<20190111095654.GH18491@redhat.com>
	<nycvar.YSQ.7.76.1901132242500.7480@xnncv>
	<154835151690.21382.18106555175919155339@sif>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, niuguoxiang <niuguoxiang@huawei.com>

+-- On Thu, 24 Jan 2019, Michael Roth wrote --+
| I would call a helper function like get_args_max() or whatever and have
| the posix implementation in qga/commands-posix.c and a stub'd version
| in qga/commands-win32.c. There's an article here that might be useful
| for figuring out how we would implement get_args_max() it for win32:
| 
|   https://blogs.msdn.microsoft.com/oldnewthing/20031210-00/?p=41553

Interesting, I'll follow-up on it.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
