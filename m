Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E3DC433E6
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 09:55:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B8F4217D8
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 09:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dXINzGG3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B8F4217D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvHf3-00083L-IK
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 05:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jvHcN-0003Lk-8S
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 05:52:55 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54158)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jvHcL-0003wi-GL
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 05:52:54 -0400
Received: by mail-wm1-x344.google.com with SMTP id j18so4145143wmi.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 02:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=i/rZS2K2Az8C+lisjWwqZtaVxOPrNRDFcL8rDoPQEgQ=;
 b=dXINzGG3ag6LKDbkW4BjtgVmcpQ9NraO57pT0C9QAZziDLD7emdkHuf6Q2abfhtT5x
 yEj33N7okEGgOpXvmTmq+HkmVrQPFolV3RI/2k3nSV6KPXRAXO1z5k48LX1FeTTjGzyA
 vtpfG18DcyO90lrbMMAGTtoCKJXhcnFGditbhycA1oJzkm9eJx+enxRK0n7Lz+4+blDf
 Sfx0ZCiO1MJx9dXLqHxGc0bVER5k33M/MbXDMVIvv8kmWb0gs6sAJ+5QLwoWB/6R3twU
 dN5m+kkhaY6l9rokKo5JeaK0p6d0tFvrKRCDyMDvQRzaV2AxcRryr1cpjZm/nZk10tpk
 DtiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=i/rZS2K2Az8C+lisjWwqZtaVxOPrNRDFcL8rDoPQEgQ=;
 b=W16Q3MHGq6YqARQkKyH66HAyRHNqqzhLhOgbW09+6wIWnkqvnawppWD9xCizbQXlV/
 Sb3NllX80yNktr/egV+RObejYTMJ8qyZlKADIdBhDb/rklNad030Bz+b7iMeobk1ytJ2
 Cb0eiGdcQdVq7gpobVreLrDRrZXz7cOXEAmXhS281M8pt6KOr7zrA+sqNC0nz+KEcvsy
 A3/gWEpnlJbnmsYyBWGoJe3Dm/eEoYl+NPIM1F9iPg1iUPMRiDQP12x48z08yjSu0QN7
 OxxCmQzkNhFOjHCY2WYYLLXIJXtZF9k39SQaPGxwCJLhARknKjBh+G+s+FZc4gMhC72t
 i6+w==
X-Gm-Message-State: AOAM530IKbVzG7gecn54iuLRGHNvybIaUDP3XKER7j8i57ed8wFNUAAC
 2+zI/LSYuIIcvXL8K9uj55zoZA==
X-Google-Smtp-Source: ABdhPJznHBmb+IdXhZHq1ca5YJCx+0epWppijMPExaFNmEYQGzFzVu5AAhkWa0NR3YqmFuZTTnaR0A==
X-Received: by 2002:a05:600c:2116:: with SMTP id
 u22mr3406458wml.82.1594720371966; 
 Tue, 14 Jul 2020 02:52:51 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u8sm28169159wrt.28.2020.07.14.02.52.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 02:52:48 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7890E1FF8C;
 Tue, 14 Jul 2020 10:52:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 2/9] configure: remove all dependencies on a (re)configure
Date: Tue, 14 Jul 2020 10:52:40 +0100
Message-Id: <20200714095247.19573-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200714095247.19573-1-alex.bennee@linaro.org>
References: <20200714095247.19573-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The previous code was brittle and missed cases such as the mipn32
variants which for some reason has the 64 bit syscalls. This leads to
a number of binary targets having deps lines like:

  all.clang-sanitizer/mipsn32el-linux-user/linux-user/signal.d
  140:  /home/alex/lsrc/qemu.git/linux-user/mips64/syscall_nr.h \
  455:/home/alex/lsrc/qemu.git/linux-user/mips64/syscall_nr.h:

  all.clang-sanitizer/mipsn32el-linux-user/linux-user/syscall.d
  146:  /home/alex/lsrc/qemu.git/linux-user/mips64/syscall_nr.h \
  485:/home/alex/lsrc/qemu.git/linux-user/mips64/syscall_nr.h:

which in turn would trigger the re-generation of syscall_nr.h in the
source tree (thanks to generic %/syscall_nr.h rules). The previous
code attempts to clean it out but misses edge cases but fails.

After spending a day trying to understand how this was happening I'm
unconvinced that there are not other such breakages possible with this
"caching". As we add more auto-generated code to the build it is likely
to trip up again. Apply a hammer to the problem.

Fixes: 91e5998f18 (which fixes 5f29856b852d and 4d6a835dea47)
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200713200415.26214-2-alex.bennee@linaro.org>

diff --git a/configure b/configure
index bc3b9ad931..e1de2f5b24 100755
--- a/configure
+++ b/configure
@@ -1955,23 +1955,20 @@ EOF
 exit 0
 fi
 
-# Remove old dependency files to make sure that they get properly regenerated
-rm -f */config-devices.mak.d
-
 # Remove syscall_nr.h to be sure they will be regenerated in the build
 # directory, not in the source directory
 for arch in alpha hppa m68k xtensa sh4 microblaze arm ppc s390x sparc sparc64 \
     i386 x86_64 mips mips64 ; do
     # remove the file if it has been generated in the source directory
     rm -f "${source_path}/linux-user/${arch}/syscall_nr.h"
-    # remove the dependency files
-    for target in ${arch}*-linux-user ; do
-        test -d "${target}" && find "${target}" -type f -name "*.d" \
-             -exec grep -q "${source_path}/linux-user/${arch}/syscall_nr.h" {} \; \
-             -print | while read file ; do rm "${file}" "${file%.d}.o" ; done
-    done
 done
 
+# Clean out all old dependency files. As more files are generated we
+# run the risk of old dependencies triggering generation in the wrong
+# places. Previous brittle attempts to be surgical tend to miss edge
+# cases leading to wasted time and much confusion.
+find -type f -name "*.d" -exec rm -f {} \;
+
 if test -z "$python"
 then
     error_exit "Python not found. Use --python=/path/to/python"
-- 
2.20.1


