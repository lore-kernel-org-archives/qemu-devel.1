Received: from eggs.gnu.org ([2001:4830:134:3::10]:43697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ale@clearmind.me>) id 1cWI96-0004I7-6b
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 02:37:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ale@clearmind.me>) id 1cWI95-0000Zl-AP
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 02:37:32 -0500
Received: from clearmind.me ([178.32.49.9]:50519)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ale@clearmind.me>) id 1cWI95-0000ZG-3t
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 02:37:31 -0500
Date: Wed, 25 Jan 2017 08:38:35 +0100
From: Alessandro Di Federico <ale+qemu@clearmind.me>
In-Reply-To: <CAFEAcA-52cjhLWWVGQ0qPeF3uKA67-ZBk=EQT2ARL1tjATWMkQ@mail.gmail.com>
References: <20170121084600.5860-1-ale+qemu@clearmind.me>
	<20170121084600.5860-2-ale+qemu@clearmind.me>
	<CAFEAcA-52cjhLWWVGQ0qPeF3uKA67-ZBk=EQT2ARL1tjATWMkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E1cWIBq-0000iN-MH@clearmind.me>
Sender: ale@clearmind.me
Subject: Re: [Qemu-devel] [RFC PATCH 1/3] Factor out {linux, bsd}-user/qemu.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Tue, 24 Jan 2017 11:18:07 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> So my issue with this is that currently linux-user is pretty
> well maintained and tested, but bsd-user is basically unmaintained
> and not even compile tested. 

I can say it compiles. I've tried to build it on FreeBSD 11. Didn't
tested it though.

> So it's convenient to have bsd-user code be basically its own
> distinct standalone thing, because then when we fix linux-user we
> don't have to care too much about whether bsd-user might be
> accidentally broken by our changes.
> 
> If we had more active testing of bsd-user I'd be a bit keener
> about removing some of the code duplication.

Currently, the code looks exactly the same to me. If we don't factor it
out I'll have to make a third copy of it for libtcg, which is kinda
annoying. I'm factoring out only a portion of the header, which
probably doesn't change that much. If in the future there's some change
we're not sure about we can keep it in the non-factored out part.

I'll check if qemu-user for BSD has something in the testsuite.

--
Alessandro Di Federico
PhD student at Politecnico di Milano
