Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A08EC3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 10:47:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F31CE205C9
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 10:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OELxCaZ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F31CE205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQTxw-0002tV-6P
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 06:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58264 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jQTuS-0006fB-1R
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 06:44:16 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jQTuQ-0007Nz-8t
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 06:44:15 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22836
 helo=us-smtp-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jQTuP-0007Ll-RS
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 06:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587379449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bc6eIxxy3ZCmKxtQ46FNChc6DV2SqQpWx9zlOiSS+j0=;
 b=OELxCaZ/yP2MTucIbcCvTeTirwBkt1GZLM4wADZtMmu4NQ0XE+9nxtZ1+8cnM9N2CuQWIC
 jSWf396UCvSFOAYul7twh9JdCGOY7Gd1YfKgXNkCwYfx4NCPeLfhI/VfpLNIxy9jeTaY09
 xgyCH7WzeRDbyJUQ/QzOqV7LEuqeWVw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-SphKJCpxNb6kCXetDZxX7w-1; Mon, 20 Apr 2020 06:44:05 -0400
X-MC-Unique: SphKJCpxNb6kCXetDZxX7w-1
Received: by mail-ed1-f71.google.com with SMTP id v21so3464938edq.14
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 03:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=T/xjJsUgF778LpNzZZV/h2y2cV6lCn7Ce6da2WhB8fs=;
 b=n9bW3LAnWYzd8lX3JjOzEQdHjJ3jjmUIw7jmiYRnIp0W4z0GNbNP5vMEjOV03Pd2Ak
 Pu/Oir+VxQc5ZlA6FqTiEYCPgRJ78gCKedKtQQwDPfVrUMK+YhifNq46rrxHT7GIQGyJ
 Wsrcfy08UbyM/hxykPvKJzKwy1c0ZfczocWiVF9McwxdfePATHR3d3beXIfPOYQGsaLc
 z41uNN2dOWCQo8C4pvS1byTRl4p5TvIqrUhTg3mRMSg597cL8S+KQvn521OsvW3SJREL
 C5aoFqmHlW8yrR26BV/Kt0ZhFjg0JMYGPZ1j6QiqWzLPplbxCmH3BV4P3aGjFGBAU+Lh
 2S6Q==
X-Gm-Message-State: AGi0Pub4Xs4L8f8hfsgMD4CQcVc4RNieMGuvOC3FSaO5llkiWeD6f/z4
 R92TQqHtgl1w/LeMSYdes+JUeDGiPCapv8zUNorTJTrVc13sbfmbti3hhzovDf7pbbuwuHSePUJ
 fCik53MS6KEDCbK4=
X-Received: by 2002:a17:906:298f:: with SMTP id
 x15mr15459766eje.380.1587379444245; 
 Mon, 20 Apr 2020 03:44:04 -0700 (PDT)
X-Google-Smtp-Source: APiQypKapnJbCH/Kuk3uuqBQKtd5dm/azVYbWC7aCH/L/nUed6lIVglsjt8ASpV3nhRhiQz38THiWA==
X-Received: by 2002:a17:906:298f:: with SMTP id
 x15mr15459754eje.380.1587379444049; 
 Mon, 20 Apr 2020 03:44:04 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id mj1sm107969ejb.6.2020.04.20.03.44.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2020 03:44:03 -0700 (PDT)
Subject: Re: [PATCH v3 01/19] target/arm: Rename KVM set_feature() as
 kvm_set_feature()
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200316160634.3386-1-philmd@redhat.com>
 <20200316160634.3386-2-philmd@redhat.com>
 <cb3178f1-5a0c-b11c-a012-c41beeb66cd2@linaro.org>
 <3dc0e645-05a5-938c-4277-38014e4a68a3@redhat.com>
 <f4ee109e-b6fc-8e1b-7110-41e045e58c30@redhat.com>
 <CAFEAcA8z5t__ZQQSqx88nMcC26SHowa3AjtDaQQFaPn-p-FYYQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7f49bc68-8c40-42b9-7810-fc1f9f6ff904@redhat.com>
Date: Mon, 20 Apr 2020 12:44:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8z5t__ZQQSqx88nMcC26SHowa3AjtDaQQFaPn-p-FYYQ@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 01:47:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 kvm-devel <kvm@vger.kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/19/20 9:58 PM, Peter Maydell wrote:
> On Sun, 19 Apr 2020 at 17:31, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com> wrote:
>>
>> On 3/17/20 10:09 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> On 3/16/20 9:16 PM, Richard Henderson wrote:
>>>> On 3/16/20 9:06 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>> +++ b/target/arm/kvm32.c
>>>>> @@ -22,7 +22,7 @@
>>>>>    #include "internals.h"
>>>>>    #include "qemu/log.h"
>>>>> -static inline void set_feature(uint64_t *features, int feature)
>>>>> +static inline void kvm_set_feature(uint64_t *features, int feature)
>>>>
>>>> Why, what's wrong with the existing name?
>>
>> Peter suggested the rename here:
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg641931.html
>=20
> In that message I suggest that if you move the set_feature()
> function to cpu.h (which is included in lots of places) then
> that is too generic a name to use for it. The function of
> the same name here in kvm32.c is fine, because it's
> 'static inline' and only visible in this file, so the bar
> for naming is lower. (In fact, it's a demonstration of why
> you don't want a generic name like 'set_feature' in a widely
> included header file.)

And your suggestion is indeed obviously correct...

Apparently after 19 months rebasing this work I'm not seeing clearly.

Thanks again!


