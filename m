Received: from eggs.gnu.org ([2001:4830:134:3::10]:39132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0SoL-0002T6-EM
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:37:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0SoK-0008Jc-MM
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:37:05 -0400
Received: from mail-qt0-x22c.google.com ([2607:f8b0:400d:c0d::22c]:48173)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e0SoK-0008JG-IX
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:37:04 -0400
Received: by mail-qt0-x22c.google.com with SMTP id d13so30726310qta.5
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 06:37:04 -0700 (PDT)
References: <20170928203708.9376-1-david@redhat.com>
	<20170928203708.9376-10-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fb01b94d-2534-d599-f9c8-8e26bed5b42f@linaro.org>
Date: Fri, 6 Oct 2017 09:37:01 -0400
MIME-Version: 1.0
In-Reply-To: <20170928203708.9376-10-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 09/30] s390x/tcg: handle WAIT PSWs
 during interrupt injection
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
> If we encounter a WAIT PSW, we have to halt immediately. Using
> cpu_loop_exit() at this point feels wrong. Simply leaving
> cs->exception_index set doesn't result in an immediate stop.
> 
> This is also necessary to properly handle SIGP STOP interrupts later.
> 
> The CPU_INTERRUPT_HALT will be processed immediately and properly set
> the CPU to halted (also resetting cs->exception_index to EXCP_HLT)
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/excp_helper.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
