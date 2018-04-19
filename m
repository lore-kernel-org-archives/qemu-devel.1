Received: from eggs.gnu.org ([2001:4830:134:3::10]:41150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f9Gja-0005se-R8
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:04:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f9GjX-0001sI-Mz
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:04:50 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:46680)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f9GjX-0001ns-Gy
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:04:47 -0400
Received: by mail-pl0-x241.google.com with SMTP id 59-v6so3949984plc.13
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 14:04:47 -0700 (PDT)
References: <20180419135901.30035-1-alex.bennee@linaro.org>
	<20180419135901.30035-7-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8fcd1b0e-e067-94b8-e58a-256d9e1e22a8@linaro.org>
Date: Thu, 19 Apr 2018 11:04:40 -1000
MIME-Version: 1.0
In-Reply-To: <20180419135901.30035-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 06/43] configure: set cross_cc_FOO for
 host compiler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org

On 04/19/2018 03:58 AM, Alex Bennée wrote:
>      i386)
>             CPU_CFLAGS="-m32"
>             LDFLAGS="-m32 $LDFLAGS"
> +           cross_cc_i386=$cc
> +           cross_cc_cflags_i386=$CPU_CFLAGS
>             ;;
>      x86_64)
>             # ??? Only extremely old AMD cpus do not have cmpxchg16b.
> @@ -1454,7 +1468,7 @@ case "$cpu" in
>             CPU_CFLAGS="-mx32"
>             LDFLAGS="-mx32 $LDFLAGS"
>             cross_cc_i386=$cc
> -           cross_cc_cflags_i386="-m32"
> +           cross_cc_cflags_i386=$CPU_CFLAGS
>             ;;

Partially redundant with patch 4?  Anyway, this is what I was expecting to see
there.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
