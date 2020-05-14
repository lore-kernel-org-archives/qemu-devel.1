Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AFBC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 18:26:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DA7D2054F
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 18:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DA7D2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZIYy-0005dk-O7
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 14:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jZIY7-0005By-Bh
 for qemu-devel@nongnu.org; Thu, 14 May 2020 14:25:39 -0400
Received: from esa1.mentor.iphmx.com ([68.232.129.153]:44267)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jZIY5-0002Zw-EK
 for qemu-devel@nongnu.org; Thu, 14 May 2020 14:25:38 -0400
IronPort-SDR: iMTLqojzLNy3EgMVBIfUTkbz0Y8LH3/A31A3lGHqyTVFbhvRiAPP2qXOA/028MHYsO5qOo+D5G
 Wgl1FRN8hgOlrvTa4PF2bMl8Bkqiq7WnZyMue8NzKDbhczWp6CbH+mwEkJKbmPac9LJo5+56UO
 L2U9CnEZDLU397iaDDP/JehQ2MKJGGnL33euGPdlmO1rO3WCAHE3q5Sl+cHTZyJh9hkmp32bDt
 DojC56ARS5D+fZMIGHkMPnZYkX42OuAKI0qH2YC5Me0JVW+CNd2qXfzome7/dCXkwA7ndtkpwm
 Tw0=
X-IronPort-AV: E=Sophos;i="5.73,392,1583222400"; d="scan'208";a="50888058"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
 by esa1.mentor.iphmx.com with ESMTP; 14 May 2020 10:25:34 -0800
IronPort-SDR: htvO48n/qAnfCi1CQdG+XoYQcidTHf6JLJhowjhYYpo30JESm9l/5eHTY6FN/L3ZWZsKomZwl4
 qjHk/VkSfUiTfgvzaOIGFr9ZsogvMyXqZl/gHSqVBKFNtnOFeDuvFs1aQdXm+FsUDUjOuTjSVc
 agiYWcjfWTHHuHId5my1Kb3kv+Pc0IIKD2+1YyU+V9iE6sKQWEsApbuYTnnuXWmcmVfMO8oEIW
 RCTAO9RmhOffPZHZJAvzCSak1bB/ZElm7/+AG2CvUBWGgKW2B6Sz01aIQBmd0jfnTa/aDNtNXP
 Rqw=
Date: Thu, 14 May 2020 18:25:28 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>, <rth@twiddle.net>,
 <ehabkost@redhat.com>
Subject: Ping Re: [PATCH 0/5] target/i386: fxtract, fscale fixes
In-Reply-To: <alpine.DEB.2.21.2005070038550.18350@digraph.polyomino.org.uk>
Message-ID: <alpine.DEB.2.21.2005141821240.23319@digraph.polyomino.org.uk>
References: <alpine.DEB.2.21.2005070038550.18350@digraph.polyomino.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-06.mgc.mentorg.com (139.181.222.6) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
Received-SPF: pass client-ip=68.232.129.153;
 envelope-from=joseph_myers@mentor.com; helo=esa1.mentor.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 14:25:34
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping for this patch series 
<https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg01465.html>.

Although my three patch series so far for floatx80 and i386 floating-point 
instructions fixes are independent of each other, it's likely future patch 
series in this area will depend on some of the previous patch series.

-- 
Joseph S. Myers
joseph@codesourcery.com

