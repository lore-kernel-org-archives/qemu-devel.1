Received: from eggs.gnu.org ([209.51.188.92]:39209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ggsV0-00078w-RV
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 09:36:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ggsV0-0008L4-4a
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 09:36:58 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44255)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ggsUz-0008BI-Ud
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 09:36:58 -0500
Received: by mail-wr1-f67.google.com with SMTP id z5so4236740wrt.11
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 06:36:54 -0800 (PST)
References: <20190107193020.21744-1-ehabkost@redhat.com>
	<20190107193020.21744-3-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <11e0ba89-3cb2-1563-8f66-ae68ef2d1b63@redhat.com>
Date: Tue, 8 Jan 2019 15:36:51 +0100
MIME-Version: 1.0
In-Reply-To: <20190107193020.21744-3-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/3] machine: Eliminate unnecessary
 stringify() usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, xen-devel@lists.xenproject.org, Richard Henderson <rth@twiddle.net>

On 1/7/19 8:30 PM, Eduardo Habkost wrote:
> stringify() is useful when we need to use macros in compat_props
> (like when we set virtio-baloon-pci.class=PCI_CLASS_MEMORY_RAM at
> pc_i440fx_1_0_machine_options()), but it is pointless when we are
> already providing a number literal.
> 
> Replace stringify() with string literals when appropriate.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  hw/core/machine.c |  8 ++--
>  hw/i386/pc.c      | 94 +++++++++++++++++++++++------------------------
>  hw/i386/pc_piix.c | 30 +++++++--------
>  hw/ppc/spapr.c    |  2 +-
>  4 files changed, 67 insertions(+), 67 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index f8563efb86..4b4d6c23de 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -135,11 +135,11 @@ GlobalProperty hw_compat_2_8[] = {
>      {
>          .driver   = "fw_cfg_mem",
>          .property = "x-file-slots",
> -        .value    = stringify(0x10),
> +        .value    = "0x10",
[...]

Lovely.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
