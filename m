Received: from eggs.gnu.org ([2001:4830:134:3::10]:51375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fzhau-00040e-E7
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 08:16:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fzhar-0001mU-BB
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 08:16:36 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436]:41685)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1fzhar-0001lR-3A
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 08:16:33 -0400
Received: by mail-pf1-x436.google.com with SMTP id h79-v6so12131568pfk.8
	for <qemu-devel@nongnu.org>; Tue, 11 Sep 2018 05:16:32 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180910232752.31565-1-cota@braap.org>
	<20180910232752.31565-2-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <cc3875ff-6cf0-b539-611a-9060d09624c7@twiddle.net>
Date: Tue, 11 Sep 2018 05:16:28 -0700
MIME-Version: 1.0
In-Reply-To: <20180910232752.31565-2-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 01/12] cacheinfo: add i/d
 cache_linesize_log
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

On 09/10/2018 04:27 PM, Emilio G. Cota wrote:
> @@ -173,5 +176,7 @@ static void __attribute__((constructor)) init_cache_info(void)
>      fallback_cache_info(&isize, &dsize);
>  
>      qemu_icache_linesize = isize;
> +    qemu_icache_linesize_log = 31 - clz32(isize);
>      qemu_dcache_linesize = dsize;
> +    qemu_dcache_linesize_log = 31 - clz32(dsize);

Either pow2ceil or realize that linesize is already a power of 2 and use ctz32.


r~
