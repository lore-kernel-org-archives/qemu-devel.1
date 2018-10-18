Received: from eggs.gnu.org ([2001:4830:134:3::10]:49717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <casasfernando@hotmail.com>) id 1gD8Xa-0005C5-61
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 09:40:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <casasfernando@hotmail.com>) id 1gD8XX-0007sN-0W
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 09:40:42 -0400
From: =?iso-8859-1?Q?Fernando_Casas_Sch=F6ssow?= <casasfernando@hotmail.com>
Date: Thu, 18 Oct 2018 13:40:36 +0000
Message-ID: <AM6PR10MB2247D63F532AE33155BA57EFB7F80@AM6PR10MB2247.EURPRD10.PROD.OUTLOOK.COM>
References: <VI1PR10MB0301515CFEEA940842FDF26FB7330@VI1PR10MB0301.EURPRD10.PROD.OUTLOOK.COM>
	<20171211115634.GI13593@stefanha-x1.localdomain>
	<VI1PR10MB030143CAC84D8E8AA783C0B0B7370@VI1PR10MB0301.EURPRD10.PROD.OUTLOOK.COM>
	<20171213112345.GK16782@stefanha-x1.localdomain>
	<VI1PR10MB0301BD1873225A06B658C988B7350@VI1PR10MB0301.EURPRD10.PROD.OUTLOOK.COM>
	<20180129160104.GN20446@stefanha-x1.localdomain>
	<AM6PR10MB2247BA55ABF2CC4F38B30339B7F80@AM6PR10MB2247.EURPRD10.PROD.OUTLOOK.COM>
	<20181018123816.GB4946@localhost.localdomain>
In-Reply-To: <20181018123816.GB4946@localhost.localdomain>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Jeff Cody <jcody@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

Hi Kevin,

Not at the moment. This is a production system and pretty much up to date b=
ut can't upgrade to 3.0 yet.
If the dump can be of any use, I can upload it somewhere for analysis.

BR,

Fernando

On jue, oct 18, 2018 at 2:38 PM, Kevin Wolf <kwolf@redhat.com> wrote:
Hi Fernando, Am 18.10.2018 um 14:25 hat Fernando Casas Sch=F6ssow geschrieb=
en:
I hope this email finds you well and I apologize in advance for resurrectin=
g this thread. I'm currently running on qemu 2.12.1 and I'm still having th=
is issue every few days but now I managed to get a core dump generated (wit=
hout including the guest memory). Would you take a look at the dump? Please=
 let me know how do you prefer me to share it. The file is around 290MB as =
is but I can try to compress it.
would it be possible for you to test whether the bug still exists in QEMU 3=
.0? There were a few fixes related to request draining in that release, so =
maybe it's already solved now. Kevin
