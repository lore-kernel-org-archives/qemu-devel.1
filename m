Received: from eggs.gnu.org ([2001:4830:134:3::10]:57104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gHS7A-0008Rd-B9
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 07:23:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gHS75-0000Lk-SR
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 07:23:15 -0400
References: <20181030111348.14713-1-kraxel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1dc8c78c-03b7-80f1-b815-d197fa5501cc@redhat.com>
Date: Tue, 30 Oct 2018 12:22:50 +0100
MIME-Version: 1.0
In-Reply-To: <20181030111348.14713-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/4] Introducing QemuSupportState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>

On 30/10/2018 12:13, Gerd Hoffmann wrote:
> Trying to fill the need to be more finegrained on support status ...
> 
> Any hints/patches how to hook that into introspection so we get
> machine type / device support status to libvirt are welcome.

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

> Gerd Hoffmann (4):
>   add QemuSupportState
>   add QemuSupportState to DeviceClass
>   tag cirrus as obsolete
>   switch machine types to QemuSupportState
> 
>  include/hw/boards.h          |  5 ++---
>  include/hw/qdev-core.h       |  2 ++
>  include/qemu/support-state.h | 17 +++++++++++++++++
>  hw/core/qdev.c               |  8 +++++++-
>  hw/display/cirrus_vga.c      |  3 +++
>  hw/display/cirrus_vga_isa.c  |  3 +++
>  hw/i386/pc_piix.c            |  3 ++-
>  hw/ppc/prep.c                |  3 ++-
>  qdev-monitor.c               |  7 +++++++
>  util/support-state.c         | 23 +++++++++++++++++++++++
>  vl.c                         |  6 +++---
>  qapi/common.json             | 16 ++++++++++++++++
>  util/Makefile.objs           |  1 +
>  13 files changed, 88 insertions(+), 9 deletions(-)
>  create mode 100644 include/qemu/support-state.h
>  create mode 100644 util/support-state.c
> 
