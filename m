Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C1BC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 16:17:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9B7F22DD3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 16:17:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9B7F22DD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0TIK-0002MG-Bz
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 12:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56879)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i0THE-0001kp-PK
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 12:16:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i0THD-0005yP-At
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 12:16:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43036)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i0THD-0005xw-2c
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 12:15:59 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C027A8A4AD
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 16:15:57 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id n13so1020149wmi.4
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 09:15:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gJ5Y0e18LiKdiPobAJw2FFKFDy/Yhb1hPMFJ+EtPDjM=;
 b=CKKO/xTarkhaZYR505Y7ySdP7+SUDyBs8aoizYWWae7bg9aU6FkkicWyWet/Bqg/+c
 rR6EK8+cMklpwlQ7acLImgU2hSRk0INpZkAkhKD6Kzbr0RFmMFWpwMgs2E7z8lsuGohR
 QpKlRaucxj0fd49gjHuTxdaCDiYBycTKl8SA5qXTt6M8kbF+EDyJ2hq4zd2w6ufcnfKH
 66OsngKhZdSOYXh0tnk92JmmlzIObdNBLPbfVixTvNjDghgcyl52HacO1MEPzg88Xp3Q
 RnTUsrS4v7qFb6QpZOuQ7+IpbOTQrlLS0hXIzGJilaRtH0jQIcLUeiMDBJZeSU5JJwDA
 7JQw==
X-Gm-Message-State: APjAAAXcRWSCsI+/+EtoJcEh04dgtKUQ/2H7Kxobzl27Mpj+kQEkQd9l
 J8SecmQ96sTv9VDKPRF6L21xYAnvm9lyDdV4L1yV06DHTC84jYYQ9Gg8jAlg3+7Yw8NVKSR1j+/
 UaSIVKSlv4DaVEUI=
X-Received: by 2002:a1c:2015:: with SMTP id g21mr895493wmg.33.1566404156487;
 Wed, 21 Aug 2019 09:15:56 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxlqSSJFubiPgvydM/DxRIUxbYZTc4wmS5EAm7wj6sET2v/VDsRi4bASK7byYfas82eaa17Rw==
X-Received: by 2002:a1c:2015:: with SMTP id g21mr895460wmg.33.1566404156309;
 Wed, 21 Aug 2019 09:15:56 -0700 (PDT)
Received: from [192.168.1.39] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id r11sm16951127wrt.84.2019.08.21.09.15.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2019 09:15:55 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <BN6PR2201MB1251511E7694854909AFEEB4C6AB0@BN6PR2201MB1251.namprd22.prod.outlook.com>
 <CAFEAcA9UJGXOdNUD49bxmrdoZ5FEv4VLqAvyzDw66MOGsGB=wg@mail.gmail.com>
 <BN6PR2201MB1251C78A16D557867586FFD4C6AB0@BN6PR2201MB1251.namprd22.prod.outlook.com>
 <1fc18db5-abd4-80be-11ee-209dfd4a55f4@linaro.org>
 <ee2c817c-6cb5-6f0a-ea04-da47c0ab67bb@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <43fefe68-1e54-9882-ed30-fcaa046b0bb3@redhat.com>
Date: Wed, 21 Aug 2019 18:15:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ee2c817c-6cb5-6f0a-ea04-da47c0ab67bb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [EXTERNAL]Re: Proposal for amending TCG interface
 naming scheme
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
Cc: Palmer Dabbelt <palmer@sifive.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/20/19 6:46 PM, David Hildenbrand wrote:
> On 20.08.19 17:37, Richard Henderson wrote:
>> On 8/20/19 6:49 AM, Aleksandar Markovic wrote:
>>>> From: Peter Maydell <peter.maydell@linaro.org>
>>>> On Tue, 20 Aug 2019 at 13:50, Aleksandar Markovic
>>>> <amarkovic@wavecomp.com> wrote:
>>>>> The idea is to provide significant "lexicographic" distance between those > groups of functions, rather than having the similar name (wiht common root > "ext) for all of them.
>>>>
>>>> The current naming of the extract/sextract TCG ops is intended to keep
>>>> them in line with the extract32/sextract32/extract64/sextract64 utility
>>>> functions in bitops.h. I think those ones are reasonably named. The
>>>> other ops are a bit more ad-hoc in naming, admittedly...
>>>>
>>>
>>> How about
>>>
>>> tcg_gen_extract2_i32
>>> tcg_gen_extract2_i64
>>> tcg_gen_extract2_tl
>>> tcg_gen_extrl_i64_i32
>>> tcg_gen_extrh_i64_i32
>>> tcg_gen_ext_i32_i64
>>> tcg_gen_extu_i32_i64
>>>
>>> to
>>>
>>> tcg_gen_gather_i32
>>> tcg_gen_gather_i64
>>> tcg_gen_gather_tl
>>
>> I'm not sure how "gather" applies.  To me this sounds like a vector
>> scatter/gather operation, where N different addresses are used to load the N
>> elements of the vector.
>>
>> When extract2 was named, I was only thinking "extract" because of how the
>> AArch64 instruction that implements this operation is named (EXTR), and "extr"
>> itself was already taken.  We did ask for naming suggestions at the time, but
>> no better ideas were floated...
>>
>> Would it be clearer to use the x86 instruction name: SHRD (SHift Right Doubleword)?
>>
> 
> I still think your proposal back then made sense - extract2. Extract a
> 64bit value from a 128bit value.

It is also valid to extract 32bit from 64bit.

