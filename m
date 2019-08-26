Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5B4C3A5A1
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 00:30:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CCAB22D37
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 00:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WxvZnuHC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CCAB22D37
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i22to-0003P2-0w
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 20:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48752)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i22sk-0002Tp-Jj
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 20:29:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i22sj-0001zG-MD
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 20:29:14 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40920)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i22sj-0001yD-En
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 20:29:13 -0400
Received: by mail-wr1-x442.google.com with SMTP id c3so13590495wrd.7
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2019 17:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iuzhz3YlSSEZ1qULLWDfG2jNmKUN6q/tYh9r34j0TbQ=;
 b=WxvZnuHCUzbw/TonCjLDGpepq2hQQtcY881oJ6YNVcx339C+BBatAhJPkuI2SNEqUP
 VIZ/0fg1Dsqq52UkBIithzl/SgzDWj6o1zXElUTJtmpfZWb3WMiXId8mqnkmp9kQVe3H
 ni/ZQ85ppm8jyO/eCVqWK3MGtOHCOHDjf6uIoD21drdq4jnNSme9lzQk/zevXdIPvwlR
 LhOPlwXb8sV2juVR3KhF1o0AhEI/9tHhjYVX+RQnlibnj7sh7wmQKaPhByl15Qm7dJmg
 D9iG8sJ2GYztP2pLhamSlPSpB/y6KtsYsQj4efpojM2roKDz/8MRm1AiSOUGtv662DUv
 duZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iuzhz3YlSSEZ1qULLWDfG2jNmKUN6q/tYh9r34j0TbQ=;
 b=nhHFnTjAtfAI/DBx2bMRyTYImkFDHKd1JXmpa6jZXPd3MWOp9e77C+A1MpIG2+J9Jv
 Qcfk6fGfYbpYAM7CUMKiToLNEnTlCAwSOCnw3vTwjdYVhwiEOistM1VT8OaglUBqj7PE
 vY3bnx48cLleyiS18TFtRVMuE3JsC8JkANYwiJM9KSMb9oME7+nVtHytITyeQQc8MalG
 M3cB1zflwam77PBpozkuEIGUsUPyEBrtmBBJ3/Mg+dFfairKI7L3kwnyxXoGXO7NjWju
 rnFajaoWwOfV0zWmH8a4PCmx4a/+lF+2Z2lqkvczUGh9QOrTJGARiKhs8ukq7KK6G8AE
 sxiw==
X-Gm-Message-State: APjAAAWJHYG2CycpdR68AnVeNyrSZpHN0xhpQYJETGiCukn/nQyMb9Y5
 8nW96Mxp+zp+72FS8bsg93t0iBtyx4o=
X-Google-Smtp-Source: APXvYqzmkktGO41ZW7zXnvcfzeMcEe9Z/ihJ7YyioIuiEAEQw7Du3j06KaJPP37NYlWzqdP5vzf/Fw==
X-Received: by 2002:adf:e5c4:: with SMTP id a4mr19625267wrn.87.1566779351495; 
 Sun, 25 Aug 2019 17:29:11 -0700 (PDT)
Received: from decltype.home.dirty-ice.org
 (2a01-036c-0113-61b1-0001-0000-0000-00d3.pool6.digikabel.hu.
 [2a01:36c:113:61b1:1::d3])
 by smtp.gmail.com with ESMTPSA id c19sm8662339wml.13.2019.08.25.17.29.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 25 Aug 2019 17:29:10 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 26 Aug 2019 02:29:06 +0200
Message-Id: <cover.1566779143.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH 0/3] Audio: misc fixes for "Audio 20190821
 patches"
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
Cc: Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This series fixes two problems reported by Maxim Levitsky in relation of
my multiple audio backend patch series, and a small feature request.

Unfortunately I don't really use PulseAudio nowadays, so I haven't
tested it other than making sure it compiles and connects to pa.

Regards,
Zoltan

Kővágó, Zoltán (3):
  audio: omitting audiodev= parameter is only deprecated
  audio: paaudio: fix client name
  audio: paaudio: ability to specify stream name

 qemu-deprecated.texi | 7 +++++++
 qapi/audio.json      | 6 ++++++
 audio/audio.c        | 8 ++++----
 audio/paaudio.c      | 6 +++---
 4 files changed, 20 insertions(+), 7 deletions(-)

-- 
2.22.0


