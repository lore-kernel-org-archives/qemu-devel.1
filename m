Received: from eggs.gnu.org ([209.51.188.92]:54433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ghuiX-0000jn-Er
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 06:11:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ghuiW-0003YY-P6
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 06:11:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ghuiW-0003Vd-JN
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 06:11:12 -0500
Date: Fri, 11 Jan 2019 12:04:33 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190111120433.5685f2b1.cohuck@redhat.com>
In-Reply-To: <20190110180458.18762-3-ehabkost@redhat.com>
References: <20190110180458.18762-1-ehabkost@redhat.com>
	<20190110180458.18762-3-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/2] virtio: Make
 disable-legacy/disable-modern compat properties optional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, "Dr.
	David Alan Gilbert" <dgilbert@redhat.com>

On Thu, 10 Jan 2019 16:04:58 -0200
Eduardo Habkost <ehabkost@redhat.com> wrote:

> The disable-legacy and disable-modern properties apply only to
> some virtio-pci devices.  Make those properties optional.
> 
> This fixes the crash introduced by commit f6e501a28ef9 ("virtio: Provide
> version-specific variants of virtio PCI devices"):
> 
>   $ qemu-system-x86_64 -machine pc-i440fx-2.6 \
>     -device virtio-net-pci-non-transitional
>   Unexpected error in object_property_find() at qom/object.c:1092:
>   qemu-system-x86_64: -device virtio-net-pci-non-transitional: can't apply \
>   global virtio-pci.disable-modern=on: Property '.disable-modern' not found
>   Aborted (core dumped)
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Fixes: f6e501a28ef9 ("virtio: Provide version-specific variants of virtio PCI devices")
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  hw/core/machine.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
