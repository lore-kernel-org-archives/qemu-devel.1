Received: from eggs.gnu.org ([2001:4830:134:3::10]:39066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dn6j4-0004si-OT
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:24:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dn6j3-0008Mn-QK
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:24:26 -0400
Date: Wed, 30 Aug 2017 14:24:13 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170830172413.GA9720@localhost.localdomain>
References: <cover.1504112256.git.jcody@redhat.com>
	<fc2539281a00353777c10f37dea6ccdb6aae4285.1504112256.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc2539281a00353777c10f37dea6ccdb6aae4285.1504112256.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/3] block-jobs: Optionally unregister
 live block operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, dgilbert@redhat.com, mrezanin@redhat.com, peterx@redhat.com, jsnow@redhat.com, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>

On Wed, Aug 30, 2017 at 01:01:41PM -0400, Jeff Cody wrote:
> From: Jeffrey Cody <jcody@redhat.com>
> 
> If configured without live block operations enabled, unregister the
> live block operation commands.
> 
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  monitor.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/monitor.c b/monitor.c
> index e0f8801..de0a70e 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -998,6 +998,22 @@ static void qmp_unregister_commands_hack(void)
>      && !defined(TARGET_S390X)
>      qmp_unregister_command(&qmp_commands, "query-cpu-definitions");
>  #endif
> +#ifndef CONFIG_LIVE_BLOCK_OPS
> +    qmp_unregister_command(&qmp_commands, "block-stream");
> +    qmp_unregister_command(&qmp_commands, "block-commit");
> +    qmp_unregister_command(&qmp_commands, "drive-mirror");
> +    qmp_unregister_command(&qmp_commands, "blockdev-mirror");
> +    qmp_unregister_command(&qmp_commands, "drive-backup");
> +    qmp_unregister_command(&qmp_commands, "blockdev-backup");
> +    qmp_unregister_command(&qmp_commands, "blockdev-snapshot");
> +    qmp_unregister_command(&qmp_commands, "blockdev-snapshot-sync");
> +    qmp_unregister_command(&qmp_commands, "block-job-set-speed");
> +    qmp_unregister_command(&qmp_commands, "block-job-cancel");
> +    qmp_unregister_command(&qmp_commands, "block-job-pause");
> +    qmp_unregister_command(&qmp_commands, "block-job-resume");
> +    qmp_unregister_command(&qmp_commands, "block-job-complete");
> +    qmp_unregister_command(&qmp_commands, "query-block-jobs");
> +#endif

I suggest using the new mechanisms added by:

  [PATCH 00/26] qapi: add #if pre-processor conditions to generated code

-- 
Eduardo
