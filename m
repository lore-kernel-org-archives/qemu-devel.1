Received: from eggs.gnu.org ([2001:4830:134:3::10]:41172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eZEss-0003Iy-QO
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 06:49:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eZEsp-0000Tp-OP
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 06:49:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35890)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eZEsp-0000TV-IP
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 06:49:27 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6FC3FC04AC47
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 11:49:26 +0000 (UTC)
Date: Wed, 10 Jan 2018 11:49:18 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180110114917.GA2450@work-vm>
References: <20180105215246.908-1-quintela@redhat.com>
	<20180105215246.908-5-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180105215246.908-5-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 04/11] tests: Use consistent names and
 sizes for migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  tests/migration-test.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index d81f22118b..f469235d0b 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -440,13 +440,13 @@ static void test_migrate_start(QTestState **from, QTestState **to,
>  
>      if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
>          init_bootfile_x86(bootpath);
> -        cmd_src = g_strdup_printf("-machine accel=%s -m 150M"
> -                                  " -name pcsource,debug-threads=on"
> +        cmd_src = g_strdup_printf("-machine accel=%s -m 256M"
> +                                  " -name source,debug-threads=on"
>                                    " -serial file:%s/src_serial"
>                                    " -drive file=%s,format=raw",
>                                    accel, tmpfs, bootpath);
> -        cmd_dst = g_strdup_printf("-machine accel=%s -m 150M"
> -                                  " -name pcdest,debug-threads=on"
> +        cmd_dst = g_strdup_printf("-machine accel=%s -m 256M"
> +                                  " -name target,debug-threads=on"
>                                    " -serial file:%s/dest_serial"
>                                    " -drive file=%s,format=raw"
>                                    " -incoming %s",
> @@ -459,12 +459,12 @@ static void test_migrate_start(QTestState **from, QTestState **to,
>          }
>          init_bootfile_ppc(bootpath);
>          cmd_src = g_strdup_printf("-machine accel=%s -m 256M"
> -                                  " -name pcsource,debug-threads=on"
> +                                  " -name source,debug-threads=on"
>                                    " -serial file:%s/src_serial"
>                                    " -drive file=%s,if=pflash,format=raw",
>                                    accel, tmpfs, bootpath);
>          cmd_dst = g_strdup_printf("-machine accel=%s -m 256M"
> -                                  " -name pcdest,debug-threads=on"
> +                                  " -name target,debug-threads=on"
>                                    " -serial file:%s/dest_serial"
>                                    " -drive file=%s,if=pflash,format=raw"
>                                    " -incoming %s",

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

(I'm OK with increasing the RAM size but we don't need to, some may find
it a bit wasteful in tests, but it's only 106M extra)

> -- 
> 2.14.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
