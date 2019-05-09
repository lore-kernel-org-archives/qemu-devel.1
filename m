Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3FEC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 14:09:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE57721479
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 14:09:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE57721479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55163 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOjjy-00084I-HL
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 10:09:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hOjjA-0007Mu-Qx
	for qemu-devel@nongnu.org; Thu, 09 May 2019 10:08:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hOjj5-0008Dn-RY
	for qemu-devel@nongnu.org; Thu, 09 May 2019 10:08:52 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42397)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hOjj3-0008CY-PV
	for qemu-devel@nongnu.org; Thu, 09 May 2019 10:08:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id l2so3239748wrb.9
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 07:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=oCgS1eH188Q5DGWyoi9EZ3m3kTi0+OF0meINDLHBpTc=;
	b=JOi9pX8OogwXGn9pffDooeFawkKZ+7XvAa++57z2YGucOrVy5Vj2UuPcy7HO83NlQv
	TFdkhHgzydlfrxuDpHQcX42wq5wcBBV+tlC4PSnYpndCRHV3XKLBPZ++K87aR9VrlX2o
	ogEcqr4hBjQ2dTz4m84YIYHPjfnczCXUrwTlwrhz6rAlN+ldcMych7LQnWAjvPC8VdFJ
	AnIO1XBhtHjVC+XynP2B1yzwTsvLBWq1ERrFLk0yu7FH5b/1AjYgKCc+IQ2E4NxIkHOX
	DGcO95Z17aK+SvVYbHR4ObTShvAxcrxTYJf9zkGxnwO8batkiVkUI2x8PdF1B8pkVERs
	80EA==
X-Gm-Message-State: APjAAAXoyx8ePYLfAcfXM1FYaNuHB0QTcQg4uNMrKwxYgDmF6uQcFg0w
	AUgTDMkNU2P/beqK21aHBDYF3g==
X-Google-Smtp-Source: APXvYqx4RJTB3Tuj/ipNQMGsAOU+ZEe4/1z67vMK7T6BUqA53Zjjphs6hOuJ7npOkWKCy/GkA7cl+g==
X-Received: by 2002:a5d:4704:: with SMTP id y4mr3191860wrq.86.1557410923162;
	Thu, 09 May 2019 07:08:43 -0700 (PDT)
Received: from steredhat (host151-251-static.12-87-b.business.telecomitalia.it.
	[87.12.251.151]) by smtp.gmail.com with ESMTPSA id
	v23sm1427455wmj.43.2019.05.09.07.08.42
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 09 May 2019 07:08:42 -0700 (PDT)
Date: Thu, 9 May 2019 16:08:40 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: sathnaga@linux.vnet.ibm.com
Message-ID: <20190509140840.oawbvmouw3x2wdok@steredhat>
References: <20190509080750.21999-1-sathnaga@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509080750.21999-1-sathnaga@linux.vnet.ibm.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH] Fix typo on "info pic" monitor cmd output
 for xive
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
Cc: qemu-trivial@nongnu.org, david@gibson.dropbear.id.au, qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 09, 2019 at 01:37:50PM +0530, sathnaga@linux.vnet.ibm.com wrote:
> From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> 
> Instead of LISN i.e "Logical Interrupt Source Number" as per
> Xive PAPR document "info pic" prints as LSIN, let's fix it.
> 
> Signed-off-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> ---
>  hw/intc/spapr_xive.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

CCing qemu-trivial

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

