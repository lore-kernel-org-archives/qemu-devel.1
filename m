Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7FFCA9EAF
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 02:19:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D5FC2070B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 02:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=startmail.com header.i=@startmail.com header.b="lljdGwsh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D5FC2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=startmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMjlE-000292-A5
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 22:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42508)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hanetzer@startmail.com>) id 1iMjkK-0001M5-76
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 22:18:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hanetzer@startmail.com>) id 1iMjkJ-0006cE-24
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 22:18:04 -0400
Received: from mx-out2.startmail.com ([145.131.90.155]:35638)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <hanetzer@startmail.com>)
 id 1iMjkI-0006c0-Qu; Mon, 21 Oct 2019 22:18:03 -0400
Date: Mon, 21 Oct 2019 21:17:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
 s=2017-11; t=1571710680;
 bh=D6thSrvEWbSyAfcsaCB7IfH39XbHE8pH2vwSCB3bJDw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lljdGwsh7cs4HZbWWMY6O6z7+X1z5SnUJUWXWXBTa2ssEakQPKV3VEgdUv2BX4PCW
 I09Fg6/32jKwAVpSSfBL1SaL/pFA8gpwrelts+VMIARK2chnhvRqQD/mD2kwj+GtvR
 qoBeGUIQpwUr6CXpj5Bbr0h+PU/36VYV6F5ILEv0S18gRT4zT5oXryBYywUrTg1fHs
 5LBByRBLYxWnHf6YBP7VwiQI1km5neAgTZlwxUStnPVuNlZY9M6rETCt35nFdnMWZx
 5RW5x7xT6xstFToY+LzwBzfyfYaA/VlPO3m20KeWRgl93vO4CGXfXdFdnHKT3CXpIc
 mN7P8FW5wRAQw==
From: "Marty E. Plummer" <hanetzer@startmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: qemu/powernv: coreboot support?
Message-ID: <20191022021754.eliz2epsusf4qbdl@proprietary-killer>
References: <21ba3404-dcd3-fe06-7725-d58e249f9fd2@kaod.org>
 <20191019153108.gkupn3tnihspq7th@proprietary-killer>
 <1cbd1882-15c8-5471-cd65-1c84c2920ba8@kaod.org>
 <20191019160933.fizoc6tpu5jday4o@proprietary-killer>
 <20191020062842.GI1960@umbus.fritz.box>
 <0a7cbd9b-2c46-259d-4e0d-9084ee2875a3@kaod.org>
 <20191021053439.GA6439@umbus.fritz.box>
 <f196a1a6-fcbf-f409-e7e7-95b42135c0be@kaod.org>
 <20191022003209.6ssq2ojiv57ixeyd@proprietary-killer>
 <20191022014032.GH6439@umbus.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022014032.GH6439@umbus.fritz.box>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 145.131.90.155
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
Cc: Joel Stanley <joel@jms.id.au>, qemu-ppc@nongnu.org,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 22, 2019 at 12:40:32PM +1100, David Gibson wrote:
> On Mon, Oct 21, 2019 at 07:32:09PM -0500, Marty E. Plummer wrote:
> > On that note, is qemu-ppc64 currently capable of running LE
> > firmware?
> 
> Well.. "qemu-ppc64" as such isn't capable of running either LE or
> firmware, since that's the Linux userspace emulator.
> qemu-system-ppc64 *is* capable of running both LE and BE firmwares though.
> 
Ah. yeah, that's what I meant. Good to know.
> Your firmware will, however, need a tiny BE shim to switch the cpu
> into LE mode.
> 
Yeah, I figured as much, and was planning to have a shim available for
'real' hardware in the event a user wants to run coreboot in LE mode
after both work properly (though somewhere in the OpenPOWER spec it is
stated firmware must be BE).
> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson



