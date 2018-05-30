Received: from eggs.gnu.org ([2001:4830:134:3::10]:37163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fO9Ew-0003N4-Pu
	for qemu-devel@nongnu.org; Wed, 30 May 2018 18:06:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fO9Et-0004Ea-I8
	for qemu-devel@nongnu.org; Wed, 30 May 2018 18:06:42 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:37065)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fO9Et-0004EI-2W
	for qemu-devel@nongnu.org; Wed, 30 May 2018 18:06:39 -0400
Received: by mail-pg0-x242.google.com with SMTP id a13-v6so8741236pgu.4
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 15:06:39 -0700 (PDT)
References: <20180529194207.31503-1-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c2a768bb-73d3-7fac-1478-b9ecadc70fb6@linaro.org>
Date: Wed, 30 May 2018 15:06:35 -0700
MIME-Version: 1.0
In-Reply-To: <20180529194207.31503-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/15] linux-user: move more definitions
 out of syscall_defs.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>

On 05/29/2018 12:41 PM, Laurent Vivier wrote:
> Move fcntl.h definitions to target directories.
> Introduce a generic header for the targets without
> specific definitions.
> Move more signal.h definitions to target directories.
> 
> Laurent Vivier (15):
>   linux-user: move generic fcntl definitions to generic/fcntl.h
>   linux-user: move alpha fcntl definitions to alpha/target_fcntl.h
>   linux-user: move hppa fcntl definitions to hppa/target_fcntl.h
>   linux-user: move arm/aarch64/m68k fcntl definitions to
>     [arm|aarch64|m68k]/target_fcntl.h
>   linux-user: move mips/mips64 fcntl definitions to mips/target_fcntl.h
>   linux-user: move ppc fcntl definitions to ppc/target_fcntl.h
>   linux-user: move sparc/sparc64 fcntl definitions to
>     sparc/target_fcntl.h
>   linux-user: move get_sp_from_cpustate() to target_cpu.h
>   linux-user: move generic signal definitions to generic/signal.h
>   linux-user: move sparc signal definitions to sparc/target_signal.h
>   linux-user: move mips signal definitions to mips/target_signal.h
>   linux-user: move openrisc signal definitions to
>     openrisc/target_signal.h
>   linux-user: move alpha signal definitions to alpha/target_signal.h
>   linux-user: move hppa signal definitions to hppa/target_signal.h
>   linux-user: remove useless #if

Ignore the acks, I'll upgrade to

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

for the whole series.


r~
