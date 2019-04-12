Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDEDC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 08:03:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81DF1205ED
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 08:03:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81DF1205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60528 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hErA5-0003ui-OO
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 04:03:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hEr9I-0003az-4q
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 04:03:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hEr9H-0007JW-9F
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 04:03:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44592)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hEr9G-0007JH-W7
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 04:02:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id y7so10669973wrn.11
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 01:02:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=Ol063zkClsRq7gcbncBPs9hkhUXZuN5mxUII7ShSebw=;
	b=P4rt3nM8B3j9+dgp1hjxjxwlaQEEQUC4JV5EvYuKf2azEib6m4C6SndUIOMfBe2VzM
	pCUZMdVQnIeEyYTQid2acBvxqBGmfonT3dpsCKxvZxtpupzWHfDRIu9Q7N3XfEPwquL7
	Y24To4ESXYXqsqwTN/W8SD6D9HONmYqveScZlr+0m56RDLDKpfT6mQFn+lQj3ROG9WW0
	NVdARaZoE18VofmmR5o0klZSmyNLDcduqvlLWD+uYMX374VgclVgZoixAiFXbES+5Tal
	sht2tM9kS61HBPMEf7T5UEIPEmR660KsoXl6w+7ioV3ESeIDMJjmhhvT1jB7JbXiQfHU
	HShg==
X-Gm-Message-State: APjAAAUyhTLMYMQfD/hNB4VKCLI6q7556gX1GUvu69nuFEzDqYmySWnO
	lduAsP1WPOOM/1WoAjZlV3+sQQ==
X-Google-Smtp-Source: APXvYqwIVmb2fAfOKPyP8VCc7Xe0xxwHCOm1Z9hXyb2CfSzIyTW8x2a7dnblGrhyRQeKUw3Trh8ddQ==
X-Received: by 2002:adf:eb0b:: with SMTP id s11mr9260019wrn.140.1555056177980; 
	Fri, 12 Apr 2019 01:02:57 -0700 (PDT)
Received: from steredhat (host35-203-static.12-87-b.business.telecomitalia.it.
	[87.12.203.35]) by smtp.gmail.com with ESMTPSA id
	t24sm10667840wmi.10.2019.04.12.01.02.56
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 12 Apr 2019 01:02:57 -0700 (PDT)
Date: Fri, 12 Apr 2019 10:02:49 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190412080249.x2b6utfnqh255msd@steredhat>
References: <1554982098-336210-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <1554982098-336210-1-git-send-email-imammedo@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH for-4.1] roms: assert if max rom size is
 less than the used size
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
Cc: peter.maydell@linaro.org, mst@redhat.com, richard.henderson@linaro.org,
	qemu-devel@nongnu.org, stefanha@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412080249.nQK8qDMFdWT9yx78EquPjznJAQxEebdOzkMyGcDqsvk@z>

On Thu, Apr 11, 2019 at 01:28:18PM +0200, Igor Mammedov wrote:
> It would ensure that we would notice attempt to write beyond
> the allocated buffer. In case of MemoryRegion backed ROM it's
> the host buffer and the guest RAM otherwise.
> 
> assert can be triggered with:
>   dd if=/dev/zero of=/tmp/blob bs=63k count=1
>   qemu-system-x86_64 `for  i in {1..33}; do echo -n " -acpitable /tmp/blob"; done`
> 
> Fixes: (a1666142db acpi-build: make ROMs RAM blocks resizeable)
> 
> Reported-by: Wei Yang <richardw.yang@linux.intel.com>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/core/loader.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Tested-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

