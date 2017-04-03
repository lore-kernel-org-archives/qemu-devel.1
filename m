Received: from eggs.gnu.org ([2001:4830:134:3::10]:56553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cv1aD-0003Ss-Lu
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:59:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cv1a9-00078V-Po
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:59:45 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:36604)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cv1a9-00077y-LQ
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:59:41 -0400
Received: by mail-qt0-x243.google.com with SMTP id n37so18726235qtb.3
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 05:59:41 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1491034725-23968-1-git-send-email-peterx@redhat.com>
	<1491034725-23968-4-git-send-email-peterx@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1215273a-1811-f307-d331-51c6d839412e@amsat.org>
Date: Mon, 3 Apr 2017 09:59:37 -0300
MIME-Version: 1.0
In-Reply-To: <1491034725-23968-4-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 3/4] hmp: info migrate_capability format
 tunes
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
> Dump the info in a single line is hard to read. Do it one per line.
> Also, the first "capabilities:" didn't help much. Let's remove it.
>
> CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Reviewed-by: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hmp.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/hmp.c b/hmp.c
> index edb8970..95eef8c 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -265,13 +265,11 @@ void hmp_info_migrate_capabilities(Monitor *mon, const QDict *qdict)
>      caps = qmp_query_migrate_capabilities(NULL);
>
>      if (caps) {
> -        monitor_printf(mon, "capabilities: ");
>          for (cap = caps; cap; cap = cap->next) {
> -            monitor_printf(mon, "%s: %s ",
> +            monitor_printf(mon, "%s: %s\n",
>                             MigrationCapability_lookup[cap->value->capability],
>                             cap->value->state ? "on" : "off");
>          }
> -        monitor_printf(mon, "\n");
>      }
>
>      qapi_free_MigrationCapabilityStatusList(caps);
>
