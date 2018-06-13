Received: from eggs.gnu.org ([2001:4830:134:3::10]:49585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fT374-00058t-WA
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 06:34:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fT371-0006Pr-Ty
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 06:34:51 -0400
References: <1528867465-26696-1-git-send-email-thuth@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <5f7eaa02-8dc6-9d61-0a30-62d632f6cda3@redhat.com>
Date: Wed, 13 Jun 2018 12:34:45 +0200
MIME-Version: 1.0
In-Reply-To: <1528867465-26696-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] trivial: Make bios files and source files
 non-executable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 13.06.2018 07:24, Thomas Huth wrote:
> These files can not be executed on the host, so they should not be
> marked as executable.

Or can not be executed at all :)

Reviewed-by: David Hildenbrand <david@redhat.com>

> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  block/blkreplay.c                  |   0
>  pc-bios/hppa-firmware.img          | Bin
>  pc-bios/palcode-clipper            | Bin
>  pc-bios/u-boot-sam460-20100605.bin | Bin
>  pc-bios/u-boot.e500                | Bin
>  replay/replay-char.c               |   0
>  6 files changed, 0 insertions(+), 0 deletions(-)
>  mode change 100755 => 100644 block/blkreplay.c
>  mode change 100755 => 100644 pc-bios/hppa-firmware.img
>  mode change 100755 => 100644 pc-bios/palcode-clipper
>  mode change 100755 => 100644 pc-bios/u-boot-sam460-20100605.bin
>  mode change 100755 => 100644 pc-bios/u-boot.e500
>  mode change 100755 => 100644 replay/replay-char.c
> 
> diff --git a/block/blkreplay.c b/block/blkreplay.c
> old mode 100755
> new mode 100644
> diff --git a/pc-bios/hppa-firmware.img b/pc-bios/hppa-firmware.img
> old mode 100755
> new mode 100644
> diff --git a/pc-bios/palcode-clipper b/pc-bios/palcode-clipper
> old mode 100755
> new mode 100644
> diff --git a/pc-bios/u-boot-sam460-20100605.bin b/pc-bios/u-boot-sam460-20100605.bin
> old mode 100755
> new mode 100644
> diff --git a/pc-bios/u-boot.e500 b/pc-bios/u-boot.e500
> old mode 100755
> new mode 100644
> diff --git a/replay/replay-char.c b/replay/replay-char.c
> old mode 100755
> new mode 100644
> 


-- 

Thanks,

David / dhildenb
