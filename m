Received: from eggs.gnu.org ([209.51.188.92]:45296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hFusP-0008N2-6y
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 02:13:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hFusN-0006vC-PU
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 02:13:57 -0400
Received: from 1.mo177.mail-out.ovh.net ([178.33.107.143]:38262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hFusN-0006rI-GZ
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 02:13:55 -0400
Received: from player798.ha.ovh.net (unknown [10.109.143.72])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 90A05EF063
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 08:13:46 +0200 (CEST)
References: <20190328062222.8409-1-joel@jms.id.au>
	<20190328062222.8409-2-joel@jms.id.au>
	<CAFEAcA_K1Rv1G-s=ndVYX6i_BvWME6ToShL6ZBpB4gnE3zdZdA@mail.gmail.com>
	<89438392-9a54-7f43-5dff-6ceeffaf9f3e@kaod.org>
	<CACPK8Xc_WeP3xuimjTBFRArteecikin9Qj8ZoCW-J2qBY4C=5g@mail.gmail.com>
	<CAFEAcA9t+GUG8PK623gb4v6ZBEhDX_7coOPcgLHDnUXTsrcrvg@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <c287ed71-59e8-3d7a-f835-1421cba7f6d9@kaod.org>
Date: Mon, 15 Apr 2019 08:13:40 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9t+GUG8PK623gb4v6ZBEhDX_7coOPcgLHDnUXTsrcrvg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] hw: timer: Add ASPEED RTC device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 4/12/19 1:55 PM, Peter Maydell wrote:
> On Fri, 12 Apr 2019 at 04:17, Joel Stanley <joel@jms.id.au> wrote:
>> vmstate and migration is a foreign concept for the small ARM machines.
>> As well as being a developer, I am an end user of Qemu for them (the
>> aspeeds, microbit), and the use case is to boot up a firmware and
>> check that it does correct thing. I've never considered saving the
>> state and resming it, and can't think of a situation where that would
>> be done.
> 
> It's a really useful debugging tool:
>  https://translatedcode.wordpress.com/2015/07/06/tricks-for-debugging-qemu-savevm-snapshots/

yes.  Our Aspeed machines migrate quite well today and, who knows,
we might want one day to run Aspeed VMs on the "cloud". I doubt it 
but, anyway, it's really not complex to do either.

Thanks,

C. 
