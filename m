Received: from eggs.gnu.org ([209.51.188.92]:52237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gyMi4-0005z2-Vq
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 15:18:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gyMi4-0000LY-8T
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 15:18:44 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <20190225200318.16102-1-david@redhat.com>
	<20190225200318.16102-8-david@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <4a2d343b-89db-c226-ddf0-da0d1d6944df@twiddle.net>
Date: Mon, 25 Feb 2019 12:18:28 -0800
MIME-Version: 1.0
In-Reply-To: <20190225200318.16102-8-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 7/7] s390x/tcg: Implement LOAD COUNT TO
 BLOCK BOUNDARY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>

On 2/25/19 12:03 PM, David Hildenbrand wrote:
> Use a new CC helper to calculate the CC lazily if needed. While the
> PoP mentions that "A 32-bit unsigned binary integer" is placed into the
> first operand, there is no word telling that the other 32 bits (high
> part) are left untouched. Maybe the other 32-bit are unpredictable.
> So store 64 bit for now.
> 
> Bit magic courtesy of Richard.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cc_helper.c   |  8 ++++++++
>  target/s390x/helper.c      |  1 +
>  target/s390x/insn-data.def |  2 ++
>  target/s390x/internal.h    |  1 +
>  target/s390x/translate.c   | 19 +++++++++++++++++++
>  5 files changed, 31 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
