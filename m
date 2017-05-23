Received: from eggs.gnu.org ([2001:4830:134:3::10]:39775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dD1Lj-0000u7-Ef
	for qemu-devel@nongnu.org; Tue, 23 May 2017 00:23:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dD1Li-0001X4-Bi
	for qemu-devel@nongnu.org; Tue, 23 May 2017 00:23:11 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170522211205.14265-1-hpoussin@reactos.org>
	<20170522211205.14265-14-hpoussin@reactos.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <75ccc442-1a32-bf36-3674-ec69ce944213@amsat.org>
Date: Tue, 23 May 2017 01:23:00 -0300
MIME-Version: 1.0
In-Reply-To: <20170522211205.14265-14-hpoussin@reactos.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 13/13] vvfat: change OEM name to
 'MSWIN4.1'
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

Hi Hervé,

On 05/22/2017 06:12 PM, Hervé Poussineau wrote:
> According to specification:
> "'MSWIN4.1' is the recommanded setting, because it is the setting least likely
> to cause compatibility problems. If you want to put something else in here,
> that is your option, but the result may be that some FAT drivers might not
> recognize the volume."

It also says "Typically this is some indication of what system formatted
the volume."

 From https://technet.microsoft.com/en-us/library/cc976796.aspx:

"Following the jump instruction is the 8-byte OEM ID, a string of 
characters that identifies the name and version number of the operating 
system that formatted the volume. To preserve compatibility with MS-DOS, 
Windows 2000 records "MSDOS5.0" in this field on FAT16 and FAT32 disks. 
On NTFS disks, Windows 2000 records "NTFS."
You may also see the OEM ID "MSWIN4.0" on disks formatted by Windows 95 
and "MSWIN4.1" on disks formatted by Windows 95 OSR2 and Windows 98. 
Windows 2000 does not use the OEM ID field in the boot sector except for 
verifying NTFS volumes."

I'm curious which one is the most up-to-date, the specification v1.03 or 
a Windows 2000. Do you have an idea if there is more MSDOS/W2K vs W95/98 
users? Hopefully W95 is a Long time no see to me.

You think having "QEMU" OEM does more harm than good?

>
> Specification: "FAT: General overview of on-disk format" v1.03, page 9
> Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
> ---
>  block/vvfat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block/vvfat.c b/block/vvfat.c
> index 53e8faa54c..1f7f46ecea 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -1024,7 +1024,7 @@ static int init_directories(BDRVVVFATState* s,
>      bootsector->jump[0]=0xeb;
>      bootsector->jump[1]=0x3e;
>      bootsector->jump[2]=0x90;
> -    memcpy(bootsector->name,"QEMU    ",8);
> +    memcpy(bootsector->name, "MSWIN4.1", 8);
>      bootsector->sector_size=cpu_to_le16(0x200);
>      bootsector->sectors_per_cluster=s->sectors_per_cluster;
>      bootsector->reserved_sectors=cpu_to_le16(1);
>

Regards,

Phil.
