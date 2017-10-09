Received: from eggs.gnu.org ([2001:4830:134:3::10]:43736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e1g3t-0002Jn-Vb
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 17:58:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e1g3q-0000p7-Jw
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 17:58:10 -0400
Received: from mail-pf0-x22f.google.com ([2607:f8b0:400e:c00::22f]:54668)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e1g3q-0000nT-EA
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 17:58:06 -0400
Received: by mail-pf0-x22f.google.com with SMTP id m28so10162815pfi.11
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 14:58:03 -0700 (PDT)
References: <20171007155522.25436-1-sw@weilnetz.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bfac5ec4-885e-7531-2d00-ce48bf518a6d@linaro.org>
Date: Mon, 9 Oct 2017 14:58:00 -0700
MIME-Version: 1.0
In-Reply-To: <20171007155522.25436-1-sw@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] oslib-posix: Fix compiler warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 10/07/2017 08:55 AM, Stefan Weil wrote:
> +        char *addr = memset_args->addr;
> +        uint64_t numpages = memset_args->numpages;
> +        uint64_t hpagesize = memset_args->hpagesize;
> +        unsigned i;

Match numpages properly while you're at it?


r~
