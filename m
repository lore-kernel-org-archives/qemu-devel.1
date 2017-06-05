Received: from eggs.gnu.org ([2001:4830:134:3::10]:33008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dI0PI-0008RC-OW
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 18:23:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dI0PI-0007Kb-1G
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 18:23:28 -0400
References: <20170511022036.32225-1-eblake@redhat.com>
	<20170511022036.32225-10-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <820d73f3-7b3f-83f2-d418-cdec96e665d8@redhat.com>
Date: Mon, 5 Jun 2017 18:23:17 -0400
MIME-Version: 1.0
In-Reply-To: <20170511022036.32225-10-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 09/20] mirror: Update signature of
 mirror_clip_sectors()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>



On 05/10/2017 10:20 PM, Eric Blake wrote:
> Rather than having a void function that modifies its input
> in-place as the output, change the signature to reduce a layer
> of indirection and return the result.
> 
> Suggested-by: John Snow <jsnow@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 

Reviewed-by: John Snow <jsnow@redhat.com>

> ---
> v2: new patch
> ---
>  block/mirror.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
