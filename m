Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA31C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 17:58:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48E012067D
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 17:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l98CthNG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48E012067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hssry-0003bV-Ft
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 13:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42604)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hssr7-00022D-Ua
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:57:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hssr6-0002bZ-Vu
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:57:41 -0400
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:45734)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hssr6-0002ah-QM
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:57:40 -0400
Received: by mail-yw1-xc43.google.com with SMTP id m16so25266960ywh.12
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 10:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7EboO1M9lMp727uwu7WK9/tzhJNY6KIIiIQlKtwWES0=;
 b=l98CthNGhk++wHxgd2YLRKlqUjQ2VchPMfc63R4vQKfwIAbWvWPVD9As2V6YoPTld/
 AETlPVBOPlhZTSZWwf4Or/VNEx0g/1RHj0wpzljsyBjKI3d9PcAjK65yUBybT1NGOGXC
 Kdr15s3S9swyeeAcoU+Ns1M/xAnkZHUFJADAL8jofU+70x4A1po9INfYWT6pT3nkS9H/
 mLodXMsk9PtAi8VZ6HkRcVUqTwhcyLCm7pT9gfJJWXd/Hdwfiw6SRSH33XTSWVw3TDlD
 2DjxuEzaPGm0p5KTzfpdH1o5m1QHpmRnJTALtcRIy9KKaimIWQOtVFAYTlH3GwSpW9ou
 qQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7EboO1M9lMp727uwu7WK9/tzhJNY6KIIiIQlKtwWES0=;
 b=nwKGqcDiVFRB9wj14sMompNC2o+C6kxJcDCYIEY6RMMvCPsdS+2MFm56EfgPjqOtcy
 WDZ1dUoycwBN4hp4p+IQ9d5jmHdSEvD1XMQ8UqjZpvCGwKuITAGQj+itRgOuewSMhJbj
 gYwG4V14ImdhF2vSOQSBihsQNN/UScASnEQ5xoG3ZdecnL6bdR7DMDMvZqgSIKwAz5CS
 Z8vLgxp4NFP6aOVGlc6gxYYOQarwYMMWU8u/bIkdhJaq60nHDnqOkLjtDM9wWjN++KmP
 hsQMdW3BV3Umj67h9rriYhHOBi7N6qLO1CUWkNEVlbnKw20MBFFjDRIG2vwqHwpg9kyx
 E2fQ==
X-Gm-Message-State: APjAAAUbNkCNlL9JvlPsEQQpZRGFQADW/7Qjw9xXwCTL7XtGgmLTNu39
 vUacqD8xyHULc8UnWtnu5mt02O8Q
X-Google-Smtp-Source: APXvYqwj7ah4oMws4dXObi1TbQ3xu/HgkFIH0vbfVpOQt8wsFJ35sbtG0/FfcgbmZgcOXsAPdlqFxA==
X-Received: by 2002:a0d:cbcf:: with SMTP id
 n198mr73789429ywd.364.1564595859272; 
 Wed, 31 Jul 2019 10:57:39 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id 206sm16077696ywk.44.2019.07.31.10.57.38
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 10:57:38 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 13:56:40 -0400
Message-Id: <20190731175702.4916-1-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c43
Subject: [Qemu-devel] [RFC PATCH v1 00/22] reimplement (some) x86 vector
 instructions using tcg-gvec
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jan Bobek <jan.bobek@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch series is an early work-in-progress snapshot of my efforts
to utilize the TCG gvec infrastracture in x86 frontend. Only a handful
of instructions have been converted (those which have a direct gvec
equivalent).

The dispatch switch for the converted instructions is sort of hacked
into gen_sse; this is obviously intended for development only.
Eventually, everything that follows this switch will be removed,
along with the SSE tables and all that goes along with it.

Cheers,
  -Jan

Jan Bobek (18):
  target/i386: introduce gen_ld_modrm_* helpers
  target/i386: introduce gen_gvec_ld_modrm_* helpers
  target/i386: add vector register file alignment constraints
  target/i386: reimplement (V)PAND, (V)ANDPS, (V)ANDPD
  target/i386: reimplement (V)POR, (V)ORPS, (V)ORPD
  target/i386: reimplement (V)PXOR, (V)XORPS, (V)XORPD
  target/i386: reimplement (V)PANDN, (V)ANDNPS, (V)ANDNPD
  target/i386: reimplement (V)PADD(B,W,D,Q)
  target/i386: reimplement (V)PSUB(B,W,D,Q)
  target/i386: reimplement (V)PADDS(B,W)
  target/i386: reimplement (V)PADDUS(B,W)
  target/i386: reimplement (V)PSUBS(B,W)
  target/i386: reimplement (V)PSUBUS(B,W)
  target/i386: reimplement (V)PMINSW
  target/i386: reimplement (V)PMINUB
  target/i386: reimplement (V)PMAXSW
  target/i386: reimplement (V)PMAXUB
  target/i386: reimplement (V)P(EQ,CMP)(B,W,D)

Richard Henderson (4):
  target/i386: Push rex_r into DisasContext
  target/i386: Push rex_w into DisasContext
  target/i386: Use prefix, aflag and dflag from DisasContext
  target/i386: Simplify gen_exception arguments

 target/i386/cpu.h            |   6 +-
 target/i386/ops_sse.h        |  65 ---
 target/i386/ops_sse_header.h |  39 --
 target/i386/translate.c      | 990 +++++++++++++++++++++++++----------
 4 files changed, 723 insertions(+), 377 deletions(-)

-- 
2.20.1


