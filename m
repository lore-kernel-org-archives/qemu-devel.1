Received: from eggs.gnu.org ([2001:4830:134:3::10]:49685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0TKN-0001Db-Gu
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:10:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0TKH-0001YG-N8
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:10:11 -0400
Received: from mail-qt0-x22b.google.com ([2607:f8b0:400d:c0d::22b]:44839)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e0TKH-0001XX-IR
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:10:05 -0400
Received: by mail-qt0-x22b.google.com with SMTP id v28so22776748qtv.1
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 07:10:05 -0700 (PDT)
References: <20170928203708.9376-1-david@redhat.com>
	<20170928203708.9376-31-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6f4ff56f-8f4c-745d-d533-0efff9bf88ed@linaro.org>
Date: Fri, 6 Oct 2017 10:10:02 -0400
MIME-Version: 1.0
In-Reply-To: <20170928203708.9376-31-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 30/30] target/s390x: special handling
 when starting a CPU with WAIT PSW
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>

On 09/28/2017 04:37 PM, David Hildenbrand wrote:
> When we try to start a CPU with a WAIT PSW, we have to take care that
> TCG will actually try to continue executing instructions.
> 
> We must therefore really only unhalt the CPU if we don't have a WAIT
> PSW. Also document the special order for restart interrupts, which
> load a new PSW and change the state to operating.
> 
> To keep KVM working, simply don't have a look at the WAIT bit when
> loading the PSW. Otherwise the behavior of a restart interrupt when
> a CPU stopped would be changed.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.c  | 11 +++++++++--
>  target/s390x/sigp.c |  6 +++++-
>  2 files changed, 14 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
