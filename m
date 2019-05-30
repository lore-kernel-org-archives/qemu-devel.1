Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECD5C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 18:13:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEB4D25F37
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 18:13:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEB4D25F37
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57549 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWPYA-0002r3-1c
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 14:13:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hWPXO-0002aC-QK
	for qemu-devel@nongnu.org; Thu, 30 May 2019 14:12:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hWPXN-0002cM-SM
	for qemu-devel@nongnu.org; Thu, 30 May 2019 14:12:26 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46490)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hWPXN-0002c6-OK
	for qemu-devel@nongnu.org; Thu, 30 May 2019 14:12:25 -0400
Received: by mail-qk1-f193.google.com with SMTP id a132so4457633qkb.13
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 11:12:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=xsE5ZFwDSg88QFuZuBViizwSd/SZkkH2+lspgcEQMhQ=;
	b=jjw2Ignup9FYuWthP418j6ao6RYj2ovtUdE5Hwuoh3ny3GBtTnE47WfLfcWp33/PAC
	G5k4+4dztuhA3NidnfupsrDy4mGGAAqxQctQjrk8qlEkf3m3gZ1LvaoCcCsBH2eCku2/
	IP8LNp9wnKic080+lPW2zNo1D60LWEHHKySZbEmpCpebBTcEJl4yz82VTUq+2aj2semH
	Duhi4bTTBJTwkBG4zpcAiuSCBO1gUMVKzntD+s80ILHC8PFRjsGpESFFlWq+s3+Q4R8U
	4f1XS1Vl2Srt06A1ZSQpFwZgz8GkxmxrFKClCAlvnC96xTRrCZW8OJNkFsYm7RjMryvW
	aEWg==
X-Gm-Message-State: APjAAAXMRDRO/PK+IhiyQcx9a1kcXnopxh/3weCobwg0C/CqIENerAv4
	xA/QHli0EwNhIUCbZe6WM977+A==
X-Google-Smtp-Source: APXvYqyZDjFCJ4VMpISW5WmJfhhlEUHYZ53ilHlAfjQrBpU/FyjecHY36oQiPs81gLo4B64gCtkMtA==
X-Received: by 2002:a37:9904:: with SMTP id b4mr4381874qke.159.1559239945243; 
	Thu, 30 May 2019 11:12:25 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103]) by smtp.gmail.com with ESMTPSA id
	n124sm1873059qkf.31.2019.05.30.11.12.23
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 30 May 2019 11:12:24 -0700 (PDT)
Date: Thu, 30 May 2019 14:12:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Message-ID: <20190530141112-mutt-send-email-mst@kernel.org>
References: <20190517125820.2885-1-jfreimann@redhat.com>
	<20190520165657.2293c5d7@x1.home>
	<20190521072157.wpb77wlc5mhfcdes@jenstp.localdomain>
	<20190521073511-mutt-send-email-mst@kernel.org>
	<20190521184918.n4nnk6ack3ssp6jv@jenstp.localdomain>
	<20190528223900-mutt-send-email-mst@kernel.org>
	<20190529074802.2cofzjkudfuilbej@jenstp.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529074802.2cofzjkudfuilbej@jenstp.localdomain>
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
	Alex Williamson <alex.williamson@redhat.com>, laine@redhat.com,
	ailan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 29, 2019 at 09:48:02AM +0200, Jens Freimann wrote:
> On Tue, May 28, 2019 at 10:40:42PM -0400, Michael S. Tsirkin wrote:
> > On Tue, May 21, 2019 at 08:49:18PM +0200, Jens Freimann wrote:
> > > On Tue, May 21, 2019 at 07:37:19AM -0400, Michael S. Tsirkin wrote:
> > > > On Tue, May 21, 2019 at 09:21:57AM +0200, Jens Freimann wrote:
> > > > Actually is there a list of devices for which this has been tested
> > > > besides mlx5? I think someone said some old intel cards
> > > > don't support this well, we might need to blacklist these ...
> > > 
> > > So far I've tested mlx5 and XL710 which both worked, but I'm
> > > working on testing with more devices. But of course help with testing
> > > is greatly appreciated.
> > 
> > A testing tool that people can run to get a pass/fail
> > result would be needed for that.
> > Do you have something like this?
> 
> I have two simple tools. One that sends packets and another one that
> sniffs for packets to see which device the packet goes to. Find it at
> https://github.com/jensfr/netfailover_driver_detect
> 
> Feedback and/or patches welcome.
> 
> regards,
> Jens

The docs say:
 ./is_legacy -d . If is_legacy returns 0 it means it has received the packets sent by send_packet. If it returns 1 it didn't receive the packet. Now run ./is_legacy -d 


So -d twice. What is the difference?

-- 
MST

