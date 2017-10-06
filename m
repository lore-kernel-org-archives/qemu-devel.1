Received: from eggs.gnu.org ([2001:4830:134:3::10]:60612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0SVb-0001eL-8p
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:17:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0SVX-00015D-E7
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:17:43 -0400
Received: from mail-qt0-x22b.google.com ([2607:f8b0:400d:c0d::22b]:55101)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e0SVX-00014w-8x
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:17:39 -0400
Received: by mail-qt0-x22b.google.com with SMTP id i13so31283655qtc.11
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 06:17:39 -0700 (PDT)
References: <20170928203708.9376-1-david@redhat.com>
	<20170928203708.9376-3-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <55d7982a-8818-9400-7579-044de50a270c@linaro.org>
Date: Fri, 6 Oct 2017 09:17:34 -0400
MIME-Version: 1.0
In-Reply-To: <20170928203708.9376-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 02/30] s390x/tcg: cleanup service
 interrupt injection
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

On 09/28/2017 04:36 PM, David Hildenbrand wrote:
> There are still some leftovers from old virtio interrupts in there.
> Most importantly, we don't have to queue service interrupts anymore.
> Just like KVM, we can simply multiplex the SCLP service interrupts and
> avoid the queue.
> 
> Also, now only valid parametes/cpu_addr will be stored on service
> interrupts.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.c         |  2 --
>  target/s390x/cpu.h         | 10 +---------
>  target/s390x/excp_helper.c | 16 +++++-----------
>  target/s390x/internal.h    |  2 --
>  target/s390x/interrupt.c   | 18 ++++--------------
>  5 files changed, 10 insertions(+), 38 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
