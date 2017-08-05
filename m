Received: from eggs.gnu.org ([2001:4830:134:3::10]:39865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1ddqzt-0003eT-4x
	for qemu-devel@nongnu.org; Sat, 05 Aug 2017 00:47:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1ddqzs-0007rt-KJ
	for qemu-devel@nongnu.org; Sat, 05 Aug 2017 00:47:33 -0400
Date: Sat, 5 Aug 2017 06:47:24 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20170805044724.GH4859@toto>
References: <1501692241-23310-1-git-send-email-peter.maydell@linaro.org>
	<1501692241-23310-10-git-send-email-peter.maydell@linaro.org>
	<20170803153800.GR4859@toto>
	<854126f3-84da-087c-f35b-480165871e7f@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <854126f3-84da-087c-f35b-480165871e7f@twiddle.net>
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 09/15] target/arm: Don't store M
 profile PRIMASK and FAULTMASK in daif
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org

On Thu, Aug 03, 2017 at 03:05:17PM -0700, Richard Henderson wrote:
> On 08/03/2017 08:38 AM, Edgar E. Iglesias wrote:
> >> +        uint32_t primask;
> >> +        uint32_t faultmask;
> > It seems like these could be booleans?
> 
> I was thinking the same thing until I read the v8m description as a 32-bit
> register.  This makes qemu match the spec, which has value.
>

Ah, I didn't check the spec :-)
