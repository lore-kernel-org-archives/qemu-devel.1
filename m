Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76411C7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:24:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22DBE22512
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:24:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22DBE22512
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hprxr-0001L4-CF
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 06:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33264)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hprxg-0000ve-Jv
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:24:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hprxf-00050Q-48
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:24:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53558)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hprxe-0004zR-S7
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:23:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 85E5030821A0;
 Tue, 23 Jul 2019 10:23:57 +0000 (UTC)
Received: from work-vm (ovpn-117-202.ams2.redhat.com [10.36.117.202])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9450C5D9C5;
 Tue, 23 Jul 2019 10:23:55 +0000 (UTC)
Date: Tue, 23 Jul 2019 11:23:53 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Yury Kotov <yury-kotov@yandex-team.ru>
Message-ID: <20190723102353.GG2719@work-vm>
References: <20190718091726.9874-1-yury-kotov@yandex-team.ru>
 <20190718091726.9874-4-yury-kotov@yandex-team.ru>
 <20190722173525.GF3035@work-vm>
 <483241563872053@myt5-bd00a25f9194.qloud-c.yandex.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <483241563872053@myt5-bd00a25f9194.qloud-c.yandex.net>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Tue, 23 Jul 2019 10:23:57 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 3/3] tests/migration: Add a test for
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
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>,
 Stefan Weil <sw@weilnetz.de>, Juan Quintela <quintela@redhat.com>,
 "open list:Overall" <qemu-devel@nongnu.org>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Yury Kotov (yury-kotov@yandex-team.ru) wrote:
> 22.07.2019, 20:35, "Dr. David Alan Gilbert" <dgilbert@redhat.com>:
> > * Yury Kotov (yury-kotov@yandex-team.ru) wrote:
> >> =A0Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
> >
> > This looks OK to me, but have you tried it on a really really overloa=
ded
> > host?
> > I worry that you might skip some of the percentage steps or not hit t=
he
> > bandwidth on the small overloaded VMs we get in CI.
>=20
> No, I haven't tried. I saw patchew's logs and you're absolutely right -=
 such
> problem exists. Now I'm looking for a way to fix it.

Yes, we've hit that type of thing before; make sure it's happy with 1
CPU that's already got 2 or 3 other things on it.

But as much as possible try and make it survive if it's really slow.

Dave

> >
> > Dave
> >
> >> =A0---
> >> =A0=A0tests/migration-test.c | 119 +++++++++++++++++++++++++++++++++=
++++----
> >> =A0=A01 file changed, 108 insertions(+), 11 deletions(-)
> >>
> >> =A0diff --git a/tests/migration-test.c b/tests/migration-test.c
> >> =A0index a4feb9545d..bb69517fc8 100644
> >> =A0--- a/tests/migration-test.c
> >> =A0+++ b/tests/migration-test.c
> >> =A0@@ -241,6 +241,17 @@ static int64_t read_ram_property_int(QTestSt=
ate *who, const char *property)
> >> =A0=A0=A0=A0=A0=A0return result;
> >> =A0=A0}
> >>
> >> =A0+static int64_t read_migrate_property_int(QTestState *who, const =
char *property)
> >> =A0+{
> >> =A0+ QDict *rsp_return;
> >> =A0+ int64_t result;
> >> =A0+
> >> =A0+ rsp_return =3D migrate_query(who);
> >> =A0+ result =3D qdict_get_try_int(rsp_return, property, 0);
> >> =A0+ qobject_unref(rsp_return);
> >> =A0+ return result;
> >> =A0+}
> >> =A0+
> >> =A0=A0static uint64_t get_migration_pass(QTestState *who)
> >> =A0=A0{
> >> =A0=A0=A0=A0=A0=A0return read_ram_property_int(who, "dirty-sync-coun=
t");
> >> =A0@@ -255,20 +266,22 @@ static void read_blocktime(QTestState *who)
> >> =A0=A0=A0=A0=A0=A0qobject_unref(rsp_return);
> >> =A0=A0}
> >>
> >> =A0+static bool check_migration_status(QTestState *who, const char *=
status)
> >> =A0+{
> >> =A0+ bool completed;
> >> =A0+ char *current_status;
> >> =A0+
> >> =A0+ current_status =3D migrate_query_status(who);
> >> =A0+ completed =3D strcmp(current_status, status) =3D=3D 0;
> >> =A0+ g_assert_cmpstr(current_status, !=3D, "failed");
> >> =A0+ g_free(current_status);
> >> =A0+ return completed;
> >> =A0+}
> >> =A0+
> >> =A0=A0static void wait_for_migration_status(QTestState *who,
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0const char *goal)
> >> =A0=A0{
> >> =A0- while (true) {
> >> =A0- bool completed;
> >> =A0- char *status;
> >> =A0-
> >> =A0- status =3D migrate_query_status(who);
> >> =A0- completed =3D strcmp(status, goal) =3D=3D 0;
> >> =A0- g_assert_cmpstr(status, !=3D, "failed");
> >> =A0- g_free(status);
> >> =A0- if (completed) {
> >> =A0- return;
> >> =A0- }
> >> =A0+ while (!check_migration_status(who, goal)) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0usleep(1000);
> >> =A0=A0=A0=A0=A0=A0}
> >> =A0=A0}
> >> =A0@@ -1121,6 +1134,89 @@ static void test_migrate_fd_proto(void)
> >> =A0=A0=A0=A0=A0=A0test_migrate_end(from, to, true);
> >> =A0=A0}
> >>
> >> =A0+static void test_migrate_auto_converge(void)
> >> =A0+{
> >> =A0+ char *uri =3D g_strdup_printf("unix:%s/migsocket", tmpfs);
> >> =A0+ QTestState *from, *to;
> >> =A0+ int i;
> >> =A0+ int64_t remaining, downtime;
> >> =A0+
> >> =A0+ /*
> >> =A0+ * We want the test to be fast enough, but stable.
> >> =A0+ * Throttle percentages are chosen to cover all cases (init, inc=
rement, max)
> >> =A0+ */
> >> =A0+ static const int64_t expected_pcts[] =3D { 0, 1, 51, 98 };
> >> =A0+ const int64_t max_bandwidth =3D 200000000; /* ~200Mb/s */
> >> =A0+ const int64_t downtime_limit =3D 50; /* 50ms */
> >> =A0+ /*
> >> =A0+ * We migrate through unix-socket (> 500Mb/s).
> >> =A0+ * Thus, expected migration speed ~=3D bandwidth limit (< 500Mb/=
s).
> >> =A0+ * So, we can predict expected_threshold
> >> =A0+ */
> >> =A0+ const int64_t expected_threshold =3D max_bandwidth * downtime_l=
imit / 1000;
> >> =A0+
> >> =A0+ if (test_migrate_start(&from, &to, uri, false, false)) {
> >> =A0+ return;
> >> =A0+ }
> >> =A0+
> >> =A0+ migrate_set_capability(from, "auto-converge", true);
> >> =A0+ migrate_set_parameter_int(from, "cpu-throttle-initial", expecte=
d_pcts[1]);
> >> =A0+ migrate_set_parameter_int(from, "cpu-throttle-increment",
> >> =A0+ expected_pcts[2] - expected_pcts[1]);
> >> =A0+ migrate_set_parameter_int(from, "max-cpu-throttle", expected_pc=
ts[3]);
> >> =A0+
> >> =A0+ migrate_set_parameter_int(from, "max-bandwidth", max_bandwidth)=
;
> >> =A0+ migrate_set_parameter_int(from, "downtime-limit", downtime_limi=
t);
> >> =A0+
> >> =A0+ /* To check remaining size after precopy */
> >> =A0+ migrate_set_capability(from, "pause-before-switchover", true);
> >> =A0+
> >> =A0+ /* Wait for the first serial output from the source */
> >> =A0+ wait_for_serial("src_serial");
> >> =A0+
> >> =A0+ migrate(from, uri, "{}");
> >> =A0+
> >> =A0+ for (i =3D 0; i < ARRAY_SIZE(expected_pcts); i++) {
> >> =A0+ int64_t pct;
> >> =A0+ pct =3D read_migrate_property_int(from, "cpu-throttle-percentag=
e");
> >> =A0+ g_assert_cmpint(pct, =3D=3D, expected_pcts[i]);
> >> =A0+ while (pct =3D=3D expected_pcts[i] && !got_stop) {
> >> =A0+ usleep(1000);
> >> =A0+ pct =3D read_migrate_property_int(from, "cpu-throttle-percentag=
e");
> >> =A0+ }
> >> =A0+ /* We break out of this loop only in paused state */
> >> =A0+ if (got_stop || i + 1 =3D=3D ARRAY_SIZE(expected_pcts)) {
> >> =A0+ /* Check unexpected throttle percentage change */
> >> =A0+ g_assert_true(got_stop);
> >> =A0+ /* Check unexpected converge */
> >> =A0+ g_assert_cmpint(i + 1, =3D=3D, ARRAY_SIZE(expected_pcts));
> >> =A0+ g_assert_true(check_migration_status(from, "pre-switchover"));
> >> =A0+ }
> >> =A0+ }
> >> =A0+
> >> =A0+ remaining =3D read_ram_property_int(from, "remaining");
> >> =A0+ g_assert_cmpint(remaining, <, expected_threshold);
> >> =A0+
> >> =A0+ wait_command(from, "{ 'execute': 'migrate-continue' , 'argument=
s':"
> >> =A0+ " { 'state': 'pre-switchover' } }");
> >> =A0+
> >> =A0+ qtest_qmp_eventwait(to, "RESUME");
> >> =A0+
> >> =A0+ wait_for_serial("dest_serial");
> >> =A0+ wait_for_migration_complete(from);
> >> =A0+
> >> =A0+ downtime =3D read_migrate_property_int(from, "downtime");
> >> =A0+ /*
> >> =A0+ * Actual downtime may be greater than downtime limit,
> >> =A0+ * but the difference should be small enough (~20ms)
> >> =A0+ */
> >> =A0+ g_assert_cmpint(downtime, <, downtime_limit + 20);
> >> =A0+
> >> =A0+ g_free(uri);
> >> =A0+
> >> =A0+ test_migrate_end(from, to, true);
> >> =A0+}
> >> =A0+
> >> =A0=A0int main(int argc, char **argv)
> >> =A0=A0{
> >> =A0=A0=A0=A0=A0=A0char template[] =3D "/tmp/migration-test-XXXXXX";
> >> =A0@@ -1176,6 +1272,7 @@ int main(int argc, char **argv)
> >> =A0=A0=A0=A0=A0=A0/* qtest_add_func("/migration/ignore_shared", test=
_ignore_shared); */
> >> =A0=A0=A0=A0=A0=A0qtest_add_func("/migration/xbzrle/unix", test_xbzr=
le_unix);
> >> =A0=A0=A0=A0=A0=A0qtest_add_func("/migration/fd_proto", test_migrate=
_fd_proto);
> >> =A0+ qtest_add_func("/migration/auto_converge", test_migrate_auto_co=
nverge);
> >>
> >> =A0=A0=A0=A0=A0=A0ret =3D g_test_run();
> >>
> >> =A0--
> >> =A02.22.0
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20
> Regards,
> Yury
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

