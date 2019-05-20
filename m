Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A956DC04AAF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 06:44:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 729BC206B6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 06:44:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 729BC206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58953 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSc2D-0000Zc-Ps
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 02:44:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hSc1T-0000C9-E0
	for qemu-devel@nongnu.org; Mon, 20 May 2019 02:43:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hSc1S-0004vc-3E
	for qemu-devel@nongnu.org; Mon, 20 May 2019 02:43:47 -0400
Received: from mga14.intel.com ([192.55.52.115]:22241)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hSc1R-0004v8-Qt
	for qemu-devel@nongnu.org; Mon, 20 May 2019 02:43:46 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	19 May 2019 23:43:44 -0700
X-ExtLoop1: 1
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by orsmga008.jf.intel.com with ESMTP; 19 May 2019 23:43:42 -0700
Date: Mon, 20 May 2019 14:43:12 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Juan Quintela <quintela@redhat.com>
Message-ID: <20190520064312.GC6718@richard>
References: <20190515121544.4597-1-quintela@redhat.com>
	<20190515121544.4597-3-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515121544.4597-3-quintela@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.115
Subject: Re: [Qemu-devel] [PATCH v3 2/8] migration-test: rename parameter to
 parameter_int
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

On Wed, May 15, 2019 at 02:15:38PM +0200, Juan Quintela wrote:
>We would need _str ones on the next patch.
>
>Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>

>---
> tests/migration-test.c | 49 +++++++++++++++++++++---------------------
> 1 file changed, 25 insertions(+), 24 deletions(-)
>
>diff --git a/tests/migration-test.c b/tests/migration-test.c
>index bd3f5c3125..0b25aa3d6c 100644
>--- a/tests/migration-test.c
>+++ b/tests/migration-test.c
>@@ -392,7 +392,8 @@ static char *migrate_get_socket_address(QTestState *who, const char *parameter)
>     return result;
> }
> 
>-static long long migrate_get_parameter(QTestState *who, const char *parameter)
>+static long long migrate_get_parameter_int(QTestState *who,
>+                                           const char *parameter)
> {
>     QDict *rsp;
>     long long result;
>@@ -403,17 +404,17 @@ static long long migrate_get_parameter(QTestState *who, const char *parameter)
>     return result;
> }
> 
>-static void migrate_check_parameter(QTestState *who, const char *parameter,
>-                                    long long value)
>+static void migrate_check_parameter_int(QTestState *who, const char *parameter,
>+                                        long long value)
> {
>     long long result;
> 
>-    result = migrate_get_parameter(who, parameter);
>+    result = migrate_get_parameter_int(who, parameter);
>     g_assert_cmpint(result, ==, value);
> }
> 
>-static void migrate_set_parameter(QTestState *who, const char *parameter,
>-                                  long long value)
>+static void migrate_set_parameter_int(QTestState *who, const char *parameter,
>+                                      long long value)
> {
>     QDict *rsp;
> 
>@@ -423,7 +424,7 @@ static void migrate_set_parameter(QTestState *who, const char *parameter,
>                     parameter, value);
>     g_assert(qdict_haskey(rsp, "return"));
>     qobject_unref(rsp);
>-    migrate_check_parameter(who, parameter, value);
>+    migrate_check_parameter_int(who, parameter, value);
> }
> 
> static void migrate_pause(QTestState *who)
>@@ -672,7 +673,7 @@ static void deprecated_set_downtime(QTestState *who, const double value)
>                     " 'arguments': { 'value': %f } }", value);
>     g_assert(qdict_haskey(rsp, "return"));
>     qobject_unref(rsp);
>-    migrate_check_parameter(who, "downtime-limit", value * 1000);
>+    migrate_check_parameter_int(who, "downtime-limit", value * 1000);
> }
> 
> static void deprecated_set_speed(QTestState *who, long long value)
>@@ -683,7 +684,7 @@ static void deprecated_set_speed(QTestState *who, long long value)
>                           "'arguments': { 'value': %lld } }", value);
>     g_assert(qdict_haskey(rsp, "return"));
>     qobject_unref(rsp);
>-    migrate_check_parameter(who, "max-bandwidth", value);
>+    migrate_check_parameter_int(who, "max-bandwidth", value);
> }
> 
> static void deprecated_set_cache_size(QTestState *who, long long value)
>@@ -694,7 +695,7 @@ static void deprecated_set_cache_size(QTestState *who, long long value)
>                          "'arguments': { 'value': %lld } }", value);
>     g_assert(qdict_haskey(rsp, "return"));
>     qobject_unref(rsp);
>-    migrate_check_parameter(who, "xbzrle-cache-size", value);
>+    migrate_check_parameter_int(who, "xbzrle-cache-size", value);
> }
> 
> static void test_deprecated(void)
>@@ -729,8 +730,8 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
>      * quickly, but that it doesn't complete precopy even on a slow
>      * machine, so also set the downtime.
>      */
>-    migrate_set_parameter(from, "max-bandwidth", 100000000);
>-    migrate_set_parameter(from, "downtime-limit", 1);
>+    migrate_set_parameter_int(from, "max-bandwidth", 100000000);
>+    migrate_set_parameter_int(from, "downtime-limit", 1);
> 
>     /* Wait for the first serial output from the source */
>     wait_for_serial("src_serial");
>@@ -781,7 +782,7 @@ static void test_postcopy_recovery(void)
>     }
> 
>     /* Turn postcopy speed down, 4K/s is slow enough on any machines */
>-    migrate_set_parameter(from, "max-postcopy-bandwidth", 4096);
>+    migrate_set_parameter_int(from, "max-postcopy-bandwidth", 4096);
> 
>     /* Now we start the postcopy */
>     migrate_postcopy_start(from, to);
>@@ -822,7 +823,7 @@ static void test_postcopy_recovery(void)
>     g_free(uri);
> 
>     /* Restore the postcopy bandwidth to unlimited */
>-    migrate_set_parameter(from, "max-postcopy-bandwidth", 0);
>+    migrate_set_parameter_int(from, "max-postcopy-bandwidth", 0);
> 
>     migrate_postcopy_complete(from, to);
> }
>@@ -868,9 +869,9 @@ static void test_precopy_unix(void)
>      * machine, so also set the downtime.
>      */
>     /* 1 ms should make it not converge*/
>-    migrate_set_parameter(from, "downtime-limit", 1);
>+    migrate_set_parameter_int(from, "downtime-limit", 1);
>     /* 1GB/s */
>-    migrate_set_parameter(from, "max-bandwidth", 1000000000);
>+    migrate_set_parameter_int(from, "max-bandwidth", 1000000000);
> 
>     /* Wait for the first serial output from the source */
>     wait_for_serial("src_serial");
>@@ -880,7 +881,7 @@ static void test_precopy_unix(void)
>     wait_for_migration_pass(from);
> 
>     /* 300 ms should converge */
>-    migrate_set_parameter(from, "downtime-limit", 300);
>+    migrate_set_parameter_int(from, "downtime-limit", 300);
> 
>     if (!got_stop) {
>         qtest_qmp_eventwait(from, "STOP");
>@@ -947,11 +948,11 @@ static void test_xbzrle(const char *uri)
>      * machine, so also set the downtime.
>      */
>     /* 1 ms should make it not converge*/
>-    migrate_set_parameter(from, "downtime-limit", 1);
>+    migrate_set_parameter_int(from, "downtime-limit", 1);
>     /* 1GB/s */
>-    migrate_set_parameter(from, "max-bandwidth", 1000000000);
>+    migrate_set_parameter_int(from, "max-bandwidth", 1000000000);
> 
>-    migrate_set_parameter(from, "xbzrle-cache-size", 33554432);
>+    migrate_set_parameter_int(from, "xbzrle-cache-size", 33554432);
> 
>     migrate_set_capability(from, "xbzrle", "true");
>     migrate_set_capability(to, "xbzrle", "true");
>@@ -963,7 +964,7 @@ static void test_xbzrle(const char *uri)
>     wait_for_migration_pass(from);
> 
>     /* 300ms should converge */
>-    migrate_set_parameter(from, "downtime-limit", 300);
>+    migrate_set_parameter_int(from, "downtime-limit", 300);
> 
>     if (!got_stop) {
>         qtest_qmp_eventwait(from, "STOP");
>@@ -999,9 +1000,9 @@ static void test_precopy_tcp(void)
>      * machine, so also set the downtime.
>      */
>     /* 1 ms should make it not converge*/
>-    migrate_set_parameter(from, "downtime-limit", 1);
>+    migrate_set_parameter_int(from, "downtime-limit", 1);
>     /* 1GB/s */
>-    migrate_set_parameter(from, "max-bandwidth", 1000000000);
>+    migrate_set_parameter_int(from, "max-bandwidth", 1000000000);
> 
>     /* Wait for the first serial output from the source */
>     wait_for_serial("src_serial");
>@@ -1013,7 +1014,7 @@ static void test_precopy_tcp(void)
>     wait_for_migration_pass(from);
> 
>     /* 300ms should converge */
>-    migrate_set_parameter(from, "downtime-limit", 300);
>+    migrate_set_parameter_int(from, "downtime-limit", 300);
> 
>     if (!got_stop) {
>         qtest_qmp_eventwait(from, "STOP");
>-- 
>2.21.0
>

-- 
Wei Yang
Help you, Help me

