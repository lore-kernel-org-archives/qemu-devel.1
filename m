Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843D8C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 08:45:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12EAA2089F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 08:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12EAA2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48852 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfKbO-0000jW-Bw
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 04:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44411)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hfKZg-0000Fy-Dd
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 04:43:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hfKZe-0006fC-Gj
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 04:43:39 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43434)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hfKZd-0006AK-PA
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 04:43:38 -0400
Received: by mail-wr1-f66.google.com with SMTP id p13so12903908wru.10
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 01:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Pxvu1mJoqFjEaFccbXq19G8BApOz4ylS8kbf4r105Js=;
 b=Q1Mlt0dPHnd1o1i/JaRSSX2MG896Usb5VVlnNSUnlBdMZTpWSKd2usXhT3Pb3A5/IC
 QhOUriRygUSuV5onslDq2oNThBySZ6JIgZubwMQpR/+E30d46/sjivX5NsfDnOm2oQX9
 3x6jP2BK/LjTEUeRrh95g7yxDVrwirBzAqYBS+U4YLd/45akDd2mzpBhLrRlU+yHZ7yU
 TkLGAs71OQH/3OHKY5aE7gF9g2R8HgKOeS0o5caozQI/g7rynFQxu3szVmsF3XXIHbHt
 h9WimN7+0FVU6XYaOgzXfpQi7slPVGWn7xkEMVdmp+3A0yZ2V3NpmWO6vqx+vdjbMi++
 dtww==
X-Gm-Message-State: APjAAAUdzpinQe36W68yDuZxpyXD9n88wlhFT4/JRkAerooq4VVHL+RZ
 u5+Uu48/6RiPxTFRsaU4wPnUyg==
X-Google-Smtp-Source: APXvYqzaIdCAnSJzGqnqOqi8mMUnz/5szdZGcX6Qv/On/P49QDuEbEtpX6QogpYAzyNciJhw0haedw==
X-Received: by 2002:a5d:6b90:: with SMTP id n16mr66173623wrx.206.1561365802991; 
 Mon, 24 Jun 2019 01:43:22 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7822:aa18:a9d8:39ab?
 ([2001:b07:6468:f312:7822:aa18:a9d8:39ab])
 by smtp.gmail.com with ESMTPSA id s7sm18661920wmc.2.2019.06.24.01.43.22
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 24 Jun 2019 01:43:22 -0700 (PDT)
To: Peter Xu <peterx@redhat.com>, Yan Zhao <yan.y.zhao@intel.com>
References: <20190624063733.22079-1-peterx@redhat.com>
 <20190624063733.22079-3-peterx@redhat.com>
 <20190624064122.GB27894@joy-OptiPlex-7040> <20190624065750.GE6279@xz-x1>
 <20190624070450.GC27894@joy-OptiPlex-7040> <20190624080649.GG6279@xz-x1>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a0a6a698-d671-9b4c-badf-75bc258242ff@redhat.com>
Date: Mon, 24 Jun 2019 10:43:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190624080649.GG6279@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH 2/2] intel_iommu: Fix unexpected unmaps
 during global unmap
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
Cc: Auger Eric <eric.auger@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/06/19 10:06, Peter Xu wrote:
> Well, if with such an error we'd better fix it right away in this
> patch... :)
> 
> Let me wait for some more comments, I'll touch that up too if I need a
> repost.

Looks good to me, except for one minor issue in this patch.  But do not
attribute this one to me, it's basically all code from you.

> +static uint64_t vtd_get_next_mask(uint64_t start, uint64_t size, int gaw)
> +{
> +    /* Tries to find smallest mask from start first */
> +    uint64_t rmask = start & -start, max_mask = 1ULL << gaw;
> +
> +    assert(size && gaw > 0 && gaw < 64);
> +
> +    /* Zero start, or too big */
> +    if (!rmask || rmask > max_mask) {
> +        rmask = max_mask;
> +    }

Perhaps simpler:

    uint64_t max_mask = 1ULL << gaw;
    uint64_t alignment = start ? start & -start : max_mask;

    size = MIN(size, max_mask);
    if (alignment <= size) {
        /* Increase the alignment of start */
        return alignment;
    } else {
        /* Find the largest page mask from size */
        return 1ULL << (63 - clz64(size));
    }

Also please rename it to get_naturally_aligned_size.

Paolo

