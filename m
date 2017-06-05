Received: from eggs.gnu.org ([2001:4830:134:3::10]:53415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dHyOS-00023o-55
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 16:14:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dHyOR-000055-8H
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 16:14:28 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1496682098-1540-1-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a627c97e-3529-95b9-2672-49abad94cb75@amsat.org>
Date: Mon, 5 Jun 2017 17:14:17 -0300
MIME-Version: 1.0
In-Reply-To: <1496682098-1540-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] block/gluster.c: Handle
 qdict_array_entries() failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, patches@linaro.org

On 06/05/2017 02:01 PM, Peter Maydell wrote:
> In qemu_gluster_parse_json(), the call to qdict_array_entries()
> could return a negative error code, which we were ignoring
> because we assigned the result to an unsigned variable.
> Fix this by using the 'int' type instead, which matches the
> return type of qdict_array_entries() and also the type
> we use for the loop enumeration variable 'i'.
>
> (Spotted by Coverity, CID 1360960.)
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  block/gluster.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/block/gluster.c b/block/gluster.c
> index 031596a..addceed 100644
> --- a/block/gluster.c
> +++ b/block/gluster.c
> @@ -493,8 +493,7 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
>      Error *local_err = NULL;
>      char *str = NULL;
>      const char *ptr;
> -    size_t num_servers;
> -    int i, type;
> +    int i, type, num_servers;
>
>      /* create opts info from runtime_json_opts list */
>      opts = qemu_opts_create(&runtime_json_opts, NULL, 0, &error_abort);
>
