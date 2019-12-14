Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCBEC43603
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 02:53:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FBC52073D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 02:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FBC52073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifxYK-0002DI-D9
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 21:53:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45612)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fthain@telegraphics.com.au>) id 1ifxXm-0001ny-BS
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 21:52:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>) id 1ifxXl-0002Kz-0x
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 21:52:34 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:48090)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>)
 id 1ifxXk-0002Gp-RZ; Fri, 13 Dec 2019 21:52:32 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by kvm5.telegraphics.com.au (Postfix) with ESMTP id 171E722C0A;
 Fri, 13 Dec 2019 21:52:29 -0500 (EST)
Date: Sat, 14 Dec 2019 13:52:33 +1100 (AEDT)
From: Finn Thain <fthain@telegraphics.com.au>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 00/10] Fixes for DP8393X SONIC device emulation
In-Reply-To: <157628778601.20418.17236421597625110152@37313f22b938>
Message-ID: <alpine.LNX.2.21.1.1912141345460.18@nippy.intranet>
References: <157628778601.20418.17236421597625110152@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 98.124.60.144
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
Cc: jasowang@redhat.com, qemu-stable@nongnu.org, hpoussin@reactos.org,
 aleksandar.rikalo@rt-rk.com, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 13 Dec 2019, no-reply@patchew.org wrote:

> === OUTPUT BEGIN ===
> 1/10 Checking commit 9c9ffc38e9b9 (dp8393x: Mask EOL bit from descriptor addresses)
> ERROR: return is not a function, parentheses are not required
> #24: FILE: hw/net/dp8393x.c:200:
> +    return (s->regs[SONIC_URDA] << 16) | (s->regs[SONIC_CRDA] & 0xfffe);
> 
> ERROR: return is not a function, parentheses are not required
> #33: FILE: hw/net/dp8393x.c:220:
> +    return (s->regs[SONIC_UTDA] << 16) | (s->regs[SONIC_TTDA] & 0xfffe);
> 

I expect that checkpatch.pl has no idea about operator precedence, but 
these parentheses could actually be omitted.

I kept them because I don't want readers to have to remember that bit 
shift operator has higher precedence than bitwise OR operator, or look it 
up if they don't.

The existing code also has those unnecessary parentheses.

Please let me know if this patch should include a code style change.

