Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2276C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 15:24:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 969812082E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 15:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 969812082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50112 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hReil-0004i6-OU
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 11:24:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hRef9-0001Jd-Fd
	for qemu-devel@nongnu.org; Fri, 17 May 2019 11:20:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hRef8-0000Yi-8v
	for qemu-devel@nongnu.org; Fri, 17 May 2019 11:20:47 -0400
Received: from 1.mo6.mail-out.ovh.net ([46.105.56.136]:38712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hRef8-0000An-30
	for qemu-devel@nongnu.org; Fri, 17 May 2019 11:20:46 -0400
Received: from player791.ha.ovh.net (unknown [10.108.42.145])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 000991CBD26
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 17:20:40 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player791.ha.ovh.net (Postfix) with ESMTPSA id 3BDD95C7120B;
	Fri, 17 May 2019 15:20:38 +0000 (UTC)
Date: Fri, 17 May 2019 17:20:37 +0200
From: Greg Kurz <groug@kaod.org>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190517172037.7f8814f9@bahia.lan>
In-Reply-To: <7b4b93c9-761b-edbb-4538-b4e549afd48e@redhat.com>
References: <155774341935.175576.9256391991091401927.stgit@bahia.lan>
	<155774365069.175576.5671141718062840805.stgit@bahia.lan>
	<20190517151711.7262e276@bahia.lan>
	<7b4b93c9-761b-edbb-4538-b4e549afd48e@redhat.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 15080303355635210546
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddruddtvddgkeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.56.136
Subject: Re: [Qemu-devel] [PATCH v2 2/2] virtfs: Fix documentation of -fsdev
 and -virtfs
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 May 2019 15:22:48 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 17/05/2019 15.17, Greg Kurz wrote:
> > On Mon, 13 May 2019 12:34:10 +0200
> > Greg Kurz <groug@kaod.org> wrote:
> >   
> >> This fixes several things:
> >> - add "id" description to -virtfs documentation
> >> - split the description into several lines in both usage and documentation
> >>   for accurateness and clarity
> >> - add documentation and usage of the synth fsdriver
> >> - add "throttling.*" description to -fsdev local
> >> - add some missing periods
> >> - add proper reference to the virtfs-proxy-helper(1) manual page
> >> - document that the virtio device may be either virtio-9p-pci, virtio-9p-ccw
> >>   or virtio-9p-device, depending on the machine type
> >>
> >> Buglink: https://bugs.launchpad.net/qemu/+bug/1581976
> >> Signed-off-by: Greg Kurz <groug@kaod.org>
> >> ---
> >> v2: - mention virtfs-proxy-helper(1) change in the changelog
> >>     - mention virtio-9p-ccw and virtio-9p-device
> >> ---  
> > 
> > Thomas,
> > 
> > Unless you (or anyone else) have some objections, I intend to apply this patch
> > and issue a pull request in a near future.  
> 
> Fine for me - I just lack the detailed 9p knowledge to provide a real
> "Reviewed-by" here, I hope you were not waiting for it?

Heh, no pb, I wasn't expecting a detailed review.

> ... but if it
> helps, I can at least say:
> 
> Acked-by: Thomas Huth <thuth@redhat.com>

Works for me :)

Thanks Thomas !

--
Greg

