Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF104C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 14:14:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4535204FD
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 14:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g9/CHPKf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4535204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3gfA-0004Zo-V6
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 10:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k3geP-0003la-6D
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 10:13:45 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44823
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k3geM-0007QK-Kc
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 10:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596723221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WG4rDVK4hLnPiAcbpUxCEOKIa8bW5QgZwnRfN3yr4LQ=;
 b=g9/CHPKfqcdvooZDJY+gaFSeCWxtzG+S9l/Ak7ig0IDDh16H77RQ1BBV2dYLuduN76ujB+
 MD6l2vE+xZsQ2ciVQtYfS2tpEk9obWa+dOdIKhJDZ6mbCIWA0zr/TG5HnVFTsOtTH9M3Q0
 znd40M9UPL7t5eLsnC5i2EhuDyYWEBY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-DSgcOl6EP5SH5199cXN9RQ-1; Thu, 06 Aug 2020 10:13:39 -0400
X-MC-Unique: DSgcOl6EP5SH5199cXN9RQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7C9C1005504
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2020 14:13:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A59EB5FC36;
 Thu,  6 Aug 2020 14:13:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 282EC10FDD9E; Thu,  6 Aug 2020 16:13:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] trace-events: Delete unused trace points
Date: Thu,  6 Aug 2020 16:13:33 +0200
Message-Id: <20200806141334.3646302-4-armbru@redhat.com>
In-Reply-To: <20200806141334.3646302-1-armbru@redhat.com>
References: <20200806141334.3646302-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:07:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: philmd@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Tracked down with the help of scripts/cleanup-trace-events.pl.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 audio/trace-events      | 3 ---
 block/trace-events      | 3 ---
 hw/misc/trace-events    | 1 -
 hw/ppc/trace-events     | 4 ----
 hw/timer/trace-events   | 1 -
 migration/trace-events  | 1 -
 target/ppc/trace-events | 1 -
 7 files changed, 14 deletions(-)

diff --git a/audio/trace-events b/audio/trace-events
index a1d1eccb8a..6aec535763 100644
--- a/audio/trace-events
+++ b/audio/trace-events
@@ -9,12 +9,9 @@ alsa_read_zero(long len) "Failed to read %ld frames (read zero)"
 alsa_xrun_out(void) "Recovering from playback xrun"
 alsa_xrun_in(void) "Recovering from capture xrun"
 alsa_resume_out(void) "Resuming suspended output stream"
-alsa_resume_in(void) "Resuming suspended input stream"
-alsa_no_frames(int state) "No frames available and ALSA state is %d"
 
 # ossaudio.c
 oss_version(int version) "OSS version = 0x%x"
-oss_invalid_available_size(int size, int bufsize) "Invalid available size, size=%d bufsize=%d"
 
 # audio.c
 audio_timer_start(int interval) "interval %d ms"
diff --git a/block/trace-events b/block/trace-events
index 9158335061..778140d304 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -42,7 +42,6 @@ backup_do_cow_enter(void *job, int64_t start, int64_t offset, uint64_t bytes) "j
 backup_do_cow_return(void *job, int64_t offset, uint64_t bytes, int ret) "job %p offset %" PRId64 " bytes %" PRIu64 " ret %d"
 
 # block-copy.c
-block_copy_skip(void *bcs, int64_t start) "bcs %p start %"PRId64
 block_copy_skip_range(void *bcs, int64_t start, uint64_t bytes) "bcs %p start %"PRId64" bytes %"PRId64
 block_copy_process(void *bcs, int64_t start) "bcs %p start %"PRId64
 block_copy_copy_range_fail(void *bcs, int64_t start, int ret) "bcs %p start %"PRId64" ret %d"
@@ -200,8 +199,6 @@ curl_setup_preadv(uint64_t bytes, uint64_t start, const char *range) "reading %"
 curl_close(void) "close"
 
 # file-posix.c
-file_xfs_write_zeroes(const char *error) "cannot write zero range (%s)"
-file_xfs_discard(const char *error) "cannot punch hole (%s)"
 file_FindEjectableOpticalMedia(const char *media) "Matching using %s"
 file_setup_cdrom(const char *partition) "Using %s as optical disc"
 file_hdev_is_sg(int type, int version) "SG device found: type=%d, version=%d"
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 066752aa90..f9a0ba1a93 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -44,7 +44,6 @@ ecc_diag_mem_writeb(uint64_t addr, uint32_t val) "Write diagnostic %"PRId64" = 0
 ecc_diag_mem_readb(uint64_t addr, uint32_t ret) "Read diagnostic %"PRId64"= 0x%02x"
 
 # empty_slot.c
-empty_slot_read(uint64_t addr, unsigned width, uint64_t value, unsigned size, const char *name) "rd addr:0x%04"PRIx64" data:0x%0*"PRIx64" size %u [%s]"
 empty_slot_write(uint64_t addr, unsigned width, uint64_t value, unsigned size, const char *name) "wr addr:0x%04"PRIx64" data:0x%0*"PRIx64" size %u [%s]"
 
 # slavio_misc.c
diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
index 7c0be4102e..ca34244e2a 100644
--- a/hw/ppc/trace-events
+++ b/hw/ppc/trace-events
@@ -10,7 +10,6 @@ spapr_pci_lsi_set(const char *busname, int pin, uint32_t irq) "%s PIN%d IRQ %u"
 spapr_pci_msi_retry(unsigned config_addr, unsigned req_num, unsigned max_irqs) "Guest device at 0x%x asked %u, have only %u"
 
 # spapr.c
-spapr_cas_failed(unsigned long n) "DT diff buffer is too small: %ld bytes"
 spapr_cas_continue(unsigned long n) "Copy changes to the guest: %ld bytes"
 
 # spapr_hcall.c
@@ -77,9 +76,6 @@ spapr_vio_free_crq(uint32_t reg) "CRQ for dev 0x%" PRIx32 " freed"
 # ppc.c
 ppc_tb_adjust(uint64_t offs1, uint64_t offs2, int64_t diff, int64_t seconds) "adjusted from 0x%"PRIx64" to 0x%"PRIx64", diff %"PRId64" (%"PRId64"s)"
 
-# prep.c
-prep_io_800_writeb(uint32_t addr, uint32_t val) "0x%08" PRIx32 " => 0x%02" PRIx32
-prep_io_800_readb(uint32_t addr, uint32_t retval) "0x%08" PRIx32 " <= 0x%02" PRIx32
 
 # prep_systemio.c
 prep_systemio_read(uint32_t addr, uint32_t val) "read addr=0x%x val=0x%x"
diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index 447b7c405b..1537c3e6ec 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -81,7 +81,6 @@ avr_timer16_read(uint8_t addr, uint8_t value) "timer16 read addr:%u value:%u"
 avr_timer16_read_ifr(uint8_t value) "timer16 read addr:ifr value:%u"
 avr_timer16_read_imsk(uint8_t value) "timer16 read addr:imsk value:%u"
 avr_timer16_write(uint8_t addr, uint8_t value) "timer16 write addr:%u value:%u"
-avr_timer16_write_ifr(uint8_t value) "timer16 write addr:ifr value:%u"
 avr_timer16_write_imsk(uint8_t value) "timer16 write addr:imsk value:%u"
 avr_timer16_interrupt_count(uint8_t cnt) "count: %u"
 avr_timer16_interrupt_overflow(const char *reason) "overflow: %s"
diff --git a/migration/trace-events b/migration/trace-events
index 4ab0a503d2..6f94106bfa 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -100,7 +100,6 @@ multifd_recv_sync_main_wait(uint8_t id) "channel %d"
 multifd_recv_terminate_threads(bool error) "error %d"
 multifd_recv_thread_end(uint8_t id, uint64_t packets, uint64_t pages) "channel %d packets %" PRIu64 " pages %" PRIu64
 multifd_recv_thread_start(uint8_t id) "%d"
-multifd_save_setup_wait(uint8_t id) "%d"
 multifd_send(uint8_t id, uint64_t packet_num, uint32_t used, uint32_t flags, uint32_t next_packet_size) "channel %d packet_num %" PRIu64 " pages %d flags 0x%x next packet size %d"
 multifd_send_error(uint8_t id) "channel %d"
 multifd_send_sync_main(long packet_num) "packet num %ld"
diff --git a/target/ppc/trace-events b/target/ppc/trace-events
index 6d15aa90b4..bc0d4e6f8b 100644
--- a/target/ppc/trace-events
+++ b/target/ppc/trace-events
@@ -20,7 +20,6 @@ kvm_failed_dtl_set(const char *msg) "Unable to set dispatch trace log state to K
 kvm_failed_null_vpa_addr_set(const char *msg) "Unable to set VPA address to KVM: %s"
 kvm_failed_put_vpa(void) "Warning: Unable to set VPA information to KVM"
 kvm_failed_get_vpa(void) "Warning: Unable to get VPA information from KVM"
-kvm_injected_interrupt(int irq) "injected interrupt %d"
 kvm_handle_dcr_write(void) "handle dcr write"
 kvm_handle_dcr_read(void) "handle dcr read"
 kvm_handle_halt(void) "handle halt"
-- 
2.26.2


