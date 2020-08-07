Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4036DC433E1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 12:59:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1186C20866
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 12:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZEAii9Pc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1186C20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k41y5-0002ya-7A
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 08:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k41xU-0002Yq-8K
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 08:58:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54994
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k41xS-0002jH-KD
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 08:58:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596805129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=rEREA90LkOSa/uOs2ylab1e4VInfXXy/vQPzCn+F8VI=;
 b=ZEAii9PcR7VLngAbd1V5BVZ+yNUak29uxm5kuyGDmIbSDwL2NVD3QDL2jP9AO0RBQEJbsV
 Tzx7+9f0OlxLvzo996UPBqXxiR8FW1jlAWs3h4suLOLFTDxmFcKCa5pWjITwejL+mE7bJ6
 E98O1Fg7OqbwgIOFSGdnttdDhXQsQuE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-mhVKPcLlNhemC-a717cN-w-1; Fri, 07 Aug 2020 08:58:45 -0400
X-MC-Unique: mhVKPcLlNhemC-a717cN-w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDB591005504
 for <qemu-devel@nongnu.org>; Fri,  7 Aug 2020 12:58:44 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-31.ams2.redhat.com [10.36.113.31])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 98A725C6C0;
 Fri,  7 Aug 2020 12:58:42 +0000 (UTC)
Subject: Re: [PATCH 003/143] pc-bios/s390-ccw: simplify Makefile
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <1596741379-12902-4-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <dc047d21-128d-74b8-5710-a7d6d969a9be@redhat.com>
Date: Fri, 7 Aug 2020 14:58:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1596741379-12902-4-git-send-email-pbonzini@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 02:21:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Cornelia Huck <cohuck@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/08/2020 21.13, Paolo Bonzini wrote:
> Make it independent from the rules.mak, and clean up to use pattern rules.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  pc-bios/s390-ccw/Makefile    | 105 ++++++++++++++++++++++++++++++++++---------
>  pc-bios/s390-ccw/netboot.mak |  62 -------------------------
>  2 files changed, 84 insertions(+), 83 deletions(-)
>  delete mode 100644 pc-bios/s390-ccw/netboot.mak

As Cornelia already mentioned in another mail, this does not work yet.
I'd also prefer if we could keep the netbook.mak stuff in that separate
file.

Maybe you could go with this minimal patch first - this seems to work
for me:

commit 7f265ef8253613d882bdeb8a89502d55923c0077
Author: Thomas Huth <thuth@redhat.com>
Date:   Fri Aug 7 14:51:52 2020 +0200

    minimam pc-bios/s390-ccw/Makefile patch

diff a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -3,10 +3,26 @@ all: build-all
 	@true

 include ../../config-host.mak
-include $(SRC_PATH)/rules.mak

+quiet-command = $(if $(V),$1,$(if $(2),@printf "  %-7s %s\n" $2 $3 &&
$1, @$1))
+cc-option = $(if $(shell $(CC) $1 -S -o /dev/null -xc /dev/null
>/dev/null \
+	      2>&1 && echo OK), $1, $2)
+
+VPATH_SUFFIXES = %.c %.h %.S %.m %.mak %.sh %.rc Kconfig% %.json.in
+set-vpath = $(if $1,$(foreach PATTERN,$(VPATH_SUFFIXES),$(eval vpath
$(PATTERN) $1)))
 $(call set-vpath, $(SRC_PATH)/pc-bios/s390-ccw)

+# Flags for dependency generation
+QEMU_DGFLAGS = -MMD -MP -MT $@ -MF $(@D)/$(*F).d
+
+%.o: %.c
+	$(call quiet-command,$(CC) $(QEMU_CFLAGS) $(QEMU_DGFLAGS) $(CFLAGS) \
+	       -c -o $@ $<,"CC","$(TARGET_DIR)$@")
+
+%.o: %.S
+	$(call quiet-command,$(CCAS) $(QEMU_CFLAGS) $(QEMU_DGFLAGS) $(CFLAGS) \
+	       -c -o $@ $<,"CCAS","$(TARGET_DIR)$@")
+
 .PHONY : all clean build-all

 OBJECTS = start.o main.o bootmap.o jump2ipl.o sclp.o menu.o \

Thomas


