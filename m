Received: from eggs.gnu.org ([2001:4830:134:3::10]:53836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fLsVu-00058R-PM
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:50:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fLsVq-0005OJ-Us
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:50:50 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:38611)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fLsVq-0005N8-LK
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:50:46 -0400
From: Laurent Vivier <laurent@vivier.eu>
References: <20180519092956.15134-1-laurent@vivier.eu>
	<20180519092956.15134-7-laurent@vivier.eu>
	<CAFEAcA8Wc2boEtJQC2feZ_N07no-ErGGk-Hhwyyuo91kGaTc2w@mail.gmail.com>
	<a423df2b-02a1-07f9-075f-55e68607f357@vivier.eu>
Message-ID: <0d3fb5f8-a8b1-57b8-2f16-294e1f824aab@vivier.eu>
Date: Thu, 24 May 2018 17:50:18 +0200
MIME-Version: 1.0
In-Reply-To: <a423df2b-02a1-07f9-075f-55e68607f357@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 6/8] linux-user: update
 ARCH_HAS_SOCKET_TYPES use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Yongbok Kim <yongbok.kim@mips.com>, Richard Henderson <rth@twiddle.net>

Le 24/05/2018 à 17:29, Laurent Vivier a écrit :
> Le 21/05/2018 à 11:19, Peter Maydell a écrit :
>> On 19 May 2018 at 10:29, Laurent Vivier <laurent@vivier.eu> wrote:
>>> to be like in the kernel and rename it TARGET_ARCH_HAS_SOCKET_TYPES
>>
>> You could note in the commit message that this fixes our
>> incorrect definition of TARGET_SOCK_CLOEXEC for SPARC.
> 
> I agree

In fact it doesn't change the value of TARGET_SOCK_CLOEXEC for SPARC,
because original value is 020000000 (0x400000) and the new value from
linux-user/socket.h is TARGET_O_CLOEXEC which is also 0x400000 for SPARC.

Thanks,
Laurent
