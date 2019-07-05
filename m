Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5CEC46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 10:14:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B860A2083B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 10:14:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B860A2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjLEt-0004B5-R0
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 06:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50580)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hjLDb-0003ZW-5z
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 06:13:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hjLDa-0005Ph-7e
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 06:13:27 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:35483)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hjLDa-0005NZ-1A
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 06:13:26 -0400
Received: by mail-wr1-f46.google.com with SMTP id y4so728346wrm.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 03:13:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lz8uIKBOGRPpvTa2r5GFApbRj6S1ohxdUrxtdsVp+8o=;
 b=PRArDgHMikn5feDb9Mbp4u7lUtubA40Ry/kOV9l1HaOKJy4As5ccxVa4XkJDLMGQMs
 L5c0hcbO5unurpDKshjyvJl8Z3ykBYSmsYxGHWIujqwG9N+4+4YrTmmyn9zHu2t8iY6n
 rtdICD5RBXiictCJd+5gfsYq2J/eQ8f677YolLIXFZPvEmITtxMRarn6FNKVJobFIKMc
 mPGrHsnvvXjCxxPOrJjNYjQmXQtxq4nInGifUzB9uPYm1XX7GzzTL/orQT8OUzt7Nr7w
 AvGp8MprhkvMHp2thVVosKw1TtO1xP37uk/9mC0kR1Q4xGnqnun7yV5rbJHmXqWKYUE7
 SHYQ==
X-Gm-Message-State: APjAAAUDZ9l7cZAUea9LSQCFjc5rPFasFXtgc5fK6KEkTkOmVZ5peQF0
 Vtp+Howtf1FcffrG0skdYBlaSKzRxps=
X-Google-Smtp-Source: APXvYqyQDoj5ryEcTfHgRcldD+cEFzW22T4gpwJCtOoqoKrFqmHPh6+v+jGPWfbT70yVO72pfQLuwA==
X-Received: by 2002:a5d:5589:: with SMTP id i9mr3314618wrv.198.1562321604695; 
 Fri, 05 Jul 2019 03:13:24 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:19db:ad53:90ea:9423?
 ([2001:b07:6468:f312:19db:ad53:90ea:9423])
 by smtp.gmail.com with ESMTPSA id 66sm6917211wma.11.2019.07.05.03.13.24
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jul 2019 03:13:24 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <CAFEAcA-yzWhwYPzC9px0H-=x3XEPVBjZOhk402is49YpbmJX9g@mail.gmail.com>
 <ac682594-fac7-ca67-2cef-85db15920c7c@redhat.com>
 <CAFEAcA-giDCA8ZTR3Ft3ZNQUBEJBaXNaMnZOmgPo3Auw1gvZjg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <faeb493b-f61b-16fe-3aff-aa40dffaf06b@redhat.com>
Date: Fri, 5 Jul 2019 12:13:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-giDCA8ZTR3Ft3ZNQUBEJBaXNaMnZOmgPo3Auw1gvZjg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.46
Subject: Re: [Qemu-devel] pl031 time across vm save/reload
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

On 05/07/19 11:58, Peter Maydell wrote:
> On Fri, 5 Jul 2019 at 10:48, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> You're right, the compatibility causes wrong behavior for the default
>> -rtc settings (the RC pauses across migration).  The right thing to do
>> would be to store the base rather than the offset: that is, you store
>> the time at which LR was written.  Then the offset is s->lr - s->base
>> and it's independent of the machine on which the rtc_clock is being read.
> 
> Right. How do we handle this for back-compat purposes? I guess
> we need to have a new migration subsection, so if it's present
> it has the 'base' value and we ignore the 'offset' in the
> main migration data, and if it's not present we assume an
> old->new migration and use the existing offset code. New->old
> migration would not be possible as the new subsection is
> always-present.

Yes, something like that but I would just bump the version.  Version 1
has the old meaning for the first field, version 2 has the new meaning.

And also, since our brains are fresh on pl031... currently s->lr is
always 0; besides the bug that writing RTC_LR should update it, the
datasheet says the counter counts up from 1 so perhaps at startup s->lr
should be set to a nonzero value?   That would be
qemu_ref_timedate(QEMU_CLOCK_VIRTUAL) - 1.

Paolo

