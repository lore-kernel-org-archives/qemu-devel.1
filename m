Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CC2C3A5A3
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 01:43:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB003214DA
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 01:43:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB003214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2mzm-0006Yr-TC
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 21:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36616)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Sandra_Loosemore@mentor.com>) id 1i2mz7-0006AD-9D
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 21:42:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Sandra_Loosemore@mentor.com>) id 1i2mz4-0005zy-57
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 21:42:51 -0400
Received: from esa3.mentor.iphmx.com ([68.232.137.180]:43072)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Sandra_Loosemore@mentor.com>)
 id 1i2mz3-0005z3-Rg
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 21:42:50 -0400
IronPort-SDR: bif7Sfe0QrtnWsFx1bJKEhIvnvvjzutZvau/0OGNykYhHAbQChJ40a8x69GgeTTMnmS/9SQjIq
 2Znrsy4o6sUpWzcLWf4c8RMmidD6H9VdqbrQHXPMmR4u8RLUxeRKHeKscMm+N9R0chpeSeaP3S
 14X8nbb93wiSD+7CPgv2YFjo7rn8H6pA9OJsm/k0JsqVlVfjWLhqhbHKrNbOwIJPctxWB5LsIh
 ByMf7EF+rU8EbVlMe9n6ciIVJT/LobvX+RVYdiP669OlnDcmBjOwzoAcaZyztDr7xOmnDlxGN/
 ZYA=
X-IronPort-AV: E=Sophos;i="5.64,439,1559548800"; d="scan'208";a="40818456"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
 by esa3.mentor.iphmx.com with ESMTP; 27 Aug 2019 17:42:46 -0800
IronPort-SDR: cowbsD11yLjGQL88dAOaUKoneP5msA2CEYSCDLBEKXEi21aKH9O2X2ktxQNJPi/McbybE/pyiw
 86/YiFLyhatXRaTVQXm344AZAcE1qa95IkM9OoE9OEThjl/DRa85nClYKmSZQmoWZj5aAmMDXY
 Ike1DFQiWVVzia2LcDkPiykP8sA+z9Qnzmd0z/ssEuXoTEKRAF6hq547NU2XBKzc5PNRO5nP6i
 cTWilqvY227nr7AmUUJl3pfPPVlbtP7wXxdE+uS8f31iBcbtq482KDAd+dg8K/ximIpqUSvXmf
 /eI=
To: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers
 <qemu-devel@nongnu.org>
References: <81a8c0ca-c5fb-fc3d-cc7b-00c4da31d621@codesourcery.com>
 <6ee9f4b4-39ff-f36a-9430-3e7a5de7a2de@linaro.org>
From: Sandra Loosemore <sandra@codesourcery.com>
Message-ID: <49104914-988e-d446-6b38-3ff26b7da7fa@codesourcery.com>
Date: Tue, 27 Aug 2019 19:42:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6ee9f4b4-39ff-f36a-9430-3e7a5de7a2de@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SVR-ORW-MBX-09.mgc.mentorg.com (147.34.90.209) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.137.180
Subject: Re: [Qemu-devel] libvhost-user: undefined reference to
 MADV_NOHUGEPAGE
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/27/19 6:39 PM, Richard Henderson wrote:
> On 8/27/19 5:26 PM, Sandra Loosemore wrote:
>> Yesterday I tried to build the recent 4.1 release system-mode QEMU for
>> aarch64-none-elf and ran into a compilation error in
>> ./contrib/libvhost-user/libvhost-user.c.
> 
> Why are you attempting to compile qemu for a non-hosted (aka bare metal)
> configuration?  That is certainly not a supported thing to do.  We require
> POSIX (or Win32) at a minimum.
> 
> I can only presume that you're intending a hosted configuration, and using a
> cross-compiler that doesn't actually match up.  What is the intended host (and
> libc if this is for Linux, since there are at least 3)?

Sorry if that was not clear.  The target is aarch64-none-elf with the 
provided semihosting facilities in QEMU.  The host is x86_64-linux-gnu. 
We deliberately link against a pretty old glibc sysroot (looks like 
version 2.11.1), but we did that for last year's 3.0 release as well, 
and haven't made any other changes in the configure options etc that we 
use to build QEMU for this target.

-Sandra

