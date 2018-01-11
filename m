Received: from eggs.gnu.org ([2001:4830:134:3::10]:36077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eZa9J-0007Ze-O7
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 05:31:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eZa9F-0003LM-RH
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 05:31:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eZa9F-0003L1-KO
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 05:31:49 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9BA19C057FA4
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 10:31:48 +0000 (UTC)
Date: Thu, 11 Jan 2018 10:31:41 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180111103140.GA2669@work-vm>
References: <20180105215246.908-1-quintela@redhat.com>
	<20180105215246.908-10-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180105215246.908-10-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 09/11] tests: Create
 migrate-start-postcopy command
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
> This way, it is like the rest of commands
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  tests/migration-test.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index c25c9dd7b1..70b3c0870b 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -436,6 +436,15 @@ static void migrate(QTestState *who, const char *uri)
>      QDECREF(rsp);
>  }
>  
> +static void migrate_start_postcopy(QTestState *who)
> +{
> +    QDict *rsp;
> +
> +    rsp = wait_command(who, "{ 'execute': 'migrate-start-postcopy' }");
> +    g_assert(qdict_haskey(rsp, "return"));
> +    QDECREF(rsp);
> +}
> +
>  static void test_migrate_start(QTestState **from, QTestState **to,
>                                 const char *uri)
>  {
> @@ -598,7 +607,6 @@ static void test_postcopy(void)
>  {
>      char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
>      QTestState *from, *to;
> -    QDict *rsp;
>  
>      test_migrate_start(&from, &to, uri);
>  
> @@ -620,9 +628,7 @@ static void test_postcopy(void)
>  
>      wait_for_migration_pass(from);
>  
> -    rsp = wait_command(from, "{ 'execute': 'migrate-start-postcopy' }");
> -    g_assert(qdict_haskey(rsp, "return"));
> -    QDECREF(rsp);
> +    migrate_start_postcopy(from);
>  
>      if (!got_stop) {
>          qtest_qmp_eventwait(from, "STOP");
> -- 
> 2.14.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
