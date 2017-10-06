Received: from eggs.gnu.org ([2001:4830:134:3::10]:46489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0TAT-0001Ml-UQ
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:59:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0TAT-0006Yw-8f
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:59:58 -0400
Received: from mail-qt0-x22e.google.com ([2607:f8b0:400d:c0d::22e]:55735)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e0TAT-0006YC-3z
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:59:57 -0400
Received: by mail-qt0-x22e.google.com with SMTP id x54so31488666qth.12
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 06:59:56 -0700 (PDT)
References: <20170928203708.9376-1-david@redhat.com>
	<20170928203708.9376-26-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2c85866e-b61f-c3fe-441b-56ebaf91d6d4@linaro.org>
Date: Fri, 6 Oct 2017 09:59:53 -0400
MIME-Version: 1.0
In-Reply-To: <20170928203708.9376-26-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 25/30] s390x/tcg: flush the tlb on SIGP
 SET PREFIX
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
> Thanks to Aurelien Jarno for doing this in his prototype.
> 
> We can flush the whole TLB as this should happen really rarely.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/sigp.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
