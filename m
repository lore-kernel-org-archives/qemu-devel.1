Return-Path: <SRS0=IrLN=YF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC691C4360C
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 07:23:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D1AC206CD
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 07:23:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D1AC206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJBkg-0001VQ-Qn
	for qemu-devel@archiver.kernel.org; Sat, 12 Oct 2019 03:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49639)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iJBk1-000166-6l
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 03:23:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iJBk0-0003Pt-0N
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 03:23:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52278)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iJBjz-0003Pd-Ol
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 03:23:03 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8AB54862A
 for <qemu-devel@nongnu.org>; Sat, 12 Oct 2019 07:23:02 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id w2so5525397wrn.4
 for <qemu-devel@nongnu.org>; Sat, 12 Oct 2019 00:23:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=v2LMwy6POXfv4gzizTfVGwXVreuBOTbhgRJQ669+H6o=;
 b=nFosfvYA5EnhhYnQFNGvxmN3Pd71tv6gLnzlkOYD5rAt4gZTTE/s8EbiPdhPuGeRse
 ikbqKC7elktPpYW2VlPx4ExUfubLX0FOnzjly5iOpEwGVJuR01BUOUXAzZgjshNwlZcP
 XW8MuzMMAczw7TTkL3zgv+zQUFuDyiLLTv/4hG2/jeinUM+6+OOdoEZP83I+bAC0VpQE
 KWbXbvbC4comb5yWhK70O2cAfc8VqxY/KHd2RpA8pito1mVc3Tp1Sk0czglKCdUDJi1k
 oZfxt89heZh7y+KA+MnWWbiDqGU3R5BG9fPiwYfUDrMor4is9rT0KPnR2WKzZ2hOregW
 qEiQ==
X-Gm-Message-State: APjAAAVgcPZJHptvudsAOcRcaJcoMicJ/kpJFFx753B/bMCUvYO8U6Mh
 U2qns+4dZTxBxZ/G+Os228tNolK3QrgA7X9BJqEg0TueXJ35wiKHgTjJhN+cIQ0qkim3xUmKrMa
 f88Qs5hrtGXrqZco=
X-Received: by 2002:a1c:f417:: with SMTP id z23mr6484495wma.77.1570864981276; 
 Sat, 12 Oct 2019 00:23:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwQoiGnFm4sd9lpGCImemXhiXk4gMRhQ9sUsYoFQe1U27FH7VdEfvzVy4hCZmDjbGii+IoP3A==
X-Received: by 2002:a1c:f417:: with SMTP id z23mr6484477wma.77.1570864981072; 
 Sat, 12 Oct 2019 00:23:01 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id q192sm13023573wme.23.2019.10.12.00.22.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Oct 2019 00:23:00 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v29 1/8] target/avr: Add outward facing
 interfaces and core CPU logic
To: Sarah Harris <S.E.Harris@kent.ac.uk>, Thomas Huth <thuth@redhat.com>
References: <20190824184635.34192-1-mrolnik@gmail.com>
 <20190824184635.34192-2-mrolnik@gmail.com>
 <55f37e1b-8ed3-b295-0298-4299279e4043@redhat.com>
 <CAK4993iY908S85hvHT64+Zo=AG8ihoTnTsFEJQSNBew7TBWWTg@mail.gmail.com>
 <54f5b717-4864-9e42-155e-a2ab2e041f02@redhat.com>
 <20190827115954.d2f925de4c0f7c063a7e7131@kent.ac.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b60d0bc3-27f8-2dec-979a-f724106c2347@redhat.com>
Date: Sat, 12 Oct 2019 09:22:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190827115954.d2f925de4c0f7c063a7e7131@kent.ac.uk>
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Michael Rolnik <mrolnik@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/27/19 12:59 PM, Sarah Harris wrote:
> I don't mind if you want to drop my signed-off-by for commits that were=
 based on Michael's work.
> You probably want to keep my sign-off for the USART/timer commit though=
 as that was new code.

Linux offers a Co-developed-by, some QEMU developers started to use it.

   Co-developed-by: states that the patch was co-created by multiple
   developers; it is a used to give attribution to co-authors (in
   addition to the author attributed by the From: tag) when several
   people work on a single patch. Since Co-developed-by: denotes
   authorship, every Co-developed-by: must be immediately followed
   by a Signed-off-by: of the associated co-author. Standard sign-off
   procedure applies, i.e. the ordering of Signed-off-by: tags should
   reflect the chronological history of the patch insofar as possible,
   regardless of whether the author is attributed via From: or
   Co-developed-by:. Notably, the last Signed-off-by: must always be
   that of the developer submitting the patch.

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#wh=
en-to-use-acked-by-cc-and-co-developed-by

>=20
> Regards,
> Sarah Harris
>=20
> On Mon, 26 Aug 2019 10:00:51 +0200
> Thomas Huth <thuth@redhat.com> wrote:
>=20
>> On 26/08/2019 09.53, Michael Rolnik wrote:
>>> the commit was originally mine. Then Sarah rearranged it, signed and
>>> submitted. She no longer maintains it. So' I believe I can remove her=
 sob.
>>> what do=C2=A0you think?.
>>
>> Fine for me, but maybe you should mention her in the patch description
>> if she made significant changes?
>>
>> Sarah, what do you think?
>>
>> Anyway, if the patch is originally from you, you should also remove th=
e
>> "From: Sarah ..." line from the patch. For this, you likely have to
>> change the author of the patch in your git tree with "git commit --ame=
nd
>> --reset-author".
>>
>>   Thomas

