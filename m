Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3214C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:52:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A82F722327
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:52:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A82F722327
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37284 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGOVq-0006Dk-M4
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 09:52:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hGOTv-0004tW-IT
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 09:50:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hGOTu-00041W-6w
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 09:50:39 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33912)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hGOTt-0003zz-Jk
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 09:50:37 -0400
Received: by mail-wm1-f66.google.com with SMTP id r186so2399549wmf.1
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 06:50:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=qaQzRqtxTQhSSiUUcB0OG33nq6xJbe+0DAJBr2/mMNU=;
	b=qLeI9tVYPE+mqxD13n3S112427zl/EDkPE1as0dGn1NgoU25lOWDtiTq8rknyeVn7k
	Yj7hB2IkJP1zbsy5VsL5ygK+plOQTKjuEXQvTb6HpdraghbbuRgvM1tdYGghpVPBo8cL
	CxARTp1LmznEGyH/uUiJKmbX77GVY1eIys6jW3c+nd7JoSla9mdRSy637dVbp3Ci6tPL
	donqzPVvHPjKVKo7wO5Wh7xTIbJM/KlqzLwJei6XznZHgYnQG247QUtra+ZRbLxw0/Qy
	klYOSrz8aaW6U9avfSkXNzLYyqNj9HT35tkraflLm0XtY1L1u85ndnPYbjWHWlLOZ6Pb
	FlcA==
X-Gm-Message-State: APjAAAXaQc61vJbmbts6nJPe2+bqoFQgd9ALwiNrlErikw5ZfugcOX8y
	FQ5Su9bUBP6Y8vMoIWFh+pdFhvWb4/c=
X-Google-Smtp-Source: APXvYqxyBrfp+/6ljac/fTLFctxYGMSW/gBSJwRtQDldGz09+gcFRMbTGGxjMGyEF0u1kU6Y5f+ifA==
X-Received: by 2002:a1c:2dd2:: with SMTP id t201mr28023282wmt.10.1555422636309;
	Tue, 16 Apr 2019 06:50:36 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ac27:aac4:c65c:6eb?
	([2001:b07:6468:f312:ac27:aac4:c65c:6eb])
	by smtp.gmail.com with ESMTPSA id w9sm3978469wmi.0.2019.04.16.06.50.35
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Apr 2019 06:50:35 -0700 (PDT)
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-block@nongnu.org
References: <20190415135746.7571-1-mlevitsk@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c239eeac-8bf1-6af4-8a2a-370be84bfcdb@redhat.com>
Date: Tue, 16 Apr 2019 15:50:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415135746.7571-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/5] Few fixes for userspace
 NVME driver
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416135035.fnCKadlRroiV3_nceQJXbswLQtnyZmYdQjwgdev2hYE@z>

On 15/04/19 15:57, Maxim Levitsky wrote:
> 
> 
> Hi!
> These are few assorted fixes and features for the userspace
> nvme driver.
> 
> Tested that on my laptop with my Samsung X5 thunderbolt drive, which
> happens to have 4K sectors, support for discard and write zeros.
> 
> Also bunch of fixes sitting in my queue from the period when I developed
> the nvme-mdev driver.
> 
> Best regards,
> 	Maxim Levitsky

I only pointed out just two cosmetic changes.  Thanks very much!

Paolo

