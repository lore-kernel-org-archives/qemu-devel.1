Received: from eggs.gnu.org ([2001:4830:134:3::10]:35356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eehtU-0007Nv-L2
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:48:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eehtR-0006sq-H1
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:48:44 -0500
Received: from chuckie.co.uk ([82.165.15.123]:56632
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1eehtR-0006sJ-9s
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:48:41 -0500
References: <20180124195843.dk7efcmdwoba2jtw@kentang.home>
	<CAFEAcA-T4P6pQTmQG2OuwA0XrHcvjvrzoiE4o=TYDfUv77OWsQ@mail.gmail.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <fb01dcd4-f288-88f2-63df-a7aada267044@ilande.co.uk>
Date: Thu, 25 Jan 2018 13:48:27 +0000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-T4P6pQTmQG2OuwA0XrHcvjvrzoiE4o=TYDfUv77OWsQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL] qemu-sparc updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 25/01/18 12:51, Peter Maydell wrote:

> On 24 January 2018 at 19:58, Mark Cave-Ayland
> <mark.cave-ayland@ilande.co.uk> wrote:
>> Hi Peter,
>>
>> Here are the latest updates for SPARC. Please pull.
>>
>>
>> ATB,
>>
>> Mark.
>>
>>
>> The following changes since commit 52483b067cce4a88ffbf8fbeea26de7549d2ad23:
>>
>>    Merge remote-tracking branch 'remotes/huth/tags/pull-request-2018-01-22' into staging (2018-01-23 10:15:09 +0000)
>>
>> are available in the git repository at:
>>
>>    https://github.com/mcayland/qemu.git tags/qemu-sparc-signed
>>
>> for you to fetch changes up to 9a323c89102f741e3a91a42906c26186a43f379e:
>>
>>    sun4u: implement power device (2018-01-24 19:46:10 +0000)
>>
>> ----------------------------------------------------------------
>> qemu-sparc update
>>
> 
> Hi; I'm afraid this has format-string issues:
> 
> In file included from hw/sparc64/trace.h:69:0,
>                   from hw/sparc64/trace.c:4:
> hw/sparc64/trace.h: In function '_nocheck__trace_sparc64_cpu_tick_set_count':
> hw/sparc64/trace.h:466:23: error: format '%lx' expects argument of
> type 'long unsigned int', but argument 6 has type 'uint64_t {aka long
> long unsigned int}' [-Werror=format=]
>                         "%d@%zd.%06zd:sparc64_cpu_tick_set_count " "%s
> set_count count=0x%016lx (npt %s) p=%p" "\n",
>                         ^
> /home/peter.maydell/qemu/include/qemu/log.h:94:22: note: in definition
> of macro 'qemu_log_mask'
>               qemu_log(FMT, ## __VA_ARGS__);              \
>                        ^
> hw/sparc64/trace.h: In function '_nocheck__trace_sparc64_cpu_tick_get_count':
> hw/sparc64/trace.h:490:23: error: format '%lx' expects argument of
> type 'long unsigned int', but argument 6 has type 'uint64_t {aka long
> long unsigned int}' [-Werror=format=]
>                         "%d@%zd.%06zd:sparc64_cpu_tick_get_count " "%s
> get_count count=0x%016lx (npt %s) p=%p" "\n",
>                         ^
> /home/peter.maydell/qemu/include/qemu/log.h:94:22: note: in definition
> of macro 'qemu_log_mask'
>               qemu_log(FMT, ## __VA_ARGS__);              \
>                        ^
> hw/sparc64/trace.h: In function '_nocheck__trace_sparc64_cpu_tick_set_limit':
> hw/sparc64/trace.h:514:23: error: format '%lx' expects argument of
> type 'long unsigned int', but argument 6 has type 'uint64_t {aka long
> long unsigned int}' [-Werror=format=]
>                         "%d@%zd.%06zd:sparc64_cpu_tick_set_limit " "%s
> set_limit limit=0x%016lx (%s) p=%p called with limit=0x%016lx at
> 0x%016lx (delta=0x%016lx)" "\n",
>                         ^
> /home/peter.maydell/qemu/include/qemu/log.h:94:22: note: in definition
> of macro 'qemu_log_mask'
>               qemu_log(FMT, ## __VA_ARGS__);              \
>                        ^
> hw/sparc64/trace.h:514:23: error: format '%lx' expects argument of
> type 'long unsigned int', but argument 9 has type 'uint64_t {aka long
> long unsigned int}' [-Werror=format=]
>                         "%d@%zd.%06zd:sparc64_cpu_tick_set_limit " "%s
> set_limit limit=0x%016lx (%s) p=%p called with limit=0x%016lx at
> 0x%016lx (delta=0x%016lx)" "\n",
>                         ^
> /home/peter.maydell/qemu/include/qemu/log.h:94:22: note: in definition
> of macro 'qemu_log_mask'
>               qemu_log(FMT, ## __VA_ARGS__);              \
>                        ^
> hw/sparc64/trace.h:514:23: error: format '%lx' expects argument of
> type 'long unsigned int', but argument 10 has type 'uint64_t {aka long
> long unsigned int}' [-Werror=format=]
>                         "%d@%zd.%06zd:sparc64_cpu_tick_set_limit " "%s
> set_limit limit=0x%016lx (%s) p=%p called with limit=0x%016lx at
> 0x%016lx (delta=0x%016lx)" "\n",
>                         ^
> /home/peter.maydell/qemu/include/qemu/log.h:94:22: note: in definition
> of macro 'qemu_log_mask'
>               qemu_log(FMT, ## __VA_ARGS__);              \
>                        ^
> hw/sparc64/trace.h:514:23: error: format '%lx' expects argument of
> type 'long unsigned int', but argument 11 has type 'uint64_t {aka long
> long unsigned int}' [-Werror=format=]
>                         "%d@%zd.%06zd:sparc64_cpu_tick_set_limit " "%s
> set_limit limit=0x%016lx (%s) p=%p called with limit=0x%016lx at
> 0x%016lx (delta=0x%016lx)" "\n",
>                         ^
> /home/peter.maydell/qemu/include/qemu/log.h:94:22: note: in definition
> of macro 'qemu_log_mask'
>               qemu_log(FMT, ## __VA_ARGS__);              \
>                        ^
> 
> Printing uint64_t requires the PRIx64 macros.

Sorry yes, those format strings were taken from some very old code so I 
should have paid a bit more attention.

I've fixed up these events and re-pushed the qemu-sparc-signed tag to 
github which should resolve the issue.


ATB,

Mark.
