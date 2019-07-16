Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04F2C76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:15:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DF742145D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P38yAFSv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DF742145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnIcV-00085S-Bc
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 04:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60180)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hnIYm-0000Te-OZ
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:11:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hnIYl-0003PS-IJ
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:11:40 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:36710)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hnIYl-0003Om-AK
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:11:39 -0400
Received: by mail-wr1-x436.google.com with SMTP id n4so19889071wrs.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 01:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=RxYfAEyw36ihWSXQYKfqSMDy1K9OXWQsSR7Cb5/oOMk=;
 b=P38yAFSv5K/JbiR8xVivWxMeA0VBNqFwpnB4XxjB79eT8JIOjFjnEjcj/hK6pHlzB8
 33IH9kRkduh76GBphjHvSswlV8Z3pyMc7al7k7T9Gx1yMRyu16wumUxiVjfNRT3JNxi1
 avx9Nvv1dVpLtwhWei8jGeYh4Hw8n6xLESk5jifPKD3f4D510buvNAOgJz7RoDkt/UXm
 qkryCOfcfpiVc/2P5ZOUkEWVrLWp8PLp5dU/Qlq+evSmfWJ7/fdCnbrMFGHWKW6tusF0
 yfYsc/FdqDLMF6MxsFW0ExJqcIS4TGEMInwgwEToEjLqbetHMAJvzSkRZmOeT6k2CoZn
 Nl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=RxYfAEyw36ihWSXQYKfqSMDy1K9OXWQsSR7Cb5/oOMk=;
 b=mu6P+tfK8qmSQRYdxymbJ4Iii+0LndFJM6aLlY0XPN6tmWHA02hhPxzRQJzQ7tDPEC
 1NB9io4i1nzZKG56y/fgqCT27vUuld6tOigSHL3Pot5FtMsd3rwRG4tS5DUbjfCNOagy
 eEyx0qpcjdD1ugsf8L5JkLtjqEqHlnHkRcbwzP23kFWh/cGDorIb1WVwJx5W2lsyMAWA
 dfPhRjiZDo8rsX6PR7XoZR0Io6fX3JuDwRlHfGougqAj6YY2LTllixwe5vba7fq/8XQT
 A2FpXFIbKZvhoE9j4Sp20G175/M2Cbth83j8GWG5xNezD6eFGjSMnsFa/1aVXdi614JW
 xR/w==
X-Gm-Message-State: APjAAAVbazQAuZIlH+10qAFHgMJ5ZrcKs5DEcPfAQ3pIWpwYfkClqqIB
 LUJQeysCRYZUfqwnuaxlP1kwa+Xc+t4=
X-Google-Smtp-Source: APXvYqyaA3zXsqo2WJY9n1bQWzk7u/tJap957e/mlY9Q0Pfms836SlRK3likuMcw6mlZGH6VZLisxQ==
X-Received: by 2002:adf:c803:: with SMTP id d3mr10742907wrh.130.1563264697972; 
 Tue, 16 Jul 2019 01:11:37 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id c1sm37723879wrh.1.2019.07.16.01.11.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 01:11:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 16 Jul 2019 10:11:16 +0200
Message-Id: <1563264677-39718-19-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1563264677-39718-1-git-send-email-pbonzini@redhat.com>
References: <1563264677-39718-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
Subject: [Qemu-devel] [PULL 18/19] create_config: remove $(CONFIG_SOFTMMU)
 hack
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

CONFIG_TPM is defined to a rather weird $(CONFIG_SOFTMMU) so that it
expands to the right thing in hw/Makefile.objs.  This however is not
needed anymore and it has a corresponding hack in create_config
to turn it into "#define CONFIG_TPM 1".  Clean up.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure             | 2 +-
 scripts/create_config | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 4983c8b..eb635c3 100755
--- a/configure
+++ b/configure
@@ -7159,7 +7159,7 @@ if test "$live_block_migration" = "yes" ; then
 fi
 
 if test "$tpm" = "yes"; then
-  echo 'CONFIG_TPM=$(CONFIG_SOFTMMU)' >> $config_host_mak
+  echo 'CONFIG_TPM=y' >> $config_host_mak
 fi
 
 echo "TRACE_BACKENDS=$trace_backends" >> $config_host_mak
diff --git a/scripts/create_config b/scripts/create_config
index 00e86c8..6d8f08b 100755
--- a/scripts/create_config
+++ b/scripts/create_config
@@ -54,7 +54,7 @@ case $line in
     done
     echo "    NULL"
     ;;
- CONFIG_*='$(CONFIG_SOFTMMU)'|CONFIG_*=y) # configuration
+ CONFIG_*=y) # configuration
     name=${line%=*}
     echo "#define $name 1"
     ;;
-- 
1.8.3.1



