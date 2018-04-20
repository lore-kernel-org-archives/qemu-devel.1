Received: from eggs.gnu.org ([2001:4830:134:3::10]:38758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9Lr8-00075u-8r
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 22:32:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9Lr5-00012I-69
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 22:32:58 -0400
Received: from mail-qk0-x229.google.com ([2607:f8b0:400d:c09::229]:46333)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9Lr5-00012A-1E
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 22:32:55 -0400
Received: by mail-qk0-x229.google.com with SMTP id s70so7494903qks.13
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 19:32:54 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180419135901.30035-1-alex.bennee@linaro.org>
	<0b1a0dd5-4b79-5e60-5b45-8ee8f2de07c8@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <96a62c45-4455-c315-9c3e-30aa30ae59b2@amsat.org>
Date: Thu, 19 Apr 2018 23:32:48 -0300
MIME-Version: 1.0
In-Reply-To: <0b1a0dd5-4b79-5e60-5b45-8ee8f2de07c8@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 00/43] fix building of tests/tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org

> It seems I can't even build fp-test for x86_64.
> 
>   CROSS-BUILD x86_64 guest-tests with cc
> In file included from /home/rth/work/qemu/qemu/tests/fp/fp-test.c:14:0:
> /home/rth/work/qemu/qemu/include/qemu/osdep.h:30:10: fatal error:
> config-host.h: No such file or directory
>  #include "config-host.h"
>           ^~~~~~~~~~~~~~~
> compilation terminated.

Cross builds when target==host arch are often broken because the less
tested. Probably because it is easier to directly use the host, yet
fully configured.
