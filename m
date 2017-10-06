Received: from eggs.gnu.org ([2001:4830:134:3::10]:42871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0T0Q-0001fj-6v
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:49:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0T0P-0006E6-Ez
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:49:34 -0400
Received: from mail-qt0-x236.google.com ([2607:f8b0:400d:c0d::236]:54447)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e0T0P-0006DV-96
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:49:33 -0400
Received: by mail-qt0-x236.google.com with SMTP id i13so31470809qtc.11
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 06:49:33 -0700 (PDT)
References: <20170928203708.9376-1-david@redhat.com>
	<20170928203708.9376-24-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c593afe1-d395-4641-7d32-2fb24e060121@linaro.org>
Date: Fri, 6 Oct 2017 09:49:29 -0400
MIME-Version: 1.0
In-Reply-To: <20170928203708.9376-24-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 23/30] s390x/tcg: implement SIGP
 CONDITIONAL EMERGENCY SIGNAL
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
> Mostly analogous to the kernel/KVM version (so I assume the checks are
> correct :) ). As a preparation for TCG.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.h  |  1 +
>  target/s390x/sigp.c | 37 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
