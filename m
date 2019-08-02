Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5458C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 16:06:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F22D216C8
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 16:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ndJqCEwL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F22D216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hta4R-0008G3-IK
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 12:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60558)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hta3E-0006pz-O1
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:05:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hta3D-0001z8-DN
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:05:04 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45857)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hta3D-0001tW-3F
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:05:03 -0400
Received: by mail-wr1-x441.google.com with SMTP id f9so77693049wre.12
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 09:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5cnjel0lre1ErQQLATcSkv2kYJPV1Ov5boqMVCtfV8c=;
 b=ndJqCEwLApPANjAA5VO4iznVLG8zEtC9kq5Wev99VEIK/Owvwy20qhS42n2EvHSd9j
 KBV4wajrRFJPwbIZMke5CyUadqSGs5HNYNm4VimOnCBMz5W7KhSe68G2KFPkkTz/BPkk
 DByKaxLO70+lLtq1uLK06U4FLniitiu+7RBgyjMtlQneXHcVWBdHFxvD+uRhhKoIAxLJ
 eXYfj/POJLA9DECg14qshdb8y6K/0XowrKkeqMDsDrEznPYeMAoVzRCtTtJvps7e/c74
 IB/QiKSecaSdxBlpi65rYOZEK09ozxx9FITjr43yrZD8h7dFB5/IxzimGsohl2y5vHQr
 8pOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5cnjel0lre1ErQQLATcSkv2kYJPV1Ov5boqMVCtfV8c=;
 b=SoTUkp+7GUdRvIOPzpOxM3VFL0x/Rfz7ChHmfDPPprqVnBSzCnwCZzXK7vcSFzD9ry
 Ywg1hFyyAMFfN9wFWD/a98zXzpIw2mW0G6Ru3pWv1x13yvaDgRkyvyWQJUHIjheSkJfT
 lxZDhLB+oJSG+mj6/d6hxf/EAAmMNRBjOp43LUyEj4XYf+6Ya0byiEtOSPtMGUQKcL0N
 JHKDUHvABEPm9f/NPBW4pObKk+3zO/MNFXhuxa8/zTlZZPlB+ym0gs7nGbyUck0ufmEG
 xxbtvJmOzavkL2m/g21ylKYuRrpu5Ts1ZU4/7BiPL8jGr7PcBGIWVb8xhrMrVyhgi8ey
 GvfA==
X-Gm-Message-State: APjAAAWNVBMBSV172KekvAXOUxUIpydCwpddKap7ULW8qg0lcZRvTOie
 K+0zCz88KELjDQUFMaE1W0bJ977sL//VAA==
X-Google-Smtp-Source: APXvYqzay+KzDqDiUfkmO/ZwjAPK9dCqeFOyzQl8vDsfkUGMnv+PhfTcHaK5yAQnF3ePF15c0REKUQ==
X-Received: by 2002:a5d:470e:: with SMTP id
 y14mr122654460wrq.308.1564761901216; 
 Fri, 02 Aug 2019 09:05:01 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o7sm66200171wmf.43.2019.08.02.09.04.59
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 02 Aug 2019 09:05:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  2 Aug 2019 17:04:55 +0100
Message-Id: <20190802160458.25681-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH 0/3] target/mips: Convert to
 do_transaction_failed hook
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patchset converts the MIPS target away from the
old broken do_unassigned_access hook to the new (added in
2017...) do_transaction_failed hook.

The motivation here is:
 * do_unassigned_access is broken because:
    + it will be called for any kind of access to physical addresses
      where there is no assigned device, whether that access is by the
      CPU or by something else (like a DMA controller!), so it can
      result in spurious guest CPU exceptions.
    + It will also get called even when using KVM, when there's nothing
      useful it can do.
    + It isn't passed in the return-address within the TCG generated
      code, so it isn't able to correctly restore the CPU state
      before generating the exception, and so the exception will
      often be generated with the wrong faulting guest PC value
 * there are now only a few targets still using the old hook,
   so if we can convert them we can delete all the old code
   and complete this API transation. (Patches for SPARC are on
   the list; the other user is RISCV, which accidentally
   implemented the old hook rather than the new one recently.)

The general approach to the conversion is to check the target for
load/store-by-physical-address operations which were previously
implicitly causing exceptions, to see if they now need to explicitly
check for and handle memory access failures. (The 'git grep' regexes
in docs/devel/loads-stores.rst are useful here: the API families to
look for are ld*_phys/st*_phys, address_space_ld/st*, and
cpu_physical_memory*.)

For MIPS, there are none of these (the usual place where targets do
this is hardware page table walks where the page table entries are
loaded by physical address, and MIPS doesn't seem to have those).

Code audit out of the way, the actual hook changeover is pretty
simple.

The complication here is the MIPS Jazz board, which has some rather
dubious code that intercepts the do_unassigned_access hook to suppress
generation of exceptions for invalid accesses due to data accesses,
while leaving exceptions for invalid instruction fetches in place. I'm
a bit dubious about whether the behaviour we have implemented here is
really what the hardware does -- it seems pretty odd to me to not
generate exceptions for d-side accesses but to generate them for
i-side accesses, and looking back through git and mailing list history
this code is here mainly as "put back the behaviour we had before a
previous commit broke it", and that older behaviour in turn I think is
more historical-accident than because anybody deliberately checked the
hardware behaviour and made QEMU work that way. However, I don't have
any real hardware to do comparative tests on, so this series retains
the same behaviour we had before on this board, by making it intercept
the new hook in the same way it did the old one. I've beefed up the
comment somewhat to indicate what we're doing, why, and why it might
not be right.

The patch series is structured in three parts:
 * make the Jazz board code support CPUs regardless of which
   of the two hooks they implement
 * switch the MIPS CPUs over to implementing the new hook
 * remove the no-longer-needed Jazz board code for the old
   hook
(This seemed cleaner to me than squashing the whole thing into
a single patch that touched core mips code and the jazz board
at the same time.)

I have tested this with:
 * the ARC Multiboot BIOS linked to from the bug
   https://bugs.launchpad.net/qemu/+bug/1245924 (and which
   was the test case for needing the hook intercept)
 * a Linux kernel for the 'mips' mips r4k machine
 * 'make check'
Obviously more extensive testing would be useful, but I
don't have any other test images. I also don't have
a KVM MIPS host, which would be worth testing to confirm
that it also still works.

If anybody happens by some chance to still have a working
real-hardware Magnum or PICA61 board, we could perhaps test
how it handles accesses to invalid memory, but I suspect that
nobody does any more :-)

thanks
-- PMM


Peter Maydell (3):
  hw/mips/mips_jazz: Override do_transaction_failed hook
  target/mips: Switch to do_transaction_failed() hook
  hw/mips/mips_jazz: Remove no-longer-necessary override of
    do_unassigned_access

 target/mips/internal.h  |  8 ++++---
 hw/mips/mips_jazz.c     | 47 +++++++++++++++++++++++++++++------------
 target/mips/cpu.c       |  2 +-
 target/mips/op_helper.c | 24 +++++++--------------
 4 files changed, 47 insertions(+), 34 deletions(-)

-- 
2.20.1


