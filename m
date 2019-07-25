Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0595FC7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 10:37:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD84521901
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 10:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD84521901
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqb7S-0005Tk-Ot
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 06:37:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35030)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hqb7I-00053s-Kf
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:36:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hqb7H-0001hg-LH
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:36:56 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34411)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hqb7H-0001hF-Fe
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:36:55 -0400
Received: by mail-wr1-f65.google.com with SMTP id 31so50253951wrm.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 03:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SsChKF1uFxeMrdIJvAxngmy5KaM4uyyZsfUt4h6/H3A=;
 b=T3fbVESLdKgT59bAOhpSDqx2MQHTGmKupqL0mcsuklQMcPnHc3jlYmtQRgWyyX1lxo
 NeUVqbuQhe4M+D8lioE/o6tUv9GB43bda1TkUi3eoPOa/k+kdLXxjR72sDYv8pDt4UxS
 svT5nBqOA49Q+MvO08koe5QThi5x+LSxykfsTzkp6AmJHvIWZ+KUauVuxneRiDILYjpZ
 QqwSnsOAgIEz9N3CYAa5KCM81Aib1Cy1L+djyIKFQPq651Esdqg2rZmMd7ypGLXLvXXr
 eTMrMkcxVkfnDHw4gTIXSXdRh/AHbd5o/ffjpf2ezK/YyICDOCEiNxRJGFrBVQyflkuk
 b+Hg==
X-Gm-Message-State: APjAAAVs1CtMGpDLR/d2TUhiuU3uOtgpIqb1mDFfqPR7cmtzMOCMEJfZ
 4UYkYvnliaCmH/Z889nmbMfgyLHmd1g=
X-Google-Smtp-Source: APXvYqyYmDmZ9XwuqpaJXtYy0nLaVQ6m/t+YVVKw4McfoY1ez5tLgnFKzz2EQxvy/qiBXfAbKysW/g==
X-Received: by 2002:a5d:4b8b:: with SMTP id b11mr12312836wrt.294.1564051014233; 
 Thu, 25 Jul 2019 03:36:54 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:cc23:f353:392:d2ee?
 ([2001:b07:6468:f312:cc23:f353:392:d2ee])
 by smtp.gmail.com with ESMTPSA id v12sm42324157wrr.87.2019.07.25.03.36.53
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Jul 2019 03:36:53 -0700 (PDT)
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Liam Merwick <liam.merwick@oracle.com>
References: <20190702121106.28374-1-slp@redhat.com>
 <20190702121106.28374-2-slp@redhat.com>
 <aca80a5c-40b9-ca31-2e22-c2bf5005f7e5@oracle.com>
 <20190725055523-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <24852119-498e-2977-e1b9-366a86493790@redhat.com>
Date: Thu, 25 Jul 2019 12:36:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725055523-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v3 1/4] hw/virtio: Factorize virtio-mmio
 headers
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
Cc: ehabkost@redhat.com, Sergio Lopez <slp@redhat.com>, maran.wilson@oracle.com,
 qemu-devel@nongnu.org, kraxel@redhat.com, rth@twiddle.net, sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/07/19 11:58, Michael S. Tsirkin wrote:
> I'm repeating myself, but still: if you insist on virtio mmio, please
> implement virtio 1 and use that with microvm. We can't keep carrying
> legacy interface into every new machine type.

I'd give Sergio the benefit of doubt, since so far he's addressed many
other review comments---just, one at a time. :)

Paolo

