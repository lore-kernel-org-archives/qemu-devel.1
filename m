Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D81C3B1BF
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 21:43:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63FEF2084E
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 21:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tHH7RU/3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63FEF2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3RhD-0000UN-KT
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 16:43:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47662)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3RgS-0007ps-II
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 16:42:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3RgR-0004qd-AL
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 16:42:36 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:42125)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3RgR-0004pc-5R
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 16:42:35 -0500
Received: by mail-pg1-x544.google.com with SMTP id w21so7973230pgl.9
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2020 13:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iwAfLdSd4Nz0+d0j/xxVSEbWBf2WYBccmS2/+I5uAl0=;
 b=tHH7RU/3tsSyj+jbN59lDUi5kcyKVVlCHnied+hnlcfdqm0qa1miVFoKQXPZCsuXgZ
 KrG/JJqzo3qmWl69eRCDzNjxje8NIP6OXFALJePYZraW5mq1C4bir8+O8q4cQBVBd+Pr
 2IpvpKBZxiMu888EkUYR7AxO4tgS/nWNVsikUdBLqDbUCGhKvkB8Pds4UEw0hrQHPnZD
 n96se0KW+pwKFE8oOujvcUYVuVRnw3YyMen/g1Dq/Bq7RjXZSo+p4sJX/1da+n1yRZzn
 jMEGtd8HHt13mlXESXrhwnDUua0tyDhSBYcchJEuFF3ams6K7qtbrKrK7ONcAqrAC8RJ
 i1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iwAfLdSd4Nz0+d0j/xxVSEbWBf2WYBccmS2/+I5uAl0=;
 b=qtJlGsdlBwoxlmCLXfywgBzUdDolS2TtTkKoLIHTiGdAesV+XC8wekuV0dGDjziIkZ
 CBQ6MXxzQKo1zQCK7gx1PIcPwbxnMEE76EWm2NKhfsbWeuSN/NB5kHmVnUnC8OKnatGY
 5X+YObr+WCGbVj5aAmSWJX4bnj1Q/eIzgLas8rAT/bd/I3hDLgBAQH+KEZNhrT6nTWtV
 6ZWROwbjsZoKUiKwnrRQQwgLMwYgrtbztpcqZMTOdGlMjodw/iSZw4OV24ubXjgjlAZU
 HvQfpPoIOP5QT99wwDFYnX//AZ0SR01kJ9aalqxtxWAzpOd2xxwTgNuuW5U1AVgObyCS
 2jNA==
X-Gm-Message-State: APjAAAV0041PXQd6WMmuwBJ8ytTcmwb9P5PYOR3Xe/wSAiiXyzGXSG/p
 oEoTAK8+JTd5U7TDElvd05TArAOw8Y0=
X-Google-Smtp-Source: APXvYqwTBCKIEaZi/Sp6anb/zImbbVIX8D/O3D0T9R9jdm2X8grBOTqSsB4dfOYPGy7Jk4HiShv+tg==
X-Received: by 2002:a63:38b:: with SMTP id 133mr14552527pgd.153.1581889353666; 
 Sun, 16 Feb 2020 13:42:33 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id z29sm14821848pgc.21.2020.02.16.13.42.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2020 13:42:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/4] target/arm vector improvements
Date: Sun, 16 Feb 2020 13:42:28 -0800
Message-Id: <20200216214232.4230-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changes for v2:

* Rename function arguments as requested by ajb.
* Minor optimization in helper_gvec_pmul_b.

Original blurb:

The first patch has been seen before.

  https://patchwork.ozlabs.org/patch/1115039/

It had a bug and I didn't fix it right away and then forgot.
Fixed now; I had mixed up the operand ordering for aarch32.

The next 3 are something that I noticed while doing other stuff.

In particular, pmull is used heavily during https transfers.
While cloning a repository, the old code peaks at 27% of the
total runtime, as measured by perf top.  The new code does
not quite reach 3% repeating the same clone.

In addition, the new helper functions are in the form that
will be required for the implementation of SVE2.


r~

Richard Henderson (4):
  target/arm: Vectorize USHL and SSHL
  target/arm: Convert PMUL.8 to gvec
  target/arm: Convert PMULL.64 to gvec
  target/arm: Convert PMULL.8 to gvec

 target/arm/helper-sve.h    |   2 +
 target/arm/helper.h        |  21 ++-
 target/arm/translate.h     |   6 +
 target/arm/neon_helper.c   | 117 -------------
 target/arm/translate-a64.c |  83 ++++-----
 target/arm/translate.c     | 348 ++++++++++++++++++++++++++++++++-----
 target/arm/vec_helper.c    | 211 ++++++++++++++++++++++
 7 files changed, 560 insertions(+), 228 deletions(-)

-- 
2.20.1


