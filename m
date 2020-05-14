Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C63AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 15:04:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ACF6205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 15:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ACF6205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZFPd-0000TE-1B
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 11:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jZEtz-0005iz-49
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:31:59 -0400
Received: from esa4.mentor.iphmx.com ([68.232.137.252]:21704)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jZEtw-0000Rt-TM
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:31:58 -0400
IronPort-SDR: WhA2u/yuiI4KZFMQfLTkUmKfAhwbsQgHwjFhaO8ooqUOgiVTC2jBjxghINiwj6E1DPUKFPg0QG
 Jb7/pfduOqak9JsAHJHokF+xBu0ZsLLhIciSm+Mc1C9ZgVbkjmkd5PVAMmBTMoKAapZsLmJDWR
 jXLkS9nHFvBnFlsLq4OugIwUDzDt1xNvzOAmDljGfxptTOHkI6opOeU8mojToW0Ry+3wm8I/4I
 Tto6RBLbbJWeqvHQk4O7BNsgZMZepLWQEcGm8jwY6bcsMcB3EOsZIZiC9JkiJEm97JGxVFq0hl
 EIA=
X-IronPort-AV: E=Sophos;i="5.73,391,1583222400"; d="scan'208";a="48902411"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
 by esa4.mentor.iphmx.com with ESMTP; 14 May 2020 06:31:53 -0800
IronPort-SDR: Al5k8oH2xeNquCTzV1H9kQgV1FCB0GIGWV0t3UlRWpHCziD0Kiu2KweZ6SJiNnkfwmtRxEzkwQ
 ksg66ZuIgQ8Mgb2KtpG+SfaBobrkqFafp8GgXk4J66Tos1mblk8UvXGoQ+pK77u1/i+2pwS+yT
 d5Wa2Z3veuEFCIbJCE1r811kLqQ5hXO1Ci1HXhPY3IuPkss5Z0H2QkJuiW1upKxrCpeJbc07wL
 K3engUZmBk0xYbnaul8u6lnSG59z6NhfmqJ0vytyOuQtkonsiHdabn7P5fkGWiRSfPBiYzeljQ
 L8k=
Date: Thu, 14 May 2020 14:31:47 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: <qemu-devel@nongnu.org>
Subject: Re: [PATCH 0/4] target/i386: miscellaneous x87 fixes
In-Reply-To: <158943730690.13639.11508123856437182115@45ef0f9c86ae>
Message-ID: <alpine.DEB.2.21.2005141431170.10618@digraph.polyomino.org.uk>
References: <158943730690.13639.11508123856437182115@45ef0f9c86ae>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
Received-SPF: pass client-ip=68.232.137.252;
 envelope-from=joseph_myers@mentor.com; helo=esa4.mentor.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 10:31:54
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
Cc: pbonzini@redhat.com, ehabkost@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 14 May 2020, no-reply@patchew.org wrote:

> This series seems to have some coding style problems. See output below for
> more information:

These are all false positives for the same reasons as for the previous 
patch series.

-- 
Joseph S. Myers
joseph@codesourcery.com

