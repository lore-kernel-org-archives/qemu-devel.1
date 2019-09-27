Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCFCC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 08:59:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D792217D7
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 08:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D792217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDm69-0008Dg-Be
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 04:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51334)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iDm2a-0005B4-3K
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 04:55:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iDm2Z-0005d1-5M
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 04:55:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59030)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>)
 id 1iDm2X-0005RT-3f; Fri, 27 Sep 2019 04:55:49 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 37DF018CB8FB;
 Fri, 27 Sep 2019 08:55:47 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com
 [10.36.116.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E3DF5600C6;
 Fri, 27 Sep 2019 08:55:46 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 234A017535; Fri, 27 Sep 2019 10:55:46 +0200 (CEST)
Date: Fri, 27 Sep 2019 10:55:46 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [RFC PATCH] configure: deprecate 32 bit build hosts
Message-ID: <20190927085546.2aemjmwudvgpek3y@sirius.home.kraxel.org>
References: <20190925233013.6449-1-alex.bennee@linaro.org>
 <CAFEAcA9vb5_Mi_axWpu7269Zg0xMLbiiV80ofLeyDpfws3G4nQ@mail.gmail.com>
 <20190926125817.GB19660@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926125817.GB19660@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Fri, 27 Sep 2019 08:55:47 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 qemu-discuss <qemu-discuss@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, qemu-ppc@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> That leaves armv7 as the only 32-bit arch in Fedora that is somewhat
> active & maintained. I don't have any real insight on whether any
> armv7 (Fedora) users are making much use of QEMU/KVM though, either
> system or user emulation. 

Played with system emulation a while back.  I doubt this is used much
in practice.  It's very slow for various reasons (no gic, no armv8 arch
updates to support kvm virt better, slow sdcard/usb I/O).  TCG on a
beefy x86 box is roughly the same speed.  Also 1G of memory isn't that
much even without considering virtual machines.

The rpi4 with 4G (disclaimer: don't have one) probably works better.
But note they are finally working on a 64bit kernel for raspbian,
which I expect is only a first step for better 64bit support.

cheers,
  Gerd


