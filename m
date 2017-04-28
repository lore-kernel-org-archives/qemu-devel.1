Received: from eggs.gnu.org ([2001:4830:134:3::10]:45290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d49wP-0003cb-52
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 13:44:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d49wK-0002WY-4p
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 13:44:25 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:40489)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1d49wJ-0002WP-Pq
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 13:44:20 -0400
Date: Fri, 28 Apr 2017 13:44:18 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170428174418.GA11439@flamenco>
References: <20170427120006.20564-1-rth@twiddle.net>
	<20170427120006.20564-14-rth@twiddle.net>
	<87o9vg79h2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o9vg79h2.fsf@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v5 13/19] tb-hash: improve tb_jmp_cache
 hash function in user mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

On Fri, Apr 28, 2017 at 18:00:57 +0100, Alex Bennée wrote:
> I'll note when I've plotted hit-rates against the cache we don't seem to
> be making a good even use of the cache over time. But I suspect there is
> more that could be done here. 

If you're talking about full-system mode here, then yes, the hit rate
isn't great, which I think is due to frequent flushes of tb_jmp_cache.

For user-mode and for many of these benchmarks we get hit rates in the high
90's. I also tried xxhash and hit rates didn't go up (sometimes even went
one or two percentage points lower), which shows that the hashing function
we have now is good enough, i.e. unless we increase the size of tb_jmp_cache,
there's not a lot to improve here.

I didn't check all benchmarks though, just a few of the SPEC06int ones.

If you have those numbers/plots I'd be interested in seeing them.

Thanks,

		E.
