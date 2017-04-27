Received: from eggs.gnu.org ([2001:4830:134:3::10]:42073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d3sNH-00036Y-ED
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 18:59:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d3sNC-0007ul-MX
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 18:58:59 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:50655)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1d3sNC-0007tA-9a
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 18:58:54 -0400
Date: Thu, 27 Apr 2017 18:58:50 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170427225850.GA21610@flamenco>
References: <20170427120006.20564-1-rth@twiddle.net>
	<20170427120006.20564-10-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170427120006.20564-10-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v5 09/19] target/arm: optimize indirect
 branches
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

On Thu, Apr 27, 2017 at 13:59:56 +0200, Richard Henderson wrote:
(snip)
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> Message-Id: <1493263764-18657-8-git-send-email-cota@braap.org>
> [rth: Replace gen_jr global variable with DISAS_EXIT state.]
> Signed-off-by: Richard Henderson <rth@twiddle.net>

Just want to confirm that this patch passes my testing.
Much better than using the boolean!

Thanks,

		E.
