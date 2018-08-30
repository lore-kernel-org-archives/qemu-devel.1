Received: from eggs.gnu.org ([2001:4830:134:3::10]:49488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fvStC-0001T7-Ke
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 15:46:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fvSt9-0004Sm-BN
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 15:45:58 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180830122756.13991-1-david@redhat.com>
	<20180830122756.13991-6-david@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <629e2ea3-2819-46c9-3202-21896b8efb9f@twiddle.net>
Date: Thu, 30 Aug 2018 12:45:25 -0700
MIME-Version: 1.0
In-Reply-To: <20180830122756.13991-6-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 5/9] s390x/tcg: add instruction flags
 for floating point instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>

On 08/30/2018 05:27 AM, David Hildenbrand wrote:
> These flags allow us to later on detect if a DATA program interrupt
> is to be injected, and which DXC (1,2,3) is to be used.
> 
> Interestingly, some support FP instructions are considered as HFP
> instructions (I assume simply because they were available very early).
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def | 254 ++++++++++++++++++-------------------
>  target/s390x/translate.c   |   8 ++
>  2 files changed, 135 insertions(+), 127 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
