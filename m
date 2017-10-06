Received: from eggs.gnu.org ([2001:4830:134:3::10]:37280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0Siw-0000VD-PB
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:31:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0Siw-0002wB-06
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:31:30 -0400
Received: from mail-qt0-x232.google.com ([2607:f8b0:400d:c0d::232]:55394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e0Siv-0002w0-RY
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:31:29 -0400
Received: by mail-qt0-x232.google.com with SMTP id x54so31320868qth.12
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 06:31:29 -0700 (PDT)
References: <20170928203708.9376-1-david@redhat.com>
	<20170928203708.9376-5-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <54a4f26b-9ede-3c10-31c6-1687ee5d06c0@linaro.org>
Date: Fri, 6 Oct 2017 09:31:26 -0400
MIME-Version: 1.0
In-Reply-To: <20170928203708.9376-5-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 04/30] s390x/tcg: rework checking for
 deliverable interrupts
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
> Currently, enabling/disabling of interrupts is not really supported.
> 
> Let's improve interrupt handling code by explicitly checking for
> deliverable interrupts only. This is the first step. Checking for
> external interrupt subclasses will be done next.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.c         |  8 +++++---
>  target/s390x/excp_helper.c | 21 +++++++--------------
>  target/s390x/internal.h    |  4 ++++
>  target/s390x/interrupt.c   | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 62 insertions(+), 17 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
