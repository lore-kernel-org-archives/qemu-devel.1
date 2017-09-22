Received: from eggs.gnu.org ([2001:4830:134:3::10]:55205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dvQTx-0002uR-Ch
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:07:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dvQTw-0003Qo-Bi
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:07:13 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:56333)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dvQTw-0003Q8-6E
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:07:12 -0400
Received: by mail-wr0-x233.google.com with SMTP id r74so1280683wrb.13
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 09:07:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170922154014.29350-2-f4bug@amsat.org>
References: <20170922154014.29350-1-f4bug@amsat.org>
	<20170922154014.29350-2-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Sep 2017 17:06:50 +0100
Message-ID: <CAFEAcA9L2LL-aKFVJGCwe3QJdGsftKBcVNXSYnEG7gFy22cfEQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/34] hw: use "qemu/osdep.h" as first
 #include in source files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>

On 22 September 2017 at 16:39, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
> applied using ./scripts/clean-includes
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/acpi/ipmi-stub.c             | 1 +
>  hw/audio/fmopl.c                | 1 -
>  hw/cpu/core.c                   | 1 +
>  hw/ppc/spapr_cpu_core.c         | 1 +
>  hw/smbios/smbios_type_38-stub.c | 1 +
>  hw/vfio/ccw.c                   | 2 +-
>  hw/virtio/vhost-vsock.c         | 2 +-
>  7 files changed, 6 insertions(+), 3 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
