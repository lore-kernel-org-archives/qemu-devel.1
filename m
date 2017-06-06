Received: from eggs.gnu.org ([2001:4830:134:3::10]:60976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dIIJx-0001BY-TA
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 13:31:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dIIJt-0003dS-0g
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 13:31:09 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:49453)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dIIJs-0003dJ-K0
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 13:31:04 -0400
Date: Tue, 6 Jun 2017 13:31:03 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170606173103.GA12323@flamenco>
References: <1496702979-26132-1-git-send-email-cota@braap.org>
	<1496702979-26132-4-git-send-email-cota@braap.org>
	<015d442b-a44e-0ebc-470c-e3289b109ca6@twiddle.net>
	<20170606162508.GB6109@flamenco>
	<e03d566d-25c4-5052-68ba-2a07b64bbfdd@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e03d566d-25c4-5052-68ba-2a07b64bbfdd@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] tcg: allocate TB structs before the
 corresponding translated code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Pranith Kumar <bobby.prani@gmail.com>

On Tue, Jun 06, 2017 at 10:02:17 -0700, Richard Henderson wrote:
> On 06/06/2017 09:25 AM, Emilio G. Cota wrote:
> >For this particular case we can get away without padding the structs if
> >we're OK with having the end of a TB struct immediately followed
> >by its translated code, instead of having that code on the following
> >cache line.
> 
> Uh, no, if you can manually pad before the struct, you can manually pad
> after the struct too.

Yes of course =) I'll respin the series to do this.

		E.
