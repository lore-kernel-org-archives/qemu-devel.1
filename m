Received: from eggs.gnu.org ([2001:4830:134:3::10]:43404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eeh09-0008Ei-KX
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 07:51:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eeh08-0001gV-59
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 07:51:33 -0500
Received: from mail-ot0-x22b.google.com ([2607:f8b0:4003:c0f::22b]:46773)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eeh07-0001ei-VU
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 07:51:32 -0500
Received: by mail-ot0-x22b.google.com with SMTP id t35so6573729otd.13
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 04:51:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180124195843.dk7efcmdwoba2jtw@kentang.home>
References: <20180124195843.dk7efcmdwoba2jtw@kentang.home>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jan 2018 12:51:10 +0000
Message-ID: <CAFEAcA-T4P6pQTmQG2OuwA0XrHcvjvrzoiE4o=TYDfUv77OWsQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL] qemu-sparc updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 24 January 2018 at 19:58, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> Hi Peter,
>
> Here are the latest updates for SPARC. Please pull.
>
>
> ATB,
>
> Mark.
>
>
> The following changes since commit 52483b067cce4a88ffbf8fbeea26de7549d2ad23:
>
>   Merge remote-tracking branch 'remotes/huth/tags/pull-request-2018-01-22' into staging (2018-01-23 10:15:09 +0000)
>
> are available in the git repository at:
>
>   https://github.com/mcayland/qemu.git tags/qemu-sparc-signed
>
> for you to fetch changes up to 9a323c89102f741e3a91a42906c26186a43f379e:
>
>   sun4u: implement power device (2018-01-24 19:46:10 +0000)
>
> ----------------------------------------------------------------
> qemu-sparc update
>

Hi; I'm afraid this has format-string issues:

In file included from hw/sparc64/trace.h:69:0,
                 from hw/sparc64/trace.c:4:
hw/sparc64/trace.h: In function '_nocheck__trace_sparc64_cpu_tick_set_count':
hw/sparc64/trace.h:466:23: error: format '%lx' expects argument of
type 'long unsigned int', but argument 6 has type 'uint64_t {aka long
long unsigned int}' [-Werror=format=]
                       "%d@%zd.%06zd:sparc64_cpu_tick_set_count " "%s
set_count count=0x%016lx (npt %s) p=%p" "\n",
                       ^
/home/peter.maydell/qemu/include/qemu/log.h:94:22: note: in definition
of macro 'qemu_log_mask'
             qemu_log(FMT, ## __VA_ARGS__);              \
                      ^
hw/sparc64/trace.h: In function '_nocheck__trace_sparc64_cpu_tick_get_count':
hw/sparc64/trace.h:490:23: error: format '%lx' expects argument of
type 'long unsigned int', but argument 6 has type 'uint64_t {aka long
long unsigned int}' [-Werror=format=]
                       "%d@%zd.%06zd:sparc64_cpu_tick_get_count " "%s
get_count count=0x%016lx (npt %s) p=%p" "\n",
                       ^
/home/peter.maydell/qemu/include/qemu/log.h:94:22: note: in definition
of macro 'qemu_log_mask'
             qemu_log(FMT, ## __VA_ARGS__);              \
                      ^
hw/sparc64/trace.h: In function '_nocheck__trace_sparc64_cpu_tick_set_limit':
hw/sparc64/trace.h:514:23: error: format '%lx' expects argument of
type 'long unsigned int', but argument 6 has type 'uint64_t {aka long
long unsigned int}' [-Werror=format=]
                       "%d@%zd.%06zd:sparc64_cpu_tick_set_limit " "%s
set_limit limit=0x%016lx (%s) p=%p called with limit=0x%016lx at
0x%016lx (delta=0x%016lx)" "\n",
                       ^
/home/peter.maydell/qemu/include/qemu/log.h:94:22: note: in definition
of macro 'qemu_log_mask'
             qemu_log(FMT, ## __VA_ARGS__);              \
                      ^
hw/sparc64/trace.h:514:23: error: format '%lx' expects argument of
type 'long unsigned int', but argument 9 has type 'uint64_t {aka long
long unsigned int}' [-Werror=format=]
                       "%d@%zd.%06zd:sparc64_cpu_tick_set_limit " "%s
set_limit limit=0x%016lx (%s) p=%p called with limit=0x%016lx at
0x%016lx (delta=0x%016lx)" "\n",
                       ^
/home/peter.maydell/qemu/include/qemu/log.h:94:22: note: in definition
of macro 'qemu_log_mask'
             qemu_log(FMT, ## __VA_ARGS__);              \
                      ^
hw/sparc64/trace.h:514:23: error: format '%lx' expects argument of
type 'long unsigned int', but argument 10 has type 'uint64_t {aka long
long unsigned int}' [-Werror=format=]
                       "%d@%zd.%06zd:sparc64_cpu_tick_set_limit " "%s
set_limit limit=0x%016lx (%s) p=%p called with limit=0x%016lx at
0x%016lx (delta=0x%016lx)" "\n",
                       ^
/home/peter.maydell/qemu/include/qemu/log.h:94:22: note: in definition
of macro 'qemu_log_mask'
             qemu_log(FMT, ## __VA_ARGS__);              \
                      ^
hw/sparc64/trace.h:514:23: error: format '%lx' expects argument of
type 'long unsigned int', but argument 11 has type 'uint64_t {aka long
long unsigned int}' [-Werror=format=]
                       "%d@%zd.%06zd:sparc64_cpu_tick_set_limit " "%s
set_limit limit=0x%016lx (%s) p=%p called with limit=0x%016lx at
0x%016lx (delta=0x%016lx)" "\n",
                       ^
/home/peter.maydell/qemu/include/qemu/log.h:94:22: note: in definition
of macro 'qemu_log_mask'
             qemu_log(FMT, ## __VA_ARGS__);              \
                      ^

Printing uint64_t requires the PRIx64 macros.


thanks
-- PMM
