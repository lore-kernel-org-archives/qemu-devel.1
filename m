Received: from eggs.gnu.org ([209.51.188.92]:48735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1hHY9Q-00042O-JN
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 14:22:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1hHY9P-0002dT-PR
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 14:22:16 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c]:46470)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1hHY9P-0002ck-Gu
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 14:22:15 -0400
Received: by mail-pg1-x52c.google.com with SMTP id v2so559649pge.13
	for <qemu-devel@nongnu.org>; Fri, 19 Apr 2019 11:22:14 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20190418224706.14014-1-programmingkidx@gmail.com>
	<723372ae-a37a-d7cd-098f-452c7513ce8a@redhat.com>
	<4B73E5E6-2129-43B8-A35E-0CF7DCAE163B@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <58c00451-f216-610d-4c9c-7437fc07c5bc@twiddle.net>
Date: Fri, 19 Apr 2019 08:22:08 -1000
MIME-Version: 1.0
In-Reply-To: <4B73E5E6-2129-43B8-A35E-0CF7DCAE163B@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] configure: Change capstone's default state
 to disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: G 3 <programmingkidx@gmail.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org

On 4/19/19 3:44 AM, G 3 wrote:
> 
> Here is the error message I see when compiling QEMU:
> 
> CHK version_gen.h
> make[1]: *** No rule to make target
> `/Users/John/qemu-git/capstone/libcapstone.a'.  Stop.
> make: *** [subdir-capstone] Error 2

You are configuring with --static?

I've seen this before myself -- IMO it's broken distro packaging, in that the
shipped pkgconfig/capstone.pc claims static library support, but the static
library itself wasn't shipped.

We should probably work around this in configure, and report the packaging bug.


r~
