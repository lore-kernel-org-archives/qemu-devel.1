Received: from eggs.gnu.org ([2001:4830:134:3::10]:45765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7eqX-0001Mc-O6
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 05:53:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7eqU-0002EW-Mf
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 05:53:05 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:53901)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e7eqU-0002DL-EY
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 05:53:02 -0400
Received: by mail-wm0-x22b.google.com with SMTP id r196so7064626wmf.2
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 02:53:02 -0700 (PDT)
References: <20171026081819.28032-1-quintela@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fb96d1fd-257a-276a-edfc-00ac25f63025@linaro.org>
Date: Thu, 26 Oct 2017 11:52:58 +0200
MIME-Version: 1.0
In-Reply-To: <20171026081819.28032-1-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tcg: fix x86 compilation with !CONFIG_TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

On 10/26/2017 10:18 AM, Juan Quintela wrote:
> This commit:
> 
> commit 55c3ceef61fcf06fc98ddc752b7cce788ce7680b
> Author: Richard Henderson <richard.henderson@linaro.org>
> Date:   Sun Oct 15 19:02:42 2017 -0700
> 
>     qom: Introduce CPUClass.tcg_initialize
> 
> Brocke compilation without CONFIG_TCG
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> CC: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/i386/cpu.c | 2 ++
>  1 file changed, 2 insertions(+)

Oops.  I'm sure the other --disable-tcg hosts are affected as well.
But as far as it goes,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
