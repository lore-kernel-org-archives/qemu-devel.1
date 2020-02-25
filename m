Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44F9C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:01:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F709218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/MPSC/S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F709218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZqM-0003sv-O6
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:01:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50217)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YlV-0002NZ-9B
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YlU-0002IW-8t
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:41 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:40716)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YlU-0002Eo-1y
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:40 -0500
Received: by mail-wm1-x32c.google.com with SMTP id t14so2838119wmi.5
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=khYyWh5ZZESTsDhSwmW3NzZ5C/nmqjY42tMKoymp4Fc=;
 b=a/MPSC/SEswGKwEuGJFOTIgpJiMWzbzf44N3Y71w3MuxxDO+8XjRf18Wu7hYsKkPDV
 pF9O4G8pQmr/8av2u6X3aJQeL5L+BGzuHYcDpU9RKA7VGg0Yx9fuOkOdkm4P0pSNN3Ys
 iHU7N6LrAXSCzqIzmvW85eOW/jWsWf5Fv5w9574IfLlhhrYFJsQxOEC1mjx29v8XzlOn
 e7/TMfvPLd035rQHPAOX4G1E11XiR300XdWCq9AHThQYoukDG9YDzuA4Vj40GN/+7qRI
 VADXVqKs2G6vdACYMAOyj9LGKh9dFsUmVnFeOZZmrPc6dSq+IoIXpSyp1lYVpZ5wVZDh
 tZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=khYyWh5ZZESTsDhSwmW3NzZ5C/nmqjY42tMKoymp4Fc=;
 b=qiS9ovlX2TmH5M2RaHXYDdZFJ1aOczbWnHWLG5rIr40pLlyfQA7cZ07Q+vrs4yv1/2
 cPU3HIikq+JAkfYHniaYzwSERnnxkxep7+jjYEClIecp0rtw43NVy828TP/DOJHF1qOe
 ufdDwVxKw//ClVSoN6aUgvVK4X0q/mVZ5ev2Ag9493UJodjNr2JZLz23002DEdKpSe6t
 klSXfZ8YHPXt/PRua4zGeoZZTXlxft+jqfwbrqgBW7H/1wWah9EYhS6PLM6ZVGgJInIK
 dlgDSHbj3/PZOdh3r4Gj/MqVBJabI6TimnKlL8lFfvbrZiuqJlf6x81DoMManNuJr0+0
 m9Tg==
X-Gm-Message-State: APjAAAUyYGL1zHSjTPHN6FV3+NgsHEdPzMpMSKx9Aush8gm097ppCEb6
 WvjyrOJLLkZZ9cwgtKqhXd8vLtUh
X-Google-Smtp-Source: APXvYqwnpir2BZi9chncLQyycA1EBEO0CKpmB4DJe5MJTUP81RrqTGDzHQVONi/DB9Giwl41D5GKqw==
X-Received: by 2002:a7b:c851:: with SMTP id c17mr4851277wml.71.1582631558806; 
 Tue, 25 Feb 2020 03:52:38 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.52.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:52:38 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 100/136] memory: Simplify memory_region_init_rom_nomigrate() to
 ease review
Date: Tue, 25 Feb 2020 12:50:30 +0100
Message-Id: <1582631466-13880-100-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
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

From: Philippe Mathieu-Daudé <philmd@redhat.com>

memory_region_init_rom_nomigrate() has the same content than
memory_region_init_ram_shared_nomigrate(), with setting the
readonly mode. The code is easier to review as creating a
readonly ram/shared/nomigrate region.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200224205533.23798-3-philmd@redhat.com>
Supersedes: <20200221173049.18134-1-philmd@redhat.com>
---
 memory.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/memory.c b/memory.c
index ce11798..6a327a5 100644
--- a/memory.c
+++ b/memory.c
@@ -1659,19 +1659,8 @@ void memory_region_init_rom_nomigrate(MemoryRegion *mr,
                                       uint64_t size,
                                       Error **errp)
 {
-    Error *err = NULL;
-    memory_region_init(mr, owner, name, size);
-    mr->ram = true;
+    memory_region_init_ram_shared_nomigrate(mr, owner, name, size, false, errp);
     mr->readonly = true;
-    mr->terminates = true;
-    mr->destructor = memory_region_destructor_ram;
-    mr->ram_block = qemu_ram_alloc(size, false, mr, &err);
-    mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
-    if (err) {
-        mr->size = int128_zero();
-        object_unparent(OBJECT(mr));
-        error_propagate(errp, err);
-    }
 }
 
 void memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
-- 
1.8.3.1



