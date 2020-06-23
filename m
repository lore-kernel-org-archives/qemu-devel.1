Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4B0C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 22:01:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 919C920675
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 22:01:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 919C920675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnqz4-00035h-SF
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 18:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jnqy8-0002CS-UQ
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 18:00:40 -0400
Received: from esa4.mentor.iphmx.com ([68.232.137.252]:45488)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jnqy6-0001bl-1K
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 18:00:39 -0400
IronPort-SDR: b0/9mSSQdUlzJUFYxbJ2UhX15g3i8DTHU3hwqcje8JAfT17Yry9sIr34Zeyq5v2IVgQTz66Spt
 T5CCj8pKLwhb/bnxo79f0AG11Uzvw5QdCLLxdFKDUuNxF21g06p7E6N7O5INeyTXJl4qAgj8j7
 fs0XS0d4T8LAcN0WL61FVoPZXtcCf9tKgsfcHd2tl8PHm/T6Os7osxZyOdYop9KhApO9gU4JVo
 /kHDG++9vuN3WKzUew57B6NbTmtxZou6KbLaYkUOG1TKK8ENHkG+w1mNtQmo9z+8Wga4pPJeFf
 gYc=
X-IronPort-AV: E=Sophos;i="5.75,272,1589270400"; d="scan'208";a="50246637"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
 by esa4.mentor.iphmx.com with ESMTP; 23 Jun 2020 14:00:35 -0800
IronPort-SDR: ASP09Gem0V3NJ3lqouMYc6izqvkz38+RzCW7sQXtJ913N3ATgkiGdgdpvD8zZC4X1lrvYFQWw3
 aoRFiJZlPSzqOCVnHqGLaY+TevvN6bK93MDBpQ9v3XVHCNJZlYZAYDm1ZPSULSSpDfrnG01c1U
 UnevetrLICEwcpBFp8yw2da3VRmqWskX0IyHShcGFB88Lr4Rs4yDFr6r1IENZ/P3XbCSpBX8eo
 4asXXRa3SZgKHkrb1MyUFp+HIsXc0zCMounmwuJWukMprwgjkjLWgUdd3eIP7oNEVRQhiFHwjn
 fkg=
Date: Tue, 23 Jun 2020 22:00:30 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 1/5] target/i386: implement special cases for fxtract
In-Reply-To: <20200623214226.GH9925@habkost.net>
Message-ID: <alpine.DEB.2.21.2006232159560.6195@digraph.polyomino.org.uk>
References: <alpine.DEB.2.21.2005070038550.18350@digraph.polyomino.org.uk>
 <alpine.DEB.2.21.2005070042360.18350@digraph.polyomino.org.uk>
 <20200623214226.GH9925@habkost.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3) To
 SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3)
Received-SPF: pass client-ip=68.232.137.252;
 envelope-from=joseph_myers@mentor.com; helo=esa4.mentor.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 18:00:36
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 23 Jun 2020, Eduardo Habkost wrote:

> > +        if (EXPD(temp) == 0) {
> > +            int shift = clz64(temp.l.lower);
> > +            temp.l.lower <<= shift;
> 
> Coverity reports the following.  It looks like a false positive
> because floatx80_is_zero() would be true if both EXPD(temp) and
> temp.l.lower were zero, but maybe I'm missing something.

Yes, that looks like a false positive to me.

-- 
Joseph S. Myers
joseph@codesourcery.com

