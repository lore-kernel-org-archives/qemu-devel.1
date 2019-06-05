Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5011FC282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 08:34:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FF9B2075B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 08:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wv5ls8rl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FF9B2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37459 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYRNb-0005ff-0d
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 04:34:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <james.dutton@gmail.com>) id 1hYRMp-0005MY-ND
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 04:33:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <james.dutton@gmail.com>) id 1hYRMo-00020E-Ai
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 04:33:55 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:38799)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <james.dutton@gmail.com>)
	id 1hYRMl-0001cJ-RA
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 04:33:53 -0400
Received: by mail-oi1-x243.google.com with SMTP id v186so3329290oie.5
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 01:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to;
	bh=SpyvTlbeSte07swkuSAASIUFzwEk9X8t7gDfA+dDPc4=;
	b=Wv5ls8rlc5G6m0ESpZ7j818DfQyuxX/EkBTJYFst/kRYsk2+rT0fZx2WtyVXxihqV5
	ummh9Ir2f+rd1BASxIVbwQ/IY9Jere4LRLDET3gWOzkZkirTYOXyI4GHD0nCq6Z0v/n+
	gwrSiB0fYY0izEoBulvxXFsJVg3PjeMitOZuzRHHulR8PvIcKrM0kVwW+Svjfdr3CcV8
	1BHuawGEvOoUtIEi2vB0xkOwnppVDsW8rdvra2rcM61s1XsCZFpeH+tPKP3KQS+mhaFk
	OYFIjkIrNLQRk048h/0CI5gQY6pPzQ+kCgoLXjNEfNeI9L2/Y1XJwRO8Cl9XSJ5/uRvI
	0cjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=SpyvTlbeSte07swkuSAASIUFzwEk9X8t7gDfA+dDPc4=;
	b=SNhXzxNgxUbPPFkPyRBwF9RMfq00afxRWwmrxAzfx8ZZfc7jOIN+KQIMZZHTvK46y/
	Jl5JguwmbPcF822q2ualOg+4oBimrenxl/OZCz1IbYWYZmqTIX94UFRAiXZTo6ZTZSoq
	2pLKNKAnr1s8HC/FocbejWIgWzCmlq6HqJzVKVr2oBA8/QrEcIMhM4vEwdoSVX9GHOAf
	SdyOkq1SDyJUx05nSvCailev04/Ljv5oKk3m201e9gKLGTRlVYf55wp+rHunXzeOAtIk
	cQf5f7uRgT+kR3tIg34T0AY4PxFOk3v+tFmuSArWKF7E3/7CGJ91CTSQQRJB4JuRYFTc
	ss1w==
X-Gm-Message-State: APjAAAV5lceW5uM2yI1davtqBUbVdGxJpF1w+9D2603e+hK0vQjXJzMi
	lIEBA/HP4o26um8hO/hCwDTC1mbtuNuK8ckbUWkIw9Yjnuw=
X-Google-Smtp-Source: APXvYqyUscE+odRNQ0BjwEHr0NKr/cW3EHSmzsWbGXuD3lJhXW4torkH5+Dj1eJVS9Utr3BjWp5624sg6IH9bhK5WxE=
X-Received: by 2002:aca:4f0c:: with SMTP id d12mr3960529oib.35.1559723626368; 
	Wed, 05 Jun 2019 01:33:46 -0700 (PDT)
MIME-Version: 1.0
From: James Courtier-Dutton <james.dutton@gmail.com>
Date: Wed, 5 Jun 2019 09:33:10 +0100
Message-ID: <CAAMvbhGcKWRv8b5qEp+gopTFU1daUkVraJids=b3of0Q7zWqqA@mail.gmail.com>
To: qemu-devel@nongnu.org
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::243
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: [Qemu-devel] Problems with Pass through of a AMD Vega 56/64
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

Hi,

Problem:
Pass through of a AMD Vega 56 or 64 on a AMD Threadripper 1950X with X399
Motherboard , Host OS: Linux Kernel 5.1.5, did not work.

Various problems were observed:
1) PCI BAR resizing -  The GPU tries to resize the BAR from 256M to 8G. The
resize fails, but the Guest does not know this, and continues on as if it
was resized, resulting in a VM_L2_PROTECTION_FAULT_STATUS in the guest.
Symptoms of (1):
Able to passthru most PCI devices except the GPU.
Solution:
This problem has been worked-around with (See other email by Alex W):
[PATCH] vfio/pci: Hide Resizable BAR capability
The reason the GPU was problematic, is because it was the only device that
tried to resize the BAR.
Fortunately, the AMD GPU driver can work with a 256M or 8G BAR.
The real fix will be the implementation of support for PCI BAR Resizing in
QEMU and VFIO.

2) The QEMU fails to start with GPU passthrough, in that it does not reach
the Seabios messages and sits at 100% CPU.
I verified that the AMD GPU card's option ROM contained both Legacy BIOS
and EFI images in it.
Removing the GPU PCI device in virt-manager allows the VM to boot, but
adding the GPU PCI device causes it to fail to boot.
Symptoms:
VM won't start, left with blank screen.
Solution:
Using Q35 and OVMF EFI works.
Using 440 and Seabios does not work.
My guess is there is a bug in Seabios preventing it from working.

3) Use case:  Have 2 AMD Vega CPUs and wish only one to be passthru to
guest and the other to be used by the Host.
Problem: Currently you can passthru both, or neither.
Solution:
I have written a patch for VFIO to handle this, but it is still work in
progress before it will be accepted into kernel mainstream.

Kind Regards

James
