Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7217C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 22:36:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90A61227BF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 22:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tj9PKDCF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90A61227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihhvM-0002jJ-C0
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 17:36:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54247)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ihhu5-0001TF-Vv
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 17:34:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ihhu3-0003tl-Hb
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 17:34:49 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:43791)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ihhu3-0003sg-B8
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 17:34:47 -0500
Received: by mail-pf1-x441.google.com with SMTP id x6so927864pfo.10
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 14:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bDZlkQFsGu9lcu99bMN7sasPdTJ24bpvTwRb0OW56FU=;
 b=tj9PKDCFbWLDvalXBdDD9W0vYOYboqKZSWJkfyBguTG4lpTusua5m+Ks7RWVlH8P+f
 Tz1QyiBdNdZc/KCOxkzrplR56h9HnVGpHoxrOkWvRL0AyhLAqyb8P5Y9BbaULJqruMoC
 69WhVLlAxcXmJSjqt4dtUYl4kzD7V7vdvviNxsrufyox7oRSbWcz0QNo3ao/j2v9Di7I
 pKPQJwwvIbYUzTmdiMENY4C9/v7LMnpxU5i9D2ZzM+4LEepo3OZd6ieRoZ7WkkgquIey
 UiM/uYlOn6ltJc3QCSoezTZZI7w+0hM79M68csSbsw9sI4o0hOJyTV6lmSekEAw5MGGo
 ySKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bDZlkQFsGu9lcu99bMN7sasPdTJ24bpvTwRb0OW56FU=;
 b=k+xRba19uxfh1gJawsdrOag1BypYGuYTfF5dFq1LJv+FBmJ6mDd6tSfMR1ghQfzMku
 f6/qeKvP0PnKCbdrc6cV8Vno4ADBs4PWNKr6uNQ/hQ8NjJz63B/CU6M5yFV8r5YuTp5b
 IFyWtQqZAzLL2FwWhroLtthxxbFaRu3AD5Wmpn9DE9qyxhfj5zv4eGtCqz3jTvVYQzRr
 cwb3YA6fGxhHr8AlOOkA/lXXtNN6hgw+tOoWS9KtMaO4lYWCDlacpgLL0FfCyMni+T5Z
 ooW2RXiMncn5BHGZPxlOtOSU8rt4pCgYSO7aJoaPMTmrcCdX9lxobyJCbA0A2sbmcDY6
 x8MA==
X-Gm-Message-State: APjAAAWd0CN9/OlNXKPfs+Eu08OUxdWEeITxBX7+1ncyOIF0yeJx+grw
 /Ku34XezNLDQdI384vhrbUWwwTLMFlE=
X-Google-Smtp-Source: APXvYqwjXdoe8hUh0qlxeNPSMzKzsW69px686qbRng0hNifPVOfK6MG6NxlkwYlqSE5D0+DGoRshxg==
X-Received: by 2002:a65:640e:: with SMTP id a14mr5185106pgv.402.1576708484590; 
 Wed, 18 Dec 2019 14:34:44 -0800 (PST)
Received: from localhost.localdomain
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id j1sm4627779pff.107.2019.12.18.14.34.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2019 14:34:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/7] configure: Improve PIE and other linkage
Date: Wed, 18 Dec 2019 12:34:34 -1000
Message-Id: <20191218223441.23852-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: philmd@redhat.com, i@maskray.me, berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This begins by dropping the -Ttext-segment stuff, which Fangrui Song
correctly points out does not work with lld.  But it's also obsolete,
so instead of adding support for lld's --image-base, remove it all.

Then, remove some other legacy random addresses that were supposed
to apply to softmmu, but didn't really make any sense, and aren't
used anyway when PIE is used, which is the default with a modern
linux distribution.

Then, clean up some of the configure logic surrounding PIE, and its
current non-application to non-x86.

Finally, add support for static-pie linking.

Changes in v2:
 - Remove mention of config-host.ld from make distclean
 - Do not split -z,rodata/-z,now into two tests
 - Fix --disable-pie --static

Tested in conjunction with AJB's 
  configure: allow disable of cross compilation container
  https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg02943.html

as otherwise check-tcg simply doesn't work on aarch64 if you happen
to have docker installed.


r~


Richard Henderson (7):
  configure: Drop adjustment of textseg
  tcg: Remove softmmu code_gen_buffer fixed address
  configure: Do not force pie=no for non-x86
  configure: Always detect -no-pie toolchain support
  configure: Unnest detection of -z,relro and -z,now
  configure: Override the os default with --disable-pie
  configure: Support -static-pie if requested

 Makefile                  |   2 +-
 accel/tcg/translate-all.c |  37 ++----------
 configure                 | 116 +++++++++++---------------------------
 3 files changed, 38 insertions(+), 117 deletions(-)

-- 
2.20.1


