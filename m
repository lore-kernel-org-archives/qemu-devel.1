Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895BBC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 06:25:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F7FC214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 06:25:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F7FC214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzxaX-0007eu-Fg
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 02:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37709)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1hzxZa-0006fd-6g
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 02:24:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hzxZZ-0007lf-6B
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 02:24:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43274)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hzxZY-0007lP-Uf
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 02:24:49 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0C66EC08EC0F
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 06:24:48 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id o5so6472099wrg.15
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 23:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ufJymnG9FR3LKo3AuqAH4flvvSq5rh12D90VKdB8i2U=;
 b=b1DPgaIeBIVuIIywIh/R4y/OxwvqM7Y4yzgLEKwdw7zNGd+h3MFkIZUyYL6T1yAqZ8
 1vNOXvNaCPxJ+JuomejfObspuQdug2cs/uPJFhzrZfNzWYLwRfT6Atv0isxLzaYiI+nI
 8GhQho3uLSzVXfkdVxa6Nvs8+Q7xeLid0CLN1kaGpxtLQB2g09BjEBNRK2+VXRLfJkhV
 0KoqrwT/5sr7cfbrNERMvcHgXAj/Iv8RsDjHEcWQ6oLXRoDSlKs2vBz1dTi260ltFHu+
 DEcLTL4tNi8u/K+BdAWN1diT133HvvCaRyT+Ow7eDZTfwm1qgaHbKY8VHJk9r5RphzDo
 nZwg==
X-Gm-Message-State: APjAAAXh7HcMf+YubBS4GF3CNONRq19MuIyUh4j5UY3rh4sxpI0S9zJw
 +0eJCdyZuzO4Nnl5SUmC3e1GtjtiOlwfiKEZpqaL//Oj33YH1fJ1PJ/kv+KAeDTRIkYOJGwWynJ
 NyjBmu6849yfVs0M=
X-Received: by 2002:a5d:604d:: with SMTP id j13mr30903405wrt.244.1566282285715; 
 Mon, 19 Aug 2019 23:24:45 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzf25ZM1x5YH3YlWAotIx+uU/GG0W0CPh4r4V6HyZ0XU8EmHysAyuiWj+vURgfg9lBozbAzXw==
X-Received: by 2002:a5d:604d:: with SMTP id j13mr30903366wrt.244.1566282285427; 
 Mon, 19 Aug 2019 23:24:45 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:8033:56b6:f047:ba4f?
 ([2001:b07:6468:f312:8033:56b6:f047:ba4f])
 by smtp.gmail.com with ESMTPSA id w13sm40946115wre.44.2019.08.19.23.24.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Aug 2019 23:24:44 -0700 (PDT)
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
References: <20190812074531.28970-1-peterx@redhat.com>
 <20190820052240.GG13560@xz-x1>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <f8e320ca-8c24-a562-1f5b-e55bd5c64d4a@redhat.com>
Date: Tue, 20 Aug 2019 08:24:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820052240.GG13560@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH RFC 0/4] intel_iommu: Do sanity check of
 vfio-pci earlier
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 Bandan Das <bsd@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/08/19 07:22, Peter Xu wrote:
> On Mon, Aug 12, 2019 at 09:45:27AM +0200, Peter Xu wrote:
>> This is a RFC series.
>>
>> The VT-d code has some defects, one of them is that we cannot detect
>> the misuse of vIOMMU and vfio-pci early enough.
>>
>> For example, logically this is not allowed:
>>
>>   -device intel-iommu,caching-mode=off \
>>   -device vfio-pci,host=05:00.0
>>
>> Because the caching mode is required to make vfio-pci devices
>> functional.
>>
>> Previously we did this sanity check in vtd_iommu_notify_flag_changed()
>> as when the memory regions change their attributes.  However that's
>> too late in most cases!  Because the memory region layouts will only
>> change after IOMMU is enabled, and that's in most cases during the
>> guest OS boots.  So when the configuration is wrong, we will only bail
>> out during the guest boots rather than simply telling the user before
>> QEMU starts.
>>
>> The same problem happens on device hotplug, say, when we have this:
>>
>>   -device intel-iommu,caching-mode=off
>>
>> Then we do something like:
>>
>>   (HMP) device_add vfio-pci,host=05:00.0,bus=pcie.1
>>
>> If at that time the vIOMMU is enabled in the guest then the QEMU
>> process will simply quit directly due to this hotplug event.  This is
>> a bit insane...
>>
>> This series tries to solve above two problems by introducing two
>> sanity checks upon these places separately:
>>
>>   - machine done
>>   - hotplug device
>>
>> This is a bit awkward but I hope this could be better than before.
>> There is of course other solutions like hard-code the check into
>> vfio-pci but I feel it even more unpretty.  I didn't think out any
>> better way to do this, if there is please kindly shout out.
>>
>> Please have a look to see whether this would be acceptable, thanks.
> 
> Any more comment on this?

No problem from me, but I wouldn't mind if someone else merged it. :)

Paolo

