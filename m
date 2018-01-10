Received: from eggs.gnu.org ([2001:4830:134:3::10]:55409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eZ9ph-0006BJ-BV
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 01:25:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eZ9pe-00013P-8N
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 01:25:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43276)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eZ9pe-00012g-2V
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 01:25:50 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0D0748553E
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 06:25:49 +0000 (UTC)
Date: Wed, 10 Jan 2018 14:25:45 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180110062545.GB5984@xz-mi>
References: <20180105215246.908-1-quintela@redhat.com>
	<20180105215246.908-3-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180105215246.908-3-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 02/11] tests: Migration ppc test was
 missing arguments
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

On Fri, Jan 05, 2018 at 10:52:37PM +0100, Juan Quintela wrote:
> Argument file is also needed there.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

Does it also mean this?

Fixes: aaf89c8a49a8c ("test: port postcopy test to ppc64")

> ---
>  tests/migration-test.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index 0448bc77dc..32f3bb86a8 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -464,8 +464,9 @@ static void test_migrate_start(QTestState **from, QTestState **to,
>          cmd_dst = g_strdup_printf("-machine accel=%s -m 256M"
>                                    " -name pcdest,debug-threads=on"
>                                    " -serial file:%s/dest_serial"
> +                                  " -drive file=%s,if=pflash,format=raw"
>                                    " -incoming %s",
> -                                  accel, tmpfs, uri);
> +                                  accel, tmpfs, bootpath, uri);
>      } else {
>          g_assert_not_reached();
>      }
> -- 
> 2.14.3
> 

-- 
Peter Xu
