Received: from eggs.gnu.org ([2001:4830:134:3::10]:56916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fAL4l-0002DG-7W
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 15:55:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fAL4i-0004UL-6T
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 15:55:07 -0400
Received: from mail-pg0-x236.google.com ([2607:f8b0:400e:c05::236]:39920)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fAL4h-0004Tk-Vy
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 15:55:04 -0400
Received: by mail-pg0-x236.google.com with SMTP id b9so6873741pgf.6
	for <qemu-devel@nongnu.org>; Sun, 22 Apr 2018 12:55:03 -0700 (PDT)
References: <1524250517-28032-1-git-send-email-cota@braap.org>
	<1524250517-28032-11-git-send-email-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <defa749d-4778-1a5d-f5de-e1b1054ecd62@linaro.org>
Date: Sun, 22 Apr 2018 09:54:59 -1000
MIME-Version: 1.0
In-Reply-To: <1524250517-28032-11-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/18] target/mips: convert to TranslatorOps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>

On 04/20/2018 08:55 AM, Emilio G. Cota wrote:
> - Added an assert in translate_insn, before exiting due to an exception,
>   to make sure that is_jmp is set to DISAS_EXCP (the exception generation
>   function always sets it.)

Comment is out of date -- s/EXCP/NORETURN/.

r~
