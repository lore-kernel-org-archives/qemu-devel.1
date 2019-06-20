Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F60C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 13:24:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7097320675
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 13:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7097320675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47734 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdx2u-0007Yr-Do
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 09:24:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51285)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hdwxJ-0002ux-B5
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 09:18:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hdwtE-0003Hq-Ga
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 09:14:28 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39377)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hdwtE-0003Hb-BR
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 09:14:08 -0400
Received: by mail-wm1-f65.google.com with SMTP id z23so3130170wma.4
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 06:14:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=seUaZ8ZAtXPB0zezIpKBQyKsqYZdDLfJzZhChR50tMc=;
 b=Fh+HS3E5f80gHZppf2fm8YDP4qVnhJhUUVeS7jpff/DF6v3OezPYj+ryM+9qKZOK18
 iJBvGZhbGLui+MmUNu43n+e07+JmPtwX/xfIS08U/ddJTAkjTNEJoxipPsk49gKkmIWQ
 LWk5iSUYbMhIdbhMAttF14Qmfr2NtSTqVLHZA3VBU7nkU5kiEDl0XhS0wvSXvo9VP9/9
 lPmDhP1NxG2JDpCVJPb44j9BrESEc+njKVbkAPexpbQEUO+4AVYz2Wv6XeH9VtK+KBuy
 v3HLSB7gQ6dE3mR+QaAplDgZiXXg9epH7o2IV1OQI/qg7xVcDtuZ5rQi0/5KEKPV60aQ
 bKPg==
X-Gm-Message-State: APjAAAWZcB/q7ZcSiF528RitwglWzUBMfXdvZudn9FARkswyQYrBCUsA
 tLtl3xG4Ag/9f9x/XmwzoMcJJj2a/GM=
X-Google-Smtp-Source: APXvYqyiwa6h8gRy7sJGGhI4kAzKjZtsXsfx9GL9Zf/XrIogUSM7fuEcKBQjZQ3PZaWGGSfMP9h3YQ==
X-Received: by 2002:a1c:1a56:: with SMTP id a83mr2814951wma.161.1561036447006; 
 Thu, 20 Jun 2019 06:14:07 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7822:aa18:a9d8:39ab?
 ([2001:b07:6468:f312:7822:aa18:a9d8:39ab])
 by smtp.gmail.com with ESMTPSA id d4sm19226439wra.38.2019.06.20.06.14.05
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Jun 2019 06:14:06 -0700 (PDT)
To: Peter Xu <peterx@redhat.com>
References: <1560934185-14152-1-git-send-email-yan.y.zhao@intel.com>
 <39c4c32b-e34a-8d8f-abbc-ab346ec5bed7@redhat.com>
 <20190620040230.GB9073@xz-x1>
 <6829b139-3eab-449e-04d6-07f1e381316d@redhat.com>
 <20190620125955.GB9657@xz-x1>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <df223a1f-bb87-0914-6216-8a4a70aae3ab@redhat.com>
Date: Thu, 20 Jun 2019 15:14:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190620125955.GB9657@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH] memory: do not do out of bound notification
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
Cc: Auger Eric <eric.auger@redhat.com>, Yan Zhao <yan.y.zhao@intel.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/06/19 14:59, Peter Xu wrote:
> I feel like this can be problematic.  I'm imaging:
> 
> start=0x1000_0000, size=0x1000_1000
> 
> This will get size=0x1000 but actually we can do size=0x1000_0000 as
> the first.

Right, we can do:

/*
 * If a naturally aligned region starting at "start" ends before "end",
 * use it.  Otherwise, keep the lowest bit of size.
 */
if (size > (start & -start))
    size = start & -start;
else
    size = size & -size;

>>
>> +        trace_vtd_as_unmap_whole(pci_bus_num(as->bus),
>> +                                 VTD_PCI_SLOT(as->devfn),
>> +                                 VTD_PCI_FUNC(as->devfn),
>> +                                 entry.iova, size);
> 
> Can move this out because this is a trace only so we don't have
> restriction on mask?
> 
>>
>> -    map.iova = entry.iova;
>> -    map.size = entry.addr_mask;
>> -    iova_tree_remove(as->iova_tree, &map);
>> +        map.iova = entry.iova;
>> +        map.size = entry.addr_mask;
>> +        iova_tree_remove(as->iova_tree, &map);
> 
> Same here?
> 

Yes, I would move these and the iova_tree_remove outside the loop, while
keeping entry's initialization inside looks cleaner.

Paolo

