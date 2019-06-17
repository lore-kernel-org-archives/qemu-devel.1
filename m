Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB80C31E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:42:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC655208C0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:42:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC655208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50530 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcvee-0001Kn-Vv
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 13:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42803)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hcvMR-0003sU-VP
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:24:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hcvMR-0006AT-42
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:24:03 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50924)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hcvMQ-0005jY-Tk
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:24:03 -0400
Received: by mail-wm1-f65.google.com with SMTP id c66so245833wmf.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 10:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=j7ij41qhCb57PeFP7V+o0W9lUzYDWPY0gJipOdBAIw8=;
 b=jVG6iWjyi/R9QNQscjLK/mTksKXeg+TH3omrJuU79vIemj4bOsPB8M4PZ3o7bPMHX/
 eOiRdfUXi3n6zNilZalhSS7XibbtKtGBVOsBh2n3881GcWUeOpq5m+ZqA+fh1m49rY8g
 8RaPdW2JqXRrV3Ft2gq7gbuZOxGVAtpPdb06Ma9C+HPcz6DOS+kaEihOqlRHke4q5tia
 gBZkE993svzMpNMX+3iNcRtRVQkAKe0ZUJETt5m0aKCCbtHpmVYPG7UVjyJPaMRE8sTQ
 pcndXiYsj84dlnfqrW+rT/aZ3JmBlQGXzl/o06Hd47DtOStUv/12hnFlUmDK7CJB2boO
 vJJw==
X-Gm-Message-State: APjAAAUfB8WdnZGia/N0pBK42H2w64fYgbXcgExq/kK9ybxbsboF4ORE
 qhBSDkB0RBM9hssmQpY0Fm0RhQ==
X-Google-Smtp-Source: APXvYqyE1prK7VPhTWxbmy1ULTDuQYz0QrXULlSEiIAnj4v9GS01dEe86NnsGzHQJyfLLX67QyA9sQ==
X-Received: by 2002:a7b:c215:: with SMTP id x21mr19777646wmi.38.1560792220965; 
 Mon, 17 Jun 2019 10:23:40 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:51c0:d03f:68e:1f6d?
 ([2001:b07:6468:f312:51c0:d03f:68e:1f6d])
 by smtp.gmail.com with ESMTPSA id w185sm14465407wma.39.2019.06.17.10.23.35
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 10:23:39 -0700 (PDT)
To: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20190612120421.20336-1-stefanha@redhat.com>
 <20190617122922.GG7397@linux.fritz.box>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <25ad60d8-8860-b535-a42b-03d4d63d0802@redhat.com>
Date: Mon, 17 Jun 2019 19:23:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190617122922.GG7397@linux.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v4] virtio-scsi: restart DMA after iothread
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/06/19 14:29, Kevin Wolf wrote:
> But in the end, if Paolo feels strongly that for whatever reason
> propagating events through the real device tree isn't good, let's get
> the bug fixed with whatever hack it takes.

It is actually good, but the implementation in hw/scsi is ugly because
it singles out virtio-scsi - whereas the rule should simply be that the
HBA is stopped after the disks and started before.  Having the HBA do
something special if it cares about the order is the part that I didn't
like.

Paolo

