Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFBBC4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 16:57:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C1242086A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 16:57:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C1242086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32995 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hak5s-0001P7-L5
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 12:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51655)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <quintela@redhat.com>) id 1hak2F-0007K7-Lj
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 12:54:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1hajzB-0001qW-4g
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 12:51:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44800)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hajz8-0001Zi-2S
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 12:51:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A48EDC18B2EE;
 Tue, 11 Jun 2019 16:50:34 +0000 (UTC)
Received: from redhat.com (ovpn-117-129.ams2.redhat.com [10.36.117.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 257E95DA99;
 Tue, 11 Jun 2019 16:50:33 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
In-Reply-To: <20190521030745.GA24543@richard> (Wei Yang's message of "Tue, 21
 May 2019 11:07:45 +0800")
References: <20190515121544.4597-1-quintela@redhat.com>
 <20190515121544.4597-8-quintela@redhat.com>
 <20190521030745.GA24543@richard>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date: Tue, 11 Jun 2019 18:50:31 +0200
Message-ID: <87o934nk14.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Tue, 11 Jun 2019 16:50:34 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 7/8] multifd: Add zlib compression
 support
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
Reply-To: quintela@redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Wei Yang <richardw.yang@linux.intel.com> wrote:
> On Wed, May 15, 2019 at 02:15:43PM +0200, Juan Quintela wrote:

>> 
>> #define MULTIFD_FLAG_SYNC (1 << 0)
>>+#define MULTIFD_FLAG_ZLIB (1 << 1)
>> 
>
> If no one use this in this patch, prefer to put it where it will be used.

Oops, you are right, I have to use it.

>>@@ -1253,6 +1270,17 @@ int multifd_save_setup(void)
>>         p->packet = g_malloc0(p->packet_len);
>>         p->name = g_strdup_printf("multifdsend_%d", i);
>>         socket_send_channel_create(multifd_new_send_channel_async, p);
>>+        zs->zalloc = Z_NULL;
>>+        zs->zfree = Z_NULL;
>>+        zs->opaque = Z_NULL;
>
> Since zlib is not default option, is it better to setup these when zlib is
> set?

Moved to an opaque void *data pointer, thanks.

>>+        if (deflateInit(zs, migrate_compress_level()) != Z_OK) {
>>+            printf("deflate init failed\n");
>>+            return -1;
>>+        }
>>+        /* We will never have more than page_count pages */
>>+        p->zbuff_len = page_count * qemu_target_page_size();
>>+        p->zbuff_len *= 2;
>>+        p->zbuff = g_malloc0(p->zbuff_len);
>>     }
>>     return 0;
>> }
>>@@ -1322,6 +1350,9 @@ int multifd_load_cleanup(Error **errp)
>>         p->packet_len = 0;
>>         g_free(p->packet);
>>         p->packet = NULL;
>>+        inflateEnd(&p->zs);
>>+        g_free(p->zbuff);
>>+        p->zbuff = NULL;
>>     }
>>     qemu_sem_destroy(&multifd_recv_state->sem_sync);
>>     g_free(multifd_recv_state->params);
>>@@ -1440,6 +1471,7 @@ int multifd_load_setup(void)
>> 
>>     for (i = 0; i < thread_count; i++) {
>>         MultiFDRecvParams *p = &multifd_recv_state->params[i];
>>+        z_stream *zs = &p->zs;
>> 
>>         qemu_mutex_init(&p->mutex);
>>         qemu_sem_init(&p->sem_sync, 0);
>>@@ -1449,6 +1481,21 @@ int multifd_load_setup(void)
>>                       + sizeof(ram_addr_t) * page_count;
>>         p->packet = g_malloc0(p->packet_len);
>>         p->name = g_strdup_printf("multifdrecv_%d", i);
>>+
>>+        zs->zalloc = Z_NULL;
>>+        zs->zfree = Z_NULL;
>>+        zs->opaque = Z_NULL;
>>+        zs->avail_in = 0;
>>+        zs->next_in = Z_NULL;
>>+        if (inflateInit(zs) != Z_OK) {
>>+            printf("inflate init failed\n");
>>+            return -1;
>>+        }
>>+        /* We will never have more than page_count pages */
>>+        p->zbuff_len = page_count * qemu_target_page_size();
>>+        /* We know compression "could" use more space */
>>+        p->zbuff_len *= 2;
>>+        p->zbuff = g_malloc0(p->zbuff_len);
>>     }
>>     return 0;
>> }
>>diff --git a/qapi/migration.json b/qapi/migration.json
>>index 8ec1944b7a..e6c27fae06 100644
>>--- a/qapi/migration.json
>>+++ b/qapi/migration.json
>>@@ -493,7 +493,7 @@
>> #
>> ##
>> { 'enum': 'MultifdCompress',
>>-  'data': [ 'none' ] }
>>+  'data': [ 'none', 'zlib' ] }
>> 
>> ##
>> # @MigrationParameter:
>>diff --git a/tests/migration-test.c b/tests/migration-test.c
>>index 8a1ccc2516..2dd4d4c5b4 100644
>>--- a/tests/migration-test.c
>>+++ b/tests/migration-test.c
>>@@ -1119,6 +1119,11 @@ static void test_multifd_tcp_none(void)
>>     test_multifd_tcp("none");
>> }
>> 
>>+static void test_multifd_tcp_zlib(void)
>>+{
>>+    test_multifd_tcp("zlib");
>>+}
>>+
>> int main(int argc, char **argv)
>> {
>>     char template[] = "/tmp/migration-test-XXXXXX";
>>@@ -1174,6 +1179,7 @@ int main(int argc, char **argv)
>>     /* qtest_add_func("/migration/ignore_shared", test_ignore_shared); */
>>     qtest_add_func("/migration/xbzrle/unix", test_xbzrle_unix);
>>     qtest_add_func("/migration/multifd/tcp/none", test_multifd_tcp_none);
>>+    qtest_add_func("/migration/multifd/tcp/zlib", test_multifd_tcp_zlib);
>
> Actually zlib is not enabled at this moment, the test here may not touch the
> real functionality.

It is, see what the

   test_multifd_tcp("zlib");

line does for:


>>     test_multifd_tcp("none");
>> }
>> 
>>+static void test_multifd_tcp_zlib(void)
>>+{
>>+    test_multifd_tcp("zlib");
>>+}
>>+
>> int main(int argc, char **argv)
>> {
>>     char template[] = "/tmp/migration-test-XXXXXX";
>>@@ -1174,6 +1179,7 @@ int main(int argc, char **argv)
>>     /* qtest_add_func("/migration/ignore_shared", test_ignore_shared); */
>>     qtest_add_func("/migration/xbzrle/unix", test_xbzrle_unix);
>>     qtest_add_func("/migration/multifd/tcp/none", test_multifd_tcp_none);
>>+    qtest_add_func("/migration/multifd/tcp/zlib", test_multifd_tcp_zlib);
>
> Actually zlib is not enabled at this moment, the test here may not touch the
> real functionality.

It is, see what the

   test_multifd_tcp("zlib");

line does for:

static void test_multifd_tcp(const char *method)
{
    ....
    migrate_set_parameter_str(from, "multifd-compress", method);
    migrate_set_parameter_str(to, "multifd-compress", method);

    ...
}

Thanks, Juan.

