Received: from eggs.gnu.org ([2001:4830:134:3::10]:55447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gLnu4-00019J-4W
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 06:27:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gLnu0-0003fB-0m
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 06:27:44 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:54302)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gLnty-0003dP-2c
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 06:27:38 -0500
Received: by mail-wm1-x333.google.com with SMTP id r63-v6so5821200wma.4
	for <qemu-devel@nongnu.org>; Sun, 11 Nov 2018 03:27:37 -0800 (PST)
References: <20181111000259.7665-1-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <49746241-61a1-0ac8-8d94-3afeafa6d176@linaro.org>
Date: Sun, 11 Nov 2018 12:27:33 +0100
MIME-Version: 1.0
In-Reply-To: <20181111000259.7665-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] decodetree: Force Python to print unsigned
 values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 11/11/18 1:02 AM, Philippe Mathieu-Daudé wrote:
> Python internal representation is signed, so unsigned values
> bigger than 31-bit are interpreted as signed (and printed with
> a '-' signed).
> Mask out to force unsigned values.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  scripts/decodetree.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Queued, thanks.


r~
