Received: from eggs.gnu.org ([2001:4830:134:3::10]:56095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJPip-000776-Vb
	for qemu-devel@nongnu.org; Thu, 17 May 2018 16:42:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJPil-0001Uh-3I
	for qemu-devel@nongnu.org; Thu, 17 May 2018 16:42:00 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:38217)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fJPik-0001UK-SQ
	for qemu-devel@nongnu.org; Thu, 17 May 2018 16:41:55 -0400
Received: by mail-pl0-x243.google.com with SMTP id c11-v6so3229825plr.5
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 13:41:54 -0700 (PDT)
References: <20180517174718.10107-1-alex.bennee@linaro.org>
	<20180517174718.10107-40-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <61f2dcac-f244-ba63-b98a-fbd8afffa7fc@linaro.org>
Date: Thu, 17 May 2018 13:41:50 -0700
MIME-Version: 1.0
In-Reply-To: <20180517174718.10107-40-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 39/49] tests/tcg/alpha: add Alpha
 specific tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On 05/17/2018 10:47 AM, Alex Bennée wrote:
> These tests did use their own crt.o stub however that is a little
> stone age so we drop crt.S and just statically link to the cross
> compilers libraries.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v4
>   - drop crt.s
>   - drop skipping of threadtest
>   - drop write() hack, include unistd.h
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
