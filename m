Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9F3C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 08:13:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F25702332A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 08:13:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F25702332A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Ljo-0001MR-7Q
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 04:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45814)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i0LOL-0000Pn-DB
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:50:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i0LOK-0006zL-6f
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:50:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46406)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i0LOJ-0006yX-V1
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:50:48 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C7E0CC0021D3
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 07:50:46 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id j16so832736wrn.5
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 00:50:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0+JcFU8qf75Sah86lbEtmokb4WmemzB98SB50CKcoME=;
 b=uP+VQyvgOQCKGSjvS7vrrBlA0C+eVciNXbpL8sr3i7dA6S48LTEaR+vsEJIvKKwAXk
 l48XJmk/2qZhwTS/VIEBM4yNjDyor7Duc7ntxYLw6rr5EfJH8jP2Tw2/iVgQWwmxAE8R
 dlXRRkuGEZSla5G39/GE4OoOTO2k2zpKpbkn8oaOh2Tf3rHC4jdr5DEmpLiynVxtvCPo
 YTFYf8tbt4ixxIaDF3epSenv0kMUS8G4mjL7LxfQRfVoJgu/uSc1JX96+1GUbPnLb4qC
 zlrvmPdyTGjdLenja9D+QAu0yBY/E37SVEBoh5FZhdyZ6jsYbl7RttksBNn5wdPdlOkn
 5LQA==
X-Gm-Message-State: APjAAAVMRdO8kFuJEXGRsJVEzbb/sh5JfVulh6gbJ8SOZ9CInTfv4Ygk
 GGyhxVE0cTe1ys/esYxfC8mxJxFDqwgOO1fQAhenTEOmz/giEIalk8l10lDfEK4WYq0TaEJ36/3
 aXFF519C2p4OPiSg=
X-Received: by 2002:a05:600c:214c:: with SMTP id
 v12mr4472571wml.28.1566373845348; 
 Wed, 21 Aug 2019 00:50:45 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxt6TRnVuYfSNEmRnhNvsmap4q/2b8Bv3PqdpiJgueQL0VCxpgykLo5ps7WmIRoZI3r6y/Euw==
X-Received: by 2002:a05:600c:214c:: with SMTP id
 v12mr4472532wml.28.1566373844966; 
 Wed, 21 Aug 2019 00:50:44 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:56e1:adff:fed9:caf0?
 ([2001:b07:6468:f312:56e1:adff:fed9:caf0])
 by smtp.gmail.com with ESMTPSA id g12sm22902870wrv.9.2019.08.21.00.50.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2019 00:50:44 -0700 (PDT)
To: Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20190812074531.28970-1-peterx@redhat.com>
 <20190820052240.GG13560@xz-x1>
 <f8e320ca-8c24-a562-1f5b-e55bd5c64d4a@redhat.com>
 <20190821050302.GA25454@xz-x1>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <8106168f-1648-5823-8a69-f93638c74c66@redhat.com>
Date: Wed, 21 Aug 2019 09:50:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190821050302.GA25454@xz-x1>
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Bandan Das <bsd@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/08/19 07:03, Peter Xu wrote:
> On Tue, Aug 20, 2019 at 08:24:49AM +0200, Paolo Bonzini wrote:
>> On 20/08/19 07:22, Peter Xu wrote:
>>> On Mon, Aug 12, 2019 at 09:45:27AM +0200, Peter Xu wrote:
>>>> This is a RFC series.
>>>>
>>>> The VT-d code has some defects, one of them is that we cannot detect
>>>> the misuse of vIOMMU and vfio-pci early enough.
>>>>
>>>> For example, logically this is not allowed:
>>>>
>>>>   -device intel-iommu,caching-mode=off \
>>>>   -device vfio-pci,host=05:00.0
>>>>
>>>> Because the caching mode is required to make vfio-pci devices
>>>> functional.
>>>>
>>>> Previously we did this sanity check in vtd_iommu_notify_flag_changed()
>>>> as when the memory regions change their attributes.  However that's
>>>> too late in most cases!  Because the memory region layouts will only
>>>> change after IOMMU is enabled, and that's in most cases during the
>>>> guest OS boots.  So when the configuration is wrong, we will only bail
>>>> out during the guest boots rather than simply telling the user before
>>>> QEMU starts.
>>>>
>>>> The same problem happens on device hotplug, say, when we have this:
>>>>
>>>>   -device intel-iommu,caching-mode=off
>>>>
>>>> Then we do something like:
>>>>
>>>>   (HMP) device_add vfio-pci,host=05:00.0,bus=pcie.1
>>>>
>>>> If at that time the vIOMMU is enabled in the guest then the QEMU
>>>> process will simply quit directly due to this hotplug event.  This is
>>>> a bit insane...
>>>>
>>>> This series tries to solve above two problems by introducing two
>>>> sanity checks upon these places separately:
>>>>
>>>>   - machine done
>>>>   - hotplug device
>>>>
>>>> This is a bit awkward but I hope this could be better than before.
>>>> There is of course other solutions like hard-code the check into
>>>> vfio-pci but I feel it even more unpretty.  I didn't think out any
>>>> better way to do this, if there is please kindly shout out.
>>>>
>>>> Please have a look to see whether this would be acceptable, thanks.
>>>
>>> Any more comment on this?
>>
>> No problem from me, but I wouldn't mind if someone else merged it. :)
> 
> Can I read this as an "acked-by"? :)

Yes, it shouldn't even need Acked-by since there are other maintainers
that handle this part of the tree:

Paolo Bonzini <pbonzini@redhat.com> (maintainer:X86 TCG CPUs)
Richard Henderson <rth@twiddle.net> (maintainer:X86 TCG CPUs)
Eduardo Habkost <ehabkost@redhat.com> (maintainer:X86 TCG CPUs)
"Michael S. Tsirkin" <mst@redhat.com> (supporter:PC)
Marcel Apfelbaum <marcel.apfelbaum@gmail.com> (supporter:PC)

> Michael, should this be for your tree?  What do you think about the
> series?  Please let me know what I need to do to move this forward.  I
> can repost a non-rfc series if needed, but it'll be exactly the same
> content.
> 
> Regards,
> 


