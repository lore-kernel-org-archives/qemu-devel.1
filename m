Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2D9C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 14:24:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89270218A4
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 14:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LkqPNEe1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89270218A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1higB2-0000mX-B7
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 10:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54035)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <amit@infradead.org>) id 1higAJ-0000Io-Ky
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 10:23:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amit@infradead.org>) id 1higAI-0002DP-Gg
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 10:23:19 -0400
Received: from bombadil.infradead.org ([2607:7c80:54:e::133]:58686)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amit@infradead.org>) id 1higAH-000261-W2
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 10:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 Mime-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DLRsy0e7FeHOVBR24/L+eBGecxu82QeEzgYKwRbd4n0=; b=LkqPNEe1Zhi7ux63UCfykAGB3
 bAlpvqG1fZhDi/CNqmBvAnzGES1LG9JVkeD+ALzGraRvLzh2rAB9OwM87zbdmEBkeJyOEgJw190J9
 W1QQn8eSOOkDul0+FqBQh7roSqoZsN52B8joqujQkzP+SHtt9IOfwyuYR54E9kJSEoXdvgU6dz14l
 TJ1DEM1ViBScHPyO7PNIUFD7ViQwZ0buBiUynVb9rv6qBSN2Q5FRCm2m5xtDajDQOePH4Lxltk3gl
 gKtO72iUIgs2hS2ojsyvPC7v3Ngj+tgxn1SDD1xRLsG2RdkrSCLmV3X6EnL21dRiwvK0SHne5nJNu
 skRujJ8gg==;
Received: from [54.239.6.185] (helo=u9312026164465a.ant.amazon.com)
 by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
 id 1higA5-00084w-G5; Wed, 03 Jul 2019 14:23:05 +0000
Message-ID: <8f76716c60febb890da7956bce02c4ece6c2db25.camel@infradead.org>
From: Amit Shah <amit@infradead.org>
To: Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Date: Wed, 03 Jul 2019 16:23:02 +0200
In-Reply-To: <af659b81-25ef-afc3-3e16-7fd8183fd2ef@redhat.com>
References: <20190529143106.11789-1-lvivier@redhat.com>
 <20190702092133-mutt-send-email-mst@kernel.org>
 <af659b81-25ef-afc3-3e16-7fd8183fd2ef@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:7c80:54:e::133
Subject: Re: [Qemu-devel] [PATCH v7 0/4] rng-builtin: add an RNG backend
 that uses qemu_guest_getrandom()
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
Cc: "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org,
 Amit Shah <amit@kernel.org>, Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, "Richard W .
 M . Jones" <rjones@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2019-07-02 at 18:48 +0200, Laurent Vivier wrote:
> On 02/07/2019 15:21, Michael S. Tsirkin wrote:
> > On Wed, May 29, 2019 at 04:31:02PM +0200, Laurent Vivier wrote:
> > > Add a new RNG backend using QEMU builtin getrandom function.
> > > 
> > > v7: rebase on master
> > >     Make rng-builtin asynchronous with QEMUBH (removed existing
> > > R-b)
> > > 
> > > v6: remove "sysemu/rng-random.h" from virtio-rng.c
> > >     rebase on qemu_getrandom v8
> > > 
> > > v5: PATCH 1 s/linux/Linux/
> > >     remove superfluous includes from rng-builtin.c
> > >     don't update rng-random documentation
> > >     add a patch from Markus to keep the default backend out of
> > > VirtIORNGConf
> > >     move TYPE_RNG_BUILTIN to sysemu/rng.h and remove sysemu/rng-
> > > builtin.h
> > > 
> > > v4: update PATCH 1 commit message
> > > 
> > > v3: Include Kashyap's patch in the series
> > >     Add a patch to change virtio-rng default backend to rng-
> > > builtin
> > > 
> > > v2: Update qemu-options.hx
> > >     describe the new backend and specify virtio-rng uses the
> > >     rng-random by default
> > 
> > 
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > feel free to merge.
> 
> Thank you Michael.
> 
> I've already included PATCH 1 in a pull-request for trivial patches
> branch.
> 
> I'm not sure the other patches are good candidates for trivial
> patches
> branch, but is there any other maintainer that can include them in a
> pull request (before the freeze)?
> 
> Amit?
> [Do you want I manage a virtio-rng pull-request for you?]

Hello Laurent,

Apologies as I haven't been around for a bit.

I don't mind you doing the pull req yourself if you have sufficient
reviews.  Do you also want to consider maintaining rng yourself?

Thanks,



