Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DADEC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 12:48:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6D06206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 12:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6D06206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkoXe-0004k6-5u
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 08:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roger.pau@citrix.com>)
 id 1jkoX5-0004JR-Do
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 08:48:11 -0400
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:29838)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roger.pau@citrix.com>)
 id 1jkoX3-0005Zw-57
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 08:48:10 -0400
Authentication-Results: esa5.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
IronPort-SDR: Nh5LXmhLtCbbZ63JR5d3tnwCEewMo1+TaSAPZ8FxYOH1Kxe8NtpniYLsiKTds5PMA0laHTNakk
 nLiIwcZDT9zM0ygdqkZkaB3yBFEf2WKDoRxHP5wMshRODN2qn1iI+LdEUIavkGJrYx0Ub9dyDE
 aI+anYMAgQlixzXO6PTXZdj/aupni6RIg9tlQQI3kN+KttoWb2gufhS2Jm+Xl1CAOlXr+i9+k2
 UxosB4mQvLqCiQtjssaxOl1tLBjKOoUYF8437gTzPoAugsUoTxPSSes8f6Vfxgkt3oz9NDi/S9
 6PE=
X-SBRS: 2.7
X-MesageID: 20289285
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.73,514,1583211600"; d="scan'208";a="20289285"
Date: Mon, 15 Jun 2020 14:47:58 +0200
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Grzegorz Uriasz <gorbak25@gmail.com>
Subject: Re: [PATCH] hw/xen_pt: Don't grant opregion permissions
Message-ID: <20200615124758.GF735@Air-de-Roger>
References: <2157e10d63619d43151fe8b8ca913b44c54aba6e.1592176600.git.gorbak25@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <2157e10d63619d43151fe8b8ca913b44c54aba6e.1592176600.git.gorbak25@gmail.com>
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Received-SPF: pass client-ip=216.71.155.168; envelope-from=roger.pau@citrix.com;
 helo=esa5.hc3370-68.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 08:48:05
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, jakub@bartmin.ski,
 qemu-devel@nongnu.org, marmarek@invisiblethingslab.com,
 Anthony Perard <anthony.perard@citrix.com>, j.nowak26@student.uw.edu.pl,
 xen-devel@lists.xenproject.org, contact@puzio.waw.pl
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Jun 14, 2020 at 11:21:09PM +0000, Grzegorz Uriasz wrote:
> With the upstreaming of linux based stubdomains to xen, qemu can't
> assume it runs inside dom0 - permission assignment must be moved to
> libxl running in dom0. This xen patch:
> https://lists.xenproject.org/archives/html/xen-devel/2020-06/msg00973.html
> implements granting the required permissions to the stubdomain running
> qemu. This patch removes granting opregion permissions in qemu - this
> should be fine as when qemu is running inside dom0 the memory mapping will
> be successfully created without first explicitly granting the permission.

In order to avoid breaking certain libxl - QEMU combinations, could
you make the check below non-fatal?

So that the current code can be kept for dom0 while not throwing an
error when used inside of a stub domain?

Thanks, Roger.

