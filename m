Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C90C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 14:20:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A43B20738
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 14:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aJ8ivbzs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A43B20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k82Ti-0003XI-S0
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 10:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k82K8-000394-77
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:10:48 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28331
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k82Jz-0007Iz-HC
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:10:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597759838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kw5nOndWF6SnzQmCqJU2rvAqhqsM7j+gveC3XxmrzX4=;
 b=aJ8ivbzsG5KxuQn7VDalMl74RpGebLciKIS2AS/dTbj3c5OvoUfROzzwvtaoNuiCJwJcGp
 pS3xx0wUBcGw3gTckJMzsxfA0cbF67zotuZmbw63UDZIKbYt+StMt1bq6Havh2TCZDl3YM
 XG1TypDrzPqdJXu1SKTqMvYFYnGyWI0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-HHodERR4N5KbXaPzyJQ3_A-1; Tue, 18 Aug 2020 10:10:36 -0400
X-MC-Unique: HHodERR4N5KbXaPzyJQ3_A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2201D6386
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 14:10:35 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 955425C64D;
 Tue, 18 Aug 2020 14:10:35 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 009/150] tests/vm: check for Python YAML parser in the Makefile
Date: Tue, 18 Aug 2020 10:08:04 -0400
Message-Id: <20200818141025.21608-10-pbonzini@redhat.com>
In-Reply-To: <20200818141025.21608-1-pbonzini@redhat.com>
References: <20200818141025.21608-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 08:01:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No need to do it in the configure file if it is only used for a help message.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                 | 9 ---------
 tests/vm/Makefile.include | 6 +++++-
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/configure b/configure
index 1c17a0f27f..625c14c500 100755
--- a/configure
+++ b/configure
@@ -959,13 +959,6 @@ do
     fi
 done
 
-# Check for existence of python3 yaml, needed to
-# import yaml config files into vm-build.
-python_yaml="no"
-if $(python3 -c "import yaml" 2> /dev/null); then
-    python_yaml="yes"
-fi
-
 : ${smbd=${SMBD-/usr/sbin/smbd}}
 
 # Default objcc to clang if available, otherwise use CC
@@ -6844,7 +6837,6 @@ if test "$docs" != "no"; then
     echo "sphinx-build      $sphinx_build"
 fi
 echo "genisoimage       $genisoimage"
-echo "python_yaml       $python_yaml"
 echo "slirp support     $slirp $(echo_version $slirp $slirp_version)"
 if test "$slirp" != "no" ; then
     echo "smbd              $smbd"
@@ -7945,7 +7937,6 @@ echo "PYTHON=$python" >> $config_host_mak
 echo "SPHINX_BUILD=$sphinx_build" >> $config_host_mak
 echo "SPHINX_WERROR=$sphinx_werror" >> $config_host_mak
 echo "GENISOIMAGE=$genisoimage" >> $config_host_mak
-echo "PYTHON_YAML=$python_yaml" >> $config_host_mak
 echo "CC=$cc" >> $config_host_mak
 if $iasl -h > /dev/null 2>&1; then
   echo "IASL=$iasl" >> $config_host_mak
diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index a599d1994d..61f893ffdc 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -17,6 +17,10 @@ IMAGE_FILES := $(patsubst %, $(IMAGES_DIR)/%.img, $(IMAGES))
 
 .PRECIOUS: $(IMAGE_FILES)
 
+ifneq ($(PYTHON),)
+HAVE_PYTHON_YAML = $(shell $(PYTHON) -c "import yaml" 2> /dev/null && echo yes)
+endif
+
 # 'vm-help' target was historically named 'vm-test'
 vm-help vm-test:
 	@echo "vm-help: Test QEMU in preconfigured virtual machines"
@@ -56,7 +60,7 @@ endif
 	@echo "    QEMU_LOCAL=1                 - Use QEMU binary local to this build."
 	@echo "    QEMU=/path/to/qemu		 - Change path to QEMU binary"
 	@echo "    QEMU_IMG=/path/to/qemu-img	 - Change path to qemu-img tool"
-ifeq ($(PYTHON_YAML),yes)
+ifeq ($(HAVE_PYTHON_YAML),yes)
 	@echo "    QEMU_CONFIG=/path/conf.yml   - Change path to VM configuration .yml file."
 else
 	@echo "    (install python3-yaml to enable support for yaml file to configure a VM.)"
-- 
2.26.2



