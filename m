Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24572C43461
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 22:50:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA554206DB
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 22:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTlOgImX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA554206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHELy-0004w7-Pw
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 18:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHEH6-0003Ux-8f; Sat, 12 Sep 2020 18:45:42 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630]:44095)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHEH4-0004NV-5M; Sat, 12 Sep 2020 18:45:39 -0400
Received: by mail-pl1-x630.google.com with SMTP id j7so2652392plk.11;
 Sat, 12 Sep 2020 15:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=C/1izafIbfTFDVThqlQpYnHLHf4305LjfMqLD1ztqLA=;
 b=aTlOgImXy5q4AsmzsiDVujmUVcw1Z2/wlb8Ezi6z/T7C1R1SOMahRIQohPCsV+z58Y
 1NjK3PKQnmNoPASC36pgBq35PnykaobajMxL7TmiYyMJu33tN+e2m49ZdzT9OEwR/qrF
 abybUnujFikdbJXZh3vXjRC9MTgPm7HIqkQQq+ufcNqFpBXVzFAJm1ZPVzhgYeahXHBt
 fnEY5oxvDurKFep7cuHS7IdCtPe758gDIWhj7/TaWA/Xizt0qMlF/UzbLYIxGh3/rQ60
 fj9HEuqg/UMiwEZIqjVmJYlQCeVwyDVOFXVWaLaIkD3WGAKEnMc08EK9iOOQfJhzYs2S
 +Xig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=C/1izafIbfTFDVThqlQpYnHLHf4305LjfMqLD1ztqLA=;
 b=dd8/Z21CVoB0fJH4jSxJzkr+FtINiLxzIS0cWm1yLvazF+8FkssRdwTRrUtXgVEs/B
 rIksFlIIf0RiOjf0WCxA4FLE8Ikcd1LqON0wZ0Co4srj2+tsxQR89pypWMEaYXZkjU9t
 eTawVpaRMebrv8NVn//PKs9ZvVyqj81n+e2BjwHt+QwSUiDfWWq3C7OEQU2Fl/PkUZRt
 Q5jS1E8VFIb0NusS749FvFtACe5pGQh3O9LrGx23XXXZZ4SklQ8zzRUAOuglcjjrh2ml
 GtKukytR/Hji7eMLWuDnBoWQE8ptrsL8zRjgiqY6Gml0/Qu32OOaf2Hy1jV5lNXUMOkl
 uqwg==
X-Gm-Message-State: AOAM532MDMqXrZ4CrwfNfSwxjcGo+q5QS5TufI4b0Wt1rmfkZFEwOKEj
 hlxlmdahOyANGyp1rpA1zP0G5ho4T7I1NF2DyPM=
X-Google-Smtp-Source: ABdhPJwOk2mfVoBr+XR9pHHBZlYRSYjl81MHBzmSbLcgbN+dbhqp3XDuG8Isa3CJ9wQ9RatBYLHG4Q==
X-Received: by 2002:a17:90a:6701:: with SMTP id
 n1mr8092459pjj.87.1599950732893; 
 Sat, 12 Sep 2020 15:45:32 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id t10sm4639266pgp.15.2020.09.12.15.45.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2020 15:45:32 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 10/27] osdep: file locking functions are not available on
 Win32
Date: Sun, 13 Sep 2020 06:44:14 +0800
Message-Id: <20200912224431.1428-11-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200912224431.1428-1-luoyonggang@gmail.com>
References: <20200912224431.1428-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x630.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

int qemu_lock_fd(int fd, int64_t start, int64_t len, bool exclusive);
int qemu_unlock_fd(int fd, int64_t start, int64_t len);
int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive);
bool qemu_has_ofd_lock(void);

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qemu/osdep.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 412962d91a..e80fddd1e8 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -502,11 +502,11 @@ int qemu_close(int fd);
 int qemu_unlink(const char *name);
 #ifndef _WIN32
 int qemu_dup(int fd);
-#endif
 int qemu_lock_fd(int fd, int64_t start, int64_t len, bool exclusive);
 int qemu_unlock_fd(int fd, int64_t start, int64_t len);
 int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive);
 bool qemu_has_ofd_lock(void);
+#endif
 
 #if defined(__HAIKU__) && defined(__i386__)
 #define FMT_pid "%ld"
-- 
2.28.0.windows.1


