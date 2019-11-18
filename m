Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EB2C43215
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 11:39:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A1A42073A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 11:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aT/tS4XD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A1A42073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWfNs-0007ST-GD
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 06:39:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51973)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iWfNH-00072K-51
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 06:39:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iWfNF-0007NV-KE
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 06:39:18 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27895
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iWfNF-0007N7-GL
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 06:39:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574077156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=vHUMAQKCLe8UWzE/y+vJwqFFRM4wn2NCBwxJ9+8Lqno=;
 b=aT/tS4XDz4adeTXyS5/VV6udLAocfoYn0l9inhK4oM32ou6W587ZzcP81zcadDSy3khgLW
 6XwfRwRzfYM4PGFKixsMDSz/Of97g8OaT7gfxfEYpbjCKIf4gy39fjl6na/nEFKHuBR+1K
 lX/3vsQUZWhsXlMKfbrfllGi5q9gw4U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-n92zAP-xMc-tY2cg0-wyvw-1; Mon, 18 Nov 2019 06:39:11 -0500
Received: by mail-wr1-f70.google.com with SMTP id e3so15165090wrs.17
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 03:39:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/mOorNYGp9pVaAlNrI0hu6lFGwcVN8SAHmsKUjGEoWA=;
 b=JSNSg2L9Fr3kpanuok9pe7gJxfM7i0xXynStFaG8pXoG3pseaIBtpcicDAMc0xb8EX
 5Xj1Lgdm9gNBbNz28MjbpgnUDhFep+f2QLGOkwJoWYRevAKQkwueVjxBG75xjx+VkCUi
 AJllpBr48L9xFU26EetlECZHwe++jNQ5C5CxfaGj9Xe8FPX6SBCeH8p940kSKYbOEj9x
 o1DPkAclGwioNzVZYWgVcEXO6mQYoACL8hiZTqbDEcNClysdDIAAbiw8VaiBUUyvodbZ
 G/8lXlcXbCKwms6QXgPx10lBrCeWdI3MZO4LXid5z3u0D4C9gZ8ebV8dxAO3CsTDYRFG
 k4qQ==
X-Gm-Message-State: APjAAAVuki7jTYb4jLFajQz2ItWVkk2wirLtWxXzkJxVk+M7HZs+FECE
 P+OVw0Eq1PlJ9b8mlcvbO1S0sRjvd4DCuPcp8u9hbAJJbbigHQZ3JdVQKy+fIiiGqk+6alx4WS+
 i5Ua+GKYKW0V3dKU=
X-Received: by 2002:adf:edc5:: with SMTP id v5mr14248033wro.322.1574077150304; 
 Mon, 18 Nov 2019 03:39:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqyp6Xv+TcQjbPleUK6XcuLBLb6Zs9crZxdAd63ey6t+b6ueOBVmwf+WyE22xyJnh1Jo8hHJRA==
X-Received: by 2002:adf:edc5:: with SMTP id v5mr14248006wro.322.1574077150023; 
 Mon, 18 Nov 2019 03:39:10 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:a15b:f753:1ac4:56dc?
 ([2001:b07:6468:f312:a15b:f753:1ac4:56dc])
 by smtp.gmail.com with ESMTPSA id y67sm20984213wmy.31.2019.11.18.03.39.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2019 03:39:09 -0800 (PST)
Subject: Re: [PATCH 03/16] vl: merge -accel processing into
 configure_accelerators
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
 <1573655945-14912-4-git-send-email-pbonzini@redhat.com>
 <4a330f6c-84ed-3f02-60f8-bd34314ad85d@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <990d1694-dc06-b19b-c390-4dc5fe511e83@redhat.com>
Date: Mon, 18 Nov 2019 12:39:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4a330f6c-84ed-3f02-60f8-bd34314ad85d@redhat.com>
Content-Language: en-US
X-MC-Unique: n92zAP-xMc-tY2cg0-wyvw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
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
Cc: armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/11/19 12:27, Thomas Huth wrote:
>>       * Note: uses machine properties such as kernel-irqchip, must run
>>       * after machine_set_property().
>>       */
>> -    configure_accelerator(current_machine, argv[0]);
>> +    cpu_ticks_init();
>> +    configure_accelerators(argv[0]);
> The comment about kernel-irqchip obviously rather belongs to
> configure_accelerators() instead of cpu_ticks_init(), so maybe you
> should move the cpu_ticks_init() before the comment now?

Ok.

> (does it need
> to be moved here at all? ... it looks pretty independent at a first glanc=
e)

No, it doesn't.  Whether to move it or not is a matter of personal
preference, so I can certainly move it back.

Paolo


