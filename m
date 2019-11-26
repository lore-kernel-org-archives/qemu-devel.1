Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E5CC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 08:51:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36E7020722
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 08:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36E7020722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZWZY-0006js-Dj
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 03:51:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1iZWTp-0001Fu-IX
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 03:45:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1iZWIm-0005cn-Mi
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 03:34:29 -0500
Received: from charlie.dont.surf ([128.199.63.193]:49382)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1iZWIl-0005ba-BU; Tue, 26 Nov 2019 03:34:27 -0500
Received: from apples.localdomain (unknown [194.62.217.57])
 by charlie.dont.surf (Postfix) with ESMTPSA id 24A08BF533;
 Tue, 26 Nov 2019 08:34:25 +0000 (UTC)
Date: Tue, 26 Nov 2019 09:34:21 +0100
From: Klaus Birkelund <its@irrelevant.dk>
To: Beata Michalska <beata.michalska@linaro.org>
Subject: Re: [PATCH v2 15/20] nvme: add support for scatter gather lists
Message-ID: <20191126083421.GA225199@apples.localdomain>
References: <20191015103900.313928-1-its@irrelevant.dk>
 <20191015103900.313928-16-its@irrelevant.dk>
 <CADSWDzupax=4s4=wb6NOR-imKNc_SkfBf1aDWdS_eN8oynJj6A@mail.gmail.com>
 <20191125062122.GA21341@apples.localdomain>
 <CADSWDzv3h+VcF9kVDRu2M=9E0Q51k9DRyxNhAxX0JwWNdKazMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADSWDzv3h+VcF9kVDRu2M=9E0Q51k9DRyxNhAxX0JwWNdKazMQ@mail.gmail.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Paul Durrant <Paul.Durrant@citrix.com>,
 Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 25, 2019 at 02:10:37PM +0000, Beata Michalska wrote:
> On Mon, 25 Nov 2019 at 06:21, Klaus Birkelund <its@irrelevant.dk> wrote:
> >
> > On Tue, Nov 12, 2019 at 03:25:18PM +0000, Beata Michalska wrote:
> > > Hi Klaus,
> > >
> > > On Tue, 15 Oct 2019 at 11:57, Klaus Jensen <its@irrelevant.dk> wrote:
> > > >
> > > > +#define NVME_CMD_FLAGS_FUSE(flags) (flags & 0x3)
> > > > +#define NVME_CMD_FLAGS_PSDT(flags) ((flags >> 6) & 0x3)
> > > Minor: This one is slightly misleading - as per the naming and it's usage:
> > > the PSDT is a field name and as such does not imply using SGLs
> > > and it is being used to verify if given command is actually using
> > > SGLs.
> > >
> >
> > Ah, is this because I do
> >
> >   if (NVME_CMD_FLAGS_PSDT(cmd->flags)) {
> >
> > in the code? That is, just checks for it not being zero? The value of
> > the PRP or SGL for Data Transfer (PSDT) field *does* specify if the
> > command uses SGLs or not. 0x0: PRPs, 0x1 SGL for data, 0x10: SGLs for
> > both data and metadata. Would you prefer the condition was more
> > explicit?
> >
> Yeah, it is just not obvious( at least to me)  without referencing the spec
> that non-zero value implies SGL usage. Guess a comment would be helpful
> but that is not major.
> 
 
Nah. Thats a good point. I have changed it to use a switch on the value.
This technically also fixes a bug because the above would accept 0x3 as
a valid value and interpret it as SGL use.


Klaus

