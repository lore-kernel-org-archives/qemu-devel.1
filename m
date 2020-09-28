Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143C4C4727C
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 21:26:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 296262083B
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 21:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdoKWFoT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 296262083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kN0fJ-0006PP-0F
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 17:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kN0eb-0005w4-7l; Mon, 28 Sep 2020 17:25:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:48452)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kN0eZ-0000mr-7i; Mon, 28 Sep 2020 17:25:48 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 554372083B;
 Mon, 28 Sep 2020 21:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601328344;
 bh=To74t1jNnXwZDrqayMwhKP7qG4cRKb2W33r0cbknBT4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pdoKWFoTlcxkTNuxdzLk2NXm7jFtuzalM9K6lxCLhO6dOsp++eD72XDJyCI0QXxp2
 lbTyYc5gZDjhpTpFX6nUJF51ki97wzAlv4U98fzg9ieXlrZYFrIMdPnYrLUOhEafgp
 bCNKdpFuy320SiaxBUWs7kQ6Se9JU7sI/dDR9MJ4=
Date: Mon, 28 Sep 2020 14:25:41 -0700
From: Keith Busch <kbusch@kernel.org>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH v4 00/14] hw/block/nvme: Support Namespace Types and
 Zoned Namespace Command Set
Message-ID: <20200928212541.GC227320@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200923182021.3724-1-dmitry.fomichev@wdc.com>
 <20200924210751.GD1738917@apples.localdomain>
 <MN2PR04MB59515B1EA1238861DFF3236AE1350@MN2PR04MB5951.namprd04.prod.outlook.com>
 <20200928063648.GA1967@apples.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928063648.GA1967@apples.localdomain>
Received-SPF: pass client-ip=198.145.29.99; envelope-from=kbusch@kernel.org;
 helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 17:25:44
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -77
X-Spam_score: -7.8
X-Spam_bar: -------
X-Spam_report: (-7.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Niklas Cassel <Niklas.Cassel@wdc.com>,
 Dmitry Fomichev <Dmitry.Fomichev@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 28, 2020 at 08:36:48AM +0200, Klaus Jensen wrote:
> On Sep 28 02:33, Dmitry Fomichev wrote:
> > You are making it sound like the entire WDC series relies on this approach.
> > Actually, the persistency is introduced in the second to last patch in the
> > series and it only adds a couple of lines of code in the i/o path to mark
> > zones dirty. This is possible because of using mmap() and I find the way
> > it is done to be quite elegant, not ugly :)
> > 
> 
> No, I understand that your implementation works fine without
> persistance, but persistance is key. That is why my series adds it in
> the first patch. Without persistence it is just a toy. And the QEMU
> device is not just an "NVMe-version" of null_blk.

I really think we should be a bit more cautious of commiting to an
on-disk format for the persistent state. Both this and Klaus' persistent
state feels a bit ad-hoc, and with all the other knobs provided, it
looks too easy to have out-of-sync states, or just not being able to
boot at all if a qemu versions have different on-disk formats.

Is anyone really considering zone emulation for production level stuff
anyway? I can't imagine a real scenario where you'd want put yourself
through that: you are just giving yourself all the downsides of a zoned
block device and none of the benefits. AFAIK, this is provided as a
development vehicle, closer to a "toy".

I think we should consider trimming this down to a more minimal set that
we *do* agree on and commit for inclusion ASAP. We can iterate all the
bells & whistles and flush out the meta data's data marshalling scheme
for persistence later.

