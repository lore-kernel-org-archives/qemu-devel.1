Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56483C49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 10:03:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C4EA2075C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 10:03:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C4EA2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7zTi-0007g9-7T
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 06:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48573)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i7zSP-0006x5-De
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 06:02:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i7zSN-0004PJ-LA
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 06:02:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41778)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i7zSN-0004Ol-Cy
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 06:02:35 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 78D07308C21D;
 Wed, 11 Sep 2019 10:02:34 +0000 (UTC)
Received: from work-vm (ovpn-117-243.ams2.redhat.com [10.36.117.243])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0350B60C05;
 Wed, 11 Sep 2019 10:02:29 +0000 (UTC)
Date: Wed, 11 Sep 2019 11:02:27 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Yury Kotov <yury-kotov@yandex-team.ru>
Message-ID: <20190911100227.GE2894@work-vm>
References: <20190903162246.18524-1-yury-kotov@yandex-team.ru>
 <20190903162246.18524-4-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903162246.18524-4-yury-kotov@yandex-team.ru>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Wed, 11 Sep 2019 10:02:34 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 3/3] tests/migration: Add a test for
 validate-uuid capability
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, yc-core@yandex-team.ru,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Yury Kotov (yury-kotov@yandex-team.ru) wrote:
> Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  tests/migration-test.c | 140 ++++++++++++++++++++++++++++++++---------
>  1 file changed, 110 insertions(+), 30 deletions(-)
> 
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index b87ba99a9e..524caf773f 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -512,7 +512,8 @@ static void migrate_postcopy_start(QTestState *from, QTestState *to)
>  
>  static int test_migrate_start(QTestState **from, QTestState **to,
>                                 const char *uri, bool hide_stderr,
> -                               bool use_shmem)
> +                               bool use_shmem, const char *opts_src,
> +                               const char *opts_dst)
>  {
>      gchar *cmd_src, *cmd_dst;
>      char *bootpath = NULL;
> @@ -521,6 +522,9 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>      const char *arch = qtest_get_arch();
>      const char *accel = "kvm:tcg";
>  
> +    opts_src = opts_src ? opts_src : "";
> +    opts_dst = opts_dst ? opts_dst : "";
> +
>      if (use_shmem) {
>          if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
>              g_test_skip("/dev/shm is not supported");
> @@ -539,16 +543,16 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>          cmd_src = g_strdup_printf("-machine accel=%s -m 150M"
>                                    " -name source,debug-threads=on"
>                                    " -serial file:%s/src_serial"
> -                                  " -drive file=%s,format=raw %s",
> +                                  " -drive file=%s,format=raw %s %s",
>                                    accel, tmpfs, bootpath,
> -                                  extra_opts ? extra_opts : "");
> +                                  extra_opts ? extra_opts : "", opts_src);
>          cmd_dst = g_strdup_printf("-machine accel=%s -m 150M"
>                                    " -name target,debug-threads=on"
>                                    " -serial file:%s/dest_serial"
>                                    " -drive file=%s,format=raw"
> -                                  " -incoming %s %s",
> +                                  " -incoming %s %s %s",
>                                    accel, tmpfs, bootpath, uri,
> -                                  extra_opts ? extra_opts : "");
> +                                  extra_opts ? extra_opts : "", opts_dst);
>          start_address = X86_TEST_MEM_START;
>          end_address = X86_TEST_MEM_END;
>      } else if (g_str_equal(arch, "s390x")) {
> @@ -556,15 +560,15 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>          extra_opts = use_shmem ? get_shmem_opts("128M", shmem_path) : NULL;
>          cmd_src = g_strdup_printf("-machine accel=%s -m 128M"
>                                    " -name source,debug-threads=on"
> -                                  " -serial file:%s/src_serial -bios %s %s",
> +                                  " -serial file:%s/src_serial -bios %s %s %s",
>                                    accel, tmpfs, bootpath,
> -                                  extra_opts ? extra_opts : "");
> +                                  extra_opts ? extra_opts : "", opts_src);
>          cmd_dst = g_strdup_printf("-machine accel=%s -m 128M"
>                                    " -name target,debug-threads=on"
>                                    " -serial file:%s/dest_serial -bios %s"
> -                                  " -incoming %s %s",
> +                                  " -incoming %s %s %s",
>                                    accel, tmpfs, bootpath, uri,
> -                                  extra_opts ? extra_opts : "");
> +                                  extra_opts ? extra_opts : "", opts_dst);
>          start_address = S390_TEST_MEM_START;
>          end_address = S390_TEST_MEM_END;
>      } else if (strcmp(arch, "ppc64") == 0) {
> @@ -575,14 +579,15 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>                                    " -prom-env 'use-nvramrc?=true' -prom-env "
>                                    "'nvramrc=hex .\" _\" begin %x %x "
>                                    "do i c@ 1 + i c! 1000 +loop .\" B\" 0 "
> -                                  "until' %s",  accel, tmpfs, end_address,
> -                                  start_address, extra_opts ? extra_opts : "");
> +                                  "until' %s %s",  accel, tmpfs, end_address,
> +                                  start_address, extra_opts ? extra_opts : "",
> +                                  opts_src);
>          cmd_dst = g_strdup_printf("-machine accel=%s -m 256M"
>                                    " -name target,debug-threads=on"
>                                    " -serial file:%s/dest_serial"
> -                                  " -incoming %s %s",
> +                                  " -incoming %s %s %s",
>                                    accel, tmpfs, uri,
> -                                  extra_opts ? extra_opts : "");
> +                                  extra_opts ? extra_opts : "", opts_dst);
>  
>          start_address = PPC_TEST_MEM_START;
>          end_address = PPC_TEST_MEM_END;
> @@ -592,16 +597,16 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>          cmd_src = g_strdup_printf("-machine virt,accel=%s,gic-version=max "
>                                    "-name vmsource,debug-threads=on -cpu max "
>                                    "-m 150M -serial file:%s/src_serial "
> -                                  "-kernel %s %s",
> +                                  "-kernel %s %s %s",
>                                    accel, tmpfs, bootpath,
> -                                  extra_opts ? extra_opts : "");
> +                                  extra_opts ? extra_opts : "", opts_src);
>          cmd_dst = g_strdup_printf("-machine virt,accel=%s,gic-version=max "
>                                    "-name vmdest,debug-threads=on -cpu max "
>                                    "-m 150M -serial file:%s/dest_serial "
>                                    "-kernel %s "
> -                                  "-incoming %s %s",
> +                                  "-incoming %s %s %s",
>                                    accel, tmpfs, bootpath, uri,
> -                                  extra_opts ? extra_opts : "");
> +                                  extra_opts ? extra_opts : "", opts_dst);
>  
>          start_address = ARM_TEST_MEM_START;
>          end_address = ARM_TEST_MEM_END;
> @@ -731,7 +736,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
>      char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
>      QTestState *from, *to;
>  
> -    if (test_migrate_start(&from, &to, uri, hide_error, false)) {
> +    if (test_migrate_start(&from, &to, uri, hide_error, false, NULL, NULL)) {
>          return -1;
>      }
>  
> @@ -841,20 +846,16 @@ static void test_postcopy_recovery(void)
>      migrate_postcopy_complete(from, to);
>  }
>  
> -static void test_baddest(void)
> +static void wait_for_migration_fail(QTestState *from, bool allow_active)
>  {
> -    QTestState *from, *to;
>      QDict *rsp_return;
>      char *status;
>      bool failed;
>  
> -    if (test_migrate_start(&from, &to, "tcp:0:0", true, false)) {
> -        return;
> -    }
> -    migrate(from, "tcp:0:0", "{}");
>      do {
>          status = migrate_query_status(from);
> -        g_assert(!strcmp(status, "setup") || !(strcmp(status, "failed")));
> +        g_assert(!strcmp(status, "setup") || !strcmp(status, "failed") ||
> +                 (allow_active && !strcmp(status, "active")));
>          failed = !strcmp(status, "failed");
>          g_free(status);
>      } while (!failed);
> @@ -864,7 +865,17 @@ static void test_baddest(void)
>      g_assert(qdict_haskey(rsp_return, "running"));
>      g_assert(qdict_get_bool(rsp_return, "running"));
>      qobject_unref(rsp_return);
> +}
> +
> +static void test_baddest(void)
> +{
> +    QTestState *from, *to;
>  
> +    if (test_migrate_start(&from, &to, "tcp:0:0", true, false, NULL, NULL)) {
> +        return;
> +    }
> +    migrate(from, "tcp:0:0", "{}");
> +    wait_for_migration_fail(from, false);
>      test_migrate_end(from, to, false);
>  }
>  
> @@ -873,7 +884,7 @@ static void test_precopy_unix(void)
>      char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
>      QTestState *from, *to;
>  
> -    if (test_migrate_start(&from, &to, uri, false, false)) {
> +    if (test_migrate_start(&from, &to, uri, false, false, NULL, NULL)) {
>          return;
>      }
>  
> @@ -916,7 +927,7 @@ static void test_ignore_shared(void)
>      char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
>      QTestState *from, *to;
>  
> -    if (test_migrate_start(&from, &to, uri, false, true)) {
> +    if (test_migrate_start(&from, &to, uri, false, true, NULL, NULL)) {
>          return;
>      }
>  
> @@ -951,7 +962,7 @@ static void test_xbzrle(const char *uri)
>  {
>      QTestState *from, *to;
>  
> -    if (test_migrate_start(&from, &to, uri, false, false)) {
> +    if (test_migrate_start(&from, &to, uri, false, false, NULL, NULL)) {
>          return;
>      }
>  
> @@ -1003,7 +1014,8 @@ static void test_precopy_tcp(void)
>      char *uri;
>      QTestState *from, *to;
>  
> -    if (test_migrate_start(&from, &to, "tcp:127.0.0.1:0", false, false)) {
> +    if (test_migrate_start(&from, &to, "tcp:127.0.0.1:0", false, false,
> +                           NULL, NULL)) {
>          return;
>      }
>  
> @@ -1049,7 +1061,7 @@ static void test_migrate_fd_proto(void)
>      QDict *rsp;
>      const char *error_desc;
>  
> -    if (test_migrate_start(&from, &to, "defer", false, false)) {
> +    if (test_migrate_start(&from, &to, "defer", false, false, NULL, NULL)) {
>          return;
>      }
>  
> @@ -1125,6 +1137,68 @@ static void test_migrate_fd_proto(void)
>      test_migrate_end(from, to, true);
>  }
>  
> +static void do_test_validate_uuid(const char *uuid_arg_src,
> +                                  const char *uuid_arg_dst,
> +                                  bool should_fail, bool hide_stderr)
> +{
> +    char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
> +    QTestState *from, *to;
> +
> +    if (test_migrate_start(&from, &to, uri, hide_stderr, false,
> +                           uuid_arg_src, uuid_arg_dst)) {
> +        return;
> +    }
> +
> +    /*
> +     * UUID validation is at the begin of migration. So, the main process of
> +     * migration is not interesting for us here. Thus, set huge downtime for
> +     * very fast migration.
> +     */
> +    migrate_set_parameter_int(from, "downtime-limit", 1000000);
> +    migrate_set_capability(from, "validate-uuid", true);
> +
> +    /* Wait for the first serial output from the source */
> +    wait_for_serial("src_serial");
> +
> +    migrate(from, uri, "{}");
> +
> +    if (should_fail) {
> +        qtest_set_expected_status(to, 1);
> +        wait_for_migration_fail(from, true);
> +    } else {
> +        wait_for_migration_complete(from);
> +    }
> +
> +    test_migrate_end(from, to, false);
> +    g_free(uri);
> +}
> +
> +static void test_validate_uuid(void)
> +{
> +    do_test_validate_uuid("-uuid 11111111-1111-1111-1111-111111111111",
> +                          "-uuid 11111111-1111-1111-1111-111111111111",
> +                          false, false);
> +}
> +
> +static void test_validate_uuid_error(void)
> +{
> +    do_test_validate_uuid("-uuid 11111111-1111-1111-1111-111111111111",
> +                          "-uuid 22222222-2222-2222-2222-222222222222",
> +                          true, true);
> +}
> +
> +static void test_validate_uuid_src_not_set(void)
> +{
> +    do_test_validate_uuid(NULL, "-uuid 11111111-1111-1111-1111-111111111111",
> +                          false, true);
> +}
> +
> +static void test_validate_uuid_dst_not_set(void)
> +{
> +    do_test_validate_uuid("-uuid 11111111-1111-1111-1111-111111111111", NULL,
> +                          false, true);
> +}
> +
>  int main(int argc, char **argv)
>  {
>      char template[] = "/tmp/migration-test-XXXXXX";
> @@ -1180,6 +1254,12 @@ int main(int argc, char **argv)
>      /* qtest_add_func("/migration/ignore_shared", test_ignore_shared); */
>      qtest_add_func("/migration/xbzrle/unix", test_xbzrle_unix);
>      qtest_add_func("/migration/fd_proto", test_migrate_fd_proto);
> +    qtest_add_func("/migration/validate_uuid", test_validate_uuid);
> +    qtest_add_func("/migration/validate_uuid_error", test_validate_uuid_error);
> +    qtest_add_func("/migration/validate_uuid_src_not_set",
> +                   test_validate_uuid_src_not_set);
> +    qtest_add_func("/migration/validate_uuid_dst_not_set",
> +                   test_validate_uuid_dst_not_set);
>  
>      ret = g_test_run();
>  
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

