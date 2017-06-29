Received: from eggs.gnu.org ([2001:4830:134:3::10]:44975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dQhpH-0000JZ-IR
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 18:22:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dQhpD-0007xO-Ir
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 18:22:15 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:41673)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dQhpD-0007wA-9s
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 18:22:11 -0400
Date: Thu, 29 Jun 2017 18:22:10 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170629222210.GB9797@flamenco>
References: <149873841036.9180.16600465902334229930.stgit@frigg.lan>
	<149873865231.9180.13927490238451232263.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <149873865231.9180.13927490238451232263.stgit@frigg.lan>
Subject: Re: [Qemu-devel] [PATCH v10 1/7] exec: [tcg] Refactor flush of
 per-CPU virtual TB cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

On Thu, Jun 29, 2017 at 15:17:32 +0300, Lluís Vilanova wrote:
> The function is reused in later patches.
> 
> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
> Reviewed-by: Richard Henderson <rth@twiddle.net>
> ---
>  accel/tcg/cputlb.c        |    2 +-
>  accel/tcg/translate-all.c |   15 ++++++++++-----
>  include/exec/exec-all.h   |    6 ++++++
>  3 files changed, 17 insertions(+), 6 deletions(-)

Richard already picked up this patch:
  tcg: consistently access cpu->tb_jmp_cache atomically
  https://patchwork.kernel.org/patch/9787697/

The patch you're sending (i.e. 1/7) is a subset of that one,
so the easiest solution probably is to drop it, making sure that:
- patch 4/7 is updated to call cpu_tb_jmp_cache_clear instead of
  tb_flush_jmp_cache_all
- This series is merged after that other patch is merged. If
  Richard also queues then we'll be guaranteed to avoid a merge
  conflict.

		E.
