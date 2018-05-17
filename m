Received: from eggs.gnu.org ([2001:4830:134:3::10]:51876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJPJW-0006jk-S6
	for qemu-devel@nongnu.org; Thu, 17 May 2018 16:15:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJPJS-0004Rg-Ts
	for qemu-devel@nongnu.org; Thu, 17 May 2018 16:15:50 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:38072)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fJPJS-0004RO-NI
	for qemu-devel@nongnu.org; Thu, 17 May 2018 16:15:46 -0400
Received: by mail-pl0-x243.google.com with SMTP id c11-v6so3194500plr.5
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 13:15:46 -0700 (PDT)
References: <20180517174718.10107-1-alex.bennee@linaro.org>
	<20180517174718.10107-29-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d1b655c1-1e22-6ccc-7865-2f830f62ad85@linaro.org>
Date: Thu, 17 May 2018 13:15:43 -0700
MIME-Version: 1.0
In-Reply-To: <20180517174718.10107-29-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 28/49] tests/tcg/arm: fix up
 test-arm-iwmmxt test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

On 05/17/2018 10:46 AM, Alex Bennée wrote:
> We need to rename the source file to a .S so we can do a single-line
> assemble and link invocation. We also specify the additional CFLAGS
> for the compile as it's a non-standard ARM binary.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> [rth: force fpu configuration]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> ---
> v4
>   - include rth's -mfpu=fpv4-sp-d16
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
