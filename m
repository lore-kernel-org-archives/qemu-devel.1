Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A158C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 18:39:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 607952072F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 18:39:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 607952072F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgBp7-0003FI-Fu
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 14:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jgBoI-0002hK-Rh
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 14:38:50 -0400
Received: from esa2.mentor.iphmx.com ([68.232.141.98]:32770)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jgBoG-0003ji-FT
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 14:38:50 -0400
IronPort-SDR: do+tBJe3uspZjtE+o+N8Jx613PkwssKMK0h32x/zcUP8FybpZ+CR/OElDYCg9vaV6ZeStm7PSX
 8ghRslGx7q/1/GO0hTmK0Wlj8rHhlWXhe8Ap82zsmg948wY2zt/hgNdA7rsuqdp+0NNXV17RSJ
 dxfVh4qdOYbxE0DPVIBJdYQ5gsweFJgIFhvhQ+Tz8V+00B8atnllQ9wWgpPP1oRweNC8f/uTpe
 sjBq8v87eKLFddD64EYNd/YNtZxB5XkiN+eisXYneG0qw3XUJKviumLTi4y6VNPgsE+GGfJvMt
 Mg8=
X-IronPort-AV: E=Sophos;i="5.73,465,1583222400"; d="scan'208";a="49389237"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
 by esa2.mentor.iphmx.com with ESMTP; 02 Jun 2020 10:38:44 -0800
IronPort-SDR: 0gl+LPBoZokWKx+sOF6BzilVUSHy47rByzFqvVA9s/NB9FeABQ4/Cot3wUl8DBQu5l8YMf77nk
 K/4IBxbdHi8Nl8GIOTBLQQ/aHChu+8XBqHHfhupjcUjZwVkWjG23CMg+HsmW+8GRkG2EVqotCq
 pZlRDHn9nOrI3ky7V2WnHmho9YWI+x4DiKbnM84PTWJhNkNelXJqSCnvXwCAcgC9d066ShkbOP
 HQ39G0qYMXWMnr7bFVbCwhSeVkE4YtR6f9/2cjBgBiaxmfE9/pHXv9c03k1QjLI7I+WjNZuBaH
 zlk=
Date: Tue, 2 Jun 2020 18:38:39 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>, <rth@twiddle.net>,
 <ehabkost@redhat.com>
Subject: Re: [PATCH 0/4] target/i386: miscellaneous x87 fixes
In-Reply-To: <alpine.DEB.2.21.2005132345100.11687@digraph.polyomino.org.uk>
Message-ID: <alpine.DEB.2.21.2006021837050.3673@digraph.polyomino.org.uk>
References: <alpine.DEB.2.21.2005132345100.11687@digraph.polyomino.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-08.mgc.mentorg.com (139.181.222.8) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
Received-SPF: pass client-ip=68.232.141.98;
 envelope-from=joseph_myers@mentor.com; helo=esa2.mentor.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 14:38:44
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
<https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg03543.html>, and 
the subsequent series 
<https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg04462.html> and 
individual patch 
<https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg06521.html>.

-- 
Joseph S. Myers
joseph@codesourcery.com

