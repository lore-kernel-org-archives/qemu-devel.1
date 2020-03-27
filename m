Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA750C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 22:05:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A162C2071B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 22:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GEgyfMfm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A162C2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHx64-0004Fe-RJ
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 18:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49228)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jHx55-0003BW-76
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 18:04:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jHx54-0000DZ-32
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 18:03:58 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:40151)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jHx53-00007P-NY
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 18:03:58 -0400
Received: by mail-pg1-x541.google.com with SMTP id t24so5226601pgj.7
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 15:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IhC/nVnd7bFrZgWR3A7hvq/IiY26kCPnLCNhRT4oR7o=;
 b=GEgyfMfmTs968pxu/8o8guzeGk0it4YEt3XyqVr1YDIxnt5QsxF+bEcGtp+sqJL8LZ
 m/kOS3EfkzDNUbMqfsStRsl4E4VvFagaVs1QSUeO1TeW6tS78roLmQ5grn1LBZ/8c96I
 gxMc9QLieqCHaGJ8TJxnC0e2aeVzpG+HRODXPnryOaIHg2ZrZf2Kb1YzmUvJbaXwaCwt
 BiyiLqGmWBYY9rh+nE8sG1fZjmUyT8SJIZp9XACEm+e/8mMUBIkKXne9vdnaEUmTKmLq
 laeWRHWoENdHggl2lw6Iu9GBI+Q2b9fnpDdT5oOB2kuWh5eEwwXO3raSO1Ep37SqyHKW
 9UgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IhC/nVnd7bFrZgWR3A7hvq/IiY26kCPnLCNhRT4oR7o=;
 b=LxIB00DxFyjwFegmHOPHxuUZW5LibpQsj9uKfHo2hAXNUs4e2DqOooAHn0PhEAZnkX
 T7SctI6b0AbZX06mzTUCXJYDTqOMmP2Rohl756up/K8jdqh7HjQQAEDOcbiN1x5XQBbN
 tj5zgdsMFGfZS+Pp6npt1fBJfeWHUBJqTUkrcdJUacfWiDD9etBBXKsNtFBL1TrN79tj
 iua7/qqYAQaS8aFgbbAs8Gxh75kuMagD/KgUFo74KANvqclCrTihEBBuLQigoq/NpE5u
 MrORwLjYhn+GnwEnU0IQPqn2d/30rRT6udPde8WhzoBCoGZiirURNcWF84/pCO6BYZGk
 4Prw==
X-Gm-Message-State: ANhLgQ2DyhL2eY3gP6Np21XRuKGzcOuMaqAdYCMx8BDbiSRojLh2I4Bg
 FI8hjUaJfQspTNz+JNGn3p9YetZAlaY=
X-Google-Smtp-Source: ADFU+vs8SSViXUuv5/yYWTz6exWTpBgHwoJWT4fZIfpysl6AsAUC00glw5cXWDBHlHNMYYZ7AQOyEw==
X-Received: by 2002:a62:14d6:: with SMTP id 205mr1361275pfu.155.1585346635594; 
 Fri, 27 Mar 2020 15:03:55 -0700 (PDT)
Received: from localhost.localdomain (174-21-138-234.tukw.qwest.net.
 [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id y29sm4516929pge.22.2020.03.27.15.03.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2020 15:03:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0 v3 0/7] configure: Improve PIE and other linkage
Date: Fri, 27 Mar 2020 15:03:46 -0700
Message-Id: <20200327220353.27233-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: dim@FreeBSD.org, alex.bennee@linaro.org, roger.pau@citrix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Version 3 is a rebase from January, with s/LDCONFIG/QEMU_LDCONFIG/.
I plan on including this in the next tcg-next pull request, if there
is no other commentary.


r~


Richard Henderson (7):
  configure: Drop adjustment of textseg
  tcg: Remove softmmu code_gen_buffer fixed address
  configure: Do not force pie=no for non-x86
  configure: Always detect -no-pie toolchain support
  configure: Unnest detection of -z,relro and -z,now
  configure: Override the os default with --disable-pie
  configure: Support -static-pie if requested

 configure                 | 116 +++++++++++---------------------------
 Makefile                  |   2 +-
 accel/tcg/translate-all.c |  37 ++----------
 3 files changed, 38 insertions(+), 117 deletions(-)

-- 
2.20.1


