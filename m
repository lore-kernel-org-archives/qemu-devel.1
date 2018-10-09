Received: from eggs.gnu.org ([2001:4830:134:3::10]:48059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g9x6y-0000GT-En
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 14:52:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g9x6t-0001CJ-Gz
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 14:52:04 -0400
Date: Tue, 9 Oct 2018 14:51:54 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181009185154.GA21860@flamenco>
References: <20181003193931.18096-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181003193931.18096-1-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v3 0/9] tcg: Reorg 128-bit atomic operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org

On Wed, Oct 03, 2018 at 14:39:22 -0500, Richard Henderson wrote:
(snip)
> Richard Henderson (9):
>   tcg: Split CONFIG_ATOMIC128
>   target/i386: Convert to HAVE_CMPXCHG128
>   target/arm: Convert to HAVE_CMPXCHG128
>   target/arm: Check HAVE_CMPXCHG128 at translate time
>   target/ppc: Convert to HAVE_CMPXCHG128 and HAVE_ATOMIC128
>   target/s390x: Convert to HAVE_CMPXCHG128 and HAVE_ATOMIC128
>   target/s390x: Split do_cdsg, do_lpq, do_stpq
>   target/s390x: Skip wout, cout helpers if op helper does not return
>   target/s390x: Check HAVE_ATOMIC128 and HAVE_CMPXCHG128 at translate

Cc'ing ppc/s390x maintainers -- I'm not sure they've seen this series.
Link to this thread (v3):
  https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg00598.html

I'm eager to get this merged, particularly for i386 where it is
fixing unnecessary exits via exec_atomic for cmpxchg16 emulation.

Thanks,

		Emilio
