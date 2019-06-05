Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65EA8C282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 07:15:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B19A2083E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 07:15:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B19A2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36691 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYQ8V-0004IA-4C
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 03:15:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hYQ7f-0003zH-Tv
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 03:14:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hYQ7e-0007x8-Ve
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 03:14:11 -0400
Received: from 1.mo69.mail-out.ovh.net ([178.33.251.173]:48648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hYQ7e-0007tA-On
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 03:14:10 -0400
Received: from player794.ha.ovh.net (unknown [10.109.160.244])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id D7D0B5CD05
	for <qemu-devel@nongnu.org>; Wed,  5 Jun 2019 09:14:07 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player794.ha.ovh.net (Postfix) with ESMTPSA id 7D6DC67BC9BC;
	Wed,  5 Jun 2019 07:14:02 +0000 (UTC)
Date: Wed, 5 Jun 2019 09:14:01 +0200
From: Greg Kurz <groug@kaod.org>
To: Yongji Xie <elohimes@gmail.com>
Message-ID: <20190605091401.5177daca@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <CAONzpcZ_Wosy3BUZYDUp8UuEYk_3VSpSP+MQr7QRab8bKJ4-JQ@mail.gmail.com>
References: <20190604073459.15651-1-xieyongji@baidu.com>
	<20190604073459.15651-3-xieyongji@baidu.com>
	<20190605084224.22e4cd92@bahia.lab.toulouse-stg.fr.ibm.com>
	<CAONzpcZ_Wosy3BUZYDUp8UuEYk_3VSpSP+MQr7QRab8bKJ4-JQ@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 7763924283489818925
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudeguddguddukecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.251.173
Subject: Re: [Qemu-devel] [PATCH v2 2/5] virtio: Set "start_on_kick" for
 legacy devices
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
Cc: qemu-devel <qemu-devel@nongnu.org>, Xie Yongji <xieyongji@baidu.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 5 Jun 2019 14:49:34 +0800
Yongji Xie <elohimes@gmail.com> wrote:

> On Wed, 5 Jun 2019 at 14:42, Greg Kurz <groug@kaod.org> wrote:
> >
> > On Tue,  4 Jun 2019 15:34:56 +0800
> > elohimes@gmail.com wrote:
> >  
> > > From: Xie Yongji <xieyongji@baidu.com>
> > >
> > > Besides virtio 1.0 transitional devices, we should also
> > > set "start_on_kick" flag for legacy devices (virtio 0.9).
> > >
> > > Signed-off-by: Xie Yongji <xieyongji@baidu.com>
> > > ---  
> >
> > Patch looks good but it would be even better if applied
> > earlier so that it doesn't revert lines added by the
> > previous patch...
> >  
> 
> Fine with me. Will do it in v3.
> 

Hold on before posting, I've just learned about hw_compat_4_0_1 while
reviewing patch 5... need so more time to understand the impact.

Cheers,

--
Greg

> Thanks,
> Yongji


