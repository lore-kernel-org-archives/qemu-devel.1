Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF486C76194
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 16:37:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B13F72238C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 16:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yfHqX8oS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B13F72238C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqgkO-0005tC-OQ
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 12:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48349)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hqgk0-0004bS-2R
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 12:37:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hqgjy-0007Do-TM
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 12:37:15 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:39494)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hqgjy-0007B1-Kc
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 12:37:14 -0400
Received: by mail-wr1-x431.google.com with SMTP id x4so51429623wrt.6
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 09:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Tk0LtwKy0jceHpEn+y+gUC7C51j/o1ZSEntT/WnGK5s=;
 b=yfHqX8oS3fCh0CteZGN3uv0+S8jG2ZyXaM1BRKf4oXT4RzSVrb7pkXogYlnCxIhOou
 QwvUfOSVxPNfLrWNg/thbRJ67xFh1vgGp4mppArPKdXXwLEBIOalqPCOrw2rPPxHcv0+
 1RaC7MPGxs5Yk6UfuD9lcjxpx/uaKGVo3XerqyUBg/n9RbJa777ISON3AHRYia0qh0o+
 oQRqoqVoOWuEnU0enxLg/ECxOGA7ywlnDtZzjNImXYc07C3EAS+zm3xrmdWrGGpq7xJj
 wnHJiNo/8M7uPWlq+u3x9Metet/0itFz8HdbD1PmaGXY0+KRpYVILnrYFhqxNDpQ1tyo
 VcHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Tk0LtwKy0jceHpEn+y+gUC7C51j/o1ZSEntT/WnGK5s=;
 b=RHizgAFtN5lVr7zy10x5NGcc4MhOjgP2nxsLfBIEV+d87hKwqqFq64A0OJsle1mHsB
 HwL1hNhroUteiDCbVF2URC4Ro6zGwaIfbq1DzZLQVjFL+4JyW+4bEmGuEpv7n6FrIdJI
 yI7phBnoZ2AwDHh0v1udKkO3Dv/ZRSRMh6Sfa83PGVpj5KmvA5dHYAG7MqXiBeAsGIHT
 hmZnT/6BDHNaMp6CeLvryforptbvK3hDf1pe/AhufuZ0KjCr58Ht66f3kd4073whgjw5
 jQPJZR52OZ4xv1zqi9eLgGFwBDhnVA7awsHTooPcTA7GEVZti/lczfXjWX4hXaZPdjh+
 tZaw==
X-Gm-Message-State: APjAAAXGD3eU5iYh3rOsJLq//1wpkbj73CpGiohQduOLSQuEvTYnLe3M
 pxp2hf3nPKo+Uts8wQIlsWqy0w==
X-Google-Smtp-Source: APXvYqzoyY4LOHXR3aaJVMlv7+EycDC5cPAxMfqBhhD472I/Cupf7cKihlhXbzr202KRdNwhP3ViHg==
X-Received: by 2002:adf:d4cc:: with SMTP id w12mr97971745wrk.121.1564072632809; 
 Thu, 25 Jul 2019 09:37:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c7sm44125140wro.70.2019.07.25.09.37.11
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 25 Jul 2019 09:37:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu, 25 Jul 2019 17:37:08 +0100
Message-Id: <20190725163710.11703-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
Subject: [Qemu-devel] [PATCH for-4.1? 0/2] Typecheck VMSTATE VARRAY macros
 and fix bug found
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Damien's patch to fix a pl330 vmstate mixup between
VMSTATE_STRUCT_VARRAY_UINT32 and VMSTATE_STRUCT_VARRAY_POINTER_UINT32
led me to think about whether we could catch that particular
mixup. It turns out that we can, by adding a type check that the
field given to the macro is really an array of the correct type.

This only found one other instance of the same bug, in the
stellaris_input device; patch 1 fixes that and then patch 2
is the improved type checking.

We should probably also go through and look at the other
VMSTATE macros that use a raw 'offsetof' rather than one
of the vmstate_offset_foo type-checking macros, and see if
we can add type checks there. (Documentation of the macros
would be nice too...)

I've marked this as for-4.1? because the stellaris bugfix
definitely seems worth including in the release but I'm less
certain about whether to put in the typecheck -- David/Juan can
decide that.

thanks
-- PMM

Based-on: <20190724143553.21557-1-damien.hedde@greensocs.com>
("pl330: fix vmstate description" -- otherwise the new typecheck
will cause a compile failure due to presence of the bug that
patch fixes)

Peter Maydell (2):
  stellaris_input: Fix vmstate description of buttons field
  vmstate.h: Type check VMSTATE_STRUCT_VARRAY macros

 include/migration/vmstate.h | 27 +++++++++++++++++++++------
 hw/input/stellaris_input.c  | 10 ++++++----
 2 files changed, 27 insertions(+), 10 deletions(-)

-- 
2.20.1


