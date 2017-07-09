Received: from eggs.gnu.org ([2001:4830:134:3::10]:35297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dUJXB-0006On-NZ
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 17:14:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dUJX6-0008V8-QR
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 17:14:29 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:59489)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dUJX6-0008V4-Mw
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 17:14:24 -0400
Date: Sun, 9 Jul 2017 17:14:23 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170709211423.GD32582@flamenco>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-18-git-send-email-cota@braap.org>
	<7e81eceb-2a5e-b5cf-6385-4aff70ecc1b2@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e81eceb-2a5e-b5cf-6385-4aff70ecc1b2@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH 17/22] tcg: distribute profiling counters
 across TCGContext's
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

On Sun, Jul 09, 2017 at 10:45:55 -1000, Richard Henderson wrote:
> On 07/08/2017 09:50 PM, Emilio G. Cota wrote:
> >+    /* includes aborted translations because of exceptions */
> >+    atomic_set(&prof->tb_count1, prof->tb_count1 + 1);
> 
> Again, atomic_set without atomic_read is pointless.
> Either you're trying to give the compiler extra information, or you aren't.

See my comment to patch 3.

> As always, it won't ever matter in practice because aligned native types
> never tear.  This is all about markup for compiler tools.

I do it mostly to avoid undefined behaviour under C11. Pleasing
(some) tools is a nice side effect though.

		E.
