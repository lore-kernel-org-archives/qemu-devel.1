Received: from eggs.gnu.org ([2001:4830:134:3::10]:36799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fziLk-0007vO-Pl
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 09:05:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fziHM-00043j-Tx
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 09:00:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44810 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fziHM-00043Y-MO
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 09:00:28 -0400
References: <20180910232752.31565-1-cota@braap.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <38838d81-91c9-5ff6-4881-e93d503800d0@redhat.com>
Date: Tue, 11 Sep 2018 15:00:25 +0200
MIME-Version: 1.0
In-Reply-To: <20180910232752.31565-1-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 00/12] i386 + x86_64 mttcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

On 11/09/2018 01:27, Emilio G. Cota wrote:
> v1: https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg00237.html
> 
> Changes since v1:
> 
> - Add Alex's R-b tags
> - Introduce atomic64 to just use a spinlock when doing atomic_set/read
>   on i64's and u64's if !CONFIG_ATOMIC64, just like the kernel does.
>   + Add a benchmark for these types of accesses to tests/
>   + Add i/d cacheline_size_log
> - Convert qsp to atomic64
> - Convert test-rcu-list to atomic64
>   + Add comments about what the patch does, as suggested by Murilo
> - Convert cpus.c to atomic64
> - Always use seqlock_write on cpu_update_icount
> 
> There's one checkpatch error, but it's a false positive.
> 
> You can fetch this series from:
>   https://github.com/cota/qemu/tree/i386-mttcg-v2

Queued 1-10.

Paolo
