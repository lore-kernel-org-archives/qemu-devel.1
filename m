Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50F7CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:25:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 745E821872
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H0Ive3TO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 745E821872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNhnU-0007ya-2c
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 14:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48048)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNhg6-0005i1-E6
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 14:17:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNhg1-0002It-Ty
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 14:17:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40136
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNhg1-0002I2-4c
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 14:17:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571941052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4P1Nevoebt0HvgtNvW+GwC7QlYV4LofraM3P2lGpFd4=;
 b=H0Ive3TOcQwSsm9ZJQtqOfydmFjWlS0xAlMv1/KmDyWOB0Qzm7+yAaUhW7E1Zbatxhpyzd
 MapnTM7tkhimfRYI2wj5jdTBcG0+cvFsdd3SlkeEh26JL2UEuBKfWPvtL7TR+p01xgA872
 cTK6EA7Omk701GrNn3UrdtwJojeV6lc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-KEppqz_lN_6t9DG9tapbrw-1; Thu, 24 Oct 2019 14:17:29 -0400
Received: by mail-wr1-f69.google.com with SMTP id c6so13289367wrp.3
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 11:17:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cmOHAjbRsjBWAOBI1UStA1dOeqXVvpnx6LD2vWPej24=;
 b=VYDd+xQ254aRDqS/VyjydPuUJUbmVLbVoDzICzN+EzrSpwbLv+0AyZZXBSN1joZwsP
 hciW9zNTxCPuq8uD8mQDrJgrD8C3KYHjHvlwAOYpJscpWYXX4ISRYCxbqlSZL9OLG2MO
 xdwxTVm163CQEl9BE9q9SzcXOVDG/QFRqGJWUaBXA5C/TG0Y9XG8g5dulacs6nFuYnLR
 NPAbsxeCq3Yu8R+6sH7jdN4jVAx7t7XbYECKJEVVnMwWjjR2Q2pLxAvwCHCkx3gloSO2
 sbpe/0RY8sFpkWF5TKmpCmRc0yOJ5e9L/CFmbGx2yjK1xUm2O334Dp8T+7b/34rbTxne
 zvBg==
X-Gm-Message-State: APjAAAWBVzOJbS3nIQEMHq/b8t2eQrOcRopGPRI/EE3CAFg18GGw95Uv
 3XTiHRgTqv2uho8RwLbxmmeIxbK0mMnJ/2xkLx955fIwDAMDRg6arbuiXqDlYUJhsWhVXgAgKli
 4JSryB80/niPCDcs=
X-Received: by 2002:a1c:e404:: with SMTP id b4mr6627424wmh.90.1571941048280;
 Thu, 24 Oct 2019 11:17:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz3ztAton64IMPlMrwlMze10ERUxbshCBQyt0E4n4s/qNfCpYZ68gCzL2lYwhLbEkXu9BWGoQ==
X-Received: by 2002:a1c:e404:: with SMTP id b4mr6627400wmh.90.1571941048041;
 Thu, 24 Oct 2019 11:17:28 -0700 (PDT)
Received: from [192.168.1.115] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id g14sm3320035wro.33.2019.10.24.11.17.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Oct 2019 11:17:27 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] Convert sparc devices to new ptimer API
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <20191021134357.14266-1-peter.maydell@linaro.org>
 <CAFEAcA8d6xXp+bCJCSWwD47Omfrenh4C=4NC3cFm4pEAHhkGmQ@mail.gmail.com>
 <9b2f59f2-5a99-41be-0a57-dd73f72dc547@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <61283014-94a5-aef1-59ad-ba9d2f16cf8f@redhat.com>
Date: Thu, 24 Oct 2019 20:17:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <9b2f59f2-5a99-41be-0a57-dd73f72dc547@ilande.co.uk>
Content-Language: en-US
X-MC-Unique: KEppqz_lN_6t9DG9tapbrw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: KONRAD Frederic <frederic.konrad@adacore.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabien Chouteau <chouteau@adacore.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/24/19 8:04 PM, Mark Cave-Ayland wrote:
> On 24/10/2019 13:19, Peter Maydell wrote:
>=20
>> On Mon, 21 Oct 2019 at 14:43, Peter Maydell <peter.maydell@linaro.org> w=
rote:
>>>
>>> This patchset converts the devices used by sparc machines to the new
>>> ptimer API.
>>>
>>> Currently the ptimer design uses a QEMU bottom-half as its mechanism
>>> for calling back into the device model using the ptimer when the
>>> timer has expired.  Unfortunately this design is fatally flawed,
>>> because it means that there is a lag between the ptimer updating its
>>> own state and the device callback function updating device state, and
>>> guest accesses to device registers between the two can return
>>> inconsistent device state. This was reported as a bug in a specific
>>> timer device but it's a problem with the generic ptimer code:
>>> https://bugs.launchpad.net/qemu/+bug/1777777
>>>
>>> The updates to the individual ptimer devices are straightforward:
>>> we need to add begin/commit calls around the various places that
>>> modify the ptimer state, and use the new ptimer_init() function
>>> to create the timer.
>>>
>>> Changes v1->v2:
>>>   * patches 2 and 3 are the old 1 and 2 and have been reviewed
>>>   * patch 1 is new and removes a pointless NULL check; without
>>>     this we'd probably have got Coverity errors when patch 3
>>>     added a use of t->timer before the check for it being NULL
>>
>> I'm going to apply these to target-arm.next; I know they haven't
>> been on list long but the change since v1 is only minor and
>> they've all been reviewed.
>=20
> Thanks Peter! Not sure if you saw my Tested-by tag last week for the slav=
io (sun4m)
> parts, but there were no obvious regressions that I could see under qemu-=
system-sparc.

This was on v1:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg653861.html


