Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5B7C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:26:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5216322205
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vs9VyP2O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5216322205
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIvo7-00086d-Of
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 11:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kIvc6-0003iv-QB
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 11:14:22 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630]:46878)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kIvc4-0003H7-OM
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 11:14:22 -0400
Received: by mail-ej1-x630.google.com with SMTP id z23so3736429ejr.13
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 08:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7i9eDP8thZM5PL+Ey2DTSTbIiJSV0EChcGkybPPV6p0=;
 b=Vs9VyP2OQPgplI1YA3C5Ec4GatiCqPKS1zCMh2nDUEjQo31K+gMKQt/m6YYt2Mxcdg
 /HCGf6FsreyYiq+TwXFcXkn3/CSvNmK3hrkEj4AsDzAunCniz1vn92R7Pi7H09Yi1215
 JlhGb8h4l+5VqhxiKvZx2bP2frpIor8ljTd9zIwSHjUd6hZ2Moio2Qpoggw8wL5rp17D
 31vkEJyKL6gFMnaRGEmppxnQ8Km4G+/pKlsYFpL95KvlXbvmlu47zdI2oPGBrO0dnGEH
 mMfwYMlWYhPnzOAJc00l15dsSSpMD6kdExeTTLxJoS2pPGUOx1XYbyLbWAHK3hvpCsPS
 mWrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7i9eDP8thZM5PL+Ey2DTSTbIiJSV0EChcGkybPPV6p0=;
 b=G4+4GH9bb5pDHBpkYkwl6iCEOXVRUAMSCKMuTBC3BGO27Rhy1o+PIrUhbbbh9ZX3ct
 AK0YMqeZpdNvtu7X2CSsPQYHM+6g2LkNLM+w5PyN2Jc5YxUua7Oytkf6b86FRqOiZo+x
 hBgPCLBQuH11GbDa9aPPL0GcymYPuV118UkmND2RSjZzsTdgo3lGVPsGSgNXJsmYkJoM
 IuKcA3P/gQDWn8kRDyIsj12HxSkjRvfKlFQjFZXWAHB3Em22M+Bplfxs/iDEQGL6j/Rz
 0XMTlVk7MDIKSphF6I3dtSdGUeD8fwTX7sR+vnWeD6d/4s/X7hB6VL/ctNkMMUJ3vs5h
 acxw==
X-Gm-Message-State: AOAM530POCN9gOhAGGBAZo/px6eDXVgSWwrCbKGjB5X4HB3x4X0D9l/t
 g2n/KOadeEzn6DZJKWdhmvih1WC6/goLdgpqMRt4qQ==
X-Google-Smtp-Source: ABdhPJyJOG+N2eUjkRd9OAOaQpfSx5nXcWRODiEvUlXMVy2/8CLc+NZHYBFdMMhDv2VUrJRoyk+xX9tWq+ZVQygFXL4=
X-Received: by 2002:a17:906:d936:: with SMTP id
 rn22mr31564189ejb.4.1600355658807; 
 Thu, 17 Sep 2020 08:14:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200916114731.102080-1-thuth@redhat.com>
In-Reply-To: <20200916114731.102080-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Sep 2020 16:14:07 +0100
Message-ID: <CAFEAcA8VyUYJnE3aji6zPQGPD-K+iVGwVNbygYypr+NpSzZBPw@mail.gmail.com>
Subject: Re: [PULL 00/24] qtests, unit tests and Cirrus-CI fixes / improvements
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x630.google.com
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
Cc: Yonggang Luo <luoyonggang@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 16 Sep 2020 at 12:47, Thomas Huth <thuth@redhat.com> wrote:
> ----------------------------------------------------------------
> * Fix "readlink -f" problem in iotests on macOS (to fix the Cirrus-CI tests)
> * Some minor qtest improvements
> * Fix the unit tests to work on MSYS2, too
> * Enable building and testing on MSYS2 in the Cirrus-CI
> * Build FreeBSD with one task again in the Cirrus-CI
> ----------------------------------------------------------------

After merging this one I tried installing GNU sed on my local
box so it could run the iotests, but they fail like this
because they assume readarray, which doesn't exist in
OSX bash:

--- /Users/pm215/src/qemu-for-merges/tests/qemu-iotests/001.out
2015-09-29 16:54:34.000000000 +0100
+++ /Users/pm215/src/qemu-for-merges/build/all/tests/qemu-iotests/001.out.bad
  2020-09-17 15:03:22.000000000 +0100
@@ -1,5 +1,6 @@
 QA output created by 001
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
+./common.filter: line 142: readarray: command not found
+, fmt=

thanks
-- PMM

