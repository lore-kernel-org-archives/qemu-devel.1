Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C34EC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 15:36:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 300B920684
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 15:36:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 300B920684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34074 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYuRf-0005Jr-Dr
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 11:36:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hYuQt-0004kt-ML
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 11:36:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hYuQp-0001EZ-Tw
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 11:36:02 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55624)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hYuQo-0000b9-Gg
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 11:35:59 -0400
Received: by mail-wm1-f65.google.com with SMTP id a15so384570wmj.5
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 08:35:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=hzc9jZrGya0V8LSsvih2SNqr+Vy0Rp7vyju8HrIrIZg=;
	b=ZQRvq5iKGv4R8jDoKziKeIOoKNuaSlq3DB/KoTrZ2pl52TH+cnfaOZ6qTE1X5Lh+/7
	knwA/9XTsabQBupWVXFO7SQ1xRoyl7ku3Jbvv/zCPRFe+ANOPw5W8344IBprtCa/EEUy
	kyL7cbOq6D52iv9mzr/gFXJ5itGcVz1YLS93bDgOZm6nEG+0cxrqFn4P/S9dGOXvQtuC
	Q8W0qkuZDEApMtP/0lgQr2owDbYC3z+8kfmr6B54hrftw7U+IhMXaevANNPX65rgdWqz
	0LgFyAZYEW8LGsou6VzneDDpNWrw7LWaiEPRECJ4F+RBEUecxInLN0i1S9MTtPUSS1Ah
	j0GA==
X-Gm-Message-State: APjAAAVMD6+ZRTExVIzYGTK4/XRNFBmkEmLpZtxdSS4trj9LOTHcUo7A
	dr5vr1LDMHHezKc4Y9bbEt78HA==
X-Google-Smtp-Source: APXvYqyCfg1z7yNCkCKvuNuU/SOY4TvJXyEvhV9lx01MMT+nt9CfZ6aiF0GJpWh+pfTJVdXrPjmsmA==
X-Received: by 2002:a1c:a545:: with SMTP id o66mr480914wme.138.1559835343749; 
	Thu, 06 Jun 2019 08:35:43 -0700 (PDT)
Received: from steredhat (host253-229-dynamic.248-95-r.retail.telecomitalia.it.
	[95.248.229.253]) by smtp.gmail.com with ESMTPSA id
	c24sm1992328wmb.21.2019.06.06.08.35.42
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 06 Jun 2019 08:35:43 -0700 (PDT)
Date: Thu, 6 Jun 2019 17:35:40 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <20190606153540.2v5g3kgd7g7ut5kr@steredhat>
References: <20190514121015.32190-1-anton.nefedov@virtuozzo.com>
	<20190603100902.hfk2qo3436kvbevw@steredhat.homenet.telecomitalia.it>
	<08293f58-121e-b26d-70b4-0c564fdbe095@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08293f58-121e-b26d-70b4-0c564fdbe095@virtuozzo.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v7 0/9] discard blockstats
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	Denis Lunev <den@virtuozzo.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"mreitz@redhat.com" <mreitz@redhat.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 04, 2019 at 04:53:23PM +0000, Anton Nefedov wrote:
> On 3/6/2019 1:09 PM, Stefano Garzarella wrote:
> > On Tue, May 14, 2019 at 12:10:40PM +0000, Anton Nefedov wrote:
> >> hi,
> >>
> >> yet another take for this patch series; please kindly consider these for 4.1
> >>
> >> Just a few cosmetic comments were received for v6 so this is mostly
> >> a rebase+ping.
> >>
> >> new in v7:
> >>      - general rebase
> >>      - since clauses -> 4.1
> >>      - patch 8: not completely trivial rebase: raw_account_discard moved to
> >>        common raw_do_pdiscard()
> >>      - patch 9: comment wording fixed
> >>
> >> v6: http://lists.nongnu.org/archive/html/qemu-devel/2018-11/msg06633.html
> >> v5: http://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg06828.html
> >> v4: http://lists.nongnu.org/archive/html/qemu-devel/2018-08/msg04308.html
> >> v3: http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg03688.html
> >>
> > 
> > Hi Anton,
> > since qemu 4.0 added the discard support on virtio-blk, should we consider it
> > in this series?
> > 
> > If you prefer I can work on it and send you the patch.
> > 
> 
> hi Stefano,
> 
> if this series is finally getting in, it is really nice if you can add
> virtio-blk support too.
> 

Sure, I'll do it!

Thanks,
Stefano

