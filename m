Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00193C04AAC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 03:12:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3F612173E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 03:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3F612173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45634 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSvCc-0001Pj-3T
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 23:12:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hSvBo-00016L-VN
	for qemu-devel@nongnu.org; Mon, 20 May 2019 23:11:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hSvBn-0003QO-NY
	for qemu-devel@nongnu.org; Mon, 20 May 2019 23:11:44 -0400
Received: from mga01.intel.com ([192.55.52.88]:43974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hSvBn-0003Pk-ER
	for qemu-devel@nongnu.org; Mon, 20 May 2019 23:11:43 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	20 May 2019 20:11:42 -0700
X-ExtLoop1: 1
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by fmsmga006.fm.intel.com with ESMTP; 20 May 2019 20:11:40 -0700
Date: Tue, 21 May 2019 11:11:10 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Juan Quintela <quintela@redhat.com>
Message-ID: <20190521031110.GB24543@richard>
References: <20190515121544.4597-1-quintela@redhat.com>
	<20190515121544.4597-9-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515121544.4597-9-quintela@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.88
Subject: Re: [Qemu-devel] [PATCH v3 8/8] multifd: rest of zlib compression
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

On Wed, May 15, 2019 at 02:15:44PM +0200, Juan Quintela wrote:
>This is still a work in progress, but get everything sent as expected
>and it is faster than the code that is already there.

Generally, I prefer to merge this one with previous one.

>
>Signed-off-by: Juan Quintela <quintela@redhat.com>
>---
> migration/ram.c | 106 +++++++++++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 104 insertions(+), 2 deletions(-)
>
>diff --git a/migration/ram.c b/migration/ram.c
>index fdb5bf07a5..efbb253c1a 100644
>--- a/migration/ram.c
>+++ b/migration/ram.c
>@@ -747,6 +747,100 @@ MultifdMethods multifd_none_ops = {
>     .recv_pages = none_recv_pages
> };
> 
>+/* Multifd zlib compression */
>+
>+static int zlib_send_prepare(MultiFDSendParams *p, uint32_t used)
>+{
>+    struct iovec *iov = p->pages->iov;
>+    z_stream *zs = &p->zs;
>+    uint32_t out_size = 0;
>+    int ret;
>+    int i;
>+
>+    for (i = 0; i < used; i++) {
>+        uint32_t available = p->zbuff_len - out_size;
>+        int flush = Z_NO_FLUSH;
>+
>+        if (i == used  - 1) {
>+            flush = Z_SYNC_FLUSH;
>+        }
>+
>+        zs->avail_in = iov[i].iov_len;
>+        zs->next_in = iov[i].iov_base;
>+
>+        zs->avail_out = available;
>+        zs->next_out = p->zbuff + out_size;
>+
>+        ret = deflate(zs, flush);
>+        if (ret != Z_OK) {
>+            printf("problem with deflate? %d\n", ret);
>+            qemu_mutex_unlock(&p->mutex);
>+            return -1;
>+        }
>+        out_size += available - zs->avail_out;
>+    }
>+    p->next_packet_size = out_size;
>+
>+    return 0;
>+}
>+
>+static int zlib_send_write(MultiFDSendParams *p, uint32_t used, Error **perr)
>+{
>+    return qio_channel_write_all(p->c, (void *)p->zbuff, p->next_packet_size,
>+                                 perr);
>+}
>+
>+static int zlib_recv_pages(MultiFDRecvParams *p, uint32_t used, Error **perr)
>+{
>+    uint32_t in_size = p->next_packet_size;
>+    uint32_t out_size = 0;
>+    uint32_t expected_size = used * qemu_target_page_size();
>+    z_stream *zs = &p->zs;
>+    int ret;
>+    int i;
>+
>+    ret = qio_channel_read_all(p->c, (void *)p->zbuff, in_size, perr);
>+
>+    if (ret != 0) {
>+        return ret;
>+    }
>+
>+    zs->avail_in = in_size;
>+    zs->next_in = p->zbuff;
>+
>+    for (i = 0; i < used; i++) {
>+        struct iovec *iov = &p->pages->iov[i];
>+        int flush = Z_NO_FLUSH;
>+
>+        if (i == used  - 1) {
>+            flush = Z_SYNC_FLUSH;
>+        }
>+
>+        zs->avail_out = iov->iov_len;
>+        zs->next_out = iov->iov_base;
>+
>+        ret = inflate(zs, flush);
>+        if (ret != Z_OK) {
>+            printf("%d: problem with inflate? %d\n", p->id, ret);
>+            qemu_mutex_unlock(&p->mutex);
>+            return ret;
>+        }
>+        out_size += iov->iov_len;
>+    }
>+    if (out_size != expected_size) {
>+        printf("out size %d expected size %d\n",
>+               out_size, expected_size);
>+        return -1;
>+    }
>+    return 0;
>+}
>+
>+MultifdMethods multifd_zlib_ops = {
>+    .send_prepare = zlib_send_prepare,
>+    .send_write = zlib_send_write,
>+    .recv_pages = zlib_recv_pages
>+};
>+
> static int multifd_send_initial_packet(MultiFDSendParams *p, Error **errp)
> {
>     MultiFDInit_t msg;
>@@ -1145,7 +1239,11 @@ static void *multifd_send_thread(void *opaque)
>     /* initial packet */
>     p->num_packets = 1;
> 
>-    multifd_send_state->ops = &multifd_none_ops;
>+    if (migrate_use_multifd_zlib()) {
>+        multifd_send_state->ops = &multifd_zlib_ops;
>+    } else {
>+        multifd_send_state->ops = &multifd_none_ops;
>+    }

Again, to manipulate a global variable in each thread is not a good idea.

This would be better to use an array to assign ops instead of *if*. In case
you would have several compress methods, the code would be difficult to read.

> 
>     while (true) {
>         qemu_sem_wait(&p->sem);
>@@ -1399,7 +1497,11 @@ static void *multifd_recv_thread(void *opaque)
>     trace_multifd_recv_thread_start(p->id);
>     rcu_register_thread();
> 
>-    multifd_recv_state->ops = &multifd_none_ops;
>+    if (migrate_use_multifd_zlib()) {
>+        multifd_recv_state->ops = &multifd_zlib_ops;
>+    } else {
>+        multifd_recv_state->ops = &multifd_none_ops;
>+    }
>     while (true) {
>         uint32_t used;
>         uint32_t flags;
>-- 
>2.21.0
>

-- 
Wei Yang
Help you, Help me

