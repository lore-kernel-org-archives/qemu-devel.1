Received: from eggs.gnu.org ([2001:4830:134:3::10]:33493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dYQ71-0002be-BY
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 01:04:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dYQ6y-0003zV-7p
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 01:04:27 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:43073)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dYQ6x-0003y1-UW
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 01:04:24 -0400
Date: Fri, 21 Jul 2017 01:04:21 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170721050421.GA27190@flamenco>
References: <1500520169-23367-1-git-send-email-cota@braap.org>
	<1500520169-23367-36-git-send-email-cota@braap.org>
	<06200ec3-3c8b-4e69-a339-76b22b99e4d1@twiddle.net>
	<20170720235306.GA6330@flamenco>
	<13fdfcaa-2875-2c21-c749-d488a8b239c3@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13fdfcaa-2875-2c21-c749-d488a8b239c3@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v3 35/43] tcg: dynamically allocate
 optimizer temps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org

On Thu, Jul 20, 2017 at 14:02:53 -1000, Richard Henderson wrote:
> On 07/20/2017 01:53 PM, Emilio G. Cota wrote:
> >BTW, is there any chance that the pool will be initialized before we copy
> >tcg_init_ctx? That'd mean the main thread has performed translation, which
> >seems unlikely to me. But should then we bother clearing the TCGProfile
> >counters after we copy tcg_init_ctx? I don't see how without translation
> >counters would be !0.
> 
> I wouldn't think so.  This cpu setup should be happening very early.

OK. I've removed the clearing of prof in v4.

> We could perhaps look at arranging fields such that all the fields that are
> "shared" between the contexts are up front, and use the qemu standard
> 
>   memcpy(new, old, offsetof(TCGContext, end_common_fields));
> 
> trick, and zero the rest.

It'll be much faster if you do this because you're familiar with all
the fields in there (I'm not); I've added this to the "to do later"
list in v4's cover letter so that we do not forget.

v4 coming up.

		E.
