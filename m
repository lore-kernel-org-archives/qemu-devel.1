Received: from eggs.gnu.org ([2001:4830:134:3::10]:57918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffvPC-0003ec-EK
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 18:58:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffvPB-0004Ds-OT
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 18:58:46 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1531927703-9799-1-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <89aeaf53-2f6b-e22e-d499-78dd19f3abff@amsat.org>
Date: Wed, 18 Jul 2018 19:58:41 -0300
MIME-Version: 1.0
In-Reply-To: <1531927703-9799-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] block/vvfat: Fix crash when reporting
 error about too many files in directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

On 07/18/2018 12:28 PM, Thomas Huth wrote:
> When using the vvfat driver with a directory that contains too many files,
> QEMU currently crashes. We are trying to print the wrong path variable here.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  block/vvfat.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/block/vvfat.c b/block/vvfat.c
> index fc41841..6ae7458 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -975,8 +975,7 @@ static int init_directories(BDRVVVFATState* s,
>          if (mapping->mode & MODE_DIRECTORY) {
>              mapping->begin = cluster;
>              if(read_directory(s, i)) {
> -                error_setg(errp, "Could not read directory %s",
> -                           mapping->path);
> +                error_setg(errp, "Could not read directory \"%s\"", s->path);
>                  return -1;
>              }
>              mapping = array_get(&(s->mapping), i);
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
