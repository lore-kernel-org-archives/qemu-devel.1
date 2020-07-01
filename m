Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90BBC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:22:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C2312067D
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gX9SEQ/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C2312067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqdcu-0003Uy-Ll
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 10:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1jqdby-0001to-Ka; Wed, 01 Jul 2020 10:21:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:51930)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1jqdbw-0001Sk-K2; Wed, 01 Jul 2020 10:21:18 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6DEA72067D;
 Wed,  1 Jul 2020 14:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593613274;
 bh=YGtkptdwe4RrotXO9hAySQJsFXlVBtsMfVs5WbtYKss=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gX9SEQ/nwJFKLFg6SqEJshpiJmRIqqELoufPSOhaoBoO8rGHSyECBGIB7EtoZSg9m
 93p4NY5qhVvtqzPG3Ix8tZtONfIoFVsoOnN+W44U4kwkUkldr8mhmI/vs9LrYHoxie
 pvcG7VQWSRdzZkoNfKEY4mEXkOwrESrELCf019MA=
Date: Wed, 1 Jul 2020 07:21:11 -0700
From: Keith Busch <kbusch@kernel.org>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: nvme emulation merge process (was: Re: [PATCH 00/10]
 hw/block/nvme: namespace types and zoned namespaces)
Message-ID: <20200701142111.GB1988944@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200630100139.1483002-1-its@irrelevant.dk>
 <20200630125932.GA553472@localhost.localdomain>
 <c10b18a8-44f3-7dab-b9bb-7d017f210934@redhat.com>
 <20200630154228.GB1987534@dhcp-10-100-145-180.wdl.wdc.com>
 <20200630203630.am3a3bc5ze5m2r3k@apples.localdomain>
 <20200701103407.GA11634@linux.fritz.box>
 <20200701131820.l4gb2ewjmnm6ysmt@apples.localdomain>
 <645af679-d2a3-a744-d07c-477198879680@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <645af679-d2a3-a744-d07c-477198879680@redhat.com>
Received-SPF: pass client-ip=198.145.29.99; envelope-from=kbusch@kernel.org;
 helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 10:21:14
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -80
X-Spam_score: -8.1
X-Spam_bar: --------
X-Spam_report: (-8.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Dmitry Fomichev <Dmitry.Fomichev@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
 Klaus Jensen <its@irrelevant.dk>, Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 01, 2020 at 03:57:27PM +0200, Philippe Mathieu-Daudé wrote:
> On 7/1/20 3:18 PM, Klaus Jensen wrote:
> > We've also seen good patches from Andrzej linger on the list for quite a
> > while, prompting a number of RESENDs. I only recently allocated more
> > time and upped my review game, but I hope that contributors feel that
> > stuff gets reviewed in a timely fashion by now.
> > 
> > Please understand that this is in NO WAY a criticism of Keith who
> > already made it very clear to me that he did not have a lot time to
> > review, but only ack the odd patch.
> > 
> >> Depending on how much time Keith can spend on review in the
> >> near future and how much control he wants to keep over the development,
> >> I could imagine adding Klaus to MAINTAINERS, either as a co-maintainer
> >> or as a reviewer. Then I could rely on reviews/acks from either of you
> >> for merging series.
> >>
> > 
> > I would be happy to step up (officially) to help maintain the device
> > with Keith and review on a daily basis, and my position can support
> > this.
> 
> Sounds good to me, but it is up to Keith Busch to accept.

I definitely want to continue at least having the opprotunity to review,
though you may have noticed I am a bit low on time for more thorough
maintenance this project deserves. The recent development pace for nvme
would benefit from having its own tree, so I'm open to either
co-maintenance, or handing off this to others. Please allow me to send a
few queries off-list today to check-in with potentially interested parties.
 
> It would be nice to have at least one developer from WDC listed as
> designated reviewer too.
> 
> Maxim is candidate for designated reviewer but I think he doesn't
> have the time.
> 
> It would also nice to have Andrzej Jakowski listed, if he is interested.

