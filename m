Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8402DC35640
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 08:56:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EBDF2067D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 08:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SncS0gZQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EBDF2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j546R-0007hD-G4
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 03:56:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44854)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j545J-0006Uc-Uy
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 03:54:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j545I-0000UY-OR
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 03:54:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39203
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j545I-0000RV-LN
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 03:54:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582275296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0nScP8NURmQnyW12ABwiufK0c18ZO5Q8mvjn41sKLQU=;
 b=SncS0gZQXBruBzn9RHNhqHTu2x3dpv61/nkJkhu1ozolOjq772LEBnM51SagdMnj/hnpep
 8rTjAp7yscdYw28JcGayVKOpQ4JbfTdRs/KIo+FnHlVV2TjBggRUOjQkbJMGBTweWIPysq
 mMH2fzT7JZK64lX0DT4eUvULu4edFig=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-TMdpttsiOAazq5EgdapWgQ-1; Fri, 21 Feb 2020 03:54:48 -0500
Received: by mail-wm1-f69.google.com with SMTP id f66so303811wmf.9
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 00:54:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=G7Nx/DyjsZg6rJMq6eb+4sW0WAwWb6KdHo/6bslKtnA=;
 b=geuZCu272Jd9WdYQyUS/KxKx/iR3kfIVvYOdVh8Fa02Rq6qbRPxrOV0NZvhgOiXdSV
 cEryHrjxFUfphHvwPBDtAg8FT+dO0+2rGSRTLqmRZDoyL96H4kxpJZDVOl8lAga62G7i
 1iTbMtm7J3KnImM4klVec9dpKcZ8ZqcSwCbP7VFxW8d1umCAIQud8hcgubcO0dVPwxHJ
 JhWyuGMGHoK5GB1m+U/i8PDA2ZLymagcxaBxCiaDDvEeye+xmli/+NggNDbivMqroQjn
 46bufo9t8WxGtHrbxMzjJ6OwkHtV08VGP95x1kI5qT8ky0gI7pKZWJpiL2yX3aoGUiIt
 EvOg==
X-Gm-Message-State: APjAAAWiIOVDqjHUUAxONrdyRbpgQZ0Q6qNwFCfgMVbXloWipQC7RoHE
 kfsQushQsqsacGoojx+XTURkgxUOSkll6dCCUsjlBuL4KuGkZ6mMvWil3Ofj9wQdcElTAV52f8s
 J625GqVRPaK31+wA=
X-Received: by 2002:a5d:484d:: with SMTP id n13mr46660010wrs.420.1582275287338; 
 Fri, 21 Feb 2020 00:54:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqzTsTyHhabrCqj+WSPuIbTsXiXwsXEQL6zIAZruHIWWLr7kVN5U4qmZl8K5hsFnquNFTQUqFA==
X-Received: by 2002:a5d:484d:: with SMTP id n13mr46659991wrs.420.1582275287128; 
 Fri, 21 Feb 2020 00:54:47 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id e16sm3037518wrs.73.2020.02.21.00.54.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2020 00:54:46 -0800 (PST)
Subject: Re: [PATCH 1/2] riscv: roms: Add 32-bit OpenSBI firmware image for
 sifive_u
To: Anup Patel <anup@brainfault.org>, Bin Meng <bmeng.cn@gmail.com>
References: <1582209758-2996-1-git-send-email-bmeng.cn@gmail.com>
 <f92f1ec7-ac03-a012-f232-32c533beb9d2@redhat.com>
 <CAEUhbmV9ouup0aqrUvEfpGFAoggVNJXw-PLD0xYurBXg+h3OMA@mail.gmail.com>
 <CAAhSdy0edkypzbhhLw2g52F2w6GrS46OKi461Fghuk5AZfCjgQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fa5088d2-2f9a-6df6-3d34-d8c0c7c34df0@redhat.com>
Date: Fri, 21 Feb 2020 09:54:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAAhSdy0edkypzbhhLw2g52F2w6GrS46OKi461Fghuk5AZfCjgQ@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: TMdpttsiOAazq5EgdapWgQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/21/20 6:54 AM, Anup Patel wrote:
> On Fri, Feb 21, 2020 at 8:08 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>>
>> Hi Philippe,
>>
>> On Fri, Feb 21, 2020 at 1:31 AM Philippe Mathieu-Daud=C3=A9
>> <philmd@redhat.com> wrote:
>>>
>>> Hi Bin,
>>>
>>> On 2/20/20 3:42 PM, Bin Meng wrote:
>>>> Although the real world SiFive HiFive Unleashed board is a 64-bit
>>>> hardware configuration, with QEMU it is possible to test 32-bit
>>>> configuration with the same hardware features.
>>>>
>>>> This updates the roms Makefile to add the build rules for creating
>>>> the 32-bit OpenSBI firmware image for sifive_u machine. A pre-built
>>>> OpenSBI image (built from commit 3e7d666) has been added as the
>>>> default bios for 32-bit sifive_u machine.
>>>
>>> With QEMU:
>>>
>>> fatal: ambiguous argument '3e7d666': unknown revision or path not in th=
e
>>> working tree.
>>>
>>> This looks like an OpenSBI commit but QEMU only include up to v0.5.
>>>
>>> Can you build v0.5? Else can you update the submodule?
>>>
>>
>> Will do in v2.
>=20
> We plan to release OpenSBI v0.6 on monday (24th Feb 2020) so maybe
> you can update all RISC-V ROM images based on OpenSBI v0.6 ??

Sounds cleaner.

Suggestions when updating a QEMU git-submodule:


- Include output of submodule 'git-log --reverse --oneline'

- Send series/pull-request with 'git-format-patch --no-binary'

>=20
>>
>>> Also, can you add a CI job to build this, so we have reproducible build=
s
>>> (see QEMU commit 71920809ceabed as example)?
>>
>> I cannot find any document for how to test CI job with gitlab CI. Does
>> QEMU has a public CI runner for testing?

There is:

https://wiki.qemu.org/Testing
https://wiki.qemu.org/Testing/CI

Currently you can use whatever CI best suits you (although long term is=20
probably to rely more on GitLab, because it allows adding runners on=20
particular hardware/setup).

>>
>> Regards,
>> Bin
>>
>=20
> Regards,
> Anup
>=20


