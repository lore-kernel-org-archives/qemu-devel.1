Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975CDC282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 15:59:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F3F52084C
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 15:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nxhMwtcF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F3F52084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45153 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDtA5-0002rY-LB
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 11:59:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hDt5u-00085U-FP
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:55:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hDt5t-0004hR-91
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:55:30 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:33360)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hDt5s-0004Yq-Qp
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:55:29 -0400
Received: by mail-wr1-x42b.google.com with SMTP id q1so21626925wrp.0
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 08:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=H8zh0PNJuRqLuMTREAO4z9J6IEYmslr+Js9BgJuSIzc=;
	b=nxhMwtcFQu1MR+wnhcylv23oub5zKQuw4xOheV+1XPMPKHYVqw24sItNsIMsnCimKQ
	KlYfu6SoyUqEwXJJ0glk2MyI1l1dWPiqRpugV5L3dGcqwQHkYlJufaAdN8G+wVlVITM5
	l5WnF1UG5pVuyEoq5pY8fTTKtq2Ze4YgDzYxRNyNz/AFFF2JfdEbuNHsO1xzq8jXIRGT
	hP9+YgZTqlPSVnKemHA0wR7Vo00qhNqOeBjQQxziB8P3/5UdMWO+Oz+BZstzM+I4GzNN
	+1u8teNWZr8HNV2VDZ1tDZPjfNDf2LgMR7sTh3FZe27r4ZoD9e+P22PxJpsXjMowykuQ
	Xuvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:subject:date:message-id
	:mime-version:content-transfer-encoding;
	bh=H8zh0PNJuRqLuMTREAO4z9J6IEYmslr+Js9BgJuSIzc=;
	b=QV/vJfXtUqw1QrPBFoEw2L5Rc0j3/quRrE8Q2K22am43sm7blKhMifU5338TadKCO5
	MfbUCqQFKJUQGnEGCKsp8lka5ssGOPg4iJWq41CvQ3bktGPUBogCl6l6kJuj3ph4PpPA
	4UH7bOWUaKIqbyKFfF+AtJOdFhlS/2UN8HXBAk2X94TudffWHXQUj+1Gta7GkrtYFXfE
	X6m9xIAnO9wvYnia3oNfrNDJSMAX2il08DNiw5UMJrii8t0rjVXrGPHtrtvTNJu1pjv2
	RAc4TadxSXSxIqcpLcCM7DFmZ/AqwHtvjVewjZjZNLiPANi9mGV93SMwf7vez7ZuGJjb
	MD9g==
X-Gm-Message-State: APjAAAWgrVr9XTaT2TkticR9kas8NtjW+OvrvH10XmBv82y6Xoqzoxre
	ivrHzPu6rvpn47Ts2H9mhrV83Lkx
X-Google-Smtp-Source: APXvYqxvt8igncMGYNL4Indudx5reB5mVFuEhVeNwZj5AFCPM53Ka2isIgMDCLwp1qKZPtUi3bdBzQ==
X-Received: by 2002:a5d:6947:: with SMTP id r7mr3555244wrw.167.1554825318019; 
	Tue, 09 Apr 2019 08:55:18 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	g84sm23117586wmf.25.2019.04.09.08.55.17 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 09 Apr 2019 08:55:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  9 Apr 2019 17:55:11 +0200
Message-Id: <1554825316-33288-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::42b
Subject: [Qemu-devel] [PULL 0/5] Misc patches for QEMU 4.0-rc3
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
Message-ID: <20190409155511.4WAaLLNb8bK_G19N5nYunLhO-RZ9FihDxRraoRjZLVY@z>

The following changes since commit 248987f92cfda8305d6d44ced23e173e62a8bc0e:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-4.0-pull-request' into staging (2019-04-09 10:02:30 +0100)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 3428e01ab818ea3c38cc8505a7be57f4d4f10543:

  tests: Make check-block a phony target (2019-04-09 17:33:38 +0200)

----------------------------------------------------------------
* fixes for Alpine and SuSE
* fix crash when hot-plugging nvdimm on older machine types

----------------------------------------------------------------
Markus Armbruster (1):
      tests: Make check-block a phony target

Peter Maydell (1):
      include/qemu/bswap.h: Use __builtin_memcpy() in accessor functions

Philippe Mathieu-Daudé (2):
      roms: Rename the EFIROM variable to avoid clashing with iPXE
      roms: Allow passing configure options to the EDK2 build tools

Thomas Huth (1):
      hw/i386/pc: Fix crash when hot-plugging nvdimm on older machine types

 hw/i386/pc.c           |  9 +++++++--
 include/qemu/bswap.h   | 26 ++++++++++++++++----------
 roms/Makefile          | 23 ++++++++++++++++++-----
 tests/Makefile.include |  2 +-
 4 files changed, 42 insertions(+), 18 deletions(-)
-- 
1.8.3.1


