Received: from eggs.gnu.org ([2001:4830:134:3::10]:45140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e5HpW-0007Ul-ON
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 16:54:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e5HpT-00060K-M8
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 16:54:14 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:52755)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1e5HpT-0005z7-FT
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 16:54:11 -0400
Date: Thu, 19 Oct 2017 16:54:09 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171019205409.GA4170@flamenco>
References: <CADHp1NwU=HowMfgBGtcwnY25v_fL6qZ2gd469a2oZY+QQi2uFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADHp1NwU=HowMfgBGtcwnY25v_fL6qZ2gd469a2oZY+QQi2uFw@mail.gmail.com>
Subject: Re: [Qemu-devel] Running Qemu in discrete time/step by step
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Matt <mattator@gmail.com>
Cc: qemu-devel@nongnu.org, Hajime Tazaki <tazaki@wide.ad.jp>, "James J. Nutaro" <nutarojj@ornl.gov>

On Thu, Oct 19, 2017 at 14:14:12 +0900, Matt wrote:
(snip)
> - VMSimint does nearly that, it runs Qemu in discrete time but
> interface it with a JAVA simulator
> http://www.ikr.uni-stuttgart.de/Content/Publications/Archive/We_SIMUTools_2014_40209.pdf
> (with the code http://www.ikr.uni-stuttgart.de/Content/IKRSimLib/Download/)
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
