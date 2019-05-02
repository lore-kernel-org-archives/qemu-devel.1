Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3271C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 11:17:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A42482085A
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 11:17:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A42482085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49331 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM9iG-0003a5-Mp
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 07:17:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hM9hB-0003Dm-3h
	for qemu-devel@nongnu.org; Thu, 02 May 2019 07:16:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hM9hA-0004xP-8s
	for qemu-devel@nongnu.org; Thu, 02 May 2019 07:16:09 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:39860)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hM9h9-0004wo-E2
	for qemu-devel@nongnu.org; Thu, 02 May 2019 07:16:07 -0400
Received: by mail-wr1-f48.google.com with SMTP id a9so2776193wrp.6
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 04:16:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=Q8L9zvdDabkWGgeIvbfIdJLGIrgZkCgFgyJ/KDuNIJE=;
	b=jRIAIvURVVUKwFsVQnl35O0gIvSn70PN6VY1EWEDMZycudZAPX5+VJmkCiy4FqwCEM
	6/5xTmyGgLWoscRL3EdjBQvU2jYFAqQTPpMLwS1xnJuONO6wbjx22JzWNcD+D1Xe6EEs
	yYe/3ad9Xmph2+BBFuozbf2aGFnfOzbFo4vew1HtHQuTaPiS9Nm4a+Q81F0DQuoYDb5V
	X0hr8swAwNYU8yytQSRSdrxMbsSVqTY/90eO6rTPYWGBn4dIUBOk9hzmCYVmHwLZ5Mbp
	gAAoy5heaYutYxkGUQDn8Ka5OKRXHZdCJGgt4nqHzD5wiaM3UVw+7h8UySFp/0Qk3eEg
	6ELw==
X-Gm-Message-State: APjAAAXEKt9K0z6BamQCG8QmafW4DTnwMcHLrs0PJC6691FpPMLHxZ83
	JO1WXlbKxtH8MUVKJ/my3fw3QQ==
X-Google-Smtp-Source: APXvYqwdyETTxiiz2cMouTmRpF+ACFTgy0NDZ/0ybA1PqrZdwkRGjjlGsGsZ8J3DK6CzvEvCQUTseg==
X-Received: by 2002:a5d:4805:: with SMTP id l5mr2422466wrq.279.1556795766202; 
	Thu, 02 May 2019 04:16:06 -0700 (PDT)
Received: from steredhat (host103-125-dynamic.46-79-r.retail.telecomitalia.it.
	[79.46.125.103])
	by smtp.gmail.com with ESMTPSA id r2sm9129620wmh.31.2019.05.02.04.16.04
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 04:16:05 -0700 (PDT)
Date: Thu, 2 May 2019 13:16:03 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190502111603.wwf2lpymrhx76x6g@steredhat>
References: <20190501134127.21104-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190501134127.21104-1-thuth@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.48
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] tests/qemu-iotests: Fix more
 reference output files due to recent qemu-io change
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
Message-ID: <20190502111603.oQOuwFotjAG73VwPwaHjhJAg706kpsdOrZx0q2aGAl4@z>

On Wed, May 01, 2019 at 03:41:27PM +0200, Thomas Huth wrote:
> The output of qemu-io changed recently - most tests have been fixed in
> commit 36b9986b08787019ef42 ("tests/qemu-iotests: Fix output of qemu-io
> related tests") already, but the qcow1 and the vmdk test was still missing.
> 
> Fixes: 99e98d7c9fc1a1639fad ("qemu-io: Use error_[gs]et_progname()")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/qemu-iotests/059.out |  8 ++++----
>  tests/qemu-iotests/092.out | 24 ++++++++++++------------
>  2 files changed, 16 insertions(+), 16 deletions(-)
> 

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Tested-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

