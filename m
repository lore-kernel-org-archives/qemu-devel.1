Received: from eggs.gnu.org ([2001:4830:134:3::10]:55830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <casasfernando@hotmail.com>) id 1gD7NX-0000WA-Fs
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 08:26:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <casasfernando@hotmail.com>) id 1gD7NP-0000Vk-O0
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 08:26:13 -0400
From: =?Windows-1252?Q?Fernando_Casas_Sch=F6ssow?= <casasfernando@hotmail.com>
Date: Thu, 18 Oct 2018 12:25:56 +0000
Message-ID: <AM6PR10MB2247BA55ABF2CC4F38B30339B7F80@AM6PR10MB2247.EURPRD10.PROD.OUTLOOK.COM>
References: <VI1PR10MB0301515CFEEA940842FDF26FB7330@VI1PR10MB0301.EURPRD10.PROD.OUTLOOK.COM>
	<20171211115634.GI13593@stefanha-x1.localdomain>
	<VI1PR10MB030143CAC84D8E8AA783C0B0B7370@VI1PR10MB0301.EURPRD10.PROD.OUTLOOK.COM>
	<20171213112345.GK16782@stefanha-x1.localdomain>
	<VI1PR10MB0301BD1873225A06B658C988B7350@VI1PR10MB0301.EURPRD10.PROD.OUTLOOK.COM>,
	<20180129160104.GN20446@stefanha-x1.localdomain>
In-Reply-To: <20180129160104.GN20446@stefanha-x1.localdomain>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] qemu process crash: Assertion failed:
 QLIST_EMPTY(&bs->tracked_requests)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Jeff Cody <jcody@redhat.com>

Hi Stefan,

I hope this email finds you well and I apologize in advance for resurrectin=
g this thread.
I'm currently running on qemu 2.12.1 and I'm still having this issue every =
few days but now I managed to get a core dump generated (without including =
the guest memory).
Would you take a look at the dump? Please let me know how do you prefer me =
to share it. The file is around 290MB as is but I can try to compress it.

Looking forward your reply.
Thanks
Kind regards,

Fernando
________________________________
From: Stefan Hajnoczi <stefanha@gmail.com>
Sent: Monday, January 29, 2018 5:01 PM
To: Fernando Casas Sch=F6ssow
Cc: qemu-devel; qemu-block@nongnu.org; Jeff Cody
Subject: Re: [Qemu-devel] qemu process crash: Assertion failed: QLIST_EMPTY=
(&bs->tracked_requests)

On Wed, Dec 13, 2017 at 03:33:01PM +0000, Fernando Casas Sch=F6ssow wrote:
> Maybe I=92m missing something here but, if I recall correctly, the qemu p=
rocess for the guest is terminated when this problem happens. So how a debu=
gger will be attached to a process that is gone?

Sorry, this got lost in my inbox.

assert(false) sends SIGABRT to the process.  The default behavior is to
dump a core file that can be analyzed later with GDB.

Your system must have core dumps enabled (i.e. ulimit -c unlimited).
Also, various pieces of software like systemd's coredumpctl can
influence where and how core dumps are stored.

But in short, an assertion failure produces a core dump.

Stefan
