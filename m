Received: from eggs.gnu.org ([2001:4830:134:3::10]:38260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fS5uW-00006G-Ty
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 15:21:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fS5uS-000139-Vd
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 15:21:56 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:35805)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fS5uS-00012F-Oh
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 15:21:52 -0400
Received: by mail-pg0-x243.google.com with SMTP id 15-v6so8710515pge.2
	for <qemu-devel@nongnu.org>; Sun, 10 Jun 2018 12:21:52 -0700 (PDT)
References: <20180605194725.8585-1-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d74dd6bb-dbb7-d532-88c7-f137fa7f15ea@linaro.org>
Date: Sun, 10 Jun 2018 09:21:43 -1000
MIME-Version: 1.0
In-Reply-To: <20180605194725.8585-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qemu-binfmt-conf.sh: ignore the OS/ABI
 field
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

On 06/05/2018 09:47 AM, Laurent Vivier wrote:
> Most of the binaries have a value of "UNIX - System V" for the OS/ABI.
> 
> But cc1 has a value of "UNIX - GNU", and if we don't update the binfmt
> mask to ignore the OS/ABI field, gcc fails to execute it:
> 
> gcc: error trying to exec '/usr/lib/gcc/m68k-linux-gnu/7/cc1': execv: Exec format error
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  scripts/qemu-binfmt-conf.sh | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
