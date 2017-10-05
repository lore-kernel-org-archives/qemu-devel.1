Received: from eggs.gnu.org ([2001:4830:134:3::10]:33141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e0Fsa-0001O7-Pm
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 19:48:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e0FsX-0000gA-NH
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 19:48:36 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:40573)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1e0FsX-0000fw-IR
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 19:48:33 -0400
Date: Thu, 5 Oct 2017 19:48:31 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171005234831.GB23670@flamenco>
References: <1502149958-23381-1-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1502149958-23381-1-git-send-email-cota@braap.org>
Subject: Re: [Qemu-devel] [PATCH 00/22] tcg: tb_lock removal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

On Mon, Aug 07, 2017 at 19:52:16 -0400, Emilio G. Cota wrote:
> This series applies on top of the "multiple TCG contexts" series, v4:
>   https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg06769.html
(snip)
> Please review!

Turns out this patchset breaks icount, even after fixing the patchset
it is based on (see [1]).

The last good patch in the series is patch 10:
"translate-all: work page-by-page in tb_invalidate_phys_range_1".
I have no time to look into fixing that, so if you end up reviewing
this set, please review only patches 1-10.

The good news is that patches > 10 get really hairy, so this should
reduce the review burden substantially.

Thanks,

		Emilio

[1] https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg01198.html
