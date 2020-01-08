Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F050C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 09:37:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE4E0206DA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 09:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X1ElL/FL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE4E0206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip7mb-000088-Qn
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 04:37:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44677)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ip7lw-00088y-Pd
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 04:37:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ip7lv-0000p9-D1
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 04:37:04 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33878
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ip7lv-0000ol-8c
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 04:37:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578476222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=68cyakBuuqykyYfuVPtYJRYgfAWVoYk6H/O1x5botQ4=;
 b=X1ElL/FLRZ5JOZkmqRponRGl4iUutXYJlTznDC9HC/v5oLDts/oUlvlPaLDJL/joXknDMS
 ZWw+7zz9VW6GviKyt2YSEYmYOnMiAUy3oee3YowpV2cPTT8JNdt4awuHEgT2BA+TJ4EBu8
 U8ibiY35fGkDCCM2V2Hu8AHGY1yYJA8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-gFUPoQweODyljWmrhdJT5g-1; Wed, 08 Jan 2020 04:36:59 -0500
Received: by mail-wr1-f71.google.com with SMTP id r2so1205390wrp.7
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 01:36:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=68cyakBuuqykyYfuVPtYJRYgfAWVoYk6H/O1x5botQ4=;
 b=atj8cJirpfMwWGDKwT3yxwbY8wrTKCb48D9RiCWax56xO4oaVo9cNh6nh+vHeqSnX5
 pkDih0Z0KnK6ZtirU/mlx6Ze+aAE+MxfO2JnyyKbFtDUVfGXTZnqGyOFhu/s3iJgGiuR
 9ELQevafHzT9CNSpUMaOSdQJIyxDOfiy7V2D9NFOqWQoOf397HzR7OuOvk4Y+Jn0kTpi
 p8WLyFikwH049VE6Ixpea/SXKjMDGfm/ssv27BsOMzbnpxwBV8br/2Pmhys4a+bcvkD6
 5A4k04Lz3LKV90UIvthi9jrFe5pNosStrvDv7QzFceQc9hvJqcVLb4I7YjgTZLg/9Gol
 dc7A==
X-Gm-Message-State: APjAAAW3tkuWDlJTvxf7U7IkzPgcvV9u5tv3edxOAUBV0Tdz0uK5QQ/9
 4r+pyVp7bILawKYI++3XjY5DUqWGz0b7y4ka/TFfIUrfskcLLvOCnw4lxQHSw30RFYTV/RATmVf
 4JG7SetJ3ji23LUA=
X-Received: by 2002:a05:600c:298:: with SMTP id
 24mr2563064wmk.141.1578476218055; 
 Wed, 08 Jan 2020 01:36:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqwOYbwL71jHMFOLZ5jV8xy/fR+AF+ZAxn6+Tt8MCWEEuGa8Xg+blvSitd6myXj3yx8d2Rz0jg==
X-Received: by 2002:a05:600c:298:: with SMTP id
 24mr2563033wmk.141.1578476217779; 
 Wed, 08 Jan 2020 01:36:57 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:bc4e:7fe8:2916:6a59?
 ([2001:b07:6468:f312:bc4e:7fe8:2916:6a59])
 by smtp.gmail.com with ESMTPSA id q68sm3371147wme.14.2020.01.08.01.36.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2020 01:36:57 -0800 (PST)
Subject: Re: discuss about pvpanic
To: zhenwei pi <pizhenwei@bytedance.com>
References: <2feff896-21fe-2bbe-6f68-9edfb476a110@bytedance.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dd8e46c4-eac4-046a-82ec-7ae17df75035@redhat.com>
Date: Wed, 8 Jan 2020 10:36:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <2feff896-21fe-2bbe-6f68-9edfb476a110@bytedance.com>
Content-Language: en-US
X-MC-Unique: gFUPoQweODyljWmrhdJT5g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: "yelu@bytedance.com" <yelu@bytedance.com>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org,
 linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/01/20 09:25, zhenwei pi wrote:
> Hey, Paolo
> 
> Currently, pvpapic only supports bit 0(PVPANIC_PANICKED).
> We usually expect that guest writes ioport (typical 0x505) in panic_notifier_list callback
> during handling panic, then we can handle pvpapic event PVPANIC_PANICKED in QEMU.
> 
> On the other hand, guest wants to handle the crash by kdump-tools, and reboots without any
> panic_notifier_list callback. So QEMU only knows that guest has rebooted (because guest
> write 0xcf9 ioport for RCR request), but QEMU can't identify why guest resets.
> 
> In production environment, we hit about 100+ guest reboot event everyday, sadly we 
> can't separate the abnormal reboot from normal operation.
> 
> We want to add a new bit for pvpanic event(maybe PVPANIC_CRASHLOADED) to represent the guest has crashed, 
> and the panic is handled by the guest kernel. (here is the previous patch https://lkml.org/lkml/2019/12/14/265)
> 
> What do you think about this solution? Or do you have any other suggestions?

Hi Zhenwei,

the kernel-side patch certainly makes sense.  I assume that you want the
event to propagate up from QEMU to Libvirt and so on?  The QEMU patch
would need to declare a new event (qapi/misc.json) and send it in
handle_event (hw/misc/pvpanic.c).  For Libvirt I'm not familiar, so I'm
adding the respective list.

Another possibility is to simply not write to pvpanic if
kexec_crash_loaded() returns true; this would match what xen_panic_event
does for example.  The kexec kernel would then log the panic normally,
without the need for MMIO at all.  However, I have no problem with
adding a new bit to the pvpanic I/O port so once you post the QEMU patch
I will certainly ack the kernel side.

Thanks,

Paolo


