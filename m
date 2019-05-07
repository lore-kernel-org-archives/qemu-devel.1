Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DDDC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 07:54:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F8A92087F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 07:54:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F8A92087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41683 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNuw9-0006z0-0x
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 03:54:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hNuvJ-0006fb-9f
	for qemu-devel@nongnu.org; Tue, 07 May 2019 03:54:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hNuvI-0005L3-By
	for qemu-devel@nongnu.org; Tue, 07 May 2019 03:54:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46830)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hNuvI-0005JZ-6C
	for qemu-devel@nongnu.org; Tue, 07 May 2019 03:54:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id r7so20817344wrr.13
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 00:53:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=RSp/vd4XagA8thCOm24BZxRakRFLppOAy0uMIGlBs8Y=;
	b=pCgj3LjyJzaL1a54CvSWM3oWdxg9ImrD21aeaUUh6QhyyhEpq5n5irSLORdpx1H6Qc
	0l1C4e4P6JqxaBsnG+KweYlP9LnfaISk3bGWVMrO7zjzYKUFykm0HFj70WLVcxrwnXP3
	+IudHeuxLx2gCQCpIP4W4HdJYZRyaHGetglU8Gr308tckaJD3/KOBwtUtYCT7JHBKnqk
	wizhchTTwoeOJqwMRCaYWU6xFeU8RdjWK6ijIAkZzKlaeJa91psXk/xkROUr9poDMl66
	cDu25yZ+fbiXZYgD0Iab5miK5p5jiHnfE9xE3ogdA9UDxAMtrigRflNe6BLI5veyVgX4
	WHGQ==
X-Gm-Message-State: APjAAAXI0igpY4MqgdKZUqq9Po9ioKgME6qkRXKjQH1ZRF3gFBEnXg3w
	0pyhj7Q73YX2OOnZ/MifN8+UGQ==
X-Google-Smtp-Source: APXvYqwKpjVT/3dJDraIxWDR51NOqWtdtzgs05VrGoKpWIP1SOVkkBIwQasZBANn8WMtO0ZvrmmNAA==
X-Received: by 2002:adf:f7d0:: with SMTP id a16mr20794008wrq.211.1557215638030;
	Tue, 07 May 2019 00:53:58 -0700 (PDT)
Received: from steredhat.homenet.telecomitalia.it
	(host103-125-dynamic.46-79-r.retail.telecomitalia.it.
	[79.46.125.103])
	by smtp.gmail.com with ESMTPSA id u70sm910014wmu.22.2019.05.07.00.53.56
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 07 May 2019 00:53:57 -0700 (PDT)
Date: Tue, 7 May 2019 09:53:55 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190507075355.ly4r7jy32k6lmh6k@steredhat.homenet.telecomitalia.it>
References: <20190503170631.228487-1-sgarzare@redhat.com>
	<e6457a03-58a4-03aa-efb0-55c84cb674d2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6457a03-58a4-03aa-efb0-55c84cb674d2@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH] net: avoid to use variable length array in
 net_client_init()
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 06, 2019 at 12:54:20PM -0500, Eric Blake wrote:
> On 5/3/19 12:06 PM, Stefano Garzarella wrote:
> > net_client_init() uses a variable length array to store the prefix
> > of 'ipv6-net' parameter (e.g. if ipv6-net=fec0::0/64, the prefix
> > is 'fec0::0').
> > Since the IPv6 prefix can be at most as long as an IPv6 address,
> > we can use an array with fixed size equals to INET6_ADDRSTRLEN.
> 
> In addition to Markus' comments, on the subject line:
> 
> s/avoid to use/avoid using/
> 

Thanks, I'll change it!

Stefano

