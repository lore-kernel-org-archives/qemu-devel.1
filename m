Received: from eggs.gnu.org ([209.51.188.92]:35786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hBj34-0004Vf-72
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 12:47:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hBj31-0005Ed-S5
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 12:47:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hBj31-0004zy-4n
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 12:47:35 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 08C2B7D7CD
	for <qemu-devel@nongnu.org>; Wed,  3 Apr 2019 16:47:31 +0000 (UTC)
Date: Wed, 3 Apr 2019 17:47:25 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190403164724.GG2790@work-vm>
References: <20190403114958.3705-1-quintela@redhat.com>
	<20190403114958.3705-4-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403114958.3705-4-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/8] migration-test: rename parameter to
 parameter_int
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>

* Juan Quintela (quintela@redhat.com) wrote:
> We would need _str ones on the next patch.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  tests/migration-test.c | 49 +++++++++++++++++++++---------------------
>  1 file changed, 25 insertions(+), 24 deletions(-)
> 
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index bd3f5c3125..0b25aa3d6c 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -392,7 +392,8 @@ static char *migrate_get_socket_address(QTestState *who, const char *parameter)
>      return result;
>  }
>  
> -static long long migrate_get_parameter(QTestState *who, const char *parameter)
> +static long long migrate_get_parameter_int(QTestState *who,
> +                                           const char *parameter)
>  {
>      QDict *rsp;
>      long long result;
> @@ -403,17 +404,17 @@ static long long migrate_get_parameter(QTestState *who, const char *parameter)
>      return result;
>  }
>  
> -static void migrate_check_parameter(QTestState *who, const char *parameter,
> -                                    long long value)
> +static void migrate_check_parameter_int(QTestState *who, const char *parameter,
> +                                        long long value)
>  {
>      long long result;
>  
> -    result = migrate_get_parameter(who, parameter);
> +    result = migrate_get_parameter_int(who, parameter);
>      g_assert_cmpint(result, ==, value);
>  }
>  
> -static void migrate_set_parameter(QTestState *who, const char *parameter,
> -                                  long long value)
> +static void migrate_set_parameter_int(QTestState *who, const char *parameter,
> +                                      long long value)
>  {
>      QDict *rsp;
>  
> @@ -423,7 +424,7 @@ static void migrate_set_parameter(QTestState *who, const char *parameter,
>                      parameter, value);
>      g_assert(qdict_haskey(rsp, "return"));
>      qobject_unref(rsp);
> -    migrate_check_parameter(who, parameter, value);
> +    migrate_check_parameter_int(who, parameter, value);
>  }
>  
>  static void migrate_pause(QTestState *who)
> @@ -672,7 +673,7 @@ static void deprecated_set_downtime(QTestState *who, const double value)
>                      " 'arguments': { 'value': %f } }", value);
>      g_assert(qdict_haskey(rsp, "return"));
>      qobject_unref(rsp);
> -    migrate_check_parameter(who, "downtime-limit", value * 1000);
> +    migrate_check_parameter_int(who, "downtime-limit", value * 1000);
>  }
>  
>  static void deprecated_set_speed(QTestState *who, long long value)
> @@ -683,7 +684,7 @@ static void deprecated_set_speed(QTestState *who, long long value)
>                            "'arguments': { 'value': %lld } }", value);
>      g_assert(qdict_haskey(rsp, "return"));
>      qobject_unref(rsp);
> -    migrate_check_parameter(who, "max-bandwidth", value);
> +    migrate_check_parameter_int(who, "max-bandwidth", value);
>  }
>  
>  static void deprecated_set_cache_size(QTestState *who, long long value)
> @@ -694,7 +695,7 @@ static void deprecated_set_cache_size(QTestState *who, long long value)
>                           "'arguments': { 'value': %lld } }", value);
>      g_assert(qdict_haskey(rsp, "return"));
>      qobject_unref(rsp);
> -    migrate_check_parameter(who, "xbzrle-cache-size", value);
> +    migrate_check_parameter_int(who, "xbzrle-cache-size", value);
>  }
>  
>  static void test_deprecated(void)
> @@ -729,8 +730,8 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
>       * quickly, but that it doesn't complete precopy even on a slow
>       * machine, so also set the downtime.
>       */
> -    migrate_set_parameter(from, "max-bandwidth", 100000000);
> -    migrate_set_parameter(from, "downtime-limit", 1);
> +    migrate_set_parameter_int(from, "max-bandwidth", 100000000);
> +    migrate_set_parameter_int(from, "downtime-limit", 1);
>  
>      /* Wait for the first serial output from the source */
>      wait_for_serial("src_serial");
> @@ -781,7 +782,7 @@ static void test_postcopy_recovery(void)
>      }
>  
>      /* Turn postcopy speed down, 4K/s is slow enough on any machines */
> -    migrate_set_parameter(from, "max-postcopy-bandwidth", 4096);
> +    migrate_set_parameter_int(from, "max-postcopy-bandwidth", 4096);
>  
>      /* Now we start the postcopy */
>      migrate_postcopy_start(from, to);
> @@ -822,7 +823,7 @@ static void test_postcopy_recovery(void)
>      g_free(uri);
>  
>      /* Restore the postcopy bandwidth to unlimited */
> -    migrate_set_parameter(from, "max-postcopy-bandwidth", 0);
> +    migrate_set_parameter_int(from, "max-postcopy-bandwidth", 0);
>  
>      migrate_postcopy_complete(from, to);
>  }
> @@ -868,9 +869,9 @@ static void test_precopy_unix(void)
>       * machine, so also set the downtime.
>       */
>      /* 1 ms should make it not converge*/
> -    migrate_set_parameter(from, "downtime-limit", 1);
> +    migrate_set_parameter_int(from, "downtime-limit", 1);
>      /* 1GB/s */
> -    migrate_set_parameter(from, "max-bandwidth", 1000000000);
> +    migrate_set_parameter_int(from, "max-bandwidth", 1000000000);
>  
>      /* Wait for the first serial output from the source */
>      wait_for_serial("src_serial");
> @@ -880,7 +881,7 @@ static void test_precopy_unix(void)
>      wait_for_migration_pass(from);
>  
>      /* 300 ms should converge */
> -    migrate_set_parameter(from, "downtime-limit", 300);
> +    migrate_set_parameter_int(from, "downtime-limit", 300);
>  
>      if (!got_stop) {
>          qtest_qmp_eventwait(from, "STOP");
> @@ -947,11 +948,11 @@ static void test_xbzrle(const char *uri)
>       * machine, so also set the downtime.
>       */
>      /* 1 ms should make it not converge*/
> -    migrate_set_parameter(from, "downtime-limit", 1);
> +    migrate_set_parameter_int(from, "downtime-limit", 1);
>      /* 1GB/s */
> -    migrate_set_parameter(from, "max-bandwidth", 1000000000);
> +    migrate_set_parameter_int(from, "max-bandwidth", 1000000000);
>  
> -    migrate_set_parameter(from, "xbzrle-cache-size", 33554432);
> +    migrate_set_parameter_int(from, "xbzrle-cache-size", 33554432);
>  
>      migrate_set_capability(from, "xbzrle", "true");
>      migrate_set_capability(to, "xbzrle", "true");
> @@ -963,7 +964,7 @@ static void test_xbzrle(const char *uri)
>      wait_for_migration_pass(from);
>  
>      /* 300ms should converge */
> -    migrate_set_parameter(from, "downtime-limit", 300);
> +    migrate_set_parameter_int(from, "downtime-limit", 300);
>  
>      if (!got_stop) {
>          qtest_qmp_eventwait(from, "STOP");
> @@ -999,9 +1000,9 @@ static void test_precopy_tcp(void)
>       * machine, so also set the downtime.
>       */
>      /* 1 ms should make it not converge*/
> -    migrate_set_parameter(from, "downtime-limit", 1);
> +    migrate_set_parameter_int(from, "downtime-limit", 1);
>      /* 1GB/s */
> -    migrate_set_parameter(from, "max-bandwidth", 1000000000);
> +    migrate_set_parameter_int(from, "max-bandwidth", 1000000000);
>  
>      /* Wait for the first serial output from the source */
>      wait_for_serial("src_serial");
> @@ -1013,7 +1014,7 @@ static void test_precopy_tcp(void)
>      wait_for_migration_pass(from);
>  
>      /* 300ms should converge */
> -    migrate_set_parameter(from, "downtime-limit", 300);
> +    migrate_set_parameter_int(from, "downtime-limit", 300);
>  
>      if (!got_stop) {
>          qtest_qmp_eventwait(from, "STOP");
> -- 
> 2.20.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
