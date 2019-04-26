Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F181FC43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 16:29:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B86BE208CA
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 16:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oberlin-edu.20150623.gappssmtp.com header.i=@oberlin-edu.20150623.gappssmtp.com header.b="Nlfdf4So"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B86BE208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oberlin.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49298 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hK3j8-0005dC-Ok
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 12:29:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hK3h4-0004Dk-09
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 12:27:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hK3h0-000105-9O
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 12:27:20 -0400
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142]:54755)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hK3gy-0000xU-AC
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 12:27:16 -0400
Received: by mail-it1-x142.google.com with SMTP id a190so6785122ite.4
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 09:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oberlin-edu.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=lnIQMa985gJdik6sa+sHszvNo6LvfSu/P2J8+RNmRRI=;
	b=Nlfdf4SoJDlgU9ZiXcWSjZ/8czDC66M4qABzfPAW0PWIGD6P5VUh8JaMvGz6SHl3DZ
	ko+GOWzLQMfYU/UOS8ZhHmIr4nHQbh1MsaJU6pjfpAA/enyyLnB6YnymXvIzrpnee4rg
	zndHHtua5uXVWIzFp6sqQIAjyY1A1pASgP/oR0YeQl6NoaCcAPIa+z76QQ6SoB+Iv7y3
	gJaph/HC9j2upmmnle/jbbs3XX7Kp9TPATOguF4jyfLG4ehi+xr/jPOcv4JKy+KWSolI
	3eVhKrQuTNOYDKzEhMX4bzgzOzf4RCLth++V4Rsrze0bypa6C3CXYnnAOt44AAqHYlte
	6y0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=lnIQMa985gJdik6sa+sHszvNo6LvfSu/P2J8+RNmRRI=;
	b=pfJJyYqtaCDhPtILitNHAwuK97clZBbDT3LrfHyP8kfkyNB7rSXjZPmL3UEkVTWk3Y
	vz3rIusoLBOqQESqGPOWI2K8Ugsf99JvSonkfmasrevppXboO6ToanziuUqT1GFckI7k
	+w4/iveuGO8Qnm3n/g/dQu0pneGhjzQgxafZZHH0k+zyJUTWO5BCBN/UEmOcaVChuIxA
	m5sr3XGkW2+ePlESTIMoKqhs3HKBgcGyBiBzhNEDe+Z2eOGoFT46jJKK6urQLQ35qbbQ
	M3XXflAhuyJi1MV2G0cJsw3IDbMlbOT7htrPhPxCfyOAnKKJWMJcOi0PMlwE5T20nmlN
	WNvw==
X-Gm-Message-State: APjAAAW+iMe2UCt5XD4tZ59pbskGqPuHNmxwV6fhxXw40LSWXlcrJpoy
	SvulLtIGFC6JGHKwbDcPqN5lmQi3HSA5QQ==
X-Google-Smtp-Source: APXvYqxqaI0mY7AlRXbj8xyN+OUvIkgFbcifUaMGSHkCek8FxKWLgeJOcB0SClS2E8c3jbEy73aNQw==
X-Received: by 2002:a24:25cf:: with SMTP id g198mr8920622itg.141.1556296032294;
	Fri, 26 Apr 2019 09:27:12 -0700 (PDT)
Received: from worksec.oberlin.net (ip-210-181.oberlin.net. [208.66.210.181])
	by smtp.gmail.com with ESMTPSA id
	c7sm7548700ioc.63.2019.04.26.09.27.11
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 26 Apr 2019 09:27:11 -0700 (PDT)
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
To: QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
	"open list:Block layer core" <qemu-block@nongnu.org>,
	Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 26 Apr 2019 12:26:21 -0400
Message-Id: <20190426162624.55977-8-stephen.checkoway@oberlin.edu>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190426162624.55977-1-stephen.checkoway@oberlin.edu>
References: <20190426162624.55977-1-stephen.checkoway@oberlin.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::142
Subject: [Qemu-devel] [PATCH v4 07/10] block/pflash_cfi02: Fix reset command
 not ignored during erase
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
Cc: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190426162621.K4JiZjVoh-_QX8J9JElkfdl1qkwFlLrIZsuxs8EKmCE@z>

When the flash device is performing a chip erase, all commands are
ignored. When it is performing a sector erase, only the erase suspend
command is valid, which is currently not supported.

In particular, the reset command should not cause the device to reset to
read array mode while programming is on going.

Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
---
 hw/block/pflash_cfi02.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index be10036886..cb1160eb35 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -325,7 +325,8 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
                     pfl->bank_width * 2, value);
         }
 
-        if (cmd == 0xF0) {
+        /* Reset does nothing during chip erase and sector erase. */
+        if (cmd == 0xF0 && pfl->cmd != 0x10 && pfl->cmd != 0x30) {
             if (pfl->wcycle == WCYCLE_AUTOSELECT_CFI) {
                 /* Return to autoselect mode. */
                 pfl->wcycle = 3;
-- 
2.20.1 (Apple Git-117)


