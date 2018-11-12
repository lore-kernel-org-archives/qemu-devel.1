Received: from eggs.gnu.org ([2001:4830:134:3::10]:45137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gM7Se-0001Re-Ii
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 03:20:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gM7SW-00032J-4g
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 03:20:41 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:45937)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gM7SI-0002iD-0O
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 03:20:26 -0500
Received: by mail-wr1-x42b.google.com with SMTP id k15-v6so8195227wre.12
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 00:20:18 -0800 (PST)
References: <20181111233622.8976-1-f4bug@amsat.org>
	<20181111233622.8976-6-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5caadde7-9a5d-24f8-e75f-7e40aad9e876@linaro.org>
Date: Mon, 12 Nov 2018 09:20:13 +0100
MIME-Version: 1.0
In-Reply-To: <20181111233622.8976-6-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 05/11] decodetree: Force Python to
 print unsigned values
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
> Python internal representation is signed, so unsigned values
> bigger than 31-bit are interpreted as signed (and printed with
> a '-' signed).
> Mask out to force unsigned values.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> TODO: display error encountered:
> 
>    case 0x-1:
>        ....
> ---
>  scripts/decodetree.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

This must have been from a trivial input file containing only fixed field
insns?  Not saying it's wrong, but just so we know.  Any chance you can build a
tests/decode/ test for this?  I know they're all currently related to parsing,
but...

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
