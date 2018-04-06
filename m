Received: from eggs.gnu.org ([2001:4830:134:3::10]:34415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f4H2b-000388-DY
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 22:23:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f4H2a-0001hR-Lq
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 22:23:49 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:39841)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f4H2a-0001h5-Gb
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 22:23:48 -0400
Date: Thu, 5 Apr 2018 22:23:47 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180406022347.GA1884@flamenco>
References: <20180406010015.16979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406010015.16979-1-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] tcg: Fix out-of-line generic vector
 compares
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, thuth@redhat.com, alex.bennee@linaro.org

On Fri, Apr 06, 2018 at 11:00:15 +1000, Richard Henderson wrote:
> A mistake in the type passed to sizeof, that happens to work
> when the out-of-line fallback itself is using host vectors,
> but fails when using only the base types.
> 
> Reported-by: Emilio G. Cota <cota@braap.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Tested-by: Emilio G. Cota <cota@braap.org>

Thanks!

		Emilio
