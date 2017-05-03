Received: from eggs.gnu.org ([2001:4830:134:3::10]:33102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d5tVo-00014f-HM
	for qemu-devel@nongnu.org; Wed, 03 May 2017 08:36:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d5tVl-0005AK-8M
	for qemu-devel@nongnu.org; Wed, 03 May 2017 08:36:08 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:36059)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1d5tVl-0005A6-1s
	for qemu-devel@nongnu.org; Wed, 03 May 2017 08:36:05 -0400
Received: by mail-wr0-x243.google.com with SMTP id v42so22586570wrc.3
	for <qemu-devel@nongnu.org>; Wed, 03 May 2017 05:36:04 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170227134202.2991-1-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d10fe946-b664-48cf-2a0f-cffd902b0d25@redhat.com>
Date: Wed, 3 May 2017 14:36:00 +0200
MIME-Version: 1.0
In-Reply-To: <20170227134202.2991-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 00/21] chardev clean-ups & tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org



On 27/02/2017 14:41, Marc-André Lureau wrote:
> Hi,
> 
> The following series contains various patches:
> - replace "chardevs" list for a /chardevs container object
> - add a few read-only socket properties mainly useful for testing
> - some chardev related clean-ups
> - add various chardev tests
> 
> This series is part of a larger refactoring series that I try to keep
> up to date here: https://github.com/elmarco/qemu/commits/chrfe
> 
> v2:
> - replaced root container unref with a TODO
> - call object_unparent() directly instead of qemu_chr_delete()
> - remove bad qcow2 NULL check removal
> - rebased

Nice, thanks!

> Marc-André Lureau (21):
>   char: remove qemu_chr_be_generic_open
>   mux: simplfy muxes_realize_done
>   xen: use a better chardev type check
>   container: don't leak container reference
>   char: add a /chardevs container
>   vl: add todo note about root container cleanup
>   char: use /chardevs container instead of chardevs list
>   char: remove qemu_chardev_add
>   char: remove chardevs list
>   char: useless NULL check
>   char-socket: introduce update_disconnected_filename()
>   char-socket: update local address after listen
>   char-socket: add 'addr' property
>   char-socket: add 'connected' property
>   char-udp: flush as much buffer as possible
>   tests: add alias check in /char/ringbuf
>   tests: add /char/pipe test
>   tests: add /char/file test
>   tests: add /char/socket test
>   tests: add /char/udp test
>   tests: add /char/console test
> 
>  chardev/char-mux.h          |   2 +-
>  include/sysemu/char.h       |  10 --
>  chardev/char-mux.c          |  11 +-
>  chardev/char-pty.c          |   2 +-
>  chardev/char-socket.c       |  46 +++++-
>  chardev/char-udp.c          |  26 ++--
>  chardev/char.c              | 155 +++++++++----------
>  gdbstub.c                   |   4 +-
>  hw/usb/ccid-card-passthru.c |   2 +-
>  hw/usb/redirect.c           |   2 +-
>  net/vhost-user.c            |   2 +-
>  qom/container.c             |   1 +
>  tests/test-char.c           | 366 +++++++++++++++++++++++++++++++++++++++++++-
>  tests/vhost-user-test.c     |   2 +-
>  ui/console.c                |   2 +-
>  ui/gtk.c                    |   2 +-
>  vl.c                        |   1 +
>  xen-common.c                |   2 +-
>  18 files changed, 511 insertions(+), 127 deletions(-)
> 
