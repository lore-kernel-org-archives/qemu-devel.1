Received: from eggs.gnu.org ([2001:4830:134:3::10]:58414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1foD5V-0008N0-39
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 15:28:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1foD5R-0003ej-W3
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 15:28:41 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:33541)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1foD5R-0003e2-P5
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 15:28:37 -0400
Received: by mail-pf1-x443.google.com with SMTP id d4-v6so4984027pfn.0
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 12:28:37 -0700 (PDT)
References: <20180810185321.20017-1-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <91c3c3ac-83f1-18e3-2fc2-c25d329c5414@linaro.org>
Date: Fri, 10 Aug 2018 12:28:33 -0700
MIME-Version: 1.0
In-Reply-To: <20180810185321.20017-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] linux-user: cleanup msync output in
 strace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <rth@twiddle.net>

On 08/10/2018 11:53 AM, Laurent Vivier wrote:
> -{ TARGET_NR_msync, "msync" , NULL, NULL, NULL },
> +{ TARGET_NR_msync, "msync" , "%s(%#x,%d,%x)", NULL, NULL },

Would you mind having a look at my linux-user reorg proposal?
It would make this change redundant.

https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg02935.html


r~
