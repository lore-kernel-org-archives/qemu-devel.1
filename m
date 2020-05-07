Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CC6C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 14:58:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9502020663
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 14:58:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9502020663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWhz2-000389-Qy
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 10:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jWhyN-0002iA-BY
 for qemu-devel@nongnu.org; Thu, 07 May 2020 10:58:03 -0400
Received: from esa3.mentor.iphmx.com ([68.232.137.180]:5467)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jWhyK-0004GQ-OX
 for qemu-devel@nongnu.org; Thu, 07 May 2020 10:58:02 -0400
IronPort-SDR: epz43jLNYUR8Wsyeih5g9/JV3zhMU5Py547VsJjcIesqJ7FzuH6voSIHKTehB19QX3lj30h0km
 Ur7IZP0ao6CvQ6fuovNYblO2MxObA4hsB+wxBwptB2WmV6FcQrDAunT4HHMidpBFYZRfgWuhgB
 UTe6WFxrH/fXiYzaSDj2AoBao/QVtA49c+k5itujvcPdbf2W+gBzur3m+NRk+iXLIdns6W/fuM
 x9IFkiOvYu1o8MvR1RpuxEcSuXvJZaEhHaPEDqYMWhQODtq9tWt+rNa9ZjIZNxmWKhawu5f+k/
 7DI=
X-IronPort-AV: E=Sophos;i="5.73,364,1583222400"; d="scan'208";a="48623229"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
 by esa3.mentor.iphmx.com with ESMTP; 07 May 2020 06:57:57 -0800
IronPort-SDR: wsyKEVZJTkurGr1QajH60x5h0JBFCrfKsnlenEaj7TjxSN3moBTNBGR0Oxcya9PsnaM3IE7h6U
 Tr98f5YFTQKHffhkyy7JptlgHijeOYe/7Wgtl1x9WWTniDV5o3LbuUuLZHx6UEcq1I+Xfc5jgW
 NQZqf0NV909rTHRcLNdkfgCxuj2fj+P/sh8dpJgZD81EYK2nxk3atMNA/YX4yY1lkAfSq35rZs
 9jdyn7oL1E7KbxAK9bJrpCvzcdnJ9L4q5RdMY0fVy/bmK357nTkD+5+4c7WgdYhXetLpIxEsjh
 6UQ=
Date: Thu, 7 May 2020 14:57:51 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: <qemu-devel@nongnu.org>
Subject: Re: [PATCH 0/5] target/i386: fxtract, fscale fixes
In-Reply-To: <158881758425.4109.8939056494235923582@45ef0f9c86ae>
Message-ID: <alpine.DEB.2.21.2005071449350.26071@digraph.polyomino.org.uk>
References: <158881758425.4109.8939056494235923582@45ef0f9c86ae>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-07.mgc.mentorg.com (139.181.222.7) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
Received-SPF: pass client-ip=68.232.137.180;
 envelope-from=joseph_myers@mentor.com; helo=esa3.mentor.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 10:57:58
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: patchew-devel@redhat.com, pbonzini@redhat.com, ehabkost@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 7 May 2020, no-reply@patchew.org wrote:

> === OUTPUT BEGIN ===
> 1/5 Checking commit 69eed0bcaaaf (target/i386: implement special cases for fxtract)
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?

I don't think any MAINTAINERS update is needed for a new testcase in an 
existing directory.

> ERROR: Use of volatile is usually wrong, please add a comment

I think the justification for volatile in such testcase code is obvious 
without comments in individual cases - to avoid any code movement or 
optimization that might break what the tests are intending to test (these 
tests are making heavy use of mixed C and inline asm to test how emulated 
instructions behave, including on input representations that are not valid 
long double values in the ABI and with the rounding precision changed 
behind the compiler's back).  I think making everything possibly relevant 
volatile in these tests is better than trying to produce a fragile 
argument that in fact certain data does not need to be volatile to avoid 
problematic code movement.

> ERROR: spaces required around that '-' (ctx:VxV)
> #139: FILE: tests/tcg/i386/test-i386-fxtract.c:80:
> +                      "0" (0x1p-16445L));
>                                 ^

No, this is a C99 hex float contstant, not a subtraction.  There are 
already such constants in tests/tcg/multiarch/float_helpers.c and 
tests/tcg/multiarch/float_madds.c at least, so I assume they are OK in 
QEMU floating-point tests and this style checker should not be objecting 
to them.

-- 
Joseph S. Myers
joseph@codesourcery.com

