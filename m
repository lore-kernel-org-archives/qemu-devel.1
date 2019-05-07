Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D28CC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 12:11:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5A87205ED
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 12:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P1TFtT+v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A87205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45781 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNywl-0008Fv-3B
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 08:11:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hNyls-0007fM-Pv
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:00:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hNyln-0003hq-DL
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:00:32 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:39864)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hNyln-0003cx-3k
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:00:27 -0400
Received: by mail-wr1-x432.google.com with SMTP id v10so9675843wrt.6
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 05:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=X9+rr2bCSDZG/nCniXr98w168+IzhYcZne15QwzLe+E=;
	b=P1TFtT+vueqVZhZXCKNUxnc8miDmySU0De8UEeP5b0fw1nOenYECcV96822hNpHXK1
	QW25QBo0695Xp17ywA/Ud5TOz4ER0TnTx/btTItSZt94Zg/mNRtNbeVavkDHHIYUgRau
	0neMhiOqyFdc1wJRwpT1G8qDtlvGNb8hWbrqiCHWDlaZYVEm/YQSyUuKkMYz6rl9s2AM
	Cjif2gaMiBv1nJJbXzYyTYggX1H6IQwcMD29eLLi3dtbDZ8x7wJ+uPIG9PiUqbDLETwg
	bXibwpkitSOSoKZztwgMI4o+yUQKNGssedPdSiYjgpJsHv4pg522Vd2Q7iGO6clFqm04
	O+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=X9+rr2bCSDZG/nCniXr98w168+IzhYcZne15QwzLe+E=;
	b=OxNyg56vQ0DtNhN6v5kTNKodRTKcjZ7TNnWch1iZMoxO2OxOG3YTVcV62XxWB39ugD
	w04PpxCjAJTQQfxTcPyR402qdnk/zHH4skWTwgQHZE82Lm9ivGQtcQFU5wGeFhxQynGl
	xmWRoZkzanilGY6E+Hd+tJnRFOwnMp50x8t781FiLHzRLm8ME2rkMNCJlQggsufkrMO3
	MNJgAyfYBUiAsfOvluEwjE4YNAaSYX64hy+cxp0zD6aoeGdK2Dq32Foq3ygBkD3uNFNs
	du3d40VN771A4cr7FO6a4nyYI+ptPnnPhRds+5X8y4pmuXy8ZX653SYHnxTeIxgsJMSv
	gRXA==
X-Gm-Message-State: APjAAAVBaU/mpsIOZUSlSCjYDuRi96veSmgsUWRAWoyUPVU2efLUtxEL
	LI9OQN5J7IKHaD8TD9Pae+33LDKN6pc=
X-Google-Smtp-Source: APXvYqxkH1f93KMvq24eW/A7JpWv6O8Qi3FEdLyml9QM4OBIoqLgpxuI5hh9Nd2Z3sY0j/ysBdnd2g==
X-Received: by 2002:adf:bc86:: with SMTP id g6mr14397539wrh.60.1557230425949; 
	Tue, 07 May 2019 05:00:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id g3sm12348596wmf.9.2019.05.07.05.00.24
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 05:00:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 13:00:04 +0100
Message-Id: <20190507120011.18100-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507120011.18100-1-peter.maydell@linaro.org>
References: <20190507120011.18100-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::432
Subject: [Qemu-devel] [PULL 08/15] qga: Fix mingw compilation warnings on
 enum conversion
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cao Jiaxi <driver1998@foxmail.com>

The win2qemu[] is supposed to be the conversion table to convert between
STORAGE_BUS_TYPE in Windows SDK and GuestDiskBusType in qga.

But it was incorrectly written that it forces to set a GuestDiskBusType
value to STORAGE_BUS_TYPE, which generates an enum conversion warning in clang.

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Cao Jiaxi <driver1998@foxmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20190503003650.10137-1-driver1998@foxmail.com
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 qga/commands-win32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index d40d61f605c..6b67f16faf1 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -457,7 +457,7 @@ void qmp_guest_file_flush(int64_t handle, Error **errp)
 
 #ifdef CONFIG_QGA_NTDDSCSI
 
-static STORAGE_BUS_TYPE win2qemu[] = {
+static GuestDiskBusType win2qemu[] = {
     [BusTypeUnknown] = GUEST_DISK_BUS_TYPE_UNKNOWN,
     [BusTypeScsi] = GUEST_DISK_BUS_TYPE_SCSI,
     [BusTypeAtapi] = GUEST_DISK_BUS_TYPE_IDE,
-- 
2.20.1


