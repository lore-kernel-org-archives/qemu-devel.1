Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915BACA9EB7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 17:34:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EA9220700
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 17:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EA9220700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMy34-00063w-Hi
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 13:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50405)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMy1j-0005Vp-GG
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 13:33:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMy1g-0008Hs-T8
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 13:32:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40908)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMy1g-0008HS-LO
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 13:32:56 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 17C67C04AC50
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 17:32:55 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id z205so7798984wmb.7
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 10:32:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qKfAao7pCi9HzPG9klIVg5xq0ShvtMXGHraAxDS4OAs=;
 b=RgCfy2ZG5+jwGBjSL1YLLA1XN0DClJci27wVszk+hRWK9VWer3IXsyHcOpylUALR2n
 bhtGVamlcBFJl21VIX7ad1vhZvsAJMmOZfdxCmBifuVo4GJsjgbNGBK3wl/IErHM/tDv
 RYQcu2B7pCIdJH/eS1MyEl9quAE8+/XDYaLNcwYxKjOjIB7oOo6IBMWPoeoW6Pi3h01l
 xIa+YCeDSanLtptsLAY/fbVJzEoBNHsAm/wQwwGo6jTpZGr4CSbSa+ZgRLa9U3Ku+eBC
 Z9ckBG3TyIljPt+hE/lgOvfiwYzquH/JgopC4juCNTjkEtX/dstZbzyxgTRRPmev6IIg
 E4eg==
X-Gm-Message-State: APjAAAU8zJ1W1a18HM6yC3FIFNr4qkTzoZVakGKnoZ8qaYcU8si7r6cr
 me8RlmWTEg8wBfIOL8fkPwN4D//j6m+4s/aZ35dE5XoP9vs1StSyr4w2kItxdXj98Vkrd6L/dUn
 Rxzvj5AM5eZoH4i8=
X-Received: by 2002:a5d:4701:: with SMTP id y1mr4784782wrq.385.1571765573799; 
 Tue, 22 Oct 2019 10:32:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxhAQ6GFH58QKv6VXuWy0IbsVz/USuNhFa92orINTG8+IApgym4IDZgtH45P0dkGhI9CDiCtA==
X-Received: by 2002:a5d:4701:: with SMTP id y1mr4784755wrq.385.1571765573553; 
 Tue, 22 Oct 2019 10:32:53 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id 17sm7439727wmg.29.2019.10.22.10.32.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2019 10:32:52 -0700 (PDT)
Subject: Re: [PATCH 0/5] hw/i386/pc: Extract pc_gsi_create() and
 pc_i8259_create()
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20191018135910.24286-1-philmd@redhat.com>
 <22db5316-648a-9416-87b5-a76772e8539e@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <aac6bd30-317b-d8a2-6442-6f3d37941785@redhat.com>
Date: Tue, 22 Oct 2019 19:32:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <22db5316-648a-9416-87b5-a76772e8539e@redhat.com>
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
Cc: Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/22/19 6:55 PM, Paolo Bonzini wrote:
> On 18/10/19 15:59, Philippe Mathieu-Daud=C3=A9 wrote:
>> These are few patches extracted from the previous too big series:
>> hw/i386/pc: Split PIIX3 southbridge from i440FX northbridge
>> https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg03685.html
>>
>> Dropped "Move kvm_i8259_init() declaration to sysemu/kvm.h" (thuth),
>> no logical changes:
>=20
> I queued this, but neither I nor patchew got patch 5.  I just got it
> from the PIIX3/i440FX series.

Odd... Yes this is the same patch resent with no change. Thanks for
noticing this and carrying about finding it!

>=20
> paolo
>=20
>> $ git backport-diff -u pc_split_i440fx_piix-v1
>> Key:
>> [----] : patches are identical
>> [####] : number of functional differences between upstream/downstream =
patch
>> [down] : patch is downstream-only
>> The flags [FC] indicate (F)unctional and (C)ontextual differences, res=
pectively
>>
>> 001/5:[----] [-C] 'hw/i386/pc: Extract pc_gsi_create()'
>> 002/5:[----] [--] 'hw/i386/pc: Reduce gsi_handler scope'
>> 003/5:[----] [--] 'hw/i386/pc: Move gsi_state creation code'
>> 004/5:[----] [--] 'hw/i386/pc: Extract pc_i8259_create()'
>> 005/5:[----] [--] 'hw/i386/pc: Remove kvm_i386.h include'
>>
>> Based-on: <20191018134754.16362-1-philmd@redhat.com>
>> hw/i386/pc: Split PIIX3 southbridge from i440FX northbridge [v2]
>> https://mid.mail-archive.com/20191018134754.16362-1-philmd@redhat.com
>>
>> Philippe Mathieu-Daud=C3=A9 (5):
>>    hw/i386/pc: Extract pc_gsi_create()
>>    hw/i386/pc: Reduce gsi_handler scope
>>    hw/i386/pc: Move gsi_state creation code
>>    hw/i386/pc: Extract pc_i8259_create()
>>    hw/i386/pc: Remove kvm_i386.h include
>>
>>   hw/i386/pc.c         | 36 +++++++++++++++++++++++++++++++++++-
>>   hw/i386/pc_piix.c    | 23 ++---------------------
>>   hw/i386/pc_q35.c     | 28 ++++------------------------
>>   include/hw/i386/pc.h |  3 ++-
>>   4 files changed, 43 insertions(+), 47 deletions(-)
>>
>=20

