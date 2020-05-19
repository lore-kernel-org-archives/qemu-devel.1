Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909BBC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 18:12:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FE3B20674
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 18:12:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FE3B20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb6jY-0001lr-Gq
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 14:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jb6j1-0001AO-KF
 for qemu-devel@nongnu.org; Tue, 19 May 2020 14:12:23 -0400
Received: from esa1.mentor.iphmx.com ([68.232.129.153]:24610)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jb6iz-0006Mm-H9
 for qemu-devel@nongnu.org; Tue, 19 May 2020 14:12:22 -0400
IronPort-SDR: ZQVkg2LtKIMs/ZrHu6H+5LGrgmasOOGamtCxqrznvILaFNq0C63G1QAJCfeFXN169mb5w+ZfMy
 GeHvd4zRBbMPZ4CgW5Q/gotwctY+z2h0bsfAKySGZnZteOkF3z6AvlQ3eE59mxXaBOdnFpp1lx
 fyZ1TtJOg34fS1fLjJPdyXSuo3BkC2me329dLkr6DGvo/x106EY6A9UpratcfnV3YZfI6PdcBd
 YZbl4p1EfcCy8X8mRib9Vum4BvbsYBWwUZf6FM0xDiB/PE32fixV3/tXiReJ5QUqXDAf8NBaFy
 bEU=
X-IronPort-AV: E=Sophos;i="5.73,410,1583222400"; d="scan'208";a="51037230"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
 by esa1.mentor.iphmx.com with ESMTP; 19 May 2020 10:12:16 -0800
IronPort-SDR: md2OD808l7fNf6vhcQBJsxb5ys1fGKH0/ph0hG8LJHnz4rGzrfousXVKxZkwnkt8S4NAqOIXOc
 Cthan4yrkW3CgfPAWllfha4sFmseuba4GUABxsgkpCN5aFb1MTKf0TO0oly5tDvBQT4T/VrSzb
 43fyVVdcRdHPHlqdQgkZiZw8tmecvGkOkXcQXRb1kByX0GyU4i9KnY27VSQB0NeGcck1frcRDN
 XeoCHdP39wEyut1QHHkKLGojSwnz8iUM4A+hTEnPqOaf9awaFrEbUa2mdoE2tKc9PS4tHBiR7i
 Bys=
Date: Tue, 19 May 2020 18:12:10 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 2/2] target/i386: fix IEEE x87 floating-point exception
 raising
In-Reply-To: <5dd2d81c-cedd-7835-6b3c-7e089254dc95@linaro.org>
Message-ID: <alpine.DEB.2.21.2005191757210.10766@digraph.polyomino.org.uk>
References: <alpine.DEB.2.21.2005152117400.3469@digraph.polyomino.org.uk>
 <alpine.DEB.2.21.2005152120280.3469@digraph.polyomino.org.uk>
 <5dd2d81c-cedd-7835-6b3c-7e089254dc95@linaro.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
Received-SPF: pass client-ip=68.232.129.153;
 envelope-from=joseph_myers@mentor.com; helo=esa1.mentor.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 14:12:17
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 19 May 2020, Richard Henderson wrote:

> To retain the hard float fast path, we need to leave float_flag_invalid set
> when the accrued exception bit is set.  To me this suggests keep all of the
> FPUS_* bits in fp_status and only convert to FPUS_* when we read the fp status
> word.

There is no hard float fast path that I can see for floatx80.  The issue 
of the fast path might be relevant for fixing SSE exception handling 
(which has some similar issues to x87), but not for floatx80.

Note that another bug in the x87 emulation is the lack of setting C1 for 
most instructions with inexact results based on the direction of rounding 
(which will require a new feature to be added to the softfloat code to 
record that information so the x87 emulation can use it).

> When it comes to raising unmasked exceptions... I have a couple of thoughts.

I expect some code will be needed in each individual instruction 
implementation, and probably extra softfloat code, to handle unmasked 
exceptions.  Some exceptions, when unmasked, should result in instructions 
not popping inputs from the stack and not updating destinations.  The 
softfloat case needs to provide information about the exact underflow case 
that targets can use when that exception is set to trap.  x87 overflow and 
underflow, when unmasked and with a register destination, are supposed to 
compute and store a result with a biased exponent for use by the trap 
handler.  The code will also need to know exactly which instructions 
should result in a trap handler being called rather than only doing it for 
fwait.  Stack underflow and overflow need to be checked for, regardless of 
exception masking.  (There are other issues relating to trapped exception 
handling as well, but that's a summary of the main ones I've noticed.)

-- 
Joseph S. Myers
joseph@codesourcery.com

