Received: from eggs.gnu.org ([2001:4830:134:3::10]:56507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eZ9uB-0007dh-MJ
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 01:30:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eZ9u8-0004Zi-AB
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 01:30:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eZ9u7-0004Z4-V8
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 01:30:28 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0561725BB8
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 06:30:27 +0000 (UTC)
Date: Wed, 10 Jan 2018 14:30:22 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180110063022.GC5984@xz-mi>
References: <20180105215246.908-1-quintela@redhat.com>
	<20180105215246.908-5-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com

On Fri, Jan 05, 2018 at 10:52:39PM +0100, Juan Quintela wrote:
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

A pure question: when will the name matter?

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
> -- 
> 2.14.3
> 

-- 
Peter Xu
