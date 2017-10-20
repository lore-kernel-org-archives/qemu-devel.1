Received: from eggs.gnu.org ([2001:4830:134:3::10]:58671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nutarojj@ornl.gov>) id 1e5Yot-0004M7-PR
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 11:02:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nutarojj@ornl.gov>) id 1e5Yon-0006GV-W3
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 11:02:43 -0400
Received: from mta01.ornl.gov ([128.219.177.137]:25888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nutarojj@ornl.gov>) id 1e5Yon-0006Fo-NG
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 11:02:37 -0400
From: "Nutaro, James J." <nutarojj@ornl.gov>
Date: Fri, 20 Oct 2017 15:02:16 +0000
Message-ID: <545610a4882f4c5494b30b7eab66b984@EXCHCS32.ornl.gov>
References: <CADHp1NwU=HowMfgBGtcwnY25v_fL6qZ2gd469a2oZY+QQi2uFw@mail.gmail.com>
	<20171019205409.GA4170@flamenco>
In-Reply-To: <20171019205409.GA4170@flamenco>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] Running Qemu in discrete time/step by step
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "'Emilio G. Cota'" <cota@braap.org>, Matt <mattator@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Hajime Tazaki <tazaki@wide.ad.jp>

Thanks for taking a look at the patch. The most recent version of the patch=
 will also work with KVM if you need to speed things up. You can find it he=
re:

https://patchwork.kernel.org/patch/9960369/

Somehow I messed up that post and it shows V8 when it should be V9.

You can get the simulator that it works with at=20

https://sourceforge.net/projects/adevs/

If nothing else, this simulator would give you a blue print for integration=
 with another tool.

Jim

-----Original Message-----
From: Emilio G. Cota [mailto:cota@braap.org]=20
Sent: Thursday, October 19, 2017 4:54 PM
To: Matt
Cc: qemu-devel@nongnu.org; Hajime Tazaki; Nutaro, James J.
Subject: Re: [Qemu-devel] Running Qemu in discrete time/step by step

On Thu, Oct 19, 2017 at 14:14:12 +0900, Matt wrote:
(snip)
> - VMSimint does nearly that, it runs Qemu in discrete time but
> interface it with a JAVA simulator
> http://www.ikr.uni-stuttgart.de/Content/Publications/Archive/We_SIMUTools=
_2014_40209.pdf
> (with the code http://www.ikr.uni-stuttgart.de/Content/IKRSimLib/Download=
/)
> - http://web.ornl.gov/~nutarojj/adevs/ does sthg similar too

Nutaro's work to interface with QEMU has been posted on the list:
  https://patchwork.kernel.org/patch/9572497/
I'm Cc'ing him in case he's not subscribed to the list.


> My questions would be:
> 1/ do you know of any other related work ?

Is QEMU's record/replay mode of any use to you? Note that as is the
case with Nutaro's patch, you'll need icount mode (i.e. single-core)
enabled.

> 2/ I believe there is interest from the research side but would it be
> possible to merge either approach or a similar one (adevs patch
> doesn't seem too big ~500 lines), would that be of interest for the
> Qemu comminity too ?
> 3/ if yes to 2. How to proceed, which one would be favorite ? if no,
> what should be improved ? or would that be a definitive no ?

I think the adevs approach is reasonable. The patch hasn't gotten much
attention I guess because not many people care about this feature.
But if you could review the patch and certify that it works for you
(i.e. it works with simulators other than adevs), that could only help
the patch getting in.

That said, I make no merging decisions so take this as just my opinion.

Cheers,

		Emilio
