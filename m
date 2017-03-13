Received: from eggs.gnu.org ([2001:4830:134:3::10]:42841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4X-0000cc-IG
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4W-0002PS-J8
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnW4W-0002Ok-CQ
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:00 -0400
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4F2337AEBF
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 19:56:00 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 13 Mar 2017 14:55:23 -0500
Message-Id: <20170313195547.21466-7-eblake@redhat.com>
In-Reply-To: <20170313195547.21466-1-eblake@redhat.com>
References: <20170313195547.21466-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 06/30] trace: Fix parameter types in
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

An upcoming patch will let the compiler warn us when we are silently
losing precision in traces; update the trace definitions to pass
through the full value at the callsite.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 migration/trace-events | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/trace-events b/migration/trace-events
index 7372ce2..079d4e6 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -7,7 +7,7 @@ qemu_loadvm_state_section_partend(uint32_t section_id) "%u"
 qemu_loadvm_state_post_main(int ret) "%d"
 qemu_loadvm_state_section_startfull(uint32_t section_id, const char *idstr, uint32_t instance_id, uint32_t version_id) "%u(%s) %u %u"
 qemu_savevm_send_packaged(void) ""
-loadvm_handle_cmd_packaged(unsigned int length) "%u"
+loadvm_handle_cmd_packaged(size_t length) "%zu"
 loadvm_handle_cmd_packaged_main(int ret) "%d"
 loadvm_handle_cmd_packaged_received(int ret) "%d"
 loadvm_postcopy_handle_advise(void) ""
@@ -186,7 +186,7 @@ postcopy_ram_enable_notify(void) ""
 postcopy_ram_fault_thread_entry(void) ""
 postcopy_ram_fault_thread_exit(void) ""
 postcopy_ram_fault_thread_quit(void) ""
-postcopy_ram_fault_thread_request(uint64_t hostaddr, const char *ramblock, size_t offset) "Request for HVA=%" PRIx64 " rb=%s offset=%zx"
+postcopy_ram_fault_thread_request(unsigned long long hostaddr, const char *ramblock, size_t offset) "Request for HVA=%llx rb=%s offset=%zx"
 postcopy_ram_incoming_cleanup_closeuf(void) ""
 postcopy_ram_incoming_cleanup_entry(void) ""
 postcopy_ram_incoming_cleanup_exit(void) ""
-- 
2.9.3
