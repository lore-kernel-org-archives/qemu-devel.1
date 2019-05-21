Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32785C072B5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 21:44:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07286217F9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 21:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07286217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59862 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTCYI-0005If-Qb
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 17:44:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hTCXU-00051l-DL
	for qemu-devel@nongnu.org; Tue, 21 May 2019 17:43:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hTCXT-0005fD-Gh
	for qemu-devel@nongnu.org; Tue, 21 May 2019 17:43:16 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34195)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hTCXT-0005eh-D2
	for qemu-devel@nongnu.org; Tue, 21 May 2019 17:43:15 -0400
Received: by mail-qk1-f194.google.com with SMTP id t64so1782qkh.1
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 14:43:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=CyZNNpYAFhZG6Z8oCZ8Jm0jNAC13DG5ilL1NzYGBJWE=;
	b=EKbENdjBPhhZTNqXPwzn4KhZDToPjJAK9Y+nRHi21Fl5+D6nv8Hx/rosYgcDsSoIfO
	R25KbFsoLMnTwES73B3SgAM14U8iMLZALQ2WwHk6at1Dtm8mGwnwjJAzDb1kaBE1I4QH
	/n4EcBr7mHcMHQJSPqBNutiD+cBu3zWUPLm0mU/Byfcic5bjDAJfFDRVmnuOw6TSjR9k
	grEscSGssCTXnKzaHEbG92PeKZjoLE+3C0fUc35fOLyPpriyaOVd22vYmVEobLsWLdns
	BJPmMFtD9Ve5wZu0sl0fGubsR+HkO/atkniKhyWnN0Dnb0ZNbcWYQ4yeYyRXKgJ6ghbg
	H9jw==
X-Gm-Message-State: APjAAAXoNnPhURBlUEVcE33LmhfPNJQ0v+lNWW3AbHiywGWYkqoN1rG9
	xWFFE+JFZ4hLN+ZC6YgF16sZZQ==
X-Google-Smtp-Source: APXvYqyyWtB3vghRkfwRtWmY6wq264QCBM20NKHPTWaxQoVAm26gppLo28xfxMPXk2G2S61GtFpuyg==
X-Received: by 2002:a05:620a:13c9:: with SMTP id
	g9mr63300624qkl.307.1558474993600; 
	Tue, 21 May 2019 14:43:13 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71]) by smtp.gmail.com with ESMTPSA id
	o13sm12018533qtk.74.2019.05.21.14.43.11
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Tue, 21 May 2019 14:43:12 -0700 (PDT)
Date: Tue, 21 May 2019 17:43:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Message-ID: <20190521174212-mutt-send-email-mst@kernel.org>
References: <20190517125820.2885-1-jfreimann@redhat.com>
	<20190521060725-mutt-send-email-mst@kernel.org>
	<20190521191754.pucxooeeema2hudu@jenstp.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521191754.pucxooeeema2hudu@jenstp.localdomain>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.222.194
Subject: Re: [Qemu-devel] [PATCH 0/4] add failover feature for assigned
 network devices
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
Cc: pkrempa@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
	aadam@redhat.com, qemu-devel@nongnu.org, laine@redhat.com, ailan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 21, 2019 at 09:17:54PM +0200, Jens Freimann wrote:
> On Tue, May 21, 2019 at 06:10:19AM -0400, Michael S. Tsirkin wrote:
> > On Fri, May 17, 2019 at 02:58:16PM +0200, Jens Freimann wrote:
> > > I'm grateful for any remarks or ideas!
> > > 
> > > Thanks!
> > 
> > Hi Jens!
> > Overall I like the patches. Thanks!
> > 
> > Could you please tell us a bit more about other hardware: does this work
> > more or less universally across vendors? were any other cards tested?
> 
> Thank you, I have tested only Mellanox and XL710 so far but am working
> on testing with more nics at the moment. I think there's a few more
> things to work out with the patches (especially the unplug before
> migration) which should give me a bit more time to test other cards.
> 
> Also I haven't yet tested unplug with surprise removal. My understanding
> is that device_del was switched from using surprise removal to
> attention button etc. a while back.

it never used surprise removal

> So I'll have to find out first how
> to try removing a card with surprise removal in qemu.
> 
> regards,
> Jens

i would not do this at this stage yet. lots of work needed to
make linux not crash

-- 
MST

