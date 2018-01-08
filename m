Received: from eggs.gnu.org ([2001:4830:134:3::10]:46846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eYcXy-0005oJ-Mt
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 13:53:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eYcXv-0005D4-LK
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 13:53:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1eYcXv-0005CD-4c
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 13:53:19 -0500
References: <20180108180231.21122-1-f4bug@amsat.org>
	<20180108180231.21122-8-f4bug@amsat.org>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <95617429-0143-14e9-6263-cc46d708f1a2@redhat.com>
Date: Mon, 8 Jan 2018 20:53:09 +0200
MIME-Version: 1.0
In-Reply-To: <20180108180231.21122-8-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 7/7] i386/pc: use the QEMU_ALIGNED() macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowang@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>, Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

On 08/01/2018 20:02, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>   hw/i386/pc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 3fcf318a95..85d9454c71 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -93,12 +93,12 @@ struct e820_entry {
>       uint64_t address;
>       uint64_t length;
>       uint32_t type;
> -} QEMU_PACKED __attribute((__aligned__(4)));
> +} QEMU_PACKED QEMU_ALIGNED(4);
>  =20
>   struct e820_table {
>       uint32_t count;
>       struct e820_entry entry[E820_NR_ENTRIES];
> -} QEMU_PACKED __attribute((__aligned__(4)));
> +} QEMU_PACKED QEMU_ALIGNED(4);
>  =20
>   static struct e820_table e820_reserve;
>   static struct e820_entry *e820_table;
>=20

Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>

Thanks,
Marcel
