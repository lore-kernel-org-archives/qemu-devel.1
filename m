Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB329C7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 08:56:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA40621842
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 08:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="jJ2KxCtx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA40621842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpqaj-0004ni-QQ
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 04:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38005)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1hpqaX-0004OY-8P
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 04:56:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1hpqaU-0001WY-AE
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 04:56:01 -0400
Received: from forwardcorp1p.mail.yandex.net
 ([2a02:6b8:0:1472:2741:0:8b6:217]:38428)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
 id 1hpqZ3-0000aS-Hw
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 04:55:58 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net
 [IPv6:2a02:6b8:0:1a2d::301])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id A8C192E144B;
 Tue, 23 Jul 2019 11:54:24 +0300 (MSK)
Received: from localhost (localhost [::1])
 by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
 kIsKj4cieE-sOB83uS8; Tue, 23 Jul 2019 11:54:24 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1563872064; bh=eJsPd7AVmUrcwV2KbQwRdANG+y5de9OYqTYT7uK51ZM=;
 h=Subject:In-Reply-To:Cc:Date:References:To:From:Message-Id;
 b=jJ2KxCtxianoPSepE7ZroypRhVuJSHFr5yr0R5hYXDKC7i0zunIUUOPtWwUe2JNDc
 8OsRCDHvJ3su4g74oJyAm+6teMcqDmpJZE3jSAN+dF5V39v1pMgP4uTTfj4kmOmVhD
 5ssghBTPdG7ZD0KBBw40NNLLhJhc8inukJ0UbHIk=
Authentication-Results: mxbackcorp1o.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000071945
X-Yandex-Avir: 1
Received: from mxbackcorp1g.mail.yandex.net (localhost [::1])
 by mxbackcorp1g.mail.yandex.net with LMTP id 6xTSBP0uVc-r2lCf8G5
 for <yury-kotov@yandex-team.ru>; Tue, 23 Jul 2019 11:54:13 +0300
Received: by myt5-bd00a25f9194.qloud-c.yandex.net with HTTP;
 Tue, 23 Jul 2019 11:54:13 +0300
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Dr. David Alan Gilbert <dgilbert@redhat.com>
In-Reply-To: <20190722173525.GF3035@work-vm>
References: <20190718091726.9874-1-yury-kotov@yandex-team.ru>
 <20190718091726.9874-4-yury-kotov@yandex-team.ru>
 <20190722173525.GF3035@work-vm>
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Tue, 23 Jul 2019 11:54:23 +0300
Message-Id: <483241563872053@myt5-bd00a25f9194.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a02:6b8:0:1472:2741:0:8b6:217
Subject: Re: [Qemu-devel] [PATCH v3 3/3] tests/migration: Add a test for
 auto converge
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
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

22.07.2019, 20:35, "Dr. David Alan Gilbert" <dgilbert@redhat.com>:
> * Yury Kotov (yury-kotov@yandex-team.ru) wrote:
>> =C2=A0Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
>
> This looks OK to me, but have you tried it on a really really overloade=
d
> host?
> I worry that you might skip some of the percentage steps or not hit the
> bandwidth on the small overloaded VMs we get in CI.

No, I haven't tried. I saw patchew's logs and you're absolutely right - s=
uch
problem exists. Now I'm looking for a way to fix it.

>
> Dave
>
>> =C2=A0---
>> =C2=A0=C2=A0tests/migration-test.c | 119 +++++++++++++++++++++++++++++=
++++++++----
>> =C2=A0=C2=A01 file changed, 108 insertions(+), 11 deletions(-)
>>
>> =C2=A0diff --git a/tests/migration-test.c b/tests/migration-test.c
>> =C2=A0index a4feb9545d..bb69517fc8 100644
>> =C2=A0--- a/tests/migration-test.c
>> =C2=A0+++ b/tests/migration-test.c
>> =C2=A0@@ -241,6 +241,17 @@ static int64_t read_ram_property_int(QTestS=
tate *who, const char *property)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return result;
>> =C2=A0=C2=A0}
>>
>> =C2=A0+static int64_t read_migrate_property_int(QTestState *who, const=
 char *property)
>> =C2=A0+{
>> =C2=A0+ QDict *rsp_return;
>> =C2=A0+ int64_t result;
>> =C2=A0+
>> =C2=A0+ rsp_return =3D migrate_query(who);
>> =C2=A0+ result =3D qdict_get_try_int(rsp_return, property, 0);
>> =C2=A0+ qobject_unref(rsp_return);
>> =C2=A0+ return result;
>> =C2=A0+}
>> =C2=A0+
>> =C2=A0=C2=A0static uint64_t get_migration_pass(QTestState *who)
>> =C2=A0=C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return read_ram_property_int(who, =
"dirty-sync-count");
>> =C2=A0@@ -255,20 +266,22 @@ static void read_blocktime(QTestState *who=
)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qobject_unref(rsp_return);
>> =C2=A0=C2=A0}
>>
>> =C2=A0+static bool check_migration_status(QTestState *who, const char =
*status)
>> =C2=A0+{
>> =C2=A0+ bool completed;
>> =C2=A0+ char *current_status;
>> =C2=A0+
>> =C2=A0+ current_status =3D migrate_query_status(who);
>> =C2=A0+ completed =3D strcmp(current_status, status) =3D=3D 0;
>> =C2=A0+ g_assert_cmpstr(current_status, !=3D, "failed");
>> =C2=A0+ g_free(current_status);
>> =C2=A0+ return completed;
>> =C2=A0+}
>> =C2=A0+
>> =C2=A0=C2=A0static void wait_for_migration_status(QTestState *who,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0const char *goal)
>> =C2=A0=C2=A0{
>> =C2=A0- while (true) {
>> =C2=A0- bool completed;
>> =C2=A0- char *status;
>> =C2=A0-
>> =C2=A0- status =3D migrate_query_status(who);
>> =C2=A0- completed =3D strcmp(status, goal) =3D=3D 0;
>> =C2=A0- g_assert_cmpstr(status, !=3D, "failed");
>> =C2=A0- g_free(status);
>> =C2=A0- if (completed) {
>> =C2=A0- return;
>> =C2=A0- }
>> =C2=A0+ while (!check_migration_status(who, goal)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0usleep(100=
0);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> =C2=A0=C2=A0}
>> =C2=A0@@ -1121,6 +1134,89 @@ static void test_migrate_fd_proto(void)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0test_migrate_end(from, to, true);
>> =C2=A0=C2=A0}
>>
>> =C2=A0+static void test_migrate_auto_converge(void)
>> =C2=A0+{
>> =C2=A0+ char *uri =3D g_strdup_printf("unix:%s/migsocket", tmpfs);
>> =C2=A0+ QTestState *from, *to;
>> =C2=A0+ int i;
>> =C2=A0+ int64_t remaining, downtime;
>> =C2=A0+
>> =C2=A0+ /*
>> =C2=A0+ * We want the test to be fast enough, but stable.
>> =C2=A0+ * Throttle percentages are chosen to cover all cases (init, in=
crement, max)
>> =C2=A0+ */
>> =C2=A0+ static const int64_t expected_pcts[] =3D { 0, 1, 51, 98 };
>> =C2=A0+ const int64_t max_bandwidth =3D 200000000; /* ~200Mb/s */
>> =C2=A0+ const int64_t downtime_limit =3D 50; /* 50ms */
>> =C2=A0+ /*
>> =C2=A0+ * We migrate through unix-socket (> 500Mb/s).
>> =C2=A0+ * Thus, expected migration speed ~=3D bandwidth limit (< 500Mb=
/s).
>> =C2=A0+ * So, we can predict expected_threshold
>> =C2=A0+ */
>> =C2=A0+ const int64_t expected_threshold =3D max_bandwidth * downtime_=
limit / 1000;
>> =C2=A0+
>> =C2=A0+ if (test_migrate_start(&from, &to, uri, false, false)) {
>> =C2=A0+ return;
>> =C2=A0+ }
>> =C2=A0+
>> =C2=A0+ migrate_set_capability(from, "auto-converge", true);
>> =C2=A0+ migrate_set_parameter_int(from, "cpu-throttle-initial", expect=
ed_pcts[1]);
>> =C2=A0+ migrate_set_parameter_int(from, "cpu-throttle-increment",
>> =C2=A0+ expected_pcts[2] - expected_pcts[1]);
>> =C2=A0+ migrate_set_parameter_int(from, "max-cpu-throttle", expected_p=
cts[3]);
>> =C2=A0+
>> =C2=A0+ migrate_set_parameter_int(from, "max-bandwidth", max_bandwidth=
);
>> =C2=A0+ migrate_set_parameter_int(from, "downtime-limit", downtime_lim=
it);
>> =C2=A0+
>> =C2=A0+ /* To check remaining size after precopy */
>> =C2=A0+ migrate_set_capability(from, "pause-before-switchover", true);
>> =C2=A0+
>> =C2=A0+ /* Wait for the first serial output from the source */
>> =C2=A0+ wait_for_serial("src_serial");
>> =C2=A0+
>> =C2=A0+ migrate(from, uri, "{}");
>> =C2=A0+
>> =C2=A0+ for (i =3D 0; i < ARRAY_SIZE(expected_pcts); i++) {
>> =C2=A0+ int64_t pct;
>> =C2=A0+ pct =3D read_migrate_property_int(from, "cpu-throttle-percenta=
ge");
>> =C2=A0+ g_assert_cmpint(pct, =3D=3D, expected_pcts[i]);
>> =C2=A0+ while (pct =3D=3D expected_pcts[i] && !got_stop) {
>> =C2=A0+ usleep(1000);
>> =C2=A0+ pct =3D read_migrate_property_int(from, "cpu-throttle-percenta=
ge");
>> =C2=A0+ }
>> =C2=A0+ /* We break out of this loop only in paused state */
>> =C2=A0+ if (got_stop || i + 1 =3D=3D ARRAY_SIZE(expected_pcts)) {
>> =C2=A0+ /* Check unexpected throttle percentage change */
>> =C2=A0+ g_assert_true(got_stop);
>> =C2=A0+ /* Check unexpected converge */
>> =C2=A0+ g_assert_cmpint(i + 1, =3D=3D, ARRAY_SIZE(expected_pcts));
>> =C2=A0+ g_assert_true(check_migration_status(from, "pre-switchover"));
>> =C2=A0+ }
>> =C2=A0+ }
>> =C2=A0+
>> =C2=A0+ remaining =3D read_ram_property_int(from, "remaining");
>> =C2=A0+ g_assert_cmpint(remaining, <, expected_threshold);
>> =C2=A0+
>> =C2=A0+ wait_command(from, "{ 'execute': 'migrate-continue' , 'argumen=
ts':"
>> =C2=A0+ " { 'state': 'pre-switchover' } }");
>> =C2=A0+
>> =C2=A0+ qtest_qmp_eventwait(to, "RESUME");
>> =C2=A0+
>> =C2=A0+ wait_for_serial("dest_serial");
>> =C2=A0+ wait_for_migration_complete(from);
>> =C2=A0+
>> =C2=A0+ downtime =3D read_migrate_property_int(from, "downtime");
>> =C2=A0+ /*
>> =C2=A0+ * Actual downtime may be greater than downtime limit,
>> =C2=A0+ * but the difference should be small enough (~20ms)
>> =C2=A0+ */
>> =C2=A0+ g_assert_cmpint(downtime, <, downtime_limit + 20);
>> =C2=A0+
>> =C2=A0+ g_free(uri);
>> =C2=A0+
>> =C2=A0+ test_migrate_end(from, to, true);
>> =C2=A0+}
>> =C2=A0+
>> =C2=A0=C2=A0int main(int argc, char **argv)
>> =C2=A0=C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0char template[] =3D "/tmp/migratio=
n-test-XXXXXX";
>> =C2=A0@@ -1176,6 +1272,7 @@ int main(int argc, char **argv)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* qtest_add_func("/migration/igno=
re_shared", test_ignore_shared); */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qtest_add_func("/migration/xbzrle/=
unix", test_xbzrle_unix);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qtest_add_func("/migration/fd_prot=
o", test_migrate_fd_proto);
>> =C2=A0+ qtest_add_func("/migration/auto_converge", test_migrate_auto_c=
onverge);
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D g_test_run();
>>
>> =C2=A0--
>> =C2=A02.22.0
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

Regards,
Yury

