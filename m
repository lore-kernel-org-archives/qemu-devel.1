Received: from eggs.gnu.org ([2001:4830:134:3::10]:47740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dzRr9-0007MQ-Tt
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 14:23:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dzRr5-0005GO-57
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 14:23:47 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56053)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dzRr4-00055p-UG
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 14:23:43 -0400
Date: Tue, 3 Oct 2017 14:23:40 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171003182340.GA27228@flamenco>
References: <1507047703-10774-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1507047703-10774-1-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] linux-user: Allow -R values up to
 0xffff0000 for 32-bit ARM guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>

On Tue, Oct 03, 2017 at 17:21:43 +0100, Peter Maydell wrote:
> The 32-bit ARM validate_guest_space() check tests whether the
> specified -R value leaves enough space for us to put the
> commpage in at 0xffff0f00. However it was incorrectly doing
> a <= check for the check against (guest_base + guest_size),
> which meant that it wasn't permitting the guest space to
> butt right up against the commpage.
> 
> Fix the comparison, so that -R values all the way up to 0xffff0000
> work correctly.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Emilio G. Cota <cota@braap.org>

		E.
