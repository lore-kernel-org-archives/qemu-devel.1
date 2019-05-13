Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E98C04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 13:22:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62DAC2147A
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 13:22:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62DAC2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57354 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQAtz-0002yg-EB
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 09:21:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hQAmz-0005cF-QF
	for qemu-devel@nongnu.org; Mon, 13 May 2019 09:14:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hQAmy-0004r8-S8
	for qemu-devel@nongnu.org; Mon, 13 May 2019 09:14:45 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:46479)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hQAmy-0004qV-Lo
	for qemu-devel@nongnu.org; Mon, 13 May 2019 09:14:44 -0400
Received: by mail-wr1-f49.google.com with SMTP id r7so14591676wrr.13
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 06:14:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=axH69f6xpSrQqDAMq3iIBe29wy2JrYNfYmwLzkbZPO4=;
	b=BARQlpLHiT4DW3AnFXeEqv7Z1uvSKxRZBYp80S7d90KazcOjA8xzLpcsdVXMrcW4jV
	4NiKTvEYERHeLO+sYGNsEy8iDNXKNw8kpTM273Q71/t9/RKFahJZbqxq5d5HAD3gCd31
	87qxRiW67EkSmjUUr7vxRQml06WMiblBeQGNti0Sy/04yHpXCNe4ecy6KCjz4uVqt1BC
	bTjZHdUcKWwSR7oBUhSz/YgZHqe9iDyuzmg8ccTMgKdkdQN7NLB+92cDkedK5/ODNigG
	nlymbaEKxASixu9sl2iNvFzgFaSQWHJYFQoLdCpzbKikL3nDQv153OsZ+gpMnt1bmPwG
	dfXA==
X-Gm-Message-State: APjAAAWqaRZQ8uHAAsiJT0MlVelLgdnJfiRyAsVRFNLno9qRxWNPteDb
	QsAU++WAsrqzu7Iqlc1lxpklQA==
X-Google-Smtp-Source: APXvYqz0naggVvHM4SJCReb5/VzA9TwQzI3XQM0gEFiJKnWb9fhSeGhW6I/6kUia/uH17O6xZDDEVg==
X-Received: by 2002:adf:eb84:: with SMTP id t4mr15114226wrn.43.1557753283489; 
	Mon, 13 May 2019 06:14:43 -0700 (PDT)
Received: from steredhat (host151-251-static.12-87-b.business.telecomitalia.it.
	[87.12.251.151]) by smtp.gmail.com with ESMTPSA id
	91sm25709100wrs.43.2019.05.13.06.14.42
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 13 May 2019 06:14:42 -0700 (PDT)
Date: Mon, 13 May 2019 15:14:40 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Alberto Garcia <berto@igalia.com>
Message-ID: <20190513131440.kdtj6jchn3uo6ihq@steredhat>
References: <20190510162254.8152-1-berto@igalia.com>
	<20190513112846.ggnhopjwbopfexum@steredhat>
	<w51d0km7eyc.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w51d0km7eyc.fsf@maestria.local.igalia.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.49
Subject: Re: [Qemu-devel] [PATCH] qcow2: Define and use
 QCOW2_COMPRESSED_SECTOR_SIZE
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 13, 2019 at 01:48:27PM +0200, Alberto Garcia wrote:
> On Mon 13 May 2019 01:28:46 PM CEST, Stefano Garzarella wrote:
> >> +            int size = QCOW2_COMPRESSED_SECTOR_SIZE *
> >> +                (((l2_entry >> s->csize_shift) & s->csize_mask) + 1);
> >
> > What about using int64_t type for the 'size' variable?
> > (because the qcow2_free_clusters() 'size' parameter is int64_t)
> 
> The maximum size that can be read from a compressed cluster descriptor
> using the formula above is twice the cluster size (more information on
> commit abd3622cc03cf41ed542126a540385f30a4c0175 and on the Compressed
> Clusters Descriptor spec in docs/interop/qcow2.txt).
> 
> Since the maximum allowed cluster size is 2MB, the value of the 'size'
> variable can never be larger than 4MB, which fits comfortably on a
> 32-bit integer. We would need to support 512MB clusters in order to have
> problems with this.

Thanks for the explaination and sorry for that!

Cheers,
Stefano

