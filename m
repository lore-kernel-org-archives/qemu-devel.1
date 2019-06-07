Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDF1C468BD
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:20:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C195208E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rclwMiRx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C195208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47944 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZByl-0006Mv-Dd
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 06:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45107)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hZB56-0008PH-33
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:22:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hZB55-0005z6-4n
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:22:40 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:33019)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hZB54-0005y0-UY
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:22:39 -0400
Received: by mail-wm1-x32c.google.com with SMTP id h19so3634800wme.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 02:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JC3AVXNsquFwiFLInZAwShppokQkGXpbpXxA7+1lbo4=;
 b=rclwMiRx1mNavkQcbhavQ1UQSYy55qEHbjX3lW0OxhsU0ZE0jf8IzXxdNfcZB8zc+1
 b+w9fCDt+a5fGw5uFQDyoT3bQAfv3hPwMhlblUbbndxIuOO3Wpo/r0z/FrRVBZint4/P
 9hHlUWMB6RWhjHZTVzWWF61B0+ozOpSNobksTH7UG79OU0gCxjDaDeA9On0XBiTHIsem
 BmqwNuon8BgeMPQ3pGPb2r5eVwANa40uw8FKkccVrfHIv39LtHKKj90CESM42K5Q5lpg
 0YXuwh/mxb5juWxcoFWcEYPtWLXztXWyJ1pty1UBJF5VcxfJLhcqXG9mCS7wQzqE37Ho
 2GXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JC3AVXNsquFwiFLInZAwShppokQkGXpbpXxA7+1lbo4=;
 b=G5lRGG9UDiqA2wWDFsI1gfHvs9ah2mOr8dlYTSvHtN0C2ZYppscszfp3WchZVt6rGX
 M1zZZV89sfxiJwGub+bWWdXti3TAgcGdAg/hn/fEDYdlWt/WL7SkZ5PVOt78XAdVj1It
 fUXgG6REYP8RZ9Fl7WLU+eZcgGcnkzz7raRkHGE5Z4AtqlqKmHY6ZMg5okh4NwiL/wgv
 n16CUPYt4sE+8UWDKfroHXdzTjm01H2c7DPCsmDAZXfwnTKkpNy7Da+sOHFJWeJrz649
 bgpjEtHwhZTE6OvLEy+qbQUIg5Vys0f2eU4SHsvcz8WNQ+3UHN8Tm8xL24Lq4c9eXxn1
 jbig==
X-Gm-Message-State: APjAAAUUSav6NmQ/YCgbHaaScK8mw0L1i/8KD39w0J1EikHPvAtri624
 ppVa+DKkmsH0RWmMfDilzNlfga6CZ3E=
X-Google-Smtp-Source: APXvYqyNQlUrzrb+WXARXP3Jf6r3bErZHIW9TOeXWSIMKZr/CjkLg5ZH7AINeShhCvNjla/KqJRy+w==
X-Received: by 2002:a05:600c:291:: with SMTP id
 17mr2858052wmk.32.1559899357794; 
 Fri, 07 Jun 2019 02:22:37 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id 88sm1876360wrl.68.2019.06.07.02.22.30
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 02:22:35 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 802B31FFB7;
 Fri,  7 Jun 2019 10:05:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  7 Jun 2019 10:05:30 +0100
Message-Id: <20190607090552.12434-32-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607090552.12434-1-alex.bennee@linaro.org>
References: <20190607090552.12434-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
Subject: [Qemu-devel] [PULL 31/52] MAINTAINERS: put myself forward for
 gdbstub
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As I've been reviewing a lot of this recently and I'm going to put
together a pull request I'd better keep an eye on it. Philippe has
also volunteered to be a reviewer.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index a96829ea83..9fd93d9c6a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1872,7 +1872,9 @@ F: util/error.c
 F: util/qemu-error.c
 
 GDB stub
-S: Orphan
+M: Alex Bennée <alex.bennee@linaro.org>
+R: Philippe Mathieu-Daudé <philmd@redhat.com>
+S: Maintained
 F: gdbstub*
 F: gdb-xml/
 
-- 
2.20.1


