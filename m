Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950EDC04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 18:17:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70A7827134
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 18:17:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70A7827134
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39068 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXrWI-0000L9-I4
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 14:17:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hXrRt-00058O-Io
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:12:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hXrRs-00009r-FZ
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:12:45 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45643)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hXrRs-00008d-An
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:12:44 -0400
Received: by mail-qk1-f193.google.com with SMTP id s22so1025806qkj.12
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 11:12:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=0pw6MZAMWtuA3pyD/FdS3ul+2ngVJ2pjV9pwSa8Ik8U=;
	b=kycW0/f5MJ8Gul59tIgWasv/GV90yeVo8WFqiBeLHM7q0Q183NI66HPTH58IaJ2W6j
	LrsjNXAsBA/ByHqe8bOiFPp+vHM2n6dyw0ItUSazqiPgsyI7co91n24mid0NjjI0Jrzu
	Z8FF8Mb2LUVFuUmL2rgeWYvpgrgmA/IXl4nuJGGP0CbmupDiEOV8wIdHw3FQY6ZEeo2y
	bXzuy7Y9M6O2f2RCtOiJ7tO0qFea59ehhfG83vch56dM74pU/Jozmh0oxZ8T8ZBaD3aM
	x2wDf4pH71tRFna2qHx9/InJ4S3RqeDmBBjClfrJMXJZHdwiZ7EFkxwufZq2vg1E/vlw
	NMtg==
X-Gm-Message-State: APjAAAU82mo3+uIKQM9q+FpXamZSSeR3cK9oyOHS3RJYCFJAsgvzYVu7
	jPee0CbJaTxeXp+i20llnNconA==
X-Google-Smtp-Source: APXvYqw1XZ7HGg08iTVC1IOhqaxZwC44a55HrPYgnFbWbIquSfu3pHOBCtrcvlEBfmu0ej4mSj3zqQ==
X-Received: by 2002:a37:4d56:: with SMTP id a83mr3938108qkb.62.1559585563534; 
	Mon, 03 Jun 2019 11:12:43 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103]) by smtp.gmail.com with ESMTPSA id
	r186sm6690925qkb.9.2019.06.03.11.12.41
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 03 Jun 2019 11:12:42 -0700 (PDT)
Date: Mon, 3 Jun 2019 14:12:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laine Stump <laine@redhat.com>
Message-ID: <20190603140832-mutt-send-email-mst@kernel.org>
References: <20190517125820.2885-1-jfreimann@redhat.com>
	<20190520165657.2293c5d7@x1.home>
	<20190521072157.wpb77wlc5mhfcdes@jenstp.localdomain>
	<20190521073511-mutt-send-email-mst@kernel.org>
	<20190521184918.n4nnk6ack3ssp6jv@jenstp.localdomain>
	<d116bc65-0715-2c6a-2616-49f67cd685c8@oracle.com>
	<20190528225039-mutt-send-email-mst@kernel.org>
	<1c5f460e-a3b9-56c1-90f7-b3a5c3d0a0d3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c5f460e-a3b9-56c1-90f7-b3a5c3d0a0d3@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.222.193
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
	aadam@redhat.com, qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>,
	si-wei liu <si-wei.liu@oracle.com>,
	Jens Freimann <jfreimann@redhat.com>, ailan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 03, 2019 at 02:06:47PM -0400, Laine Stump wrote:
> On 5/28/19 10:54 PM, Michael S. Tsirkin wrote:
> > On Tue, May 28, 2019 at 05:14:22PM -0700, si-wei liu wrote:
> > > 
> > > 
> > > On 5/21/2019 11:49 AM, Jens Freimann wrote:
> > > > On Tue, May 21, 2019 at 07:37:19AM -0400, Michael S. Tsirkin wrote:
> > > > > On Tue, May 21, 2019 at 09:21:57AM +0200, Jens Freimann wrote:
> > > > > > On Mon, May 20, 2019 at 04:56:57PM -0600, Alex Williamson wrote:
> 
> > > > > Actually is there a list of devices for which this has been tested
> > > > > besides mlx5? I think someone said some old intel cards
> > > > > don't support this well, we might need to blacklist these ...
> > > > 
> > > > So far I've tested mlx5 and XL710 which both worked, but I'm
> > > > working on testing with more devices. But of course help with testing
> > > > is greatly appreciated.
> >>
> > > It won't work on Intel ixgbe and Broadcom bnxt_en, which requires toggling
> > > the state of tap backing the virtio-net in order to release/reprogram MAC
> > > filter. Actually, it's very few NICs that could work with this - even some
> > > works by chance the behavior is undefined. Instead of blacklisting it makes
> > > more sense to whitelist the NIC that supports it - with some new sysfs
> > > attribute claiming the support presumably.
> > > 
> > > -Siwei
> > 
> > I agree for many cards we won't know how they behave until we try.  One
> > can consider this a bug in Linux that cards don't behave in a consistent
> > way.  The best thing to do IMHO would be to write a tool that people can
> > run to test the behaviour.
> 
> Is the "bad behavior" something due to the hardware of the cards, or their
> drivers? If it's the latter, then at least initially having a whitelist
> would be counterproductive, since it would make it difficult for relative
> outsiders to test and report success/failure of various cards.

We can add an "ignore whitelist" flag. Would that address the issue?

> (It's probably just a pipe dream, but it would be nice if it eventually
> could work with old igb cards - I have several of them that I use for SRIOV
> testing, and would rather avoid having to buy new hardware.)

I think it generally can be worked around in the driver.
Most host drivers do get a notification when guest driver
loads/unloads and can use that to manipulate the on-device
switch.

-- 
MST

