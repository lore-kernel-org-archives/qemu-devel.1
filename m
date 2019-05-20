Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F902C04AAF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 10:50:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 083922081C
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 10:50:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 083922081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33281 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSfsV-0006GD-9b
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 06:50:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hSfrT-0005lF-3g
	for qemu-devel@nongnu.org; Mon, 20 May 2019 06:49:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hSfrS-0001Nf-AW
	for qemu-devel@nongnu.org; Mon, 20 May 2019 06:49:43 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40375)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hSfrS-0001Mw-1z
	for qemu-devel@nongnu.org; Mon, 20 May 2019 06:49:42 -0400
Received: by mail-wr1-f66.google.com with SMTP id h4so14042977wre.7
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 03:49:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=ZoqkhPnPKHmRoqcRz4R1sR9fYvvVWJdju2AMezgB6+k=;
	b=HtmPXd2GaFEck1i5Gqjf2r8XEVAUZD3ZWwwhVyyJINBEJ4eagxA+at4cgm9/uq68tl
	toZBdRR0dCmldYBzl3VYTdOlma5DDU2ofA6tnDbj8bIT21HGn9JtrDQ6/NYPNhQFhnMa
	+eHs9RXAvCTMLvDPQjAqJXtm8dx9fAMdoRxpaJKWWIgvZiiYkIeXTTuDGd6Zwdn3ZJsh
	F4uRT1nePx4cPEO9obYPEeT49pMDDw8merdCbXrJc9nMmAX5XusvcqGGvgXvY1OnQppU
	z7zM0GfFnPhrQiTo3eBYD0/h9OZNQoYBrhcFgADw8vz3yInvJYn56HZRDs3Y9P3dhEFQ
	aGuw==
X-Gm-Message-State: APjAAAVtmSpRQewl3vSUxreSCx+bCV51ZeIiOeeB2cyEog3/MlBW5wTT
	lJGEIraLfSTddQErL2+E/SxWCQ==
X-Google-Smtp-Source: APXvYqyv+ZfpmM2xsxf4jwObFGhQFA+y13g2McI0zPt6UIPu2kofqB0/leOHI+rccU/qP/HZTGrgQw==
X-Received: by 2002:a5d:4fd2:: with SMTP id h18mr11036003wrw.117.1558349380978;
	Mon, 20 May 2019 03:49:40 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ac04:eef9:b257:b844?
	([2001:b07:6468:f312:ac04:eef9:b257:b844])
	by smtp.gmail.com with ESMTPSA id
	o11sm4699626wrp.23.2019.05.20.03.49.40
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 20 May 2019 03:49:40 -0700 (PDT)
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
References: <20190520030839.6795-1-peterx@redhat.com>
	<20190520030839.6795-12-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <33678ffc-8556-5cb8-f29e-907cf031a50b@redhat.com>
Date: Mon, 20 May 2019 12:49:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520030839.6795-12-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v2 11/15] kvm: Introduce slots lock for
 memory listener
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
Cc: Laurent Vivier <lvivier@redhat.com>,
	"Dr . David Alan Gilbert" <dgilbert@redhat.com>,
	Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/05/19 05:08, Peter Xu wrote:
> +/* Must be with slots_lock held */

Perhaps "Called with KVMMemoryListener slots_lock held."?

Paolo

>  static KVMSlot *kvm_alloc_slot(KVMMemoryListener *kml)


