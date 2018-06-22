Received: from eggs.gnu.org ([2001:4830:134:3::10]:37938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fWMlq-0004lm-P2
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:10:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fWMll-0005Y2-On
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:10:38 -0400
Received: from mail-he1eur01hn0242.outbound.protection.outlook.com
	([104.47.0.242]:11919
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1fWMlk-0005XG-Gw
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:10:33 -0400
Date: Fri, 22 Jun 2018 17:10:15 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20180622141015.GA15836@rkaganb.sw.ru>
References: <20180517162342.4330-1-viktor.prutyanov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517162342.4330-1-viktor.prutyanov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] dump: add Windows crashdump format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, dgilbert@redhat.com, armbru@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

On Thu, May 17, 2018 at 07:23:38PM +0300, Viktor Prutyanov wrote:
> Recently a Windows guest driver has been added with the ability to
> publish the data needed to produce useful guest dumps on the
> hypervisor side.  The data is wrapped in a standard VMCOREINFO
> container and is exposed to the hypervisor via FwCfg (see
> https://github.com/virtio-win/kvm-guest-drivers-windows/tree/master/fwcfg64)
> 
> This patch series extends dump-guest-memory to make use of this data
> and generate guest dumps in Windows crashdump format directly in QEMU
> (as opposed to postprocessing the traditional ELF dumps).
> 
> The first patch in the series is identical to the one posted two weeks
> ago with message-id: <20180501132031.13270-1-viktor.prutyanov@virtuozzo.com>.
> The rest are various improvements on top of it, making it useful in
> situations beyond immediately after a BSOD.
> 
> Viktor Prutyanov (4):
>   dump: add Windows dump format to dump-guest-memory
>   dump: use system context in Windows dump
>   dump: add fallback KDBG using in Windows dump
>   dump: add Windows live system dump
> 
>  Makefile.target |   1 +
>  dump.c          |  24 +++-
>  hmp-commands.hx |  13 +-
>  hmp.c           |   9 +-
>  qapi/misc.json  |   5 +-
>  win_dump.c      | 385 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  win_dump.h      | 176 ++++++++++++++++++++++++++
>  7 files changed, 604 insertions(+), 9 deletions(-)
>  create mode 100644 win_dump.c
>  create mode 100644 win_dump.h
> 

Ping?
