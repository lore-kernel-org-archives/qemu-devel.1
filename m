Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BC2C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 17:15:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF9D020651
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 17:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QahufIIK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF9D020651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44915 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMbmO-00089p-8i
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 13:15:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMbku-0006aS-Qp
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:13:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMbkt-00012d-Hz
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:13:52 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39974)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMbkt-000111-A3
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:13:51 -0400
Received: by mail-wr1-x444.google.com with SMTP id h4so8761979wre.7
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 10:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=gxn73yHrkMnhu3Hh5HOdigs39onYkcXmr918feAXYD0=;
	b=QahufIIKjmZm06ldWfS9a9TJaafGGew9iKqqUBgijAzO7WZTUvnIJJxmDct5205stW
	uKQ+4dwvgEz1dSWmI7nEabVqMpY5YiJOtw+WV8aQhmLWQDj2inGgLQEhPS58709MPlFm
	/9x9L4lk9PFArFdng/aH+q/NNvdj8c3J/ytGqaEib2Puu7IdLgzsZ8O0eBe7D/xoyIjE
	ELaMSFkIt7nEG+jkPSmHxpx7HN0CXI66Db0gtCPdD//MN5cvIIFWcmnrOPwesNAp5pKk
	QgThaS1tX0zWAMHcSFHPPzpdkF6HVYhSBvouVdF5lbAX6SD4EdnnOq/couwG3D9eaJM+
	8sfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=gxn73yHrkMnhu3Hh5HOdigs39onYkcXmr918feAXYD0=;
	b=AxM29NGOoAEHH3aHTRs4lYqUoCnNKh754d5uFbwEFT78Orlkv9clx4n2jc/5O5x5OB
	YSPkyd7GnX8qtJRj8L8icdv6lgEeCt5fNnwDNgMSt5N4BCv7EBQZWw6yXgtHyNdwPycI
	8jznRvJ4tB+BfG1mB6un0CPojxnOlFMBdIg8IkZmhLCyNgrtUFe+dSR3DiMSo2QtKHg+
	3juWSHq9ZNbPU4W5Ss9fc1Lk6clerMSNfnbpOvqjG5uYT3HfKSrEzKLx7fnZ1T7DUj+h
	Kw9yhntC62UqWYcYulaDZkmD5zhKjkb0W7jXpfQ511fd5ukJ9mzBynmD3+67cnqhEQ8u
	0llg==
X-Gm-Message-State: APjAAAUioZ8YUd5ITUBstftHNDPIkcOjHyvFmKIg9REzigv69DdLAmzJ
	vpr7wAUwGVbEv4CXUyuWNb1TPg==
X-Google-Smtp-Source: APXvYqxDJ1HipS6p4HnQeE4DQUBaBLOLGRtZ1r52XS4t9NuFEmX22xi4QX5Oxcp4yU4+b3E9PYcrOA==
X-Received: by 2002:a5d:464f:: with SMTP id j15mr7875159wrs.265.1556903629942; 
	Fri, 03 May 2019 10:13:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id e5sm1717671wrh.79.2019.05.03.10.13.48
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 May 2019 10:13:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Fri,  3 May 2019 18:13:45 +0100
Message-Id: <20190503171347.13747-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH 0/2] hw/arm/boot: handle large Images more
 gracefully
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
Cc: Mark Rutland <mark.rutland@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190503171345.bWvIZ5tG9uAs446OG1iUQAADJfe_ITY8KCSFBws0hO4@z>

This patchset attempts to fix https://bugs.launchpad.net/qemu/+bug/1823998
which reports that we don't handle kernels larger than 128MB
correctly, because we allow the initrd to be placed over the
tail end of the kernel. AArch64 kernel Image files (since v3.17)
report the total size they require (including any BSS area that
isn't in the Image itself), so we can use that to be sure we
place the initrd sufficiently far into the RAM.

Patch 1 in this series adjusts our "where do we put the initrd"
heuristic so that it always places it at least after whatever
our best guess at the kernel size is. (This might still not
be right for images like self-decompressing 32-bit kernels, where
there's no way to know how big the kernel will be after
decompression.) Patch 2 makes load_aarch64_image() return the
kernel size as indicated in the Image file header, so that for
the specific case of AArch64 Image files we will definitely not
put the initrd on top of them.

I've given this a quick smoke test but I don't have a very large
Image kernel to hand, so testing appreciated.

thanks
-- PMM

Peter Maydell (2):
  hw/arm/boot: Avoid placing the initrd on top of the kernel
  hw/arm/boot: Honour image size field in AArch64 Image format kernels

 hw/arm/boot.c | 51 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 16 deletions(-)

-- 
2.20.1


