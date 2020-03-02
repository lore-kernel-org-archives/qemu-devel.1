Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAC6C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:23:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E278214DB
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iMKXKL9q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E278214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8pj6-00028G-Od
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 13:23:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43563)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j8pfC-0002Vg-R4
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:19:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j8pf7-0001C7-Oi
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:19:34 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26306
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j8pf6-00019j-Kd
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:19:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583173153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UuAf5Rd4AEhOI0FeYxtu80ZH9uOdGMfHPGF2bBYkPtw=;
 b=iMKXKL9qI07O8PFF35mBIbEwZIr0VOLFURMLs8aTg8fAbzv8AD57fJ3Jr8OtC3j0W0Nw6B
 GNmHLbVNXLm9alWTX5KnuAliOqfCzO1Kn0GdhZKNug4W7jE5CzOEsUJ3DscU9JbZsL6BI5
 vJY2gE+EE/LhJAgeOc5Pp/k0c/ELdJc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-x8Fj5TG3Nfeafc209sfNVg-1; Mon, 02 Mar 2020 13:19:12 -0500
X-MC-Unique: x8Fj5TG3Nfeafc209sfNVg-1
Received: by mail-wr1-f70.google.com with SMTP id p11so64198wrn.10
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 10:19:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UuAf5Rd4AEhOI0FeYxtu80ZH9uOdGMfHPGF2bBYkPtw=;
 b=QOStbBL5RywL4NSprhRnoYPYXLG9pGNS8MCooZr9WRm6ffTx+JsBShCtb4/ZagdJQd
 Vo+l/4IwSiK5Cu5P5yyJI3pte6iJ2amV4ZR0eNGM7dnMqp+jzB0hiu73/5EI58U3l2gC
 F48VaOyAiSksscKcK9gtgf6Py5NlAOt4v5rPzY52zBkZ+wKdv7los8St03ASIzejh3yu
 5Kp3v7Lac0r44GJ1xxN/+QzPDcJqATH5yUjLr1/WS/3EAS47+bt7jk8TtRzWdL9/5Hr6
 sKIaUI3VYjVzvsnj+RrV4YT7HkOhqf7Q8BDd7xOLOIQxvbL5hkehtE7CCsbCTFbP7yQc
 SbfQ==
X-Gm-Message-State: ANhLgQ0k/pUnY3R1hhQ9KoqXO96C1wp4mYbqao/GMwveVDfXwUZQ6wtD
 YyGefpbO83f89XjAvDfqdy2+lLY0w3AY9mX9urk+5OYseNoPc9Npmp6U0m9qp5wMooAqc9XnFF7
 nHHcYj/NmLkfqmi8=
X-Received: by 2002:a1c:1f0c:: with SMTP id f12mr274440wmf.179.1583173150896; 
 Mon, 02 Mar 2020 10:19:10 -0800 (PST)
X-Google-Smtp-Source: ADFU+vt00ze5X6p7yyQRm/R5Mmg6gcrhIp16P9jmt/u6WfjTv9OWYFDVKs/mYItKCARoffhG8/qYhA==
X-Received: by 2002:a1c:1f0c:: with SMTP id f12mr274426wmf.179.1583173150707; 
 Mon, 02 Mar 2020 10:19:10 -0800 (PST)
Received: from ?IPv6:2a01:e35:2fb0:49e0:3f7b:4b69:b9c:cdc0?
 ([2a01:e35:2fb0:49e0:3f7b:4b69:b9c:cdc0])
 by smtp.gmail.com with ESMTPSA id h20sm6620401wrc.47.2020.03.02.10.19.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2020 10:19:10 -0800 (PST)
Subject: Re: CPU reset vs DeviceState reset
To: Eduardo Habkost <ehabkost@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <CAFEAcA9rQ4_o53zfsdcGZWse3eYWksYJdYHLeUFhq6TcBX3_zw@mail.gmail.com>
 <20200302174551.GK4440@habkost.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c73a059c-6d6f-607d-0cdb-fbc515b45edf@redhat.com>
Date: Mon, 2 Mar 2020 19:19:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200302174551.GK4440@habkost.net>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

On 3/2/20 6:45 PM, Eduardo Habkost wrote:
> My impression is that this is just historical legacy, but I'm not
> sure how much work a conversion to the new system would require.
> I see lots of cpu_reset() calls scattered around the code.
> 
> To make it worse, TYPE_CPU do have a DeviceClass::reset method
> implemented, but cpu_reset() won't call it because it bypasses
> the Device reset system completely.  I will do some git
> archaeology work to try to find out why the code is this way.

Without verifying the code base/commits, my understanding is that was 
required to use cpu object with linux-user before Markus added support 
for anonymous object container for QOM objects on linux-user. So now we 
could make CPUClass inherits of DeviceClass.

> 
> 
> On Mon, Mar 02, 2020 at 05:20:33PM +0000, Peter Maydell wrote:
>> Hi; I've just noticed that although TYPE_CPU is a subclass of
>> TYPE_DEVICE, it seems to implement its own reset method
>> ('reset' field in CPUClass struct) rather than just using the
>> DeviceClass's 'reset'.
>>
>> Is there a reason for doing this, or is it just historical legacy
>> from TYPE_CPU originally not being a subclass of TYPE_DEVICE?
>>
>> I ask because I'd like to be able to use 3-phase reset in the Arm
>> CPU, and I'm wondering whether it would be better to make TYPE_CPU
>> just use Device's reset system, or to treat TYPE_CPU as its own
>> base class and implement Resettable there. The former seems more
>> straightforward, unless I'm missing something that means we
>> really do need to have the reset method be different.
>>
>> thanks
>> -- PMM
>>
> 


