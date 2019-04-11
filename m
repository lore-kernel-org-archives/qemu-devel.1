Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF086C10F11
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 01:31:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F67020674
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 01:31:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F67020674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40051 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEOZK-0003sv-LG
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 21:31:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hEOYQ-0003a3-3X
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 21:31:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hEOYP-0007gv-2y
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 21:31:01 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44790)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hEOYO-0007gk-Tv
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 21:31:01 -0400
Received: by mail-qk1-f195.google.com with SMTP id y5so2484433qkc.11
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 18:31:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=kFYzzDCm70A+7FT/vT7bxff2QgQb2SRrM+UAT7566Us=;
	b=W+OMZUjawKU/C7ZCCvzMUlUzdyV24Wu7I0LSAUvKlwoDygaVvsolTHHHgCywPYbx/O
	HffmYjolPtCF4INU/WEK67rbm7/vu4qkxjAQ2D9K+9ibcP/SSil/pghVE7LWgUYsm3rX
	MI3Z9HW843CzFrTcX9wed9K7HyIKS090c5qKhm1SSwato0W4RBT4m44khKvyOl2NDNOB
	TYIOxOUo+8nAhNUKIpjvsWNHoOwXHM81TnT9jBE4Sa9aiN+74Q8NCxXyTb4mMVQFk+fE
	cQS3+TrTeKd8ODnY9+pk1rTqDe2vatKypjKR3GZ5/NN9Bam5UnRvgJzjW/+kNzYfItDG
	xkVw==
X-Gm-Message-State: APjAAAVfpZJPhJmnOVINIZOJs0wBtK1iaCgekEJvZDs5+NoJmdbta2zp
	RrhRr/2DkgHWLbtHWt3HIGxVtQ==
X-Google-Smtp-Source: APXvYqz5wLY0cyBYGKmaR3L0+2iplXTYnK5mbWXN89ZzoMC2NignGs7gm7mStd/c2NwF4k0+gCvUBg==
X-Received: by 2002:a37:9ac3:: with SMTP id
	c186mr35484221qke.117.1554946260089; 
	Wed, 10 Apr 2019 18:31:00 -0700 (PDT)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net.
	[173.76.246.42]) by smtp.gmail.com with ESMTPSA id
	d21sm27933434qtc.91.2019.04.10.18.30.58
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 10 Apr 2019 18:30:58 -0700 (PDT)
Date: Wed, 10 Apr 2019 21:30:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190410213001-mutt-send-email-mst@kernel.org>
References: <20190401111843.54528-1-ybettan@redhat.com>
	<20190409131734.GE16944@stefanha-x1.localdomain>
	<1871f593-ec5b-fede-7da5-a7ae78056249@redhat.com>
	<CAJSP0QVpPGKO_NH2CXpdYtQfLsMF+OjKx2QzjtKJVkOnnoBHdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <CAJSP0QVpPGKO_NH2CXpdYtQfLsMF+OjKx2QzjtKJVkOnnoBHdw@mail.gmail.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.222.195
Subject: Re: [Qemu-devel] [RFC-PATCH] Introducing virtio-example device.
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
Cc: Yoni Bettan <ybettan@redhat.com>, Amnon Ilan <ailan@redhat.com>,
	qemu-devel <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411013056.aB_ieZUEb2MYAG0xVmRV98QXY4CLXW5Oe__rCwKZwik@z>

On Wed, Apr 10, 2019 at 08:15:32PM +0100, Stefan Hajnoczi wrote:
> On Wed, Apr 10, 2019 at 4:45 PM Yoni Bettan <ybettan@redhat.com> wrote:
> > On 4/9/19 4:17 PM, Stefan Hajnoczi wrote:
> > > On Mon, Apr 01, 2019 at 02:18:43PM +0300, Yoni Bettan wrote:
> > The final purpose is to have:
> >
> > 1. device specification
> >
> > 2. device implementation
> >
> > 3. device driver
> >
> > 4. blog
> >
> > maybe I should have written it at the beginning, this is not the entire
> > project but it is its start.
> 
> The way I'd design VIRTIO devices without prior knowledge is:
> 
> 1. Learn the VIRTIO device model.  Understand the concepts in VIRTIO.
> <-- this is hard today, there's not much good documentation

Best doc is still probably Rusty's whitepaper. It only covers 0.X
spec so somewhat outdated but it does explain the concepts I think.

> 2. Design an initial version of the device spec.  Mostly configuration
> layout, virtqueues, and request structs.  Not much text is necessary
> at this point, but it's critical for thinking through features before
> implementation.
> 
> 3. Implement guest driver and device emulation.
> 
> 4. Iterate on spec and implementation until it's functionally complete.
> 
> 5. Submit the spec to the VIRTIO Technical Committee.
> 
> 6. Submit driver and device emulation patches.  They can be merged
> when the spec is approved/close to approved.
> 
> Are you jumping to #3?  This is likely to lead to poor quality
> implementations and specs because the fundamental VIRTIO concepts
> weren't understood.
> 
> If the point is to educate others and/or do it "the right way", then I
> would really avoid hacking around without first doing the other steps.
> 
> Stefan

