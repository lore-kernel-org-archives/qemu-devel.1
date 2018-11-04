Received: from eggs.gnu.org ([2001:4830:134:3::10]:49483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1gJLHl-00009K-T6
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 11:30:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1gJLHk-0001py-UM
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 11:30:01 -0500
References: <20181103014831.29889-1-lbloch@janustech.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <ef076659-6aee-ad66-c95f-01964a03b5f5@weilnetz.de>
Date: Sun, 4 Nov 2018 17:28:33 +0100
MIME-Version: 1.0
In-Reply-To: <20181103014831.29889-1-lbloch@janustech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vdi: Use a literal number of bytes for
 DEFAULT_CLUSTER_SIZE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

On 03.11.18 02:48, Leonid Bloch wrote:
> If an expression is used to define DEFAULT_CLUSTER_SIZE, when compiled,
> it will be embedded as a literal expression in the binary (as the
> default value) because it is stringified to mark the size of the default
> value. Now this is fixed by using a defined number to define this value.
> 
> Signed-off-by: Leonid Bloch <lbloch@janustech.com>
> ---
>  block/vdi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/vdi.c b/block/vdi.c
> index 6555cffb88..25320eff47 100644
> --- a/block/vdi.c
> +++ b/block/vdi.c
> @@ -85,7 +85,7 @@
>  #define BLOCK_OPT_STATIC "static"
>  
>  #define SECTOR_SIZE 512
> -#define DEFAULT_CLUSTER_SIZE (1 * MiB)
> +#define DEFAULT_CLUSTER_SIZE S_1MiB

This changes the data type, so a fix is needed for a format string in
line 434.

Regards
Stefan
