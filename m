Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9257C3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 20:01:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F471206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 20:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rl320j63"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F471206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2LBR-0006bP-4b
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 16:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47111)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i2L8u-0004oy-1R
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 15:59:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i2L8t-0000iW-50
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 15:59:07 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:43373)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i2L8t-0000iJ-05
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 15:59:07 -0400
Received: by mail-qt1-x841.google.com with SMTP id b11so19120191qtp.10
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 12:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OYqRte1JS5Bhp59A4OiGPveBRZs2QVDnMFW1w5xdkWI=;
 b=rl320j63C8hkgKnDY+kXuPUebIEsVFBaTfhhQzo5w6M0BXlwl0La653nYDg57dNu0a
 ToQoE72o8d8NqOeb4AReU6PyP+BUTIbBMRxn0N6fpY1RWz1V6OoV8+xg7XnmYOcGo5sR
 FmsXFtRCFR3kJqL/NrTQAzA49U8j2NpSB8cOGzy26gObNilkWP194ULF+Cr0mAEdBUU8
 H1uZ2Hu/Zj+LbVG6hNY/LhKpSGRvYFN9lK/Yc9GRrVJlR5lhMUQ96bhR7lZo3yg0BxsQ
 TfTt3J8CvuaWyGu25hi52iIxnG1WE5BRe2S3hghYWJMm3KPmsrXzBRgyyt1Wn0I6mMq7
 xNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OYqRte1JS5Bhp59A4OiGPveBRZs2QVDnMFW1w5xdkWI=;
 b=tOshFUHqi7MAZFnXbHamysgaDas6DnO9sFe98uBM6NTDCtg4UKeTdLR+zeFgW03c2N
 PWDjQrKXojCYgTrTIJfvORHzDv59RA+GFug4+5A7soD5jZW5Dz1aryGzangQ7JL01HRg
 qtu2IVhwHsSYbvmDXfWbqlJCGibiwFjhYe/zM7eat1Q1kKuEUcJUhbxMvQrtsJZ/wpdj
 dM+SZJESloRL+FZQC31vVGH9i0RTZbB1px4SjY96u1TX0zpCZAcZwLT4FyHFdNeF8A8A
 q+/kETlec7H7qoiKrDCEarIf2hfU8C3I6ZKpzgA/eH1nvyazBSiWREnjsnp1ztcJ8YBJ
 lZDQ==
X-Gm-Message-State: APjAAAWHLTGseMPJ5vO2uA/WPP3l9LRWzCJj6qLt89d0eONKm7UhzuqM
 VTAO5KQY/fyOBYctNZYOWGeV0qZKljg=
X-Google-Smtp-Source: APXvYqy30XDTZf8Su4tQUJEKD3Szw+VtKyyVv6QeFlL8UkqNVlvIgbjNcnyUEySV3JBcilOOqXewwg==
X-Received: by 2002:ac8:358e:: with SMTP id k14mr18347569qtb.83.1566849546436; 
 Mon, 26 Aug 2019 12:59:06 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-61b1-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:61b1::5])
 by smtp.gmail.com with ESMTPSA id v7sm6795459qte.86.2019.08.26.12.59.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 26 Aug 2019 12:59:06 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 26 Aug 2019 21:59:00 +0200
Message-Id: <cover.1566847960.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
Subject: [Qemu-devel] [PATCH v2 0/4] Audio: misc fixes for "Audio 20190821
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

This is the second iteration of my "random fixes" patchset.  Compared to
v1, this has a new patch, fixing the memory error caused by an invalid
malloc.

Regards,
Zoltan

Kővágó, Zoltán (4):
  audio: fix invalid malloc size in audio_create_pdos
  audio: omitting audiodev= parameter is only deprecated
  audio: paaudio: fix client name
  audio: paaudio: ability to specify stream name

 qemu-deprecated.texi |  7 +++++++
 qapi/audio.json      |  6 ++++++
 audio/audio.c        | 10 +++++-----
 audio/paaudio.c      |  6 +++---
 4 files changed, 21 insertions(+), 8 deletions(-)

-- 
2.22.0


