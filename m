Received: from eggs.gnu.org ([2001:4830:134:3::10]:38570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0Sm4-0001Yd-Ik
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:34:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0Sm3-0005qR-PR
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:34:44 -0400
Received: from mail-qt0-x230.google.com ([2607:f8b0:400d:c0d::230]:45572)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e0Sm3-0005q3-Kg
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:34:43 -0400
Received: by mail-qt0-x230.google.com with SMTP id k1so20411374qti.2
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 06:34:43 -0700 (PDT)
References: <20170928203708.9376-1-david@redhat.com>
	<20170928203708.9376-6-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f077f7b4-abf9-8550-f4e8-449d425a26b7@linaro.org>
Date: Fri, 6 Oct 2017 09:34:39 -0400
MIME-Version: 1.0
In-Reply-To: <20170928203708.9376-6-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 05/30] s390x/tcg: take care of external
 interrupt subclasses
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
> We can now let go of INTERRUPT_EXT. When cr0 changes, we have to
> revalidate if we now have a pending external interrupt, just like
> when the PSW (or SYSTEM MASK only) changes.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.h         | 10 +++++-----
>  target/s390x/excp_helper.c | 15 ++++++++++-----
>  target/s390x/interrupt.c   | 32 +++++++++++++++++++++++++++++++-
>  target/s390x/translate.c   |  6 ++++--
>  4 files changed, 50 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
