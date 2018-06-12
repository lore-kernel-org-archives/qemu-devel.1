Received: from eggs.gnu.org ([2001:4830:134:3::10]:39391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSl67-0003Jd-TL
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 11:20:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSl63-0006nl-0y
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 11:20:39 -0400
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:35749)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fSl62-0006nM-Pl
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 11:20:34 -0400
Received: by mail-it0-x241.google.com with SMTP id a3-v6so15922911itd.0
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 08:20:34 -0700 (PDT)
References: <20180606181352.61144-1-lfy@google.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6155757f-6dad-9299-80c3-d6ae4cc86e75@linaro.org>
Date: Tue, 12 Jun 2018 05:20:28 -1000
MIME-Version: 1.0
In-Reply-To: <20180606181352.61144-1-lfy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Improve file-backed RAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lingfeng Yang <lfy@google.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>

On 06/06/2018 08:13 AM, Lingfeng Yang via Qemu-devel wrote:
>  size_t qemu_mempath_getpagesize(const char *mem_path)
>  {
> +#ifndef _WIN32
>  #ifdef CONFIG_LINUX
>      struct statfs fs;
>      int ret;
> @@ -73,10 +82,14 @@ size_t qemu_mempath_getpagesize(const char *mem_path)
>  #endif
>  
>      return getpagesize();
> +#else
> +    return WIN_FILE_PAGE_SIZE;
> +#endif
>  }

As a rule, positive tests are easier to read than negative ones.  And when it
comes to nesting ifdefs, doubly so.


r~
