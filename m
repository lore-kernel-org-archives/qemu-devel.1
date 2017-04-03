Received: from eggs.gnu.org ([2001:4830:134:3::10]:55620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cv1YP-0001xZ-UP
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:57:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cv1YM-0005xH-2a
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:57:54 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:35941)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cv1YL-0005wl-VY
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:57:50 -0400
Received: by mail-qk0-x244.google.com with SMTP id r140so7889391qke.3
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 05:57:49 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1491034725-23968-1-git-send-email-peterx@redhat.com>
	<1491034725-23968-2-git-send-email-peterx@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <998cd006-532d-513c-38d1-6b0a638b1850@amsat.org>
Date: Mon, 3 Apr 2017 09:57:45 -0300
MIME-Version: 1.0
In-Reply-To: <1491034725-23968-2-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 1/4] migration: set current_active_state
 once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

On 04/01/2017 05:18 AM, Peter Xu wrote:
> We set it right above this one. No need to set it twice.
>
> CC: Juan Quintela <quintela@redhat.com>
> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  migration/migration.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 54060f7..f9f4d98 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1938,7 +1938,6 @@ static void *migration_thread(void *opaque)
>      qemu_savevm_state_begin(s->to_dst_file, &s->params);
>
>      s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;
> -    current_active_state = MIGRATION_STATUS_ACTIVE;
>      migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
>                        MIGRATION_STATUS_ACTIVE);
>
>
