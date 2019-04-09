Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DDAC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:36:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF7352084F
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7cEk/yY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF7352084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46140 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDtjt-0006U7-8T
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 12:36:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hDtic-0005kL-Lj
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:35:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hDtib-0003cV-OA
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:35:30 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:37486)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hDtib-0003XB-DR
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:35:29 -0400
Received: by mail-wm1-x333.google.com with SMTP id v14so4088255wmf.2
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 09:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=0JtibV0dwo7Z7MQLq0lSRy0Pvf+3oj7T/AI7AlsTmbE=;
	b=X7cEk/yYpohDdeFf9DLrptj1VDJfy618EWkolNfWmqScyYTCd/SlHMbjUeBvStG2hm
	+UBaQphNztpuvJDXCIafGBcANMv1mvmlfpMiRBNGnNDQbjyv5Jzo01tBLxSj/Fni6vIk
	rHXJu1e8w8PpKwUVGOXNJKdM8b8gNUQducwT+Jxg9OUTJwJEBsp28qtQzgI32TqL60NN
	1KjyYiqhedmCJUurYScFRtc+FSna/zK5Lpc6+9ZOTRai7gCRVip7KlfwuNv6Be9N5SqQ
	j66XFC2VYTZukJ6QayZ3q5AcHWt+YBEqKLvBM/p56TueuyUIIsoUbN+ZfUUMWxhYqnD0
	iDNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:subject:date:message-id
	:mime-version:content-transfer-encoding;
	bh=0JtibV0dwo7Z7MQLq0lSRy0Pvf+3oj7T/AI7AlsTmbE=;
	b=cASEedwjhShjfitJ7MSqHgB5N6Q9b8ygB1Mp3vHgPleNEOYFtG1019yilxxX8Rhbzp
	RvQDC2HVYOsCuKPJBLT7W/mGbHleVJ/SvUulXQnvgFH6fNVjbrj1+GQyZe4iwTfdJp0o
	+WiNhNVa+j2/jh9gOqqGVzKhA0txJtTOQdsty1l9Hb3Nt2TGqJ6q086N+HVEpKgZzcyC
	RqdqlYL8UCKx7lR7vqgrRR+lDHW93mZwlIfF+DHlSPfz0lNtB5C9xxT9RD0bpVLpZvyH
	gcen9zi4am6I1ZJTZVoqgw7SHM/JXbwadQZpJB4vsfcjEs+uHZ9AQw+/n9Gmhfg0XZMf
	uXDA==
X-Gm-Message-State: APjAAAWzb7K++OOrYlkoEb8D56YytWFsynoKXYdkPDb+eq0OzrVVgUwS
	jvw4eYDAiOIXzlnqitlmjXZWqpVv
X-Google-Smtp-Source: APXvYqxGTblp0CIiDewR7fwRhE+8WZp9kDrELmI+3mD41kwxarw2eMOvg8kLZM3sAyuLguWKZgd16A==
X-Received: by 2002:a1c:7e55:: with SMTP id z82mr6942694wmc.11.1554827721553; 
	Tue, 09 Apr 2019 09:35:21 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	l23sm13312650wmj.10.2019.04.09.09.35.20 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 09 Apr 2019 09:35:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  9 Apr 2019 18:35:19 +0200
Message-Id: <1554827719-10184-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::333
Subject: [Qemu-devel] [PULL v3 0/5] Misc patches for QEMU 5.0-rc3
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
Message-ID: <20190409163519.KzYl-Oa8Ykdz133HaFTOjJ73u3EysQ4A9X0fI2gNhQg@z>

The following changes since commit 248987f92cfda8305d6d44ced23e173e62a8bc0e:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-4.0-pull-request' into staging (2019-04-09 10:02:30 +0100)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 3e20c81ed87cb15cd04f929b075e244e0758641a:

  tests: Make check-block a phony target (2019-04-09 18:34:21 +0200)

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

