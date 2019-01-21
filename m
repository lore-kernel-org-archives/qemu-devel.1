Received: from eggs.gnu.org ([209.51.188.92]:39024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gld6z-0002Ek-GW
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:11:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gld1A-0004eY-Ja
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:05:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gld1A-0004eG-DK
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:05:48 -0500
Date: Mon, 21 Jan 2019 15:05:41 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190121170541.GN4136@habkost.net>
References: <20190118120143.21631-1-sgarzare@redhat.com>
	<20190118120143.21631-5-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118120143.21631-5-sgarzare@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 4/5] hw/i386/pc: use PVH option rom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, George Kennedy <george.kennedy@oracle.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Maran Wilson <maran.wilson@oracle.com>, Liam Merwick <liam.merwick@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Richard Henderson <rth@twiddle.net>, Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Fri, Jan 18, 2019 at 01:01:42PM +0100, Stefano Garzarella wrote:
> Use pvh.bin option rom when we are booting an uncompressed
> kernel using the x86/HVM direct boot ABI.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
> ---
>  hw/i386/pc.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 9ed5063de8..2833b130ba 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1252,6 +1252,10 @@ static void load_linux(PCMachineState *pcms,
>                                   initrd_size);
>              }
>  
> +            option_rom[nb_option_roms].bootindex = 0;
> +            option_rom[nb_option_roms].name = "pvh.bin";
> +            nb_option_roms++;
> +

We still need to address Michael's comment from v2 about
machine-type compatibility:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg587489.html

A question I've sent is quoted below:

| On Tue, Jan 15, 2019 at 01:57:22PM -0500, Michael S. Tsirkin wrote:
| > OK but this is guest visible so needs to be guarded by the
| > new machine type.
| 
| Aren't option ROMs treated like other firmware?  i.e.: guest
| visible, but copied during live migration and not considered part
| of guest ABI.


-- 
Eduardo
