Received: from eggs.gnu.org ([2001:4830:134:3::10]:33185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ebXZL-0001Wn-Qq
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 15:10:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ebXZI-0001CV-LT
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 15:10:51 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:42116)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ebXZI-0001CJ-FQ
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 15:10:48 -0500
Received: by mail-pg0-x241.google.com with SMTP id q67so10046663pga.9
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 12:10:48 -0800 (PST)
References: <20180116172510.28878-1-laurent@vivier.eu>
	<20180116172510.28878-2-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8eb21965-b5c5-0b42-3157-1f9373c27820@linaro.org>
Date: Tue, 16 Jan 2018 12:10:43 -0800
MIME-Version: 1.0
In-Reply-To: <20180116172510.28878-2-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/4] linux-user: Move CPU type name
 selection to a function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: YunQiang Su <syq@debian.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Aaron Sierra <asierra@xes-inc.com>

On 01/16/2018 09:25 AM, Laurent Vivier wrote:
> Instead of a sequence of "#if ... #endif" move the
> selection to a function in linux-user/*/target_elf.h
> 
> We can't add them in linux-user/*/target_cpu.h
> because we will need to include "elf.h" to
> use ELF flags with eflags, and including
> "elf.h" in "target_cpu.h" introduces some
> conflic in elfload.c
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
> 
> Notes:
>     v2: new patch in the series

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
