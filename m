Received: from eggs.gnu.org ([2001:4830:134:3::10]:49498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e9DIJ-0000y5-JG
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 12:52:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e9DII-0004P3-Oj
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 12:52:11 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <CAEfK_44JHKD9wdMWQGr7s=-Y8NrU4=Tr8kCqAJWm1f=zyFA2xg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3fd5c433-e879-0ef0-d87a-061660ddf14d@amsat.org>
Date: Mon, 30 Oct 2017 13:51:53 -0300
MIME-Version: 1.0
In-Reply-To: <CAEfK_44JHKD9wdMWQGr7s=-Y8NrU4=Tr8kCqAJWm1f=zyFA2xg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4] nvme: Add tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Doug Gale <doug16k@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, mreitz@redhat.com, keith.busch@intel.com, pbonzini@redhat.com

Cc'ing Stefan and Trivial

On 10/30/2017 01:07 PM, Doug Gale wrote:
> From 0e27b5dca8f4f32a1b194e1b3544be77dd4f45d9 Mon Sep 17 00:00:00 2001
> From: Doug Gale <doug16k@gmail.com>
> Date: Mon, 30 Oct 2017 09:28:43 -0400
> Subject: [PATCH] nvme: Add tracing
> 

^ to remove from commit description, maybe maintainer taking this can
cleanup.
> Add trace output for commands, errors, and undefined behavior.
> Add guest error log output for undefined behavior.
> Report invalid undefined accesses to MMIO.
> Annotate unlikely error checks with unlikely.
> 
> Signed-off-by: Doug Gale <doug16k@gmail.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/block/nvme.c       | 349 ++++++++++++++++++++++++++++++++++++++++++--------
>  hw/block/trace-events |  93 ++++++++++++++
>  2 files changed, 390 insertions(+), 52 deletions(-)
