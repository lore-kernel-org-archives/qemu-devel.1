Received: from eggs.gnu.org ([2001:4830:134:3::10]:41290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cvrUg-0000ar-Gn
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 16:25:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cvrUf-0004bC-IW
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 16:25:30 -0400
References: <cover.1491416061.git.jcody@redhat.com>
	<91ebd19aec29055c98e4658ed5cf3fb50720afe5.1491416061.git.jcody@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <58745f14-b07b-a94d-3854-c15d30a51d7e@redhat.com>
Date: Wed, 5 Apr 2017 16:25:18 -0400
MIME-Version: 1.0
In-Reply-To: <91ebd19aec29055c98e4658ed5cf3fb50720afe5.1491416061.git.jcody@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.10 4/9] block: code movement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org



On 04/05/2017 02:28 PM, Jeff Cody wrote:
> Move bdrv_is_read_only() up with its friends.
> 
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  block.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/block.c b/block.c
> index 4a61ff0..8bfe7f4 100644
> --- a/block.c
> +++ b/block.c
> @@ -192,6 +192,11 @@ void path_combine(char *dest, int dest_size,
>      }
>  }
>  
> +bool bdrv_is_read_only(BlockDriverState *bs)
> +{
> +    return bs->read_only;
> +}
> +
>  int bdrv_set_read_only(BlockDriverState *bs, bool read_only, Error **errp)
>  {
>      /* Do not set read_only if copy_on_read is enabled */
> @@ -3367,11 +3372,6 @@ void bdrv_get_geometry(BlockDriverState *bs, uint64_t *nb_sectors_ptr)
>      *nb_sectors_ptr = nb_sectors < 0 ? 0 : nb_sectors;
>  }
>  
> -bool bdrv_is_read_only(BlockDriverState *bs)
> -{
> -    return bs->read_only;
> -}
> -
>  bool bdrv_is_sg(BlockDriverState *bs)
>  {
>      return bs->sg;
> 

http://i.imgur.com/BrkMeS5.jpg
