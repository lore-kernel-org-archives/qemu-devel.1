Received: from eggs.gnu.org ([2001:4830:134:3::10]:38811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fHBIo-0005wy-Tp
	for qemu-devel@nongnu.org; Fri, 11 May 2018 12:53:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fHBIl-0003Gg-2M
	for qemu-devel@nongnu.org; Fri, 11 May 2018 12:53:55 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:37239)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fHBIk-0003GH-Pe
	for qemu-devel@nongnu.org; Fri, 11 May 2018 12:53:51 -0400
References: <20180510222601.19944-1-laurent@vivier.eu>
	<20180510222601.19944-5-laurent@vivier.eu>
	<CAFEAcA988cQ4eBOGVmvMkYPUynp6zA73wW=0vRB8GYBL8-fJ7A@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <5313f0a4-3cf3-c8a2-a073-3fbb536d3189@vivier.eu>
Date: Fri, 11 May 2018 18:53:20 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA988cQ4eBOGVmvMkYPUynp6zA73wW=0vRB8GYBL8-fJ7A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 4/5] linux-user: move ppc socket.h
 definitions to ppc/sockbits.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Riku Voipio <riku.voipio@iki.fi>, Yongbok Kim <yongbok.kim@mips.com>, Richard Henderson <rth@twiddle.net>

Le 11/05/2018 à 14:12, Peter Maydell a écrit :
> On 10 May 2018 at 23:26, Laurent Vivier <laurent@vivier.eu> wrote:
>> No code change.
>>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> ---
>> --- a/linux-user/socket.h
>> +++ b/linux-user/socket.h
>> @@ -1,6 +1,6 @@
>>
>>  #if defined(TARGET_MIPS) || defined(TARGET_HPPA) || defined(TARGET_ALPHA) || \
>> -    defined(TARGET_SPARC)
>> +    defined(TARGET_SPARC) || defined(TARGET_PPC)
>>  #include "sockbits.h"
>>  #else
> 
> Follow-on cleanup: rather than having this long list of target ifdefs,
> we should just have every target supply a sockbits.h (perhaps deferring
> to a generic set of values the way that lots of archs use the asm-generic
> versions).

I agree.

Laurent
