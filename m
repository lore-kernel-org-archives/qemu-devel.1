Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1608CA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 14:56:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 694A42070B
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 14:56:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 694A42070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iONUj-0007xd-Jm
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 10:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51485)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iONTl-0006iD-DE
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 10:55:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iONTj-0007zc-06
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 10:55:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47742)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iONTi-0007yC-OP
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 10:55:42 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E9A7AC049E10
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 14:55:40 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id g13so2608285wme.0
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 07:55:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8zX7ckHm+kYgBFLo3mJLgsenQCngnbAdH53djMSOBuE=;
 b=FK7SGdoUskSdk4XP8Iwo3nKWKjCt4hGuntxuFBTgS7CXfbClKXoiAjA/1UQW7hZRjP
 DNc+ao/xm1WH1YhNWixPE+d5/n7TLjG1pV7HnfchJcEWMhHROea3+ojl7L5tMPpXeQHQ
 34vFQSp5jIT+fV0PJZUUcMahIH5DjTZJBkDtL8OPrBCQvQzv1Vz2kPmYPpeZHu95neW5
 XdcuJlSbvcJwuJZVO94aceEeOT1H8WvgiG4nbGz2EGADk5qYPj2CaZzh9N0eyhsGjMYh
 RuB3GmKkA2tP8JxbXkNHlfVYyrGib8Ebhdlp0NGmyHlNJ1jK182WVn9jwn6ezexqRyUo
 mjhQ==
X-Gm-Message-State: APjAAAX8Mv9lATVsrfZ5Ha9TKTA2Eu6ENwFm8u8kmfM3sDna/IPTe3Zz
 myXrj4za1u48uEvmGGK7FciP15VqnvFWn/fCETJrf+5Qoty7iHFHOzaPcYs/VBBurfatdIIfKTy
 wcRdAe6VrOCyk38A=
X-Received: by 2002:a1c:41c1:: with SMTP id o184mr8544596wma.81.1572101739679; 
 Sat, 26 Oct 2019 07:55:39 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyHmG0QaS3yj2RoVDENOtlrUsjSIHVtTYi/TA0bpaiPndS4e+B3B+PBwjK9grChiUetuMxyTw==
X-Received: by 2002:a1c:41c1:: with SMTP id o184mr8544579wma.81.1572101739433; 
 Sat, 26 Oct 2019 07:55:39 -0700 (PDT)
Received: from [192.168.1.33] (62.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.62])
 by smtp.gmail.com with ESMTPSA id f6sm7845073wrm.61.2019.10.26.07.55.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Oct 2019 07:55:38 -0700 (PDT)
Subject: Re: [PATCH 0/5] hw/i386/pc: Extract pc_gsi_create() and
 pc_i8259_create()
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Sergio Lopez <slp@redhat.com>
References: <20191018135910.24286-1-philmd@redhat.com>
 <22db5316-648a-9416-87b5-a76772e8539e@redhat.com>
 <aac6bd30-317b-d8a2-6442-6f3d37941785@redhat.com>
Message-ID: <f5d9b8c9-302e-336d-5737-3fe421d793a1@redhat.com>
Date: Sat, 26 Oct 2019 16:55:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <aac6bd30-317b-d8a2-6442-6f3d37941785@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
Cc: Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Paolo,

On 10/22/19 7:32 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 10/22/19 6:55 PM, Paolo Bonzini wrote:
>> On 18/10/19 15:59, Philippe Mathieu-Daud=C3=A9 wrote:
>>> These are few patches extracted from the previous too big series:
>>> hw/i386/pc: Split PIIX3 southbridge from i440FX northbridge
>>> https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg03685.html
>>>
>>> Dropped "Move kvm_i8259_init() declaration to sysemu/kvm.h" (thuth),
>>> no logical changes:
>>
>> I queued this, but neither I nor patchew got patch 5.=C2=A0 I just got=
 it
>> from the PIIX3/i440FX series.

In the patch 'hw/i386: Introduce the microvm machine type'
Sergio uses gsi_handler(), so you need to drop 'hw/i386/pc:
Reduce gsi_handler scope' to keep microvm building.

> Odd... Yes this is the same patch resent with no change. Thanks for
> noticing this and carrying about finding it!
>=20
>>
>> paolo
>>
>>> $ git backport-diff -u pc_split_i440fx_piix-v1
>>> Key:
>>> [----] : patches are identical
>>> [####] : number of functional differences between upstream/downstream=
=20
>>> patch
>>> [down] : patch is downstream-only
>>> The flags [FC] indicate (F)unctional and (C)ontextual differences,=20
>>> respectively
>>>
>>> 001/5:[----] [-C] 'hw/i386/pc: Extract pc_gsi_create()'
>>> 002/5:[----] [--] 'hw/i386/pc: Reduce gsi_handler scope'
>>> 003/5:[----] [--] 'hw/i386/pc: Move gsi_state creation code'
>>> 004/5:[----] [--] 'hw/i386/pc: Extract pc_i8259_create()'
>>> 005/5:[----] [--] 'hw/i386/pc: Remove kvm_i386.h include'
>>>
>>> Based-on: <20191018134754.16362-1-philmd@redhat.com>
>>> hw/i386/pc: Split PIIX3 southbridge from i440FX northbridge [v2]
>>> https://mid.mail-archive.com/20191018134754.16362-1-philmd@redhat.com
>>>
>>> Philippe Mathieu-Daud=C3=A9 (5):
>>> =C2=A0=C2=A0 hw/i386/pc: Extract pc_gsi_create()
>>> =C2=A0=C2=A0 hw/i386/pc: Reduce gsi_handler scope
>>> =C2=A0=C2=A0 hw/i386/pc: Move gsi_state creation code
>>> =C2=A0=C2=A0 hw/i386/pc: Extract pc_i8259_create()
>>> =C2=A0=C2=A0 hw/i386/pc: Remove kvm_i386.h include
>>>
>>> =C2=A0 hw/i386/pc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
 36 +++++++++++++++++++++++++++++++++++-
>>> =C2=A0 hw/i386/pc_piix.c=C2=A0=C2=A0=C2=A0 | 23 ++-------------------=
--
>>> =C2=A0 hw/i386/pc_q35.c=C2=A0=C2=A0=C2=A0=C2=A0 | 28 ++++------------=
------------
>>> =C2=A0 include/hw/i386/pc.h |=C2=A0 3 ++-
>>> =C2=A0 4 files changed, 43 insertions(+), 47 deletions(-)
>>>
>>

