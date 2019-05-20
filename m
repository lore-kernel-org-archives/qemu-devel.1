Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE38C04AB4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 02:05:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5F6C2082C
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 02:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5F6C2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56321 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSXgK-00076G-2A
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 22:05:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hSXfD-0006iD-RW
	for qemu-devel@nongnu.org; Sun, 19 May 2019 22:04:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hSXfA-0007Jm-W4
	for qemu-devel@nongnu.org; Sun, 19 May 2019 22:04:30 -0400
Received: from mga01.intel.com ([192.55.52.88]:34696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hSXfA-0007I2-D9
	for qemu-devel@nongnu.org; Sun, 19 May 2019 22:04:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	19 May 2019 19:04:24 -0700
X-ExtLoop1: 1
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by orsmga007.jf.intel.com with ESMTP; 19 May 2019 19:04:22 -0700
Date: Mon, 20 May 2019 10:03:52 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Juan Quintela <quintela@redhat.com>
Message-ID: <20190520020352.GA9990@richard>
References: <20190515121544.4597-1-quintela@redhat.com>
	<20190515121544.4597-4-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515121544.4597-4-quintela@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.88
Subject: Re: [Qemu-devel] [PATCH v3 3/8] tests: Add migration multifd test
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 15, 2019 at 02:15:39PM +0200, Juan Quintela wrote:
>We set multifd-channels.
>
>Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>Reviewed-by: Thomas Huth <thuth@redhat.com>
>Signed-off-by: Juan Quintela <quintela@redhat.com>
>---
> tests/migration-test.c | 48 ++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 48 insertions(+)
>
>diff --git a/tests/migration-test.c b/tests/migration-test.c
>index 0b25aa3d6c..ff480e0682 100644
>--- a/tests/migration-test.c
>+++ b/tests/migration-test.c
>@@ -1028,6 +1028,53 @@ static void test_precopy_tcp(void)
>     g_free(uri);
> }
> 
>+static void test_multifd_tcp(void)
>+{
>+    char *uri;
>+    QTestState *from, *to;
>+
>+    if (test_migrate_start(&from, &to, "tcp:127.0.0.1:0", false, false)) {
>+        return;
>+    }
>+
>+    /*
>+     * We want to pick a speed slow enough that the test completes
>+     * quickly, but that it doesn't complete precopy even on a slow
>+     * machine, so also set the downtime.
>+     */
>+    /* 1 ms should make it not converge*/
>+    migrate_set_parameter_int(from, "downtime-limit", 1);
>+    /* 1GB/s */
>+    migrate_set_parameter_int(from, "max-bandwidth", 1000000000);
>+
>+    migrate_set_parameter_int(from, "multifd-channels", 2);
>+    migrate_set_parameter_int(to, "multifd-channels", 2);
>+
>+    migrate_set_capability(from, "multifd", "true");
>+    migrate_set_capability(to, "multifd", "true");

Hi, Juan

In case to test multifd, what's the minimum configuration? Set multifd
capability at both side is fine?

>+    /* Wait for the first serial output from the source */
>+    wait_for_serial("src_serial");
>+
>+    uri = migrate_get_socket_address(to, "socket-address");
>+
>+    migrate(from, uri, "{}");
>+
>+    wait_for_migration_pass(from);
>+
>+    /* 300ms it should converge */
>+    migrate_set_parameter_int(from, "downtime-limit", 600);
>+
>+    if (!got_stop) {
>+        qtest_qmp_eventwait(from, "STOP");
>+    }
>+    qtest_qmp_eventwait(to, "RESUME");
>+
>+    wait_for_serial("dest_serial");
>+    wait_for_migration_complete(from);
>+
>+    test_migrate_end(from, to, true);
>+}
>+
> int main(int argc, char **argv)
> {
>     char template[] = "/tmp/migration-test-XXXXXX";
>@@ -1082,6 +1129,7 @@ int main(int argc, char **argv)
>     qtest_add_func("/migration/precopy/tcp", test_precopy_tcp);
>     /* qtest_add_func("/migration/ignore_shared", test_ignore_shared); */
>     qtest_add_func("/migration/xbzrle/unix", test_xbzrle_unix);
>+    qtest_add_func("/migration/multifd/tcp", test_multifd_tcp);
> 
>     ret = g_test_run();
> 
>-- 
>2.21.0
>

-- 
Wei Yang
Help you, Help me

