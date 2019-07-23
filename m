Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CF3C76186
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 17:35:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64125218B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 17:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64125218B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpygr-00028h-WF
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 13:35:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54058)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hpygg-0001gQ-GN
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 13:34:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hpygf-00067U-65
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 13:34:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58072)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hpyge-000670-Tu
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 13:34:53 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 369C380F6D;
 Tue, 23 Jul 2019 17:34:52 +0000 (UTC)
Received: from work-vm (ovpn-117-202.ams2.redhat.com [10.36.117.202])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C7BD19C78;
 Tue, 23 Jul 2019 17:34:50 +0000 (UTC)
Date: Tue, 23 Jul 2019 18:34:47 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Yury Kotov <yury-kotov@yandex-team.ru>
Message-ID: <20190723173447.GC2760@work-vm>
References: <20190723134215.25095-1-yury-kotov@yandex-team.ru>
 <20190723134215.25095-4-yury-kotov@yandex-team.ru>
 <20190723173419.GQ2719@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723173419.GQ2719@work-vm>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 23 Jul 2019 17:34:52 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 3/3] tests/migration: Add a test for
 auto converge
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
Cc: Juan Quintela <quintela@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Peter Crosthwaite <crosthwaite.peter@gmail.com>,
 "open list:Overall" <qemu-devel@nongnu.org>, yc-core@yandex-team.ru,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Dr. David Alan Gilbert (dgilbert@redhat.com) wrote:
> * Yury Kotov (yury-kotov@yandex-team.ru) wrote:
> > Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
> 
> OK, I think that's worth a go; lets see how it does in heavy CI systems/
> 
> Dave

and I meant:


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> > ---
> >  tests/migration-test.c | 103 ++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 92 insertions(+), 11 deletions(-)
> > 
> > diff --git a/tests/migration-test.c b/tests/migration-test.c
> > index a4feb9545d..b783ae47b3 100644
> > --- a/tests/migration-test.c
> > +++ b/tests/migration-test.c
> > @@ -241,6 +241,17 @@ static int64_t read_ram_property_int(QTestState *who, const char *property)
> >      return result;
> >  }
> >  
> > +static int64_t read_migrate_property_int(QTestState *who, const char *property)
> > +{
> > +    QDict *rsp_return;
> > +    int64_t result;
> > +
> > +    rsp_return = migrate_query(who);
> > +    result = qdict_get_try_int(rsp_return, property, 0);
> > +    qobject_unref(rsp_return);
> > +    return result;
> > +}
> > +
> >  static uint64_t get_migration_pass(QTestState *who)
> >  {
> >      return read_ram_property_int(who, "dirty-sync-count");
> > @@ -255,20 +266,22 @@ static void read_blocktime(QTestState *who)
> >      qobject_unref(rsp_return);
> >  }
> >  
> > +static bool check_migration_status(QTestState *who, const char *status)
> > +{
> > +    bool completed;
> > +    char *current_status;
> > +
> > +    current_status = migrate_query_status(who);
> > +    completed = strcmp(current_status, status) == 0;
> > +    g_assert_cmpstr(current_status, !=, "failed");
> > +    g_free(current_status);
> > +    return completed;
> > +}
> > +
> >  static void wait_for_migration_status(QTestState *who,
> >                                        const char *goal)
> >  {
> > -    while (true) {
> > -        bool completed;
> > -        char *status;
> > -
> > -        status = migrate_query_status(who);
> > -        completed = strcmp(status, goal) == 0;
> > -        g_assert_cmpstr(status, !=,  "failed");
> > -        g_free(status);
> > -        if (completed) {
> > -            return;
> > -        }
> > +    while (!check_migration_status(who, goal)) {
> >          usleep(1000);
> >      }
> >  }
> > @@ -1121,6 +1134,73 @@ static void test_migrate_fd_proto(void)
> >      test_migrate_end(from, to, true);
> >  }
> >  
> > +static void test_migrate_auto_converge(void)
> > +{
> > +    char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
> > +    QTestState *from, *to;
> > +    int64_t remaining, percentage;
> > +
> > +    /*
> > +     * We want the test to be fast enough, but stable.
> > +     * Throttle percentages are chosen to cover all cases (init, increment, max)
> > +     */
> > +    static const int64_t expected_pcts[] = { 0, 1, 51, 98 };
> > +    const int64_t max_bandwidth = 200000000; /* ~200Mb/s */
> > +    const int64_t downtime_limit = 50; /* 50ms */
> > +    /*
> > +     * We migrate through unix-socket (> 500Mb/s).
> > +     * Thus, expected migration speed ~= bandwidth limit (< 500Mb/s).
> > +     * So, we can predict expected_threshold
> > +     */
> > +    const int64_t expected_threshold = max_bandwidth * downtime_limit / 1000;
> > +
> > +    if (test_migrate_start(&from, &to, uri, false, false)) {
> > +        return;
> > +    }
> > +
> > +    migrate_set_capability(from, "auto-converge", true);
> > +    migrate_set_parameter_int(from, "cpu-throttle-initial", expected_pcts[1]);
> > +    migrate_set_parameter_int(from, "cpu-throttle-increment",
> > +                              expected_pcts[2] - expected_pcts[1]);
> > +    migrate_set_parameter_int(from, "max-cpu-throttle", expected_pcts[3]);
> > +
> > +    migrate_set_parameter_int(from, "max-bandwidth", max_bandwidth);
> > +    migrate_set_parameter_int(from, "downtime-limit", downtime_limit);
> > +
> > +    /* To check remaining size after precopy */
> > +    migrate_set_capability(from, "pause-before-switchover", true);
> > +
> > +    /* Wait for the first serial output from the source */
> > +    wait_for_serial("src_serial");
> > +
> > +    migrate(from, uri, "{}");
> > +
> > +    /*
> > +     * Wait for pre-switchover status to check last throttle percentage
> > +     * and remaining. These values will be zeroed later
> > +     */
> > +    wait_for_migration_status(from, "pre-switchover");
> > +
> > +    /* We expect that migration can't converge without throttling */
> > +    percentage = read_migrate_property_int(from, "cpu-throttle-percentage");
> > +    g_assert_cmpint(percentage, >, 0);
> > +
> > +    remaining = read_ram_property_int(from, "remaining");
> > +    g_assert_cmpint(remaining, <, expected_threshold);
> > +
> > +    wait_command(from, "{ 'execute': 'migrate-continue' , 'arguments':"
> > +                       "  { 'state': 'pre-switchover' } }");
> > +
> > +    qtest_qmp_eventwait(to, "RESUME");
> > +
> > +    wait_for_serial("dest_serial");
> > +    wait_for_migration_complete(from);
> > +
> > +    g_free(uri);
> > +
> > +    test_migrate_end(from, to, true);
> > +}
> > +
> >  int main(int argc, char **argv)
> >  {
> >      char template[] = "/tmp/migration-test-XXXXXX";
> > @@ -1176,6 +1256,7 @@ int main(int argc, char **argv)
> >      /* qtest_add_func("/migration/ignore_shared", test_ignore_shared); */
> >      qtest_add_func("/migration/xbzrle/unix", test_xbzrle_unix);
> >      qtest_add_func("/migration/fd_proto", test_migrate_fd_proto);
> > +    qtest_add_func("/migration/auto_converge", test_migrate_auto_converge);
> >  
> >      ret = g_test_run();
> >  
> > -- 
> > 2.22.0
> > 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

