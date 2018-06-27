Received: from eggs.gnu.org ([2001:4830:134:3::10]:53220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fY6tf-0005UA-Mn
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 05:37:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fY6tb-0003GM-P9
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 05:37:55 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41425)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fY6tb-0003FT-IY
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 05:37:51 -0400
Received: by mail-wr0-f195.google.com with SMTP id h10-v6so1309178wrq.8
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 02:37:51 -0700 (PDT)
References: <20180517162342.4330-1-viktor.prutyanov@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <16962ebe-86a2-dcb2-c169-82487e77c420@redhat.com>
Date: Wed, 27 Jun 2018 11:37:48 +0200
MIME-Version: 1.0
In-Reply-To: <20180517162342.4330-1-viktor.prutyanov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/4] dump: add Windows crashdump format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, rkagan@virtuozzo.com, armbru@redhat.com, dgilbert@redhat.com

On 17/05/2018 18:23, Viktor Prutyanov wrote:
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

Queued, thanks.

Paolo
