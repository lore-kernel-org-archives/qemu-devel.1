Received: from eggs.gnu.org ([2001:4830:134:3::10]:43365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d2iZj-0004CX-Ag
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 14:19:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d2iZh-0004U0-4k
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 14:19:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:4033)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d2iZg-0004Pr-UN
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 14:19:01 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1492850128-17472-5-git-send-email-zhang.zhanghailiang@huawei.com>
	(zhanghailiang's message of "Sat, 22 Apr 2017 16:35:14 +0800")
References: <1492850128-17472-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1492850128-17472-5-git-send-email-zhang.zhanghailiang@huawei.com>
Reply-To: quintela@redhat.com
Date: Mon, 24 Apr 2017 20:18:55 +0200
Message-ID: <87tw5doei8.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RESEND v2 04/18] COLO: integrate colo
 compare with colo frame
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, zhangchen.fnst@cn.fujitsu.com, Jason Wang <jasowang@redhat.com>

zhanghailiang <zhang.zhanghailiang@huawei.com> wrote:
> For COLO FT, both the PVM and SVM run at the same time,
> only sync the state while it needs.
>
> So here, let SVM runs while not doing checkpoint, change
> DEFAULT_MIGRATE_X_CHECKPOINT_DELAY to 200*100.
>
> Besides, we forgot to release colo_checkpoint_semd and
> colo_delay_timer, fix them here.
>
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

....

> diff --git a/migration/migration.c b/migration/migration.c
> index 353f272..2ade2aa 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -70,7 +70,7 @@
>  /* The delay time (in ms) between two COLO checkpoints
>   * Note: Please change this default value to 10000 when we support hybrid mode.
>   */
> -#define DEFAULT_MIGRATE_X_CHECKPOINT_DELAY 200
> +#define DEFAULT_MIGRATE_X_CHECKPOINT_DELAY (200 * 100)
>  
>  static NotifierList migration_state_notifiers =
>      NOTIFIER_LIST_INITIALIZER(migration_state_notifiers);

1000 or 200 * 100

Please, fix value or comment?

Later, Juan.
