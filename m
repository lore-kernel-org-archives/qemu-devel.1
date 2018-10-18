Received: from eggs.gnu.org ([2001:4830:134:3::10]:58592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gD7ZZ-0004EO-Gs
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 08:38:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gD7ZY-0001l1-RL
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 08:38:41 -0400
Date: Thu, 18 Oct 2018 14:38:16 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181018123816.GB4946@localhost.localdomain>
References: <VI1PR10MB0301515CFEEA940842FDF26FB7330@VI1PR10MB0301.EURPRD10.PROD.OUTLOOK.COM>
	<20171211115634.GI13593@stefanha-x1.localdomain>
	<VI1PR10MB030143CAC84D8E8AA783C0B0B7370@VI1PR10MB0301.EURPRD10.PROD.OUTLOOK.COM>
	<20171213112345.GK16782@stefanha-x1.localdomain>
	<VI1PR10MB0301BD1873225A06B658C988B7350@VI1PR10MB0301.EURPRD10.PROD.OUTLOOK.COM>
	<20180129160104.GN20446@stefanha-x1.localdomain>
	<AM6PR10MB2247BA55ABF2CC4F38B30339B7F80@AM6PR10MB2247.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <AM6PR10MB2247BA55ABF2CC4F38B30339B7F80@AM6PR10MB2247.EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] qemu process crash: Assertion failed:
 QLIST_EMPTY(&bs->tracked_requests)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fernando Casas =?iso-8859-1?Q?Sch=F6ssow?= <casasfernando@hotmail.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Jeff Cody <jcody@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

Hi Fernando,

Am 18.10.2018 um 14:25 hat Fernando Casas Sch=F6ssow geschrieben:
> I hope this email finds you well and I apologize in advance for resurre=
cting this thread.
> I'm currently running on qemu 2.12.1 and I'm still having this issue ev=
ery few days but now I managed to get a core dump generated (without incl=
uding the guest memory).
> Would you take a look at the dump? Please let me know how do you prefer=
 me to share it. The file is around 290MB as is but I can try to compress=
 it.

would it be possible for you to test whether the bug still exists in
QEMU 3.0? There were a few fixes related to request draining in that
release, so maybe it's already solved now.

Kevin
