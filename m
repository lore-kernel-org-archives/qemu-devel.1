Received: from eggs.gnu.org ([2001:4830:134:3::10]:52292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dWUT2-0007a4-6V
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 17:19:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dWUT1-0000lj-5w
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 17:19:12 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170715132841.9865-1-hpoussin@reactos.org>
	<20170715132841.9865-3-hpoussin@reactos.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f8e135c8-2fd1-4ded-1a30-da1c9c8fe8f0@amsat.org>
Date: Sat, 15 Jul 2017 18:19:00 -0300
MIME-Version: 1.0
In-Reply-To: <20170715132841.9865-3-hpoussin@reactos.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/4] vvfat: add a constant for bootsector
 name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 07/15/2017 10:28 AM, Hervé Poussineau wrote:
> Also add links to related compatibility problems.
> 
> Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   block/vvfat.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/block/vvfat.c b/block/vvfat.c
> index c2674d7703..e585a8e0be 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -71,6 +71,12 @@ void nonono(const char* file, int line, const char* msg) {
>   
>   #endif
>   
> +/* bootsector OEM name. see related compatibility problems at:
> + * https://jdebp.eu/FGA/volume-boot-block-oem-name-field.html
> + * http://seasip.info/Misc/oemid.html
> + */
> +#define BOOTSECTOR_OEM_NAME "MSWIN4.1"
> +
>   #define DIR_DELETED 0xe5
>   #define DIR_KANJI DIR_DELETED
>   #define DIR_KANJI_FAKE 0x05
> @@ -1028,7 +1034,7 @@ static int init_directories(BDRVVVFATState* s,
>       bootsector->jump[0]=0xeb;
>       bootsector->jump[1]=0x3e;
>       bootsector->jump[2]=0x90;
> -    memcpy(bootsector->name, "MSWIN4.1", 8);
> +    memcpy(bootsector->name, BOOTSECTOR_OEM_NAME, 8);
>       bootsector->sector_size=cpu_to_le16(0x200);
>       bootsector->sectors_per_cluster=s->sectors_per_cluster;
>       bootsector->reserved_sectors=cpu_to_le16(1);
> 
