Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08607C4BA2D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:15:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C223F2469C
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BGfz/ctW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C223F2469C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7J0y-00015P-VW
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 08:15:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56327)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j7J0D-0000Ri-3r
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:14:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j7J0C-0000VZ-6Q
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:14:57 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51022
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j7J0C-0000VR-2m
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:14:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582809295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0k4q7jFv0F1yohMfLS+7dnfuhjclgWbv1zGRIl2eqvs=;
 b=BGfz/ctWyHMwZRrT3cPcjpFI6NJbgfOTN6Y8m1+kublooyzzuNliJBz5aIEZaRg1KiXHqa
 LM3ffhVbXc75myr0Q2t1ehb2+McntytRHCW8vye2/NoU9QIwjnglvqkzxqIIHbfrlXkac3
 RDVosQKBI1kCng1fcUueAqYwAGLlCSM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-fNdrwI-QNl2VYdX4wlgsLQ-1; Thu, 27 Feb 2020 08:14:53 -0500
X-MC-Unique: fNdrwI-QNl2VYdX4wlgsLQ-1
Received: by mail-wm1-f69.google.com with SMTP id p2so682683wmi.8
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 05:14:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0k4q7jFv0F1yohMfLS+7dnfuhjclgWbv1zGRIl2eqvs=;
 b=eeLhjQ9cd26YOPGyUmjdE7HBqMqXC8B24xYdjekkoqW/5ZyWjcdGnvXnu8lqIUULXA
 BH2Rz8GUk62rFSkU1iUpdL6ND6QQs63JXr21FxLS+I5zxrF7MQxgS6ERqOp8bXBVaZ9r
 C+psdQYRVtlPwUi2gLsB8NKokDxULlJVRAEVl53uidpd5gqNq/0LXKlyV8J+JtA4da0p
 wmKQVXdYVMrdhQMYox7M5ppv/vz94Bug8U+u/O3qyPG3r1Gmt6zGQ/5Q7jJh8m8zY1cV
 Z0WWGQZuliTDbT0BZxB+fxqpCy09lt8FnqRdi/qXLA27eqAN0qLqIkelxUH6Y4zWXPCC
 oU0g==
X-Gm-Message-State: APjAAAW1sQ7k+0SZSvIsGW65Ji/M8LtzJpRODKcXPvcHc+Fdziskr0QQ
 W2U1rktxLuJ+yuYXYYs98PoCyjTw0Vh6GtYLVomemk0MYpJL2QON6DYkIFV2PgO36qLeHTj651L
 uKzCoUVrpcQMUD20=
X-Received: by 2002:a7b:cc6a:: with SMTP id n10mr5252305wmj.170.1582809292154; 
 Thu, 27 Feb 2020 05:14:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqzKb7irxfKHkVbApi7dOzOXRlof5bD3jB6yRXU1QzYcIi+lkN78+gsrshLYIyKadze2r2VMng==
X-Received: by 2002:a7b:cc6a:: with SMTP id n10mr5252233wmj.170.1582809290973; 
 Thu, 27 Feb 2020 05:14:50 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:30cb:d037:e500:2b47?
 ([2001:b07:6468:f312:30cb:d037:e500:2b47])
 by smtp.gmail.com with ESMTPSA id z133sm7761100wmb.7.2020.02.27.05.14.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2020 05:14:50 -0800 (PST)
Subject: Re: [PATCH 13/18] docs/system: put qemu-block-drivers body in an
 included file
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200226113034.6741-1-pbonzini@redhat.com>
 <20200226113034.6741-14-pbonzini@redhat.com>
 <CAFEAcA_qWUY19ubmSaNoqbwjf8N8d1Dw=vMMD7j5yH8TSwK35A@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8d38cf7b-5e31-8494-a25b-b673e1170fa9@redhat.com>
Date: Thu, 27 Feb 2020 14:14:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_qWUY19ubmSaNoqbwjf8N8d1Dw=vMMD7j5yH8TSwK35A@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/02/20 12:58, Peter Maydell wrote:
>>  .. toctree::
>>     :maxdepth: 2
>> -
>> -   qemu-block-drivers
> Why do you drop the documentation from the HTML manual ?

I'm adding it back (at the correct place) in patch 18, but it will be
included in images.rst rather than part of the toctree.

>> Secure Shell (ssh) disk images
>> -------------------------------
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> (OTOH, we should probably pick a rST style guide for which
> characters to use for which section headings and follow
> it here to avoid unnecessarily confusing ourselves...)

Right, I was trying to be consistent here between the characters used
here and the characters used in the rest of the manual, so that the file
can be included directly in both the man page and the manual.

Paolo


