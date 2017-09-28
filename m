Received: from eggs.gnu.org ([2001:4830:134:3::10]:33594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dxcPl-0006Tc-5e
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 13:15:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dxcPh-0004UE-1Z
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 13:15:57 -0400
Received: from mail-pg0-x233.google.com ([2607:f8b0:400e:c05::233]:55459)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dxcPg-0004Tl-Rl
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 13:15:52 -0400
Received: by mail-pg0-x233.google.com with SMTP id b11so1279809pgn.12
	for <qemu-devel@nongnu.org>; Thu, 28 Sep 2017 10:15:52 -0700 (PDT)
References: <20170927083636.26648-1-kraxel@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9f93e3fb-6979-137a-c86d-b7641563921f@linaro.org>
Date: Thu, 28 Sep 2017 10:15:47 -0700
MIME-Version: 1.0
In-Reply-To: <20170927083636.26648-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] console: purge curses bits from console.h
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>

On 09/27/2017 01:36 AM, Gerd Hoffmann wrote:
> Handle the translation from vga chars to curses chars in curses_update()
> instead of console_write_ch().  Purge any curses support bits from
> ui/console.h include file.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/ui/console.h | 23 ++---------------------
>  ui/curses.c          | 25 ++++++++++++++++++++-----
>  2 files changed, 22 insertions(+), 26 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
