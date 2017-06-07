Received: from eggs.gnu.org ([2001:4830:134:3::10]:43017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dIkPB-00075h-OO
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 19:30:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dIkP8-0006Cr-HW
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 19:30:25 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59435)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dIkP8-0006CN-Bc
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 19:30:22 -0400
Date: Wed, 7 Jun 2017 19:30:19 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170607233019.GA29137@flamenco>
References: <20170607155536.1193-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170607155536.1193-1-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v4 0/7] tcg: allocate TB structs preceding
 translate
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

On Wed, Jun 07, 2017 at 08:55:29 -0700, Richard Henderson wrote:
> Then I've a few follow-up patches to take advantage of the new TB
> placement for arm platforms.  I've had a look at the asm output for
> ppc64 and s390x, and don't see anything obvious that can be improved.

Nice! Just tested patches 3-7 with an arm guest image on 
x86 and aarch64 hosts:

  Tested-by: Emilio G. Cota <cota@braap.org>

Thanks,

		E.
