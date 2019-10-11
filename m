Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557ACC47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 09:54:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C97620679
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 09:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="Vb93kSvF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C97620679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIrci-0001Mf-9q
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 05:54:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57830)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anthony.perard@citrix.com>) id 1iIrbk-0000n1-Sl
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 05:53:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1iIrbj-0001ES-TB
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 05:53:12 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:40339)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1iIrZl-0008Um-40; Fri, 11 Oct 2019 05:53:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1570787470;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=fAuOiHeCZZgtzXPvOfi0e7bo6YbfdBtlKzxEdypaumY=;
 b=Vb93kSvFI0gUEyXOlASDVvKDYJUK7Cg+a/YbrClnWEjU6hpaBaYgXsik
 xkLXHWAD+S7gd0t5Vs825rgVh4YdnwHLfmgG/rkJlfGvQcD+2/b0V+GLW
 eGejHZ/JTyINBzmR/oBcfrC5zmZyHYevvblvpQDH/469fmWaxmgtYXrVo w=;
Authentication-Results: esa3.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=anthony.perard@citrix.com;
 spf=Pass smtp.mailfrom=anthony.perard@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 anthony.perard@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible
Received-SPF: Pass (esa3.hc3370-68.iphmx.com: domain of
 anthony.perard@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
 ip4:168.245.78.127 ~all"
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: OyDrkW88vgbZYfr8QEjZwtSnLQxxM4qKmn2q43QuT4vd5b4PL4Oqw9xS8uoeCqsE7wDS1fT+wi
 bZPI5EgbHmwzXPtoJGL4QAvLIfvZ7Rk5k1Xpjg/cLojV9GGB0/MFZqvb9Q1+6Id0/He7TOfHbE
 wehkF1JuroPVw1fLiOZtODsZpouB5xJLq5U+mCT9ORP+DrkZC9Cd3IkSqdid2F6zCT+hTNFg6W
 wA4RMQUJQvk97VvVTMbffNrFm1Hqcre4aTAObUOs+17GUnU2R5qxjyO5O/0Mb6YL8C6dE1aT8Z
 pAQ=
X-SBRS: 2.7
X-MesageID: 6758945
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.67,283,1566878400"; 
   d="scan'208";a="6758945"
Date: Fri, 11 Oct 2019 10:51:03 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Subject: Re: [PATCH 00/97] Patch Round-up for stable 4.0.1, freeze on
 2019-10-10
Message-ID: <20191011095103.GR1163@perard.uk.xensource.com>
References: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.145.155
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
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 01, 2019 at 06:44:39PM -0500, Michael Roth wrote:
> Hi everyone,

Hi Michael,

> Please respond here or CC qemu-stable@nongnu.org on any patches you
> think should be included in the release.

[...]

> Anthony PERARD (1):
>       xen-bus: Fix backend state transition on device reset

Could you cherry-pick df6180bb56cd03949c2c64083da58755fed81a61
"xen-bus: check whether the frontend is active during device reset..."
as well, to fix the fix?

Thanks,

-- 
Anthony PERARD

