Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3747ACA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 16:03:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0532B21872
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 16:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DJtk3UvO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0532B21872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO23R-0007fc-D1
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 12:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33716)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iO1zL-0004GO-LL
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 11:58:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iO1zK-0000jA-CB
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 11:58:55 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:39009)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iO1zK-0000iw-6O
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 11:58:54 -0400
Received: by mail-wr1-x42a.google.com with SMTP id a11so2917589wra.6
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 08:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UeNi4HqnVEC6u0wtwkj53CHw9ds/RgSxB0I9/9d9f7A=;
 b=DJtk3UvOnOpbwIOc3L5wDqtiq40DPuHSBvDke+Y2EiWVf+SClVChmiKhOQ8ywiu1b8
 /XC1HWU6KGnBSVXXJYmzQMhJk0x6Dq9YQsQZm67d3g0fld+YE6PMCqEoELAV8FemInfA
 UT0BG5iejHrvH2YefQFb+pHP6ABN8NiMbobn6mvyZqus0fTU0jHM6uWYpRePDL1xY9xq
 Vu7ZIZ9O11jUCZa/Jk6qDbOEgKwh9qyYH99Suz2swktaJhfGxI1B9DW4WLjPJH5DoC0s
 MA1NnfmSnwv5ZxRU5TtdfF7EPZ/4iriRPt8be2Pm8uG9/uQlDgwqn9WdrRQVk5bn+5f+
 9exw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UeNi4HqnVEC6u0wtwkj53CHw9ds/RgSxB0I9/9d9f7A=;
 b=p8+Xt685SDBk2ELzK+Xtgl/0YA16rT/FazA7V4U5A9iVOT2N7zN2kp7QLDGTSSmcag
 I8oa2j94Arf/ThojuPJOTDTzMw1he1zQcAkAKlOaTMZglFCth16gB95SZwEc1pI8hVxk
 1nQqGPwdXZDe1FMcHafX+MLaVBbKcMIJaJJd3md/MEmDaaiqpUUGECiSlBzlscXqCJEM
 C8fMtNzjz7O3hu1m/V46v++y/uvHwpCUBw1AuVHfBXhPyK30MoakwWBtO2PWusCrlvx8
 4nUfSq4aSqa39ubFVbBF66ngOzAUdtc04Tv2zPOsm1JhhUbasTzM0kWeHVCo09A6QHc0
 UGVg==
X-Gm-Message-State: APjAAAWiHr+2v9Ezfayb+5XO0Dxu1kuNNqNIDGsGdO62+UodQGyyedjZ
 kV2RQLrELnPYydmMHlaRyQpUwfoLIJk=
X-Google-Smtp-Source: APXvYqym5p6+22GscfZ79WwQoE8wkFetpxA1p+tr6DkmPg4nk6CvpT8S3SeU39rBarz1h1zOTO0Rmg==
X-Received: by 2002:adf:ee03:: with SMTP id y3mr3688624wrn.116.1572019131935; 
 Fri, 25 Oct 2019 08:58:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 65sm4218887wrs.9.2019.10.25.08.58.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 08:58:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/4] tcg/LICENSE: Remove no-longer-true statement that TCG
 is BSD-licensed
Date: Fri, 25 Oct 2019 16:58:44 +0100
Message-Id: <20191025155848.17362-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Claudio Fontana <claudio.fontana@gmail.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Laszlo Ersek <lersek@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since 2008 the tcg/LICENSE file has not changed: it claims that
everything under tcg/ is BSD-licensed.

This is not true and hasn't been true for years: in 2013 we
accepted the tcg/aarch64 target code under a GPLv2-or-later
license statement. We also have generic vector optimisation
code under the LGPL2.1-or-later, and the TCI backend is
GPLv2-or-later. Further, many of the files are not BSD
licensed but MIT licensed.

We don't really consider the tcg subdirectory to be a distinct
part of QEMU anyway.

This patchset adds explicit licensing/copyright comments to
the three files which were missing them, removes the
inaccurate tcg/LICENSE file, and updates the top-level
LICENSE file to be more accurate about the current state
of the licenses used in the code in tcg/.

If we want a policy that tcg/ code has a restricted
permitted set of licenses, then we really need to have
this enforced by checkpatch -- history demonstrates that
just writing it in tcg/LICENSE does not prevent code under
other licenses getting in. In the v1 email thread nobody
seemed to be very strongly arguing for this, though, and
at this point we would need to make an active effort to
track down contributors and get relicensing statements.
If anybody wants to push that effort now would be a good
time to volunteer :-)

Note on the licensing for the tcg-target.opc.h files:
 * I've used the same license as the rest of the relevant
   backend, which is to say GPL2-or-later for tcg/aarch64
   and MIT for tcg/i386 and tcg/ppc.
 * In all 3 cases, the only people who've made contributions
   to the files are Richard Henderson and (for aarch64) Alex Bennée

Richard, Alex -- an acked-by for the relevant patches would
be nice (or if you intended a different license for the
contributions than I have assumed please say so!)

v1->v2 changes:
 * note the presence of MIT licensed code as well
 * 3 new patches adding copyright/licensing to files
   that were missing it

thanks
-- PMM

Peter Maydell (4):
  tcg/aarch64/tcg-target.opc.h: Add copyright/license
  tcg/i386/tcg-target.opc.h: Add copyright/license
  tcg/ppc/tcg-target.opc.h: Add copyright/license
  tcg/LICENSE: Remove out of date claim about TCG subdirectory licensing

 tcg/aarch64/tcg-target.opc.h | 15 ++++++++++++---
 tcg/i386/tcg-target.opc.h    | 28 +++++++++++++++++++++++++---
 tcg/ppc/tcg-target.opc.h     | 20 ++++++++++++++++++++
 LICENSE                      |  5 +++--
 tcg/LICENSE                  |  3 ---
 5 files changed, 60 insertions(+), 11 deletions(-)
 delete mode 100644 tcg/LICENSE

-- 
2.20.1


