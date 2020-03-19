Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B877C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 19:36:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAE7A2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 19:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dB/MEmRy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAE7A2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jF0xX-0007r4-Ul
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 15:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58037)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jF0v3-0004GB-Fc
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 15:33:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jF0v1-0005n4-QD
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 15:33:29 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:46935)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jF0v1-0005mC-J9
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 15:33:27 -0400
Received: by mail-wr1-x42c.google.com with SMTP id j17so1217186wru.13
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 12:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JFJLunAQLH/hFDSe72Adl5o0i/8lmOMXjxKvCOas7IU=;
 b=dB/MEmRyQbB8ift5YJMO2na5FN5tocOp1FA5RQCCRWwMzJcnkeE26JNm4i08nCaAbT
 oSe7MGoYcwj1PPUO2CEbXZ6rgP5bzB9Btt0HsRvL3x0eRhq64tx6sDq6hHr2FWynFBPd
 JVU3o8pIRkGQkfTcoRte7dbYRJzi12i+AEu7W+C15eiLR1NCGkrGOe3oPR0XSkLiTN4E
 yb3rhaF8w0sU7qpyxaACs5ol1Vhm3Fq0oTeU1q9rPz/F/Uvrpg8k+gNBPTHIUXrjYnl7
 yeXRDWeLO41B82PNaBmGMyVIUSb2oPeVgjcD3vBOzbWZ8iO6hL+G4TMGGnkiNLHd4Ab6
 gQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JFJLunAQLH/hFDSe72Adl5o0i/8lmOMXjxKvCOas7IU=;
 b=kUTFaPNfHHmJ+I8OiyR3EoO7sU4i482huLHDjVX/JgGfMSiNM9yzrh7gpXV95Fvc5q
 TOVW5jVQxbLtAGmL5eG461NI6uD7f13xPEgz7aJYIHijtr1DiS8u+gBUW/8gF2oCzoDE
 +w6LPtbm2kILWeAjpA3RwKoeuE6KPTadV3hOabJ/8ATyYpGyZxO5wE5YUnsQay3ozdRJ
 x+WkclcIb3TsDF3fntXgDB8HT6p2sc0pB0EEUiP3juPc9N2iY45qFgZ4YNd5CoRVnxYu
 shXrmpLNWLLwaVX5EhaiA8eNkvamofKgW3n7t2IEX1oZwYNyMKicE3abr8zBGSZWD7Ri
 5/Wg==
X-Gm-Message-State: ANhLgQ1SxATkUPCP7/dMXoQRey6Ew3tXiGiQMtYQeGGvcz2WVdhi8Kd0
 1c3HPNfhrRclTxX61Q332ntR0hNYHhlRuw==
X-Google-Smtp-Source: ADFU+vt14JsG9k7Uu2KcvBsPEwsnb1rqSujhrXgmGfAq19PHF27d1jzLjj4Hm2Q7my4l8A8W5/trHw==
X-Received: by 2002:a5d:658f:: with SMTP id q15mr6155590wru.110.1584646405629; 
 Thu, 19 Mar 2020 12:33:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o9sm4984794wrw.20.2020.03.19.12.33.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2020 12:33:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/6] Automation of Coverity Scan uploads (via Docker)
Date: Thu, 19 Mar 2020 19:33:17 +0000
Message-Id: <20200319193323.2038-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v1 of this series was over a year ago:
https://patchew.org/QEMU/20181113184641.4492-1-peter.maydell@linaro.org/

I dusted it off and fixed some stuff because Paolo reports that the
machine he was previously using for uploads can't run the Coverity
tools any more.

The first four patches are fixes for problems that cause the Coverity
tool not to be able to scan everything.  The first one in particular
meant that every compilation unit failed, which would block uploads. 
The other 3 would reduce the scan coverage but weren't fatal.  (The
only remaining warnings in the log are where Coverity complains about
asm intrinsics system headers.)

With these scripts you can do an upload with
COVERITY_TOKEN=nnnnnnnnn ./scripts/coverity-scan/run-coverity-scan --docker
(where nnnnnnnn is the project's secret token which admins can
get from the Coverity web UI).

I did in fact do an upload to test it, so the currently visible
results on the website are the result of a scan on ce73691e258 plus
this series.

The new upload has +112 defects, which is quite a lot, but I don't
think it's so many that it is "defects we rejected as false positives
coming back again"; my guess is a combination of the fixes in the
first 4 patches increasing coverage plus we haven't run a test in a
while plus maybe the script has some more config options enabled that
Paolo's box did not.  (In the web UI defects that were dismissed as
FPs seem still to be considered present-but-dismissed, so I think
that's OK.)

Not much has changed since v1; I didn't get very much feedback
the first time around[*]. Docker still seems to do the "download
the Coverity tools" part more often than I expect. On the other
hand "actually automated with a script in the tree" beats "not
automated and currently broken" so maybe this patchset as it
stands is good enough, given that basically 1 or 2 people ever
will be running the script ?

[*] Eric will note that yes, the script still uses set -e.

(Like v1 this doesn't try to tie it into Travis, but we could
in theory do that some day, or have some other automated once
a week run of the script.)

thanks
-- PMM

Peter Maydell (6):
  osdep.h: Drop no-longer-needed Coverity workarounds
  thread.h: Fix Coverity version of qemu_cond_timedwait()
  thread.h: Remove trailing semicolons from Coverity qemu_mutex_lock()
    etc
  linux-user/flatload.c: Use "" for include of QEMU header target_flat.h
  scripts/run-coverity-scan: Script to run Coverity Scan build
  scripts/coverity-scan: Add Docker support

 include/qemu/osdep.h                       |  14 -
 include/qemu/thread.h                      |  12 +-
 linux-user/flatload.c                      |   2 +-
 MAINTAINERS                                |   5 +
 scripts/coverity-scan/coverity-scan.docker | 131 +++++++
 scripts/coverity-scan/run-coverity-scan    | 401 +++++++++++++++++++++
 6 files changed, 544 insertions(+), 21 deletions(-)
 create mode 100644 scripts/coverity-scan/coverity-scan.docker
 create mode 100755 scripts/coverity-scan/run-coverity-scan

-- 
2.20.1

