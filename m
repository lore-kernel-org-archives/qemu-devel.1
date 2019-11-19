Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3827CC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 16:10:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0230A22365
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 16:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icAa2MzC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0230A22365
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX65Q-0003XR-SJ
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 11:10:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60632)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iX63i-0001iT-I1
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:08:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iX63h-0005zg-BC
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:08:54 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39334)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iX63h-0005zE-59
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:08:53 -0500
Received: by mail-wr1-x441.google.com with SMTP id l7so24518693wrp.6
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 08:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=IxNe+PRA4UNUXRxlwBF/Lxfbz/p8jdQxx9siBVgywJQ=;
 b=icAa2MzC4t1MNIhDwGn3NHE9S4tsUulOXoVzxbmIp9456X0ucSSQhJsp/VbrcQDpyF
 w9Yfm1tyzi5T+/Fz6vCe+OgJvDGJoEWwBjRkDAhGRO51NAzAznJQX+Zn6mI1zEM5b5Jx
 bkAhqsfFpjkxChaQAhvs4h9V2oa/FhhVclp/V1YuhQ4N07jUFzz/NSIb6n1veIhlK2A6
 HIYr5abSMeTMM/ZAeIVoTRKFWEF4bHIFtA3CQONhFE5f83YT4mC4xQeUb0ZxLgobsjNn
 MxeiwoecQ5oO5J4LzXhH+dC1uV8X9riBF03GFRB7Vg77dUezlG76h4hhvbITkkFXiP5J
 QYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=IxNe+PRA4UNUXRxlwBF/Lxfbz/p8jdQxx9siBVgywJQ=;
 b=YOAvSXKDaSTJEwz/wQXhM3hA0/GfrUI4mVxuGpLxXOTQTOglYIh5Wud2xlt13HdLsp
 d6910uvnce9hwAOqncaJPMvup4j2890ZvZQTsWZelVJjkscLjiFuRF+GMxGv4TbnOwuC
 FbPPoUMug4d9kbIKR+UOXlNHJP/ZN2KLa8xmTsNsRPxfLXsBW6GP90/1axczheNpMMqT
 WVPwA3t690fyTpO55qjiqmq7jKKpVo0/wUL1cgzFvVK1LAJjoFM1asM99TGAUcGPry3t
 VYOmGKaXJdWrigPG3elYtQmnzFAsjsa9VDrRjgUuj24im3CfVnOUX6x+k1ljOYgkYF5T
 p4KQ==
X-Gm-Message-State: APjAAAUDGH25ejvtZpsmosBiMof96OjiTDstl6NpHVCske/rAb4vkjxG
 tW3No3bplF8sCxN04Ey9sQYJWUjx
X-Google-Smtp-Source: APXvYqx77y8Q97mzu3TUCd1Ed+NqhQGmI1MLYOUi/wTaiBJF+ZPwYefR0Y9dBytOYXnHFZZKMI4dbQ==
X-Received: by 2002:adf:ec4b:: with SMTP id w11mr36827280wrn.243.1574179731619; 
 Tue, 19 Nov 2019 08:08:51 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n13sm3442203wmi.25.2019.11.19.08.08.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Nov 2019 08:08:50 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/12] scripts: Detect git worktrees for get_maintainer.pl --git
Date: Tue, 19 Nov 2019 17:08:37 +0100
Message-Id: <1574179728-35535-2-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574179728-35535-1-git-send-email-pbonzini@redhat.com>
References: <1574179728-35535-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

Recent git versions support worktrees where .git is not a directory but
a file with a path to the .git repository; however the get_maintainer.pl
script only recognises the .git directory, let's fix it.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Tested-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20191112034532.69079-1-aik@ozlabs.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/get_maintainer.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 71415e3..27991eb 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -81,7 +81,7 @@ my %VCS_cmds;
 
 my %VCS_cmds_git = (
     "execute_cmd" => \&git_execute_cmd,
-    "available" => '(which("git") ne "") && (-d ".git")',
+    "available" => '(which("git") ne "") && (-e ".git")',
     "find_signers_cmd" =>
 	"git log --no-color --follow --since=\$email_git_since " .
 	    '--format="GitCommit: %H%n' .
-- 
1.8.3.1



