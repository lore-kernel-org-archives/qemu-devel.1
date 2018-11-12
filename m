Received: from eggs.gnu.org ([2001:4830:134:3::10]:45391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gM7Tt-00023l-Oi
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 03:22:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gM7Ts-0003iE-Vs
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 03:22:01 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39611)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gM7Ts-0003i4-N8
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 03:22:00 -0500
Received: by mail-wr1-x441.google.com with SMTP id b13so8211972wrx.6
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 00:22:00 -0800 (PST)
References: <20181111233622.8976-1-f4bug@amsat.org>
	<20181111233622.8976-7-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6e37ef75-449b-4aca-97a2-748232586830@linaro.org>
Date: Mon, 12 Nov 2018 09:21:56 +0100
MIME-Version: 1.0
In-Reply-To: <20181111233622.8976-7-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 06/11] scripts/decodetree: Allow empty
 specifications
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Peer Adelt <peer.adelt@hni.uni-paderborn.de>, Richard Henderson <rth@twiddle.net>
Cc: Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org

On 11/12/18 12:36 AM, Philippe Mathieu-Daudé wrote:
> Starting with empty specifications allow to write stubs/templates,
> useful when testing/rebasing.
> 
> This fixes:
> 
>   decode.inc.c: In function ‘decode’:
>   decode.inc.c:9:7: error: unused variable ‘u’ [-Werror=unused-variable]
>      } u;
>        ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  scripts/decodetree.py | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
