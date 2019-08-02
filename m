Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E376C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 09:25:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66CCB21773
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 09:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66CCB21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htToc-00048h-LH
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 05:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52530)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1htTnk-0003ar-9T
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 05:24:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1htTnj-00063w-Bc
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 05:24:40 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:33468)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1htTnj-00063T-0Q
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 05:24:39 -0400
Received: by mail-wr1-f51.google.com with SMTP id n9so76544460wru.0
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 02:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Uyw6dvGmwcoFQAoEs9JosOi+gzc5Rda6dO21dMTh4WA=;
 b=Ie/WbYBD3ub1+wFkHn1+aaT+pzd0pmSvSLQFS+5e3jkweYAkFi4iyguApQLTOc/giJ
 op03wUAavIhTG1Fm+teXN2e0gpqXu9O192LBd92e4AHI954eiGXVpzCQiz0unDKAUWBW
 QaV6E7wHNqxpJQgvc8mWacth+1DRqazAwZhP4XEiMtYEFPKGh8g6+xwJ+jSWDBpK9xkn
 3+JtYhIpAQeAQhxvLh/3eU1meMQ6d/K3T3iyEitv0kb737lha6tmdOmaG4NoM9N/mQlh
 dmO710fsT2AKSdRuIilEJOTtfeDupPTlMTvVhoIirik2p87OVOQBSCiQ8QfqGiTB2I4g
 12yA==
X-Gm-Message-State: APjAAAVgfUmh/8UA1QgBDbg4NlZncOFPgC5L222ni/vfNwPx5yV4Il2y
 luirUv3tf7nsJ5njoxOcHLL0NHusZaw=
X-Google-Smtp-Source: APXvYqznheXOwNU4R8nkncPOuS1sT1UKHYmlp3k85tGHHfONsbGXnXBpHS9KeL4sOcPK7jiVpLsooA==
X-Received: by 2002:adf:fc52:: with SMTP id e18mr24173454wrs.14.1564737877769; 
 Fri, 02 Aug 2019 02:24:37 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4013:e920:9388:c3ff?
 ([2001:b07:6468:f312:4013:e920:9388:c3ff])
 by smtp.gmail.com with ESMTPSA id 32sm67981640wrh.76.2019.08.02.02.24.37
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 02 Aug 2019 02:24:37 -0700 (PDT)
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20190729125755.45008-1-slp@redhat.com>
 <932a0c3c-b6cb-540f-ca07-1559c8fe9049@redhat.com>
 <9953cc99-80b3-814c-f75e-a16c987c23e5@redhat.com>
 <20190801154456-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <050e84b7-f8ca-8bd9-0d42-73a32c78f8de@redhat.com>
Date: Fri, 2 Aug 2019 11:24:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190801154456-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.51
Subject: Re: [Qemu-devel] [RFC] virtio-mmio: implement modern (v2)
 personality (virtio-1)
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Sergio Lopez Pascual <slp@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/08/19 21:45, Michael S. Tsirkin wrote:
>>> OVMF is a heavy-weight guest firmware, which I see entirely out of scope
>>> for "micro VMs". And so virtio-mmio/1.0 would seem like a needless &
>>> unwelcome complication, from the OVMF maintainership perspective.
>> But given that, why not rip out virtio-mmio completely?
>
> From OVMF?

Yes, of course.

Paolo

