Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4E6C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 09:32:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12C38214DA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 09:32:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12C38214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD3ea-0006eO-Ss
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 05:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33271)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iD3cU-0005cJ-Ea
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 05:29:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iD3cS-0008Qp-JD
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 05:29:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47498)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iD3cS-0008Nr-Ak
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 05:29:56 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 474EC5859E
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 09:29:55 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id q9so908646wmj.9
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 02:29:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XdCyxypkTILYxxil0UhO8du5NnWEbx8LxbROXgsSMwg=;
 b=jo1JuQ090dKxJh0JvD4CIBY11VmymUhPyEWPuppO1AwvEbMUk0hFGd4HQR1iH0GhgC
 cp9Rn0wJ9DapQXKLWqehQx19C2xIcmbeF5Dt88EziQ+2HVyjVD8LREiN+B7DecwsPMGb
 vmj+FMaFd0HQWF9GUfo3ipvh9Vtd11Rb8zKvIvleruwuxe+S+1q5kCX+wcoEZ9sz0r2v
 4o0pPJfKk10OU2wvd6dnz0Wodox9wh99x9cqCachXp65g0DWHJFWSO3OX1Kffln9Gkyc
 NYnSXifMLza/gt3t0I093KywEZgoFAKBuE0lStRmPCtnafyX+J1lyAEMZS0x7BXqCYBj
 6aRQ==
X-Gm-Message-State: APjAAAVxMk5OEI0CtAfFcZpr982t6iFi2m6O+itKSuwZ9lm1PfP4oTe5
 Gpf4LeofxzrNFsM0lJuQy4GNrol3Tl6gaAtbCxc5lN9BBqFDbG9hmdj+XTbRi16Bh1JW7lKZaOT
 FfjjxYfgM6Qd42ls=
X-Received: by 2002:a05:600c:248a:: with SMTP id
 10mr6504127wms.97.1569403793892; 
 Wed, 25 Sep 2019 02:29:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwM7Grp5b8CHzOYJry57kiiBqUsG7R+SwPYWG/hlDKUI7a9TdSXAhvU+EEvgBUpurnzZWA5Ig==
X-Received: by 2002:a05:600c:248a:: with SMTP id
 10mr6504083wms.97.1569403793607; 
 Wed, 25 Sep 2019 02:29:53 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36?
 ([2001:b07:6468:f312:9520:22e6:6416:5c36])
 by smtp.gmail.com with ESMTPSA id g1sm2756164wrv.68.2019.09.25.02.29.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2019 02:29:52 -0700 (PDT)
Subject: Re: [PATCH v4 0/8] Introduce the microvm machine type
To: Gerd Hoffmann <kraxel@redhat.com>
References: <20190924124433.96810-1-slp@redhat.com>
 <c689e275-1a05-7d08-756b-0be914ed24ca@redhat.com> <87h850ssnb.fsf@redhat.com>
 <b361be48-d490-ac6a-4b54-d977c20539c0@redhat.com>
 <20190925091225.bx4c4x2o6qgydidj@sirius.home.kraxel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <8fa274c8-6bb7-bf88-7715-bb23f5dfb7de@redhat.com>
Date: Wed, 25 Sep 2019 11:29:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190925091225.bx4c4x2o6qgydidj@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Pankaj Gupta <pagupta@redhat.com>, mtosatti@redhat.com, ehabkost@redhat.com,
 Sergio Lopez <slp@redhat.com>, mst@redhat.com, lersek@redhat.com,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, imammedo@redhat.com, philmd@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/09/19 11:12, Gerd Hoffmann wrote:
>   Hi,
> 
>> If you want to add hotplug to microvm, you can reuse the existing code
>> for CPU and memory hotplug controllers, and write drivers for them in
>> Linux's drivers/platform.  The drivers would basically do what the ACPI
>> AML tells the interpreter to do.
> 
> How would the linux kernel detect those devices?
>
> I guess that wouldn't be ACPI, seems everyone wants avoid it[1].
> 
> So device tree on x86?  Something else?

Yes, device tree would be great.

> [1] Not clear to me why, some minimal ACPI tables listing our
>     devices (isa-serial, fw_cfg, ...) doesn't look unreasonable
>     to me.

It's not, but ACPI is dog slow and half of the boot time is cut if you
remove it.

> We could also make virtio-mmio discoverable that way.

True, but the simplest way to plumb virtio-mmio into ACPI would be
taking the device tree properties and representing them as _DSD[1].  So
at this point it's just as easy to use directly the device tree.

Paolo

[1]
https://kernel-recipes.org/en/2015/talks/representing-device-tree-peripherals-in-acpi/

