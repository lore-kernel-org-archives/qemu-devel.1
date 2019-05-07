Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F39C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 12:05:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ECB8206BF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 12:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Po9GDH7G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ECB8206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45656 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNyr7-0002pr-Jd
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 08:05:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hNylr-0007dg-Q6
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:00:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hNylq-0003t1-KC
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:00:31 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:40737)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hNylq-0003s4-DH
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:00:30 -0400
Received: by mail-wm1-x334.google.com with SMTP id h11so19613378wmb.5
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 05:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=2H24j/ivxKhpWMoNZRyFm5/WUhhAwlHuP6YRtZPABdg=;
	b=Po9GDH7GhqXavjGPmL2GFhMIfMm1PbDdrfrn7Gy45f11Oogo9As3XZJv0QjnWwU1en
	/IGIHUimZ7Ge56gXihpEwF1nLkJ2TgOSLAY4+5ecrh/Pcof2IsTq/szfsasGk4LjI5Ny
	ZiwryR+us5QOzyVJYCecnMXtkLJnpi4ftahrtryGcHzdMBu8CAlQzN326JYLCMIojOq5
	gbSYv7KOnda+4MIGRannH6dui/RoS6SnGUH/wqELKYMpigtNiLwztaxGPBaDREDe/AMq
	ztjWv96teUDajYvjX8lmkXy8KHexyKwyBauo5v3dqlp6/mQW9ECs0XcxSKetYe5yQ9Tu
	D/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=2H24j/ivxKhpWMoNZRyFm5/WUhhAwlHuP6YRtZPABdg=;
	b=LMaGxvm/J+MkFoMlXYKcHihYNZD953jBWV8rVzhYta4uAUXFRSBJcP/w1MNDgOKTUM
	Bwe74spZfBl9XpgwN4cpzh+LVijxyvEyFJki4pqR/leRYS69Z0wUPokdiXKwqdNdLt4D
	NQPpo/F1l/w07TqJuQ2VG9TcjXwW5lQ6a3QSJgmLMFIW0CQHIPKmbf/owOY1WmDkxGpV
	kNrI4+r2tLHqDgk7erjAha0WOkOsQACRXpcvC4q9+vJGI+gd1uWcdTQPelFGOSqfYeb9
	5FZsq8PZl9O1YpJfbyksciN63CyljhGass7F1KofnOtj7wJbf0JjedGDTFHvuWkbijFH
	7lDg==
X-Gm-Message-State: APjAAAXjjUfX2DB21TrBfQIfI3Dx3+wP5DhW9t2N6cwGHcvE/JrCLMpl
	I95VLgLrQV7UoDli28bVgcstXPk7k/E=
X-Google-Smtp-Source: APXvYqzLX4z5Yl6q/KCtD+zhluzuPuelQNia2NlxMWy0+f4sgRpZ6raGgTrpW+ZvrRrtPe4MG06UFA==
X-Received: by 2002:a1c:ac07:: with SMTP id v7mr19777642wme.49.1557230428551; 
	Tue, 07 May 2019 05:00:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id g3sm12348596wmf.9.2019.05.07.05.00.27
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 05:00:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 13:00:06 +0100
Message-Id: <20190507120011.18100-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507120011.18100-1-peter.maydell@linaro.org>
References: <20190507120011.18100-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::334
Subject: [Qemu-devel] [PULL 10/15] osdep: Fix mingw compilation regarding
 stdio formats
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

I encountered the following compilation error on mingw:

/mnt/d/qemu/include/qemu/osdep.h:97:9: error: '__USE_MINGW_ANSI_STDIO' macro redefined [-Werror,-Wmacro-redefined]
 #define __USE_MINGW_ANSI_STDIO 1
        ^
/mnt/d/llvm-mingw/aarch64-w64-mingw32/include/_mingw.h:433:9: note: previous definition is here
 #define __USE_MINGW_ANSI_STDIO 0      /* was not defined so it should be 0 */

It turns out that __USE_MINGW_ANSI_STDIO must be set before any
system headers are included, not just before stdio.h.

Signed-off-by: Cao Jiaxi <driver1998@foxmail.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Stefan Weil <sw@weilnetz.de>
Message-id: 20190503003719.10233-1-driver1998@foxmail.com
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/qemu/osdep.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 303d315c5d4..af2b91f0b87 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -85,17 +85,17 @@ extern int daemon(int, int);
 #endif
 #endif
 
+/* enable C99/POSIX format strings (needs mingw32-runtime 3.15 or later) */
+#ifdef __MINGW32__
+#define __USE_MINGW_ANSI_STDIO 1
+#endif
+
 #include <stdarg.h>
 #include <stddef.h>
 #include <stdbool.h>
 #include <stdint.h>
 #include <sys/types.h>
 #include <stdlib.h>
-
-/* enable C99/POSIX format strings (needs mingw32-runtime 3.15 or later) */
-#ifdef __MINGW32__
-#define __USE_MINGW_ANSI_STDIO 1
-#endif
 #include <stdio.h>
 
 #include <string.h>
-- 
2.20.1


