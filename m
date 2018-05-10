Received: from eggs.gnu.org ([2001:4830:134:3::10]:34047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fGmhb-0006Iu-Mh
	for qemu-devel@nongnu.org; Thu, 10 May 2018 10:37:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fGmhX-0000AT-NW
	for qemu-devel@nongnu.org; Thu, 10 May 2018 10:37:51 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:33856)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1fGmhX-0000AH-HU
	for qemu-devel@nongnu.org; Thu, 10 May 2018 10:37:47 -0400
Received: by mail-pl0-x242.google.com with SMTP id ay10-v6so1430723plb.1
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 07:37:47 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180510143618.23673-1-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <d4525d99-e8cd-e56b-e23e-d486cb9f57ef@twiddle.net>
Date: Thu, 10 May 2018 07:37:44 -0700
MIME-Version: 1.0
In-Reply-To: <20180510143618.23673-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] atomic.h: Work around gcc spurious "unused
 value" warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>

On 05/10/2018 07:36 AM, Peter Maydell wrote:
> Some versions of gcc produce a spurious warning if the result of
> __atomic_compare_echange_n() is not used and the type involved
> is a signed 8 bit value:
>   error: value computed is not used [-Werror=unused-value]
> This has been seen on at least
>  gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
> 
> Work around this by using an explicit cast to void to indicate
> that we don't care about the return value.
> 
> We don't currently use our atomic_cmpxchg() macro on any signed
> 8 bit types, but the upcoming support for the Arm v8.1-Atomics
> will require it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Sending out my workaround as an actual patch. If this is OK I'll
> put in via target-arm.next as it's a dependency for the v8.1-atomics
> series.
> 
>  include/qemu/atomic.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
