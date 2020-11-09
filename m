Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7998FC5517A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 21:46:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC29E206CB
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 21:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dd0c2xUs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC29E206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcEzl-0001Py-B6
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 16:46:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kcExh-00083N-Sl
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 16:44:29 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:32892)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kcExe-0007f8-DP
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 16:44:29 -0500
Received: by mail-wr1-x444.google.com with SMTP id b8so10449861wrn.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 13:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dKWmfjUK7xqu8mR9QlHEmukySxjQ68aVSEOSYQiOZ2I=;
 b=dd0c2xUsOUDQ24mv4ERrkO4sALWJOlCIPKE1xFAdNl9qx6JCO4lmN6xQmWs59Rpj1N
 KgzBjkm58CLo8+uYfQozDtM0XguwknTwDPrIuNtB2bCQSOydkHyuLTo6IKRs2MkjZVpm
 dlPhaIIxvqSLJiAmNRNvH0OoMATAzmZaQJGLJzxJsE1QGoigsWLLUjJh6UpjmauBRfH/
 ipkgnRMRkIQXssdgJ4DfrXcw21dIBgAydfeh+z5hN0xDym2W2fx+d0XiOXHRT/BwSVwK
 PNrTghbWIg8YJLXLbNK1Qoouy7yzszSOnTeeNfbyq3/Ad+ACLZIZDh2O6YchJdUFy2R9
 7eYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dKWmfjUK7xqu8mR9QlHEmukySxjQ68aVSEOSYQiOZ2I=;
 b=stluiCb/7Gu2mLspKZQCRHXjww0JdpEuHGj5dOrYFw+Js6pom7Sj/jQP33xYmczua0
 AFzsQZf+2x+zdVcm1y/G8G/OGQ/cBVXC4IngT3lgA6SkHC9XB6fAyf4KtBBp0K89TCVu
 yckjgG68SkTE8HDx+I95gQtZaADShaSmIySQVuu+zwe4XvPizoNPcPfb/WQASSj3gjwl
 9UuTUyH1ikv7VYKffK1EUTNpHGvGytnbbPATWW/SlC1uYqK2Kcdm2g5roTvjs1i9kzQ/
 AqO0DduVNqDU+bhaO2aBWHjDYGqg2Zwd3vfSyPPmZNbFsJHB13p1YcXczlYKCEbI/6nH
 Rblg==
X-Gm-Message-State: AOAM530SiUYGbwiqQ6fJ7mhyMssEaFZF0dRdJpmn57YC2Bx9VqPxHS4Z
 olzxfdiUd/OE1/fHoG1+i9UZq2kxZ5k51Q==
X-Google-Smtp-Source: ABdhPJwfTMqfxxMLQPw7HKcTCw60BUGhclMjCM4SOQS7xgNBBWn/qL0dYPnYdLiwAxAeBn6jBD0hnQ==
X-Received: by 2002:adf:ea47:: with SMTP id j7mr19928502wrn.126.1604958262833; 
 Mon, 09 Nov 2020 13:44:22 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e3sm14913252wrn.32.2020.11.09.13.44.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 13:44:22 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC 0/2] Build a single Sphinx manual, not five
Date: Mon,  9 Nov 2020 21:44:18 +0000
Message-Id: <20201109214420.32131-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x444.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Maxim Cournoyer <maxim.cournoyer@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When we first converted our documentation to Sphinx, we split it into
multiple manuals (system, interop, tools, etc), which are all built
separately.  The primary driver for this was wanting to be able to
avoid shipping the 'devel' manual to end-users.  However, this is
working against the grain of the way Sphinx wants to be used and
causes some annoyances:
 * Cross-references between documents become much harder or
   possibly impossible (currently we don't even try)
 * There is no single index to the whole documentation
 * Within one manual there's no links or table-of-contents info
   that lets you easily navigate to the others
 * The devel manual doesn't get published on the QEMU website
   (it would be nice to able to refer to it there)
 * Common information like the QEMU license, supported platforms,
   and deprecation information either gets duplicated across manuals,
   split between them, or shoved into the system manual as the
   closest to a generic one
    
Merely hiding our developer documentation from end users seems like
it's not enough benefit for these costs.

This RFC series switches over to building a single big manual,
the same way that the readthedocs version builds it.

Patch 1 in the set suppresses the warnings that would otherwise
be caused by the handful of 'orphan' rst files in the top level
directory. This is not the correct long-term thing to do with these
files -- my suggestions for most of them are in this thread:
https://lore.kernel.org/qemu-devel/CAFEAcA_ff6bRythvzJWs0McUSz3=2=1=hV9wX_BTv00jPfSHsw@mail.gmail.com/
 -- but for the purposes of this series and until somebody
cleans them up properly, this is the minimal necessary change,
because it's patch 2 that I'm really interested in opinions on.

Earlier discussion on one manual vs multiple was partly on IRC
but also in this thread:
https://lore.kernel.org/qemu-devel/CAFEAcA_4wXqGeOgsY2GbY1mk==DCz--j-jhs+OdGQnOHEf+D_A@mail.gmail.com/

Incidentally, historically we did ship some internals documentation
to end users -- the old qemu-tech.texi "translator internals"
ended up in the user manual. The new 'devel' manual is a lot
bigger, of course.

If you don't want to apply this patch and build the docs to see
what the effect is, you can just look at the readthedocs output
to see what one-big-manual looks like:
https://qemu.readthedocs.io/en/latest/

Side note: it would be nice not to have to duplicate the
list of manpages in docs/conf.py and docs/meson.build. I think
if we didn't insist on only installing the manpages that apply
to the configuration we built for (ie if we installed the full
manpage docs the same way we install the full HTML docs
regardless of config) we could do that, by having Sphinx
build the manpages into a manpages/man[178]/ hierarchy and
just having meson.build do an install_subdir() on it. But
for this patchset I've retained the current behaviour.

thanks
-- PMM

Peter Maydell (2):
  docs: Mark rst files in the top level directory as orphan
  docs: Build and install all the docs in a single manual

 docs/conf.py                 | 37 ++++++++++++++++++++-
 docs/cpu-hotplug.rst         |  2 ++
 docs/devel/conf.py           | 15 ---------
 docs/index.html.in           | 17 ----------
 docs/interop/conf.py         | 26 ---------------
 docs/meson.build             | 64 ++++++++++++++----------------------
 docs/microvm.rst             |  2 ++
 docs/pr-manager.rst          |  2 ++
 docs/specs/conf.py           | 16 ---------
 docs/system/conf.py          | 28 ----------------
 docs/tools/conf.py           | 33 -------------------
 docs/user/conf.py            | 15 ---------
 docs/virtio-net-failover.rst |  2 ++
 docs/virtio-pmem.rst         |  1 +
 14 files changed, 70 insertions(+), 190 deletions(-)
 delete mode 100644 docs/devel/conf.py
 delete mode 100644 docs/index.html.in
 delete mode 100644 docs/interop/conf.py
 delete mode 100644 docs/specs/conf.py
 delete mode 100644 docs/system/conf.py
 delete mode 100644 docs/tools/conf.py
 delete mode 100644 docs/user/conf.py

-- 
2.20.1


