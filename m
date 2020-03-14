Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78818C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 14:04:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C06920684
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 14:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GnaWuTfR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C06920684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD7PF-0001Mq-Bg
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 10:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60703)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jD7OV-0000xh-LT
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 10:04:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jD7OU-0001Vc-Bk
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 10:04:03 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24625
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jD7OU-0001QX-5b
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 10:04:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584194641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dFwK+q+BCG+yHMYkTc5Wb7u0wGu76W1Hgd8cLsglZWc=;
 b=GnaWuTfRayNGWzAdfFYWleLZgG9W8bkpc27eX9D90bDnL7Mvk9sU9+ylpQuFMsJXA+RhFV
 SMJF6TfVHv8oZdu8UOMXp5lrYuhd8Iy3OAbXcWNki3TyQvt3u0Do0EiktJhNeL6b8PcLj1
 H/6ONOke1NMjDblaYHq6zPcoCfqtRvE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-8oYN4EkwN964FwMn-enldQ-1; Sat, 14 Mar 2020 10:03:59 -0400
X-MC-Unique: 8oYN4EkwN964FwMn-enldQ-1
Received: by mail-wr1-f72.google.com with SMTP id o9so5999531wrw.14
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 07:03:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dFwK+q+BCG+yHMYkTc5Wb7u0wGu76W1Hgd8cLsglZWc=;
 b=bZz3nU+5TU65v6swVhRY16swUYlrW/F8OQVgClVUvCHA9dbqubKI+gmscz8r+ac72d
 QVGRjXVkMWaRzA7RM5LKoc1+37TuFjo6wSgzymg+n7fs+I3lNZQUNUyC90HfHBsA2AWt
 oSSJvsY1tOfJzH7kZ+Azp2kMMWiHTUEo79Uowsy0YApQJuoxbZ6vboit469T/jokCl1L
 8kPLm2415W3S7AFkrdlR2FtZW25tVdCVpw07dzhmMitl5yEwgZLnRa+od+6A/yZKni1x
 XC0vYu74u1FecoIzxCCtV8w1U9aFhtUvFchkOD97K886oI35+/PPaXWNniZCW/2xvsnj
 ArsA==
X-Gm-Message-State: ANhLgQ1YAFtCMrl5EaZ/4q8rirhiQN6FUXU2wTz7bPUBlSSfSV3k8H2w
 8kQpJVIkMBR0FpHuy5AjTZxdSw0RFJ0wmwd8GNQj65gLXt186PK6/zZpG7wVMUHd44H7AdiruGR
 VxPZxHIJCRNSwcrM=
X-Received: by 2002:a5d:4682:: with SMTP id u2mr7798998wrq.399.1584194638175; 
 Sat, 14 Mar 2020 07:03:58 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtR1jFazTTcJavUO00/w9FfX16B/P9B7hrRYEr+cAZydcYzwwywnnz89NSS8zU/8l7//wOVcw==
X-Received: by 2002:a5d:4682:: with SMTP id u2mr7798972wrq.399.1584194637902; 
 Sat, 14 Mar 2020 07:03:57 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7de8:5d90:2370:d1ac?
 ([2001:b07:6468:f312:7de8:5d90:2370:d1ac])
 by smtp.gmail.com with ESMTPSA id k126sm21444870wme.4.2020.03.14.07.03.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 07:03:57 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] mac_via: fix incorrect creation of mos6522 device
 in mac_via
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200305065422.12707-1-pannengyuan@huawei.com>
 <20200305065422.12707-3-pannengyuan@huawei.com>
 <CAFEAcA_twjUHpvf5ZpzA_bKyf8MZ4BuSY0MvNTgSEyVTYf9mXQ@mail.gmail.com>
 <0b2d3222-d122-e0db-db04-1c4e3028f8f8@huawei.com>
 <CAFEAcA9PQd=PwuF+j=3kOA_eCiRd_8TLEwPx8qB-jWvV_9CcMQ@mail.gmail.com>
 <0c3ae5aa-36c3-a809-4a42-159348f44780@huawei.com>
 <CAFEAcA8_RkECOT=YJ3ML0wxBrKiqVw=CssORU=jyryfcNueB0w@mail.gmail.com>
 <871rq08tn9.fsf@dusky.pond.sub.org>
 <eca27715-554d-2c2e-5e58-ffd01abb654c@ilande.co.uk>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e1ae65dd-f9cd-b0ee-0ea6-f3c2b010fdab@redhat.com>
Date: Sat, 14 Mar 2020 15:03:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <eca27715-554d-2c2e-5e58-ffd01abb654c@ilande.co.uk>
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Pan Nengyuan <pannengyuan@huawei.com>, Laurent Vivier <laurent@vivier.eu>,
 QEMU Developers <qemu-devel@nongnu.org>, Euler Robot <euler.robot@huawei.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/03/20 14:19, Mark Cave-Ayland wrote:
>> Observe that mac_via_init() has obvious side effects.  In particular, it
>> creates two devices that are then visible in "info qtree", and that's
>> caught by device-introspect-test.
>>
>> I believe these things need to be done in .realize().

That is not a problem; the devices should be removed when the device is
finalized.  In theory the steps would be:

- the child properties are removed

- this causes unparent to be called on the child devices

- this causes the child devices to be unrealized

- this causes the child devices to remove themselves from their bus (and
from "info qtree")

- this causes the refcount to drop to zero and the devices to be
finalized themselves.

The question is why they are not, i.e. where does the above reasoning break.

So, sysbus_init_child_obj is fine.

Paolo


