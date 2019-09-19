Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC70C49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 09:17:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5B6E217D6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 09:17:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5B6E217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAsZG-0002kq-Mc
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 05:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39080)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dovgaluk@ispras.ru>) id 1iAsNS-0004df-TL
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 05:05:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1iAsNR-00071B-PE
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 05:05:26 -0400
Received: from mail.ispras.ru ([83.149.199.45]:56636)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1iAsNR-0006za-HA
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 05:05:25 -0400
Received: from PASHAISP (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id 7420E540089;
 Thu, 19 Sep 2019 12:05:24 +0300 (MSK)
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
To: "'Kevin Wolf'" <kwolf@redhat.com>
References: <156872146565.1757.3033215873677512474.stgit@pasha-Precision-3630-Tower>
 <156872148244.1757.2888672921697745021.stgit@pasha-Precision-3630-Tower>
 <20190918091831.GD5207@localhost.localdomain>
 <001201d56e02$9d88b5f0$d89a21d0$@ru>
 <20190918093305.GF5207@localhost.localdomain>
 <001401d56e04$b93c02a0$2bb407e0$@ru>
 <20190918094436.GG5207@localhost.localdomain>
 <001501d56e06$bbd7aa30$3386fe90$@ru>
 <20190919085302.GA10163@localhost.localdomain>
In-Reply-To: <20190919085302.GA10163@localhost.localdomain>
Date: Thu, 19 Sep 2019 12:05:28 +0300
Message-ID: <001901d56ec9$620ae260$2620a720$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdVux60peHun6/R7TL2DPLOr9rf6ngAAV32w
Content-Language: ru
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 83.149.199.45
Subject: Re: [Qemu-devel] [for-4.2 PATCH 3/6] replay: update docs for
 record/replay with block devices
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
Cc: peter.maydell@linaro.org, pavel.dovgaluk@ispras.ru, quintela@redhat.com,
 ciro.santilli@gmail.com, jasowang@redhat.com, crosthwaite.peter@gmail.com,
 qemu-devel@nongnu.org, armbru@redhat.com, alex.bennee@linaro.org,
 maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com,
 boost.lists@gmail.com, thomas.dullien@googlemail.com, pbonzini@redhat.com,
 mreitz@redhat.com, artem.k.pisarenko@gmail.com, dgilbert@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Kevin Wolf [mailto:kwolf@redhat.com]
> > >
> > > However, global -snapshot is just a convenient shortcut for specifying
> > > snapshot=on for all -drive arguments. So if -snapshot is incompatible
> > > with replay, shouldn't manually marking all drives as snapshot=on be
> > > incompatible as well?
> > >
> > > Maybe you're really interested in some specific drive not having
> > > snapshot=on? But then it might be better to check that specific drive
> > > instad of forbidding just the shortcut for setting it.
> >
> > -snapshot adds the flag for top-level drive, making driver operations
> > dependent on temporary file structure.
> >
> > Moving this overlay beneath blkreplay driver makes drive operations
> > deterministic for the top-level device.
> 
> So the real requirement is that blkreplay is the top-level node of any
> guest device, right? And only because of this, you can't use -snapshot
> (or snapshot=on on the blkreplay driver).
> 
> If we instead check e.g. in blk_insert_bs() or blk_attach_dev() that in
> record/replay mode, the root node of the BlockBackend is blkreplay,
> wouldn't we catch many more incorrect setups?

That sounds interesting.
Will it help to check that every backend is connected to blkreplay?
How then this check has to be done?

Pavel Dovgalyuk


