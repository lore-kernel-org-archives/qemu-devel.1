Received: from eggs.gnu.org ([2001:4830:134:3::10]:40182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gMjj9-0004Lw-AR
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 20:12:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gMjXU-0004J1-Sy
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 20:00:23 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:49135)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gMjXU-0004Ix-KG
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 20:00:16 -0500
Date: Tue, 13 Nov 2018 20:00:14 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181114010014.GA19024@flamenco>
References: <20181112214503.22941-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112214503.22941-1-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH for-4.0 00/17] tcg: Move softmmu out-of-line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org

On Mon, Nov 12, 2018 at 22:44:46 +0100, Richard Henderson wrote:
> Based on an idea forwarded by Emilio, which suggests a 5-6%
> speed gain is possible.  I have not spent too much time
> measuring this, as the code size gains are significant.

Nice!

> I believe that I posted an x86_64-only patch some time ago,
> but this now includes i386, aarch64 and arm32.  In late
> testing I do some failures on i386, for sparc guest.  I'll
> follow up on that later.

The following might be related: I'm seeing segfaults with -smp 8
and beyond when doing bootup+shutdown of an aarch64 guest on
an x86-64 host. smp -1 is stable AFAICT. The first commit that
shows these crashes is "tcg/i386: Use TCG_TARGET_NEED_LDST_OOL_LABELS",
that is f7ec49a51c8 in your tcg-tlb-x86 github branch.

Thanks,

		Emilio
