Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4C6C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:38:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 496F920665
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gl+8yXAY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 496F920665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwvt-0001H0-FD
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLR-00042w-D6; Thu, 03 Sep 2020 17:00:33 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a]:44661)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLK-0007f2-JX; Thu, 03 Sep 2020 17:00:30 -0400
Received: by mail-ot1-x32a.google.com with SMTP id a2so3981328otr.11;
 Thu, 03 Sep 2020 14:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=bZwBA4peLRyGs8ohtkAt1JRxKXRjQb8BlHQpeJ+7qBM=;
 b=gl+8yXAY9Qy03h4KXWVLSI715zYwZY0Y6cZA0UPXXUtkLR3g2WvW1/MMdvl+1c72a/
 C7R0MeSVJ12nC2t0ra0abC4LcKnIzBmJlQgQXDuCGgK015s/uXDSauguW+edMLLU5/YI
 VS9TZk+vwOtrJKO/cOzwmjXGtzSuQGCqVUZFXNz5laW85CTcQbswMhPam4zAsTeQfdYR
 5HexfJ/mLMOg/CWqxqyR0Z8V6NH00zNUmwBQB2eWKtEGQl5yWZ3NwItV+oNMag3C7f5E
 1xtN+z/viOcqPKnM1bbuwTPFa0FzGih7KOfVIZYIsiSqd9aJQKrb7J0+fGtSG/cLshit
 LNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=bZwBA4peLRyGs8ohtkAt1JRxKXRjQb8BlHQpeJ+7qBM=;
 b=uFvgiFcGaXL0ovqdl6TsoMbes9JbpwK/zctjYpCIbGOOq90EjqjUf61nvAoPR0+Rz1
 g55+7IvQfdgu4qaRMmicZzi5FSTaz9V/DSuEHFC6TMCsba3JIPtL5hMPBND7fbS47kvD
 ouKZBaoGx4a/ouP/hxBKP5EzII54+Dm2g9qGwSzYxfVSVIjVqC0GOA5wSXFC/uJ8Z7R1
 O79jmFsL7i2SQ/jC8NGYAPnNTJ2R9GVEcSZvScf6gaMi5B7gaJknQvfwzDJznzmyacuZ
 WVKJ2t86IuLxEQ2juYnAlBWspJYYI4s4jtiC5/75/YO9TbRmD4cYGIUIC6612QY5A1W2
 wQRQ==
X-Gm-Message-State: AOAM532W8M/4JQ7hrZ8rpWN2bxyBcidPfDOIPMLhQ/jv88RpVHPbLiCk
 obzBYNjWaOW/4nEwOKAQzbxjGxArV4U=
X-Google-Smtp-Source: ABdhPJy99SGG5AIzkQH1kFBC0VKy93XlH+nU5+TdBGgzjffCfQ/LCf4OWtpQQaulynD/0A0muud7Vg==
X-Received: by 2002:a9d:170e:: with SMTP id i14mr3217027ota.170.1599166824814; 
 Thu, 03 Sep 2020 14:00:24 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id 92sm764752ota.38.2020.09.03.14.00.24
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:00:24 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 35/77] virtiofsd: Whitelist fchmod
Date: Thu,  3 Sep 2020 15:58:53 -0500
Message-Id: <20200903205935.27832-36-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x32a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-stable@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

lo_setattr() invokes fchmod() in a rarely used code path, so it should
be whitelisted or virtiofsd will crash with EBADSYS.

Said code path can be triggered for example as follows:

On the host, in the shared directory, create a file with the sticky bit
set and a security.capability xattr:
(1) # touch foo
(2) # chmod u+s foo
(3) # setcap '' foo

Then in the guest let some process truncate that file after it has
dropped all of its capabilities (at least CAP_FSETID):

int main(int argc, char *argv[])
{
    capng_setpid(getpid());
    capng_clear(CAPNG_SELECT_BOTH);
    capng_updatev(CAPNG_ADD, CAPNG_PERMITTED | CAPNG_EFFECTIVE, 0);
    capng_apply(CAPNG_SELECT_BOTH);

    ftruncate(open(argv[1], O_RDWR), 0);
}

This will cause the guest kernel to drop the sticky bit (i.e. perform a
mode change) as part of the truncate (where FATTR_FH is set), and that
will cause virtiofsd to invoke fchmod() instead of fchmodat().

(A similar configuration exists further below with futimens() vs.
utimensat(), but the former is not a syscall but just a wrapper for the
latter, so no further whitelisting is required.)

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1842667
Reported-by: Qian Cai <caiqian@redhat.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200608093111.14942-1-mreitz@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
(cherry picked from commit 63659fe74e76f5c5285466f0c5cfbdca65b3688e)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tools/virtiofsd/seccomp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/virtiofsd/seccomp.c b/tools/virtiofsd/seccomp.c
index bd9e7b083c..3b1522acdd 100644
--- a/tools/virtiofsd/seccomp.c
+++ b/tools/virtiofsd/seccomp.c
@@ -42,6 +42,7 @@ static const int syscall_whitelist[] = {
     SCMP_SYS(exit_group),
     SCMP_SYS(fallocate),
     SCMP_SYS(fchdir),
+    SCMP_SYS(fchmod),
     SCMP_SYS(fchmodat),
     SCMP_SYS(fchownat),
     SCMP_SYS(fcntl),
-- 
2.17.1


