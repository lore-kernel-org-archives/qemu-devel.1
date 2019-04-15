Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9CCC10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 22:21:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 409FA20854
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 22:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnxXoNkw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 409FA20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56145 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG9z5-0004Mo-Mx
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 18:21:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hG9yG-0003zO-Rr
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 18:21:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hG9yE-0002fM-Vd
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 18:21:00 -0400
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e]:41430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1hG9yC-0002dW-Uy
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 18:20:57 -0400
Received: by mail-yb1-xb2e.google.com with SMTP id a13so4081255ybl.8
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 15:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to;
	bh=RH7FA3FDuNnRl3iJFAPnBSCDZNM+FpKQG4gKIc48LHY=;
	b=hnxXoNkwvakue/XHPfEIHMw5eJQ2zy/UfL8b0+JLVB0H7lg0ZekW2t/ZmWrNh8XvAS
	mjIxTYn7BcjMeoDvtQYyaTrSW+2bCMlJ/8MXPKZTMOusZ1aBzqTCDVjnEq9BF9JLJny5
	d3yLJ11asI/TVuAQDA/NtA9fsUhPb+UuRe56fztQOl8G9CkHDnQWqAqI1U+4Z9mowfqP
	pxUgAgpOhwCJqPczyS5LE7cpixmhha7KTo0HEqWHutiFVjRu3pkrhZeXPWQpstEb8r8W
	FB6tNz3ClIgiSyb9mf4YlaCgs5aQLVCZiNA/3EGNRo/NuBCfTwHgRNJfIGMe3NWCacJT
	ZmVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=RH7FA3FDuNnRl3iJFAPnBSCDZNM+FpKQG4gKIc48LHY=;
	b=rfZXDvfjACRbwBqhq+tYAp0jDMDRhSAN0K5WzqkY3SqmiAyVEQqSLYijAo43sD2SQA
	Z21Puks1SSKkjl2aDR+pvY018PRcmxHZFm67YUERAq6VQfvHg+YmMJc4EdSiP8UTmjce
	VMvHkLNLxpux7lTjB5d0YvYsMIkbQdDY/QDqOcIzELIVTT4nUV1sSs6TGXIbd040Nqua
	Hx1SSD5dKDlUvUXB0j6u6m515nGjMor7Wx7tYT2xOpjatERMmihdUbHek0W1uhIU6yxC
	LnBmA7LWQsCy3GxOjidzl5BuKAeUlH8yVvCcjGzjz6f3nZCrIXw92lXmN7k/ESHeHfVD
	vGow==
X-Gm-Message-State: APjAAAVHALkWF32uTc8cIrppKTNStIEaFtDNKTBm7s8Tefo11pPUKwMt
	gCSZLalBRAbbFNTS6uYMNNopUL/a+vKjIjNco7MunuT6
X-Google-Smtp-Source: APXvYqycaFd++Uw7Z0Xo8mmtfK/2EGOsmjikM3LluXVEZVCCpf1+3aux8woFFUwoqR3AU4ViSvB2CDaxiyb5ned8SqY=
X-Received: by 2002:a25:2417:: with SMTP id k23mr18096824ybk.430.1555366853551;
	Mon, 15 Apr 2019 15:20:53 -0700 (PDT)
MIME-Version: 1.0
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 15 Apr 2019 15:20:42 -0700
Message-ID:
 <CAMo8BfLCON2wbQ36dkVQ92tcVPWoPdje12CqySFnJyoYDDOdDg@mail.gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Stefan Weil <sw@weilnetz.de>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b2e
Subject: [Qemu-devel] recent QEMU-w64 does not load multiboot kernels by
 default
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415222042.0ppZzh5ktusMLzxvZUr_7B3OxOUWeNImZ_vStajDOzc@z>

Hello,

recent qemu-system-i386 for w64 (e.g. one installed from
https://qemu.weilnetz.de/w64/qemu-w64-setup-20190218.exe )
refuses to load multiboot kernel by default:

  "C:\Program Files\qemu\qemu-system-i386.exe" -kernel p:\tmp\kernel
  C:\Program Files\qemu\qemu-system-i386.exe: Error loading
uncompressed kernel without PVH ELF Note

Adding -M pc-i440fx-3.1 (as well as most other machines, but not
pc-i440fx-4.0) fixes that. On linux host the same kernel gets loaded
either way (with or without -M).

-- 
Thanks.
-- Max

