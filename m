Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCAFC10F0B
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 08:11:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3E9420693
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 08:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3E9420693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37767 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH28x-0004Jt-0d
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 04:11:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hH26Y-0002o3-Jz
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 04:09:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hH26X-0007bA-IF
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 04:09:10 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40644)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hH26X-0007am-9A
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 04:09:09 -0400
Received: by mail-wm1-f65.google.com with SMTP id z24so1749911wmi.5
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 01:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=QkTtdyGJ4gKkfDMAPxF2VHmM/8vf/U2IwgO+lF2bjW4=;
	b=pQTzxX2fIMdxd8sUycuuNm2Gcvzm1clXYM8lN0WeMbyZDFOqeIl5RRlt4gWXGy4c8g
	kOEp4XHRbqH3KvRy/psAkeW7EUKZT1bn3PwiM4uPfAletXsOaM3DINqfNRPuBVqBVqBe
	dOlhevHoBV3lCosEmrI5uc2F9ZaMeH4whwd18Jfp8SkL8cplcn+DoQJCthsbdghB0NLm
	ZyxXGjtobNB1O9a+6zxh/Q8dZlVvl3YI79yUDslzd+28s8piQ/+vHYNbUVAv7F+t5DpU
	ZUkD0oPI/feN00o/WXQILhDUcoXkpvsehArEcLXv/+iAte6AL9Al1D3dCY9TcMO+6H1T
	EZKA==
X-Gm-Message-State: APjAAAUanhGcxuboPRt8TWj0VJkp4xBZuEsGmXO2Sb2O5b3dqnGU3SeL
	M9bwp3vAOKzsz0Gq4mDcWMUzJQ==
X-Google-Smtp-Source: APXvYqyq3qa+NeO8b+Hyd5j7N6AZSbrDaAPQusv46CMBaLEGq0GKRtGJnL8GXI8NR1OWEZHXoxGsvw==
X-Received: by 2002:a1c:f205:: with SMTP id s5mr2038829wmc.124.1555574947850; 
	Thu, 18 Apr 2019 01:09:07 -0700 (PDT)
Received: from steredhat (host35-203-static.12-87-b.business.telecomitalia.it.
	[87.12.203.35])
	by smtp.gmail.com with ESMTPSA id f1sm1060986wml.28.2019.04.18.01.09.06
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 18 Apr 2019 01:09:06 -0700 (PDT)
Date: Thu, 18 Apr 2019 10:09:04 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190418080904.egxbetgrraw6ktjb@steredhat>
References: <20190418034501.5038-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190418034501.5038-1-ehabkost@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH] cpu: Fix crash with empty -cpu option
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
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
	Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418080904.wSOy4xeVND-h8pSbFWBFqfN-vLBXumn1_04kwWRVRSI@z>

On Thu, Apr 18, 2019 at 12:45:01AM -0300, Eduardo Habkost wrote:
> Fix the following crash:
> 
>   $ qemu-system-x86_64 -cpu ''
>   qemu-system-x86_64: qom/cpu.c:291: cpu_class_by_name: \
>       Assertion `cpu_model && cc->class_by_name' failed.
> 
> Regression test script included.
> 
> Fixes: commit 99193d8f2ef5 ("cpu: drop unnecessary NULL check and cpu_common_class_by_name()")
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  exec.c                              |  4 ++++
>  tests/acceptance/empty_cpu_model.py | 19 +++++++++++++++++++
>  2 files changed, 23 insertions(+)
>  create mode 100644 tests/acceptance/empty_cpu_model.py
> 

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Tested-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

