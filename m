Received: from eggs.gnu.org ([2001:4830:134:3::10]:43569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gYwlm-0000J8-N7
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 12:33:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gYwlh-0006iE-Uk
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 12:33:30 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36195)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gYwlg-0006gA-WF
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 12:33:25 -0500
Date: Mon, 17 Dec 2018 12:33:20 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181217173320.GA31091@flamenco>
References: <20181217150116.10446-1-alex.bennee@linaro.org>
	<87mup4gmep.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87mup4gmep.fsf@linaro.org>
Subject: Re: [Qemu-devel] [PATCH  v1 0/4] de-macrofy softmmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org

On Mon, Dec 17, 2018 at 16:15:10 +0000, Alex Bennée wrote:
> 
> Alex Bennée <alex.bennee@linaro.org> writes:
> 
> > Hi,
> >
> <snip>
> >
> > Unfortunately in my simple boot test I see a slight performance
> > degradation:
> >
> > original: 10 times (100.00%), avg time 5.358 (0.02 varience/0.13 deviation)
> > demacro: 10 times (100.00%), avg time 5.760 (0.08 varience/0.29 deviation)
> 
> Moving stuff back into cputlb seems to help:
> 
>  10 times (100.00%), avg time 5.583 (0.03 varience/0.17 deviation)

Yes, I'd move it there. Also playing with attr __noinline__
for the slow paths like we did for hardfloat should help.

> > Emilio,
> >
> > Any chance you could run this through your more comprehensive benchmark
> > suite?

Sure, please give me a few days (got a paper submission deadline
on Wed).

Do you have a branch I can pull from?

Thanks,

		Emilio
