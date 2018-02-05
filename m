Received: from eggs.gnu.org ([2001:4830:134:3::10]:34970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eilvr-0000LY-6q
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 13:56:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eilvq-0002n3-AH
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 13:55:59 -0500
References: <20180205162745.23650-1-mreitz@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <e8d5d6d2-970c-84f4-bc93-c42e0c69e289@redhat.com>
Date: Mon, 5 Feb 2018 13:55:49 -0500
MIME-Version: 1.0
In-Reply-To: <20180205162745.23650-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] qemu-img: Make resize error
 message more general
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org



On 02/05/2018 11:27 AM, Max Reitz wrote:
> The issue:
> 
>   $ qemu-img resize -f qcow2 foo.qcow2
>   qemu-img: Expecting one image file name
>   Try 'qemu-img --help' for more information
> 
> So we gave an image file name, but we omitted the length.  qemu-img
> thinks the last argument is always the size and removes it immediately
> from argv (by decrementing argc), and tries to verify that it is a valid
> size only at a later point.
> 
> So we do not actually know whether that last argument we called "size"
> is indeed a size or whether the user instead forgot to specify that size
> but did give a file name.
> 
> Therefore, the error message should be more general.
> 
> Bug: https://bugzilla.redhat.com/show_bug.cgi?id=1523458
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  qemu-img.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/qemu-img.c b/qemu-img.c
> index 68b375f998..2753b63514 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -3468,7 +3468,7 @@ static int img_resize(int argc, char **argv)
>          }
>      }
>      if (optind != argc - 1) {
> -        error_exit("Expecting one image file name");
> +        error_exit("Expecting image file name and size");
>      }
>      filename = argv[optind++];
>  
> 

Sounds good to me.

Reviewed-by: John Snow <jsnow@redhat.com>
