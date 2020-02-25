Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF86C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:52:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 367C121556
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acAq4T8W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 367C121556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Zgt-0005d7-CP
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:51:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50087)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YlM-0001yK-F8
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YlK-0001gI-FE
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:32 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:35428)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YlK-0001dF-8M
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:30 -0500
Received: by mail-wm1-x334.google.com with SMTP id m3so2666589wmi.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0BfDGmNNoS/7MbaiDYjxGfK5TfJo6+VifgJPDM0/QoI=;
 b=acAq4T8WakxRLCafQj4RYYEivz/U7JJ2KQLKoIPrdOKzCfmpDhazp+gHezoNdKloA9
 +hUTqYHIMzwB9EhvCymq8djOIbfyOuK7MjeM0vHI7H9cUGzlg81e3G5b3h6rkm9692P1
 aQyZu1nFG8Vgg6MFyPImDl1Xfg4FMd1C3Bc2M8T/U5FZdiovBUSPe0fZZ7/KGRuy1yZT
 jYsQQbougk0MPJW0vTwOPnNRDVxo3GElnEP1wKZwArkRi9NylFJVLyaP7kuRzmseNiDv
 OtqV7S6DpdlBHw52Wfg6VaHGsIJsiNO2MPXHjhWqj0amzPixtzW5Gfv8ADvy6dkzgYgk
 d43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=0BfDGmNNoS/7MbaiDYjxGfK5TfJo6+VifgJPDM0/QoI=;
 b=ZwshP15hLIuW+DFZtZWFSdtlcxsJsa5Oh5Lo9xMkVA32/F2PTYE8Ra0RARDBdd0Q4G
 M5j4oV3c9qSyaRgPHKiDB19TuucKmJKZQcIrVLkZIMKBCbksN283HiQekMZdOJfulC7C
 lRhs6YEj1B5Qgk/ILxaumwi56EE4xmCEiwqWgz8HEs8hpTqMygxf5cKaxeSoVJY1GkbM
 bj63ExOODQ6qIVldWq6QH9Wic3ij5+BxKK2Mpx1QiMNjBHiMQKywV7X6uqWWlufFhCtw
 IGGOpUXE1eZLIrUzpg+Vt3Qo2NxoIVWFxwk1WAQyknUe2GWBc+PUZlIjx7xGZN3tJ3Lb
 OYVg==
X-Gm-Message-State: APjAAAVCW7Aj0eaOHYFCigVwJW2W16ZVFMsHzuM3TLi6bLY3Pu5e7391
 BTl8DUpj8nafURZdbylnv+S6K9Ck
X-Google-Smtp-Source: APXvYqzq7n5JC4geFKVTE8Eub6Dh1+nNSr+PyByNblAkCXlkrCZJOFX5WHKmQ/loIY8GF7e6058U9Q==
X-Received: by 2002:a7b:c119:: with SMTP id w25mr5074395wmi.116.1582631549050; 
 Tue, 25 Feb 2020 03:52:29 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.52.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:52:28 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 089/136] hw/ide/internal: Remove unused DMARestartFunc typedef
Date: Tue, 25 Feb 2020 12:50:19 +0100
Message-Id: <1582631466-13880-89-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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

The IDE DMA restart callback has been removed in commit fe09c7c9f0.

Fixes: fe09c7c9f0
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/hw/ide/internal.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
index 52ec197..ce766ac 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -326,7 +326,6 @@ typedef int DMAIntFunc(IDEDMA *, int);
 typedef int32_t DMAInt32Func(IDEDMA *, int32_t len);
 typedef void DMAu32Func(IDEDMA *, uint32_t);
 typedef void DMAStopFunc(IDEDMA *, bool);
-typedef void DMARestartFunc(void *, int, RunState);
 
 struct unreported_events {
     bool eject_request;
-- 
1.8.3.1



