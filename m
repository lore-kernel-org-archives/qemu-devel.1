Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5545C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 12:46:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78336208C2
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 12:46:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78336208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hx9iH-0003fO-QY
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 08:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44951)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hx9hq-0003FN-9T
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 08:45:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hx9hp-0000Pv-6M
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 08:45:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36796)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hx9hp-0000PW-07
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 08:45:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id r3so10703041wrt.3
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 05:45:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Iai2XMHreZtPQzNCJ5E1hj7XpzUJV3iDebTMKyw/FWU=;
 b=sDk1JTYLSw1xgMRtKKE1lV41EUFtSQcakanoLXlzD8+9IDpflu1pobOYi97kiWVLRH
 DYmm/lr/yG5F+Iz4akPyySzh/WAkZC7GSAbRZQDaim+rct2VJAapuWcWnsewVbC4fqDA
 MRpvgBBtyVTStVWiWYNhYDyn8GGh66wuThCCkC+pwSZ4djeY3LhefLtHsI2tUgCG+PNU
 URgAhVFCccLOADIPUzxBRAR8rfNqg/o1AuF5k37MVabum0HkZ8oPVgHrhx5XNajVTD3j
 mw2Ofj6O/eWvLMOYUUujvHjVoDeE0056D4cYDi+ZGi2vX6A+i/U39nVx2J/dH+Asc37y
 XcpQ==
X-Gm-Message-State: APjAAAX7WWR6WlCVoQZJvX0+L2j+Bb3qCwCtJcH0oU05v1hVfSUX0P8H
 dJq4IuovQHnHuyIhYIubJPnO60Wo1vg=
X-Google-Smtp-Source: APXvYqyNRI9JCyPGBmrAgrbJ5w7oidY854Ppgawt+n7NIAXrJs0tq3yRk+T5B8/vK6hSz/Q0DHZGrw==
X-Received: by 2002:adf:f088:: with SMTP id n8mr40563924wro.58.1565613942710; 
 Mon, 12 Aug 2019 05:45:42 -0700 (PDT)
Received: from [10.201.49.73] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
 by smtp.gmail.com with ESMTPSA id x24sm15896931wmh.5.2019.08.12.05.45.41
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 12 Aug 2019 05:45:41 -0700 (PDT)
To: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Prasad J Pandit <ppandit@redhat.com>
References: <20190812065221.20907-1-kraxel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <aec51679-b766-5773-86cb-9ebd06a8cb49@redhat.com>
Date: Mon, 12 Aug 2019 14:45:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190812065221.20907-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH 0/1] display/bochs: fix pcie support (qemu
 security issue)
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/08/19 08:52, Gerd Hoffmann wrote:
> Just found while investigating
>   https://bugzilla.redhat.com/show_bug.cgi?id=1707118
> 
> Found PCIe extended config space filled with random crap due to
> allocation being too small (conventional pci config space only).
> 
> PCI(e) config space is guest writable.  Writes are limited by
> write mask (which probably is also filled with random stuff),

Yes, it is also allocated with 256 bytes only.

> so the guest can only flip enabled bits.  But I suspect it
> still might be exploitable, so rather serious because it might
> be a host escape for the guest.  On the other hand the device
> is probably not yet in widespread use.
> 
> Migitation: use "-device bochs-display" as conventional pci
> device only.
> 
> Note: qemu 4.1 release is planned for tomorrow.
> 
> Gerd Hoffmann (1):
>   display/bochs: fix pcie support
> 
>  hw/display/bochs-display.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 

Looks good to me, and no other device seems to have the same issue.  We
could add an assertion that pci_config_size has not increased after
calling pc->realize.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo

