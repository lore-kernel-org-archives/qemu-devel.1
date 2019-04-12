Received: from eggs.gnu.org ([209.51.188.92]:60598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEumR-00037P-GP
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:55:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEumP-0000he-IZ
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:55:39 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45237)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hEumN-0000b4-75
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:55:35 -0400
Received: by mail-ot1-x344.google.com with SMTP id e5so8095985otk.12
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 04:55:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190328062222.8409-1-joel@jms.id.au>
	<20190328062222.8409-2-joel@jms.id.au>
	<CAFEAcA_K1Rv1G-s=ndVYX6i_BvWME6ToShL6ZBpB4gnE3zdZdA@mail.gmail.com>
	<89438392-9a54-7f43-5dff-6ceeffaf9f3e@kaod.org>
	<CACPK8Xc_WeP3xuimjTBFRArteecikin9Qj8ZoCW-J2qBY4C=5g@mail.gmail.com>
In-Reply-To: <CACPK8Xc_WeP3xuimjTBFRArteecikin9Qj8ZoCW-J2qBY4C=5g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Apr 2019 12:55:16 +0100
Message-ID: <CAFEAcA9t+GUG8PK623gb4v6ZBEhDX_7coOPcgLHDnUXTsrcrvg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/2] hw: timer: Add ASPEED RTC device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joel Stanley <joel@jms.id.au>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, 12 Apr 2019 at 04:17, Joel Stanley <joel@jms.id.au> wrote:
> vmstate and migration is a foreign concept for the small ARM machines.
> As well as being a developer, I am an end user of Qemu for them (the
> aspeeds, microbit), and the use case is to boot up a firmware and
> check that it does correct thing. I've never considered saving the
> state and resming it, and can't think of a situation where that would
> be done.

It's a really useful debugging tool:
 https://translatedcode.wordpress.com/2015/07/06/tricks-for-debugging-qemu-savevm-snapshots/

thanks
-- PMM
