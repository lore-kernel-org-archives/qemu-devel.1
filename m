Received: from eggs.gnu.org ([2001:4830:134:3::10]:54551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fJLB1-0001oL-Co
	for qemu-devel@nongnu.org; Thu, 17 May 2018 11:50:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fJLAx-0006QT-Dm
	for qemu-devel@nongnu.org; Thu, 17 May 2018 11:50:47 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:36389)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fJLAx-0006QE-3K
	for qemu-devel@nongnu.org; Thu, 17 May 2018 11:50:43 -0400
References: <20180516205543.29305-1-laurent@vivier.eu>
	<20180516205543.29305-7-laurent@vivier.eu>
	<CAFEAcA8q2maj0iWgk066xBQs7biH6dBafWm6qUSK5tV2myaj1Q@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <f1b0475a-bdbc-f3b7-a71e-7d85128ff76f@vivier.eu>
Date: Thu, 17 May 2018 17:50:05 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8q2maj0iWgk066xBQs7biH6dBafWm6qUSK5tV2myaj1Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 6/8] linux-user: update
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>, Yongbok Kim <yongbok.kim@mips.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Le 17/05/2018 à 17:45, Peter Maydell a écrit :
> On 16 May 2018 at 21:55, Laurent Vivier <laurent@vivier.eu> wrote:
>> to be like in the kernel and rename it TARGET_ARCH_HAS_SOCKET_TYPES
>>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> 
>> +/* Flags for socket, socketpair, accept4 */
>> +#define TARGET_SOCK_CLOEXEC    TARGET_O_CLOEXEC
>> +#ifndef TARGET_SOCK_NONBLOCK
>> +#define TARGET_SOCK_NONBLOCK   O_NONBLOCK
> 
> Shouldn't this be TARGET_O_NONBLOCK ?

Yes, thank you

Laurent
