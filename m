Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC50C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 11:57:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A93B20737
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 11:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f3OFit0W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A93B20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqxqL-0001ln-8u
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 07:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jqxkM-0007t9-8F
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 07:51:18 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41774
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jqxkK-0007U7-BY
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 07:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593690675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=jkUPzi9L5jmllgRWaxn+RCUweDjsKiOMxRGkQnWS964=;
 b=f3OFit0WQOhRuDlQaro4E4GA515JdM3C6aLKx/9cJaGxkAcWyvugDKVD+rWh/8wrpdOHH2
 DL+AQlbobtdJlKu/2ASa6oVLiVO/4YJ0rF/bk9wM+15BisV3sR9bEFQwApF4yJ1FC/Y0sG
 K+kt3dkuZ46ZITbjJ+uf8Px5hvfPt8U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-2lI30-pIM1OhiEMle460IQ-1; Thu, 02 Jul 2020 07:51:13 -0400
X-MC-Unique: 2lI30-pIM1OhiEMle460IQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA08B8015FD;
 Thu,  2 Jul 2020 11:51:11 +0000 (UTC)
Received: from thuth.com (ovpn-113-212.ams2.redhat.com [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7C72A60CD3;
 Thu,  2 Jul 2020 11:51:10 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PULL SUBSYSTEM s390x 10/11] pc-bios/s390-ccw: Generate and include
 dependency files in the Makefile
Date: Thu,  2 Jul 2020 13:50:44 +0200
Message-Id: <20200702115045.6171-11-thuth@redhat.com>
In-Reply-To: <20200702115045.6171-1-thuth@redhat.com>
References: <20200702115045.6171-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 04:18:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Janosch Frank <frankja@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Makefile of the s390-ccw bios does not handle dependencies of the
*.c files from the headers yet, so that you often have to run a "make
clean" to get the build right when one of the headers has been changed.
Let's make sure that we generate and include dependency files for all
*.c files now to avoid this problem in the future.

Acked-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20200630142955.7662-1-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/Makefile    |  3 +++
 pc-bios/s390-ccw/netboot.mak | 13 +++++++------
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index a048b6b077..50bc880272 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -38,5 +38,8 @@ s390-netboot.img:
 	@echo "s390-netboot.img not built since roms/SLOF/ is not available."
 endif
 
+ALL_OBJS = $(sort $(OBJECTS) $(NETOBJS) $(LIBCOBJS) $(LIBNETOBJS))
+-include $(ALL_OBJS:%.o=%.d)
+
 clean:
 	rm -f *.o *.d *.img *.elf *~ *.a
diff --git a/pc-bios/s390-ccw/netboot.mak b/pc-bios/s390-ccw/netboot.mak
index 5eefb7c289..577c023afe 100644
--- a/pc-bios/s390-ccw/netboot.mak
+++ b/pc-bios/s390-ccw/netboot.mak
@@ -1,8 +1,7 @@
 
 SLOF_DIR := $(SRC_PATH)/roms/SLOF
 
-NETOBJS := start.o sclp.o cio.o virtio.o virtio-net.o jump2ipl.o netmain.o \
-	   libnet.a libc.a
+NETOBJS := start.o sclp.o cio.o virtio.o virtio-net.o jump2ipl.o netmain.o
 
 LIBC_INC := -nostdinc -I$(SLOF_DIR)/lib/libc/include
 LIBNET_INC := -I$(SLOF_DIR)/lib/libnet
@@ -11,15 +10,16 @@ NETLDFLAGS := $(LDFLAGS) -Ttext=0x7800000
 
 $(NETOBJS): QEMU_CFLAGS += $(LIBC_INC) $(LIBNET_INC)
 
-s390-netboot.elf: $(NETOBJS)
-	$(call quiet-command,$(CC) $(NETLDFLAGS) -o $@ $(NETOBJS),"BUILD","$(TARGET_DIR)$@")
+s390-netboot.elf: $(NETOBJS) libnet.a libc.a
+	$(call quiet-command,$(CC) $(NETLDFLAGS) -o $@ $^,"BUILD","$(TARGET_DIR)$@")
 
 s390-netboot.img: s390-netboot.elf
 	$(call quiet-command,$(STRIP) --strip-unneeded $< -o $@,"STRIP","$(TARGET_DIR)$@")
 
 # libc files:
 
-LIBC_CFLAGS :=  $(QEMU_CFLAGS) $(CFLAGS) $(LIBC_INC) $(LIBNET_INC)
+LIBC_CFLAGS = $(QEMU_CFLAGS) $(CFLAGS) $(LIBC_INC) $(LIBNET_INC) \
+	      -MMD -MP -MT $@ -MF $(@:%.o=%.d)
 
 CTYPE_OBJS = isdigit.o isxdigit.o toupper.o
 %.o : $(SLOF_DIR)/lib/libc/ctype/%.c
@@ -52,7 +52,8 @@ libc.a: $(LIBCOBJS)
 
 LIBNETOBJS := args.o dhcp.o dns.o icmpv6.o ipv6.o tcp.o udp.o bootp.o \
 	      dhcpv6.o ethernet.o ipv4.o ndp.o tftp.o pxelinux.o
-LIBNETCFLAGS := $(QEMU_CFLAGS) $(CFLAGS) -DDHCPARCH=0x1F $(LIBC_INC) $(LIBNET_INC)
+LIBNETCFLAGS = $(QEMU_CFLAGS) $(CFLAGS) $(LIBC_INC) $(LIBNET_INC) \
+	       -DDHCPARCH=0x1F -MMD -MP -MT $@ -MF $(@:%.o=%.d)
 
 %.o : $(SLOF_DIR)/lib/libnet/%.c
 	$(call quiet-command,$(CC) $(LIBNETCFLAGS) -c -o $@ $<,"CC","$(TARGET_DIR)$@")
-- 
2.18.1


