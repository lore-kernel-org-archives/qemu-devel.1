Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB314CA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 18:38:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 894DD2064A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 18:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iowUVSae"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 894DD2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYZnV-0004kz-OX
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 14:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jYZmS-0003ss-B2
 for qemu-devel@nongnu.org; Tue, 12 May 2020 14:37:28 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57085
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jYZmP-0003FZ-Ld
 for qemu-devel@nongnu.org; Tue, 12 May 2020 14:37:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589308643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RBHa5Cuxad+m+bT1Szig6IiwRvnZWW/s/yP0tv/XhC8=;
 b=iowUVSaeYlRT93eH5C+L/XhhCNqZJV2fIvTyPoL3FINf7v+vepDpinYoORA4NWqPKMQK/+
 Fi+L85BbjZULqJcI8OuCMmOikRo+7Q/WYzYdDXLXT3VP/icACKSvFLF/hpxgAy1AZX/3ZU
 mJKSpTt1Mx0m4NjTc/8MOkJRtNgP9Qs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-oKZXa0InNieA3CkxYtir6g-1; Tue, 12 May 2020 14:37:17 -0400
X-MC-Unique: oKZXa0InNieA3CkxYtir6g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5178107B768;
 Tue, 12 May 2020 18:37:16 +0000 (UTC)
Received: from kaapi (unknown [10.40.193.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C8525D9DD;
 Tue, 12 May 2020 18:37:09 +0000 (UTC)
Date: Wed, 13 May 2020 00:07:06 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 0/2] use unsigned type for MegasasState fields
In-Reply-To: <26201c24-c483-85a7-2f4b-b3cc56d4b8b7@redhat.com>
Message-ID: <nycvar.YSQ.7.76.2005122357030.1451610@xnncv>
References: <20200507105718.1319187-1-ppandit@redhat.com>
 <26201c24-c483-85a7-2f4b-b3cc56d4b8b7@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed;
 boundary="-1463810047-489165051-1589308636=:1451610"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 02:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Ren Ding <rding@gatech.edu>,
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

---1463810047-489165051-1589308636=:1451610
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

+-- On Tue, 12 May 2020, Philippe Mathieu-Daudé wrote --+
| Cc'ing Marc-André our signed/unsigned conversion expert (with Paolo).

  megasas_init_firmware
    pa_lo = le32_to_cpu(initq->pi_addr_lo);
    pa_hi = le32_to_cpu(initq->pi_addr_hi);
    s->producer_pa = ((uint64_t) pa_hi << 32) | pa_lo;
    s->reply_queue_head = ldl_le_pci_dma(pcid, s->producer_pa);

IIUC, here ldl_le_pci_dma() returns an 'uint32_t' type, but since 
'reply_queue_head' is a signed int, large 'uint32_t' value turns negative.

| Do you have a reproducer?

  Yes, there is a reproducer with ASAN, though it did not work for me. 
Ren(CC'd) had shared this trace:

AddressSanitizer: heap-buffer-overflow on address 0x7f9159054058 at pc 0x55763514b5cd bp 0x7f9179bd6d90 sp 0x7f9179bd6d88
READ of size 8 at 0x7f9159054058 thread T2
  #0 0x55763514b5cc in megasas_lookup_frame /home/ren/tmp/redacted-dbg/qemu/hw/scsi/megasas.c:449:30
  #1 0x55763513205c in megasas_handle_abort /home/ren/tmp/redacted-dbg/qemu/hw/scsi/megasas.c:1904:17
  #2 0x55763512d0f8 in megasas_handle_frame /home/ren/tmp/redacted-dbg/qemu/hw/scsi/megasas.c:1961:24
  #3 0x55763512ba7d in megasas_mmio_write /home/ren/tmp/redacted-dbg/qemu/hw/scsi/megasas.c:2122:9
  #4 0x55763515247c in megasas_port_write /home/ren/tmp/redacted-dbg/qemu/hw/scsi/megasas.c:2173:5
  #5 0x557634621b3b in memory_region_write_accessor /home/ren/tmp/redacted-dbg/qemu/memory.c:483:5
  #6 0x557634621741 in access_with_adjusted_size /home/ren/tmp/redacted-dbg/qemu/memory.c:544:18
  #7 0x557634620498 in memory_region_dispatch_write /home/ren/tmp/redacted-dbg/qemu/memory.c:1482:16
  #8 0x5576344b6b6c in flatview_write_continue /home/ren/tmp/redacted-dbg/qemu/exec.c:3161:23
  #9 0x5576344a87d9 in flatview_write /home/ren/tmp/redacted-dbg/qemu/exec.c:3201:14
  #10 0x5576344a8376 in address_space_write /home/ren/tmp/redacted-dbg/qemu/exec.c:3291:18
  #11 0x5576344a8af4 in address_space_rw /home/ren/tmp/redacted-dbg/qemu/exec.c:3301:16
  #12 0x557634689e10 in kvm_handle_io /home/ren/tmp/redacted-dbg/qemu/accel/kvm/kvm-all.c:2086:9
  #13 0x557634688a45 in kvm_cpu_exec /home/ren/tmp/redacted-dbg/qemu/accel/kvm/kvm-all.c:2332:13
  #14 0x5576345ee7aa in qemu_kvm_cpu_thread_fn /home/ren/tmp/redacted-dbg/qemu/cpus.c:1299:17
  #15 0x557635a11509 in qemu_thread_start /home/ren/tmp/redacted-dbg/qemu/util/qemu-thread-posix.c:519:9
  #16 0x7f918cec26b9 in start_thread (/lib/x86_64-linux-gnu/libpthread.so.0+0x76b9)
  #17 0x7f918c5d441c in clone /build/glibc-LK5gWL/glibc-2.23/misc/../sysdeps/unix/sysv/linux/x86_64/clone.S:109


Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D
---1463810047-489165051-1589308636=:1451610--


