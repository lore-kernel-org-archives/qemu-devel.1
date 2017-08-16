Received: from eggs.gnu.org ([2001:4830:134:3::10]:58717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dhyuv-0002mV-Ro
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 10:03:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dhyus-0001jd-Pj
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 10:03:29 -0400
Received: from mail-pg0-x230.google.com ([2607:f8b0:400e:c05::230]:35375)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dhyus-0001jU-JO
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 10:03:26 -0400
Received: by mail-pg0-x230.google.com with SMTP id v189so23412451pgd.2
	for <qemu-devel@nongnu.org>; Wed, 16 Aug 2017 07:03:26 -0700 (PDT)
References: <20170816082650.21880-1-cohuck@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6b74c05e-2a29-7f24-48ea-b8012897ad40@linaro.org>
Date: Wed, 16 Aug 2017 07:03:22 -0700
MIME-Version: 1.0
In-Reply-To: <20170816082650.21880-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.10] boot-serial-test: prefer tcg
 accelerator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, pbonzini@redhat.com, mst@redhat.com, lvivier@redhat.com

On 08/16/2017 01:26 AM, Cornelia Huck wrote:
> Prefer to use the tcg accelarator if it is available: This is our only
> real smoke test for tcg, and fast enough to use it for that.
> 
> Fixes: 480bc11e6 ("boot-serial-test: fallback to kvm accelerator")
> Reported-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  tests/boot-serial-test.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks, guys.  I don't mind if this gets deferred for 2.11.


r~
