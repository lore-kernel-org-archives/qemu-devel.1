Received: from eggs.gnu.org ([2001:4830:134:3::10]:50699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1faq84-0008Nc-Au
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 18:20:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1faq80-0007Iq-Bm
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 18:20:04 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:38415)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1faq80-0007IL-41
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 18:20:00 -0400
Received: by mail-pl0-x241.google.com with SMTP id b1-v6so294748pls.5
	for <qemu-devel@nongnu.org>; Wed, 04 Jul 2018 15:20:00 -0700 (PDT)
References: <20180704183855.18304-1-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <de8fe432-016a-65bb-455e-dfe55da18751@linaro.org>
Date: Wed, 4 Jul 2018 15:19:56 -0700
MIME-Version: 1.0
In-Reply-To: <20180704183855.18304-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/ppc: fix build on ppc64 host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 07/04/2018 11:38 AM, Laurent Vivier wrote:
> When I try to build a ppc64 target on a ppc64 host (gcc 8.1.1), I have:
> 
> .../target/ppc/int_helper.c: In function 'helper_vinsertb':
> .../target/ppc/int_helper.c:1954:32: error: array subscript 18446744073709551608 is above array bounds of 'uint8_t[16]' {aka 'unsigned char[16]'} [-Werror=array-bounds]
>          memmove(&r->u8[index], &b->u8[8 - sizeof(r->element)],              \
>                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> .../target/ppc/int_helper.c:1965:1: note: in expansion of macro 'VINSERT'
> 
> If we compare with the macro for ppc64le, we can see
> sizeof(r->element[0]) should be used instead of sizeof(r->element).
> 
> And VINSERT uses only u8, u16, u32 and u64, so the maximum value
> of sizeof(r->element[0]) is 8
> 
> Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  target/ppc/int_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
