Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A449C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 07:14:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46B8B21D7F
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 07:14:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46B8B21D7F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUmrX-0005i3-Cf
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 02:14:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57767)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1iUmqb-0005Da-HH
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 02:13:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1iUmqa-0000Z2-KA
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 02:13:49 -0500
Received: from charlie.dont.surf ([128.199.63.193]:55524)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1iUmqW-0000YM-QO; Wed, 13 Nov 2019 02:13:44 -0500
Received: from apples.localdomain (unknown [194.62.217.57])
 by charlie.dont.surf (Postfix) with ESMTPSA id A9450BF413;
 Wed, 13 Nov 2019 07:13:42 +0000 (UTC)
Date: Wed, 13 Nov 2019 08:13:38 +0100
From: Klaus Birkelund <its@irrelevant.dk>
To: Beata Michalska <beata.michalska@linaro.org>
Subject: Re: [PATCH v2 19/20] nvme: make lba data size configurable
Message-ID: <20191113071338.GA470977@apples.localdomain>
References: <20191015103900.313928-1-its@irrelevant.dk>
 <20191015103900.313928-20-its@irrelevant.dk>
 <CADSWDzsWWpv64aVJuUUPgu8+DTH8Cs_sRxMqeF6kUb1AicgBvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADSWDzsWWpv64aVJuUUPgu8+DTH8Cs_sRxMqeF6kUb1AicgBvQ@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 128.199.63.193
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
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <keith.busch@intel.com>, Paul Durrant <Paul.Durrant@citrix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 12, 2019 at 03:24:00PM +0000, Beata Michalska wrote:
> Hi Klaus,
> 
> On Tue, 15 Oct 2019 at 11:50, Klaus Jensen <its@irrelevant.dk> wrote:
> >  #define DEFINE_NVME_NS_PROPERTIES(_state, _props) \
> > -    DEFINE_PROP_UINT32("nsid", _state, _props.nsid, 0)
> > +    DEFINE_PROP_UINT32("nsid", _state, _props.nsid, 0), \
> > +    DEFINE_PROP_UINT8("lbads", _state, _props.lbads, 9)
> >
> Could we actually use BDRV_SECTOR_BITS instead of magic numbers?
> 
 
Yes, better. Fixed in two places.

