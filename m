Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E879C433E5
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 10:54:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF5D6206BE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 10:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ujkHhBGg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF5D6206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwO0k-0000iD-1d
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 06:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jwNy2-0004bp-7F
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 06:51:53 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51859)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jwNxv-0003qX-F6
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 06:51:48 -0400
Received: by mail-wm1-x341.google.com with SMTP id 22so14180088wmg.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 03:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DqfpJSe2gTXPFMFK1RIpYZrvJwlQQx+0+8ewUbbarN8=;
 b=ujkHhBGg2yoLYpffAxO7ZMdLwdbACGWuWTdf5ehbigSJeJgaF0Dxq4fhpQJ6owMo/x
 jmPiVQ3iAs4LoKNSEiYpR8Tc5UqP8AYLVVN3wuS7pHkVdgX/6OA3zHjiSaOdmoFHtZhY
 97lovYZFmmAxn/dNPWeH/iwN+UOeSDGZjA7aYsEg3/MJbTHmMx11V5sTNYECJ62E2Amc
 tQWTNucmGoJyEsWZdp5GKhbdgBGgIax3ICGorsxew027mZoRT3C4lLtiP4A4PmnMBt/A
 1ln9864HmQNyXQDfll8+6ZWqA8OKygjTWD0DycqKbHFECrNEgQAsVQ1pohnWnx+6aVn7
 17/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DqfpJSe2gTXPFMFK1RIpYZrvJwlQQx+0+8ewUbbarN8=;
 b=dzrUO70XC+R+QalQ3Q9x/ZWXOFanIBfzZw0lYqhL864jvOAsZUmgSZf5tKp7pimZFx
 il7Uh6V5GEWr2ot89fMFZUSgCFmKSpGZJhSjprXBmGFMwDmoBquu8SFTpoXJ56tI9v9O
 OSP8dOsV1iyxzMAC7Nk0kUIgsr3i20qeZkGKSrGDQ2R1kcLJTj9k+00xEUolp2/jWDRd
 XmA7zkPIggmVW1fvqPhnT90vxznV1pTVG6czdKTEEs0ur9PYw5mu23WHaZ2bsH/uByIj
 OM5Bmyjzi5F3DNBbtOrqrknBFWsN7qZz+4yDbag0gLz9RLIVjph++07ojc9W+MKM/F22
 imCA==
X-Gm-Message-State: AOAM532U8QeeP9aOukCF2qfi4ZPhjyDYzI5XbxoJ4D+fmAW2CJ59CFCE
 0E7W6QD+NwplwSAzNU4hSATHJg==
X-Google-Smtp-Source: ABdhPJz0NkUJVv0nBdxuQmN+sEtFGz4TRsw4y14w/Xv8s33haNB/YK1ENL5mkRQwrXIiBAYg01Lb9w==
X-Received: by 2002:a05:600c:4114:: with SMTP id
 j20mr8522271wmi.74.1594983101418; 
 Fri, 17 Jul 2020 03:51:41 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j145sm13940777wmj.7.2020.07.17.03.51.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2020 03:51:40 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 907D11FF7E;
 Fri, 17 Jul 2020 11:51:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 0/5] candidate fixes for 5.1-rc1 (shippable, semihosting,
 OOM tcg)
Date: Fri, 17 Jul 2020 11:51:34 +0100
Message-Id: <20200717105139.25293-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
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
Cc: fam@euphon.net, berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

These are some candidate patches for rc1. 

The first is a quick fix that finally gets shippable up and running
again. We may want to consider a grand renaming of our docker scheme
but I don't think thats something worth dropping in while we are
stabilising - especially if we change the project name on gitlab. 

The semihosting fixes had just slipped off my radar but are pretty
minor bug fixes.

Finally I whipped up the last two because of a report of QEMU OOM'ing
on some CI systems with low memory. It doesn't restore the link to
guest ram size but instead introduces an advisory helper function to
probe guest physical memory.

Please review.

Alex Bennée (3):
  shippable: add one more qemu to registry url
  util: add qemu_get_host_physmem utility function
  accel/tcg: better handle memory constrained systems

KONRAD Frederic (2):
  semihosting: defer connect_chardevs a little more to use serialx
  semihosting: don't send the trailing '\0'

 include/qemu/osdep.h      | 10 ++++++++++
 accel/tcg/translate-all.c |  7 ++++++-
 hw/semihosting/console.c  |  4 +++-
 softmmu/vl.c              |  5 +++--
 util/oslib-posix.c        | 11 +++++++++++
 util/oslib-win32.c        |  6 ++++++
 .shippable.yml            |  2 +-
 7 files changed, 40 insertions(+), 5 deletions(-)

-- 
2.20.1


