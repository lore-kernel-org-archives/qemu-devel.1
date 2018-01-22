Received: from eggs.gnu.org ([2001:4830:134:3::10]:33522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1edT7a-0002cF-1S
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 22:50:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1edT7Z-00021A-Aa
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 22:50:10 -0500
Received: from mail-pg0-x22f.google.com ([2607:f8b0:400e:c05::22f]:44572)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1edT7Z-00020o-49
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 22:50:09 -0500
Received: by mail-pg0-x22f.google.com with SMTP id m20so6096234pgc.11
	for <qemu-devel@nongnu.org>; Sun, 21 Jan 2018 19:50:08 -0800 (PST)
References: <20180119114444.7590-1-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <58589c41-6866-e26f-8743-015d91fe2fbc@linaro.org>
Date: Sun, 21 Jan 2018 19:50:05 -0800
MIME-Version: 1.0
In-Reply-To: <20180119114444.7590-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/m68k: fix TCG variable double free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

On 01/19/2018 03:44 AM, Laurent Vivier wrote:
> t64 is also unconditionally freed after the switch () { ... }
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  target/m68k/translate.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
