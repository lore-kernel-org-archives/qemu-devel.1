Received: from eggs.gnu.org ([2001:4830:134:3::10]:47522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUl4K-0002ac-2q
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 22:38:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUl4G-0008J0-Sp
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 22:38:32 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:36560)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dUl4G-0008ID-Nm
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 22:38:28 -0400
Received: by mail-qt0-x242.google.com with SMTP id v31so15077457qtb.3
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 19:38:28 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170711015524.22936-1-f4bug@amsat.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <12cda13a-cdba-c480-6f6c-67811135a8a1@twiddle.net>
Date: Mon, 10 Jul 2017 16:38:21 -1000
MIME-Version: 1.0
In-Reply-To: <20170711015524.22936-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] util/cacheinfo: add missing include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>, Pranith Kumar <bobby.prani@gmail.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Geert Martin Ijewski <gm.ijewski@web.de>

On 07/10/2017 03:55 PM, Philippe Mathieu-Daudé wrote:
> This include was forgotten when splitting cacheinfo.c out of
> tcg/ppc/tcg-target.inc.c (see commit b255b2c8).
> 
> While compiling on powerpc:
> 
>        CC      util/cacheinfo.o
>      qemu/util/cacheinfo.c: In function 'arch_cache_info':
>      qemu/util/cacheinfo.c:137:33: error: 'AT_ICACHEBSIZE' undeclared (first use in this function)
>               *isize = qemu_getauxval(AT_ICACHEBSIZE);
>                                       ^
>      qemu/util/cacheinfo.c:137:33: note: each undeclared identifier is reported only once for each function it appears in
>      qemu/util/cacheinfo.c:140:33: error: 'AT_DCACHEBSIZE' undeclared (first use in this function)
>               *dsize = qemu_getauxval(AT_DCACHEBSIZE);
>                                       ^
>      qemu/rules.mak:66: recipe for target 'util/cacheinfo.o' failed
>      make: *** [util/cacheinfo.o] Error 1

For the record, what is the os version?
Because this doesn't happen here for Centos7.


r~
