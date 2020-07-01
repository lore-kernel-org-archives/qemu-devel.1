Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DBAC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 08:47:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B9CD2074D
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 08:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.uni-paderborn.de header.i=@mail.uni-paderborn.de header.b="nMn2nych"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B9CD2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mail.uni-paderborn.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqYPE-0004q8-Bk
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 04:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1jqYOR-0003yz-N3
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 04:47:00 -0400
Received: from collins.uni-paderborn.de ([2001:638:502:c003::14]:35746)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1jqYOO-0006Px-Rb
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 04:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=72pn0uy8A0Xba4zvLJTwr3WyljwoaW0urRMjxWHvg9c=; b=nMn2nychi7kn0O5zOBC4g+EZ0
 amlywyQG5O0i4L6B0u1NsCZ+mC96EgzJ60m1HdIE7WIFlndruswMo4dZIrVt9xDVaGJa+dfYjKc/I
 0LFPLX28jOYhRGaFVQf47RW3SW3GeeQa15Ppz2Xzr3cyXCsQDUq/ENi8xfjzVRQ3pQoQY=;
Date: Wed, 1 Jul 2020 10:46:49 +0200
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: "Konopik, Andreas (EFS-GH2)" <andreas.konopik@efs-auto.de>
Subject: Re: [PATCH v3 1/1] tricore: added triboard with tc27x_soc
Message-ID: <20200701084649.lo77kx7gxqq6ddbe@schnipp-desktop>
References: <4006678c6d834f4fb126314e83f99f5c@efs-auto.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4006678c6d834f4fb126314e83f99f5c@efs-auto.de>
X-IMT-Spam-Score: 0.0 ()
X-Sophos-SenderHistory: ip=2a02:908:2214:e5a0:6cad:915:5142:377d, fs=434106,
 da=81202275, mc=6, sc=0, hc=6, sp=0, fso=434106, re=0, sd=0, hd=0
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2020.7.1.84217, AntiVirus-Engine: 5.74.0,
 AntiVirus-Data: 2020.7.1.5740000
X-IMT-Authenticated-Sender: kbastian@UNI-PADERBORN.DE
Received-SPF: pass client-ip=2001:638:502:c003::14;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=collins.uni-paderborn.de
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Biermanski,
 Lars \(EFS-GH3\)" <lars.biermanski@efs-auto.de>, "Hofstetter,
 Georg \(EFS-GH2\)" <Georg.Hofstetter@efs-auto.de>, "Brenken,
 David \(EFS-GH5\)" <david.brenken@efs-auto.de>, "Rasche,
 Robert \(EFS-GH2\)" <robert.rasche@efs-auto.de>,
 David Brenken <david.brenken@efs-auto.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Andreas,

On Tue, Jun 30, 2020 at 10:28:57AM +0000, Konopik, Andreas (EFS-GH2) wrote:
> Hi Bastian,
> 
> > On Mon, Jun 22, 2020 at 03:19:34PM +0200, David Brenken wrote:
> > > From: Andreas Konopik <andreas.konopik@efs-auto.de>
> > > +const MemmapEntry tc27x_soc_memmap[] = {
> > > +    [TC27XD_DSPR2]     = { 0x50000000,   0x1E000 },
> > > +    [TC27XD_DCACHE2]   = { 0x5001E000,    0x2000 },
> > > +    [TC27XD_DTAG2]     = { 0x500C0000,     0xC00 },
> > 
> > The size changed from 0xa00 to 0xc00 from v2. The manual states that it has no
> > size. I guess you inferred the size from the address range. How does real hw
> > behave if you access DTAG2?
> 
> DTAG size of 0xa00 was a mistake, 0xc00 is correct. Even though the manual does not assign sizes, DTAG and PTAG can be mapped for memory testing purposes.
> Therefore memory accesses to DTAG/PTAG are possible (see Footnote 3 & 4 [1, Page 3-10]).
> 
> Real hardware has to be configured via MTU before accessing DTAG/PTAG. Because QEMU tricore has no MTU, we wanted to be less restrictive by mapping DTAG/PTAG into memory.

Ok, that sound reasonable to me.

> 
> > Why not use KiB/MiB sizes as before? I created a patch for that. Can you check
> > that I didn't skrew up the sizes?
> 
> Thank you, the patch looks good to me.
> How do you want to proceed? Should we send you a Patch v4?

Yes, that would be best.

Cheers,
Bastian

