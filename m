Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40829ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:48:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BEE32067B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cWwwrQAb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BEE32067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL69A-0003PX-KK
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 09:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34743)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iL5iO-0004dq-Gq
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:21:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iL5iN-0000Gp-0K
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:21:16 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38451)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iL5iM-0000Fw-Oe
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:21:14 -0400
Received: by mail-wr1-x444.google.com with SMTP id o15so1906250wru.5
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7dP4GniHlhzsckLWI2mSbUrs50mZwdrxTXLkHD7zpW8=;
 b=cWwwrQAbSGJRbFAi1XE5wSxRIleMKQsEjgW1Ls4j4xJ3acVdrkGK/zbMOmErBK/0IX
 KcH8zmwjN9MvMDF3czgM7QKSe5hxLtjbF60ZMNNKsC66v53EhW0sADHvr/N2yXyMJN8e
 G0e7A5F9y4KnCSDR++HjmENKJt8uuyrZR4gr85gPwyPEeqWsCpkbMyqwHsBAL3mntY4r
 R7U/X9tQ34yQ42ISSbaqW7BG7VZV7BmE6c3eDwPYFlYHMp+BSuelg0vSfS6gwIMYzZPW
 SDa/8qd6o9+4wYkKjlMtMSZWCAMy3qgQ1nkC2AYhQI75hTlvNOFglnGvweZy58Cs0Y4Y
 Ec0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7dP4GniHlhzsckLWI2mSbUrs50mZwdrxTXLkHD7zpW8=;
 b=GpB+pnJl1bB7Z90FQiMgcaZ3IkJM78TQeWsVE2FpspGmdl2x8+1OmAlLLcr9C1Noxo
 J7v5GhWzTtu1FuzWoh1ayINFmeqZ7/9ku+pYdkj6c/tFTEpgvyexFxGucYW1+Ntp9OC6
 k9ghLT0A4mvwhoXb9r3swzlzkUi57fwplsf45WzLk/bJ/pD/oqKH4pYlzntc7daTrV2I
 sBFd3DjgCZxLmfewuYi35ChBSaqP/jmAOHWwm+Wc4V49y8ALJA62MSnRZIMB01sXKnpD
 FCwYH7UJMsh4hu4AnNPsSozK6jsERaZ2u+uaBJGcvjc2Fdjq77qM4DNEQv0SldUEZk3+
 vwVw==
X-Gm-Message-State: APjAAAWjugCqX+YwaTVVTeMWL075781leCMCBc+gYKIDMQ2xwJT/m/88
 cS27Z8SSd0vnikhIahHPU9cb2e2jYlOHpg==
X-Google-Smtp-Source: APXvYqxGruiPS1r/ehoRHTeJNfcz+h3Hn0XQS3lgo1cRJ+rtqfAhIdZhXIlYrLmKHz5gBJmizX6arA==
X-Received: by 2002:a5d:69c8:: with SMTP id s8mr3002600wrw.167.1571318473015; 
 Thu, 17 Oct 2019 06:21:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id u25sm2183814wml.4.2019.10.17.06.21.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:21:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] Convert ppc and microblaze devices to new ptimer API
Date: Thu, 17 Oct 2019 14:21:10 +0100
Message-Id: <20191017132110.4343-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Jason Wang <jasowang@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patchset converts the devices used by ppc and microblaze
machines to the new ptimer API. (xilinx_timer is used by both,
hence putting both archs in the same patchset).

Currently the ptimer design uses a QEMU bottom-half as its mechanism
for calling back into the device model using the ptimer when the
timer has expired.  Unfortunately this design is fatally flawed,
because it means that there is a lag between the ptimer updating its
own state and the device callback function updating device state, and
guest accesses to device registers between the two can return
inconsistent device state. This was reported as a bug in a specific
timer device but it's a problem with the generic ptimer code:
https://bugs.launchpad.net/qemu/+bug/1777777

The updates to the individual ptimer devices are straightforward:
we need to add begin/commit calls around the various places that
modify the ptimer state, and use the new ptimer_init() function
to create the timer.

Testing has been 'make check' only, which obviously doesn't
exercise the devices very much, so more specific testing would
be appreciated. I'm happy for these patches to go in via the
ppc tree if you want, or I can collect them up with the other
ptimer-related changes I'm sending for other archs.

thanks
--PMM

Peter Maydell (3):
  hw/net/fsl_etsec/etsec.c: Switch to transaction-based ptimer API
  hw/timer/xilinx_timer.c: Switch to transaction-based ptimer API
  hw/dma/xilinx_axidma.c: Switch to transaction-based ptimer API

 hw/net/fsl_etsec/etsec.h |  1 -
 hw/dma/xilinx_axidma.c   |  9 +++++----
 hw/net/fsl_etsec/etsec.c |  9 +++++----
 hw/timer/xilinx_timer.c  | 13 ++++++++-----
 4 files changed, 18 insertions(+), 14 deletions(-)

-- 
2.20.1


