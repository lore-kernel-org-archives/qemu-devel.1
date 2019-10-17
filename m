Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAEBFA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:11:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9688D2067B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:11:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9688D2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL8Mi-0006OC-1L
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 12:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56866)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iL7dh-0006a4-ON
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:24:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iL7dg-0000nc-MK
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:24:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48144)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iL7dg-0000n6-EU
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:24:32 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 896033E2AF
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 15:24:31 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id 7so1136945wrl.2
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 08:24:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IS/vtS+qEHcMK9d+rcriOqJkkt4vsA+YTxXci4TyB6U=;
 b=RdexYmYPDmjJsrSJQM7bHoKlattPtTWEqOhi3iaE0hOw6KADlmIybEohV3XchpPeYF
 edoRjjkc/JkY+nDBnDB5E7Etp4cEjVlNXji+vMwiCxtSTH2y8nbMxkLWexNGTIVQ7V+A
 sv4xX4V3ynzR0PGhEMd4xFh6WxY7aUGKb0uNslVlqQ0L7XBrG+90DsTKWC3bfnY4l/yQ
 IrsYaVe4IdIdLLs0Eyy+1pNME2owpBXyDYjfOFIz3xIOpQMOQZBtfrre6+9zDkhP1iX+
 1t3/eZTRkWhyrqZp48Y2xwAH3OpWWURb/72ED0oNj2ZDYc9Z7Q1au3pADkDyNMhFldAv
 u3kQ==
X-Gm-Message-State: APjAAAVB8qSwrLXxLSHem5sH5OssdfalhflPsdjSyfDQs+8t6QKkWYjU
 eja4FSBQQZd66w57VAUk8svZDUksYlErv8PihorTpuXN050g6UyJf59jIB2LLIcFXeQ8HkX92Fa
 ECKLoHqNxdeKkVLQ=
X-Received: by 2002:adf:8567:: with SMTP id 94mr591057wrh.65.1571325870249;
 Thu, 17 Oct 2019 08:24:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzhFPVbKfUp3tx76jtZI8VakBCjX11WPTy7buNDPK/URMAYlqlnKm68uUiP2gvOXliZrShARw==
X-Received: by 2002:adf:8567:: with SMTP id 94mr591040wrh.65.1571325870084;
 Thu, 17 Oct 2019 08:24:30 -0700 (PDT)
Received: from [192.168.50.32] (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id a71sm2433307wme.11.2019.10.17.08.24.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2019 08:24:29 -0700 (PDT)
Subject: Re: [PATCH 2/3] hw/timer/xilinx_timer.c: Switch to transaction-based
 ptimer API
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191017132122.4402-1-peter.maydell@linaro.org>
 <20191017132122.4402-3-peter.maydell@linaro.org>
 <cabcec27-c6a7-6ea7-e933-589f2385c137@redhat.com>
 <CAFEAcA9dRMu_hauo_PuJyWh03+-Y9ogWmKSBfzu_6GhYCrnDAQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <57a5d309-97a5-75ce-dade-504557071fc4@redhat.com>
Date: Thu, 17 Oct 2019 17:24:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9dRMu_hauo_PuJyWh03+-Y9ogWmKSBfzu_6GhYCrnDAQ@mail.gmail.com>
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
Cc: Jason Wang <jasowang@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/17/19 5:03 PM, Peter Maydell wrote:
> On Thu, 17 Oct 2019 at 15:57, Philippe Mathieu-Daud=C3=A9 <philmd@redha=
t.com> wrote:
>>
>> Hi Peter,
>>
>> On 10/17/19 3:21 PM, Peter Maydell wrote:
>>> +/* Must be called inside ptimer transaction block */
>>>    static void timer_enable(struct xlx_timer *xt)
>>>    {
>>>        uint64_t count;
>>> @@ -174,8 +173,11 @@ timer_write(void *opaque, hwaddr addr,
>>>                    value &=3D ~TCSR_TINT;
>>>
>>>                xt->regs[addr] =3D value & 0x7ff;
>>> -            if (value & TCSR_ENT)
>>> +            if (value & TCSR_ENT) {
>>> +                ptimer_transaction_begin(xt->ptimer);
>>>                    timer_enable(xt);
>>> +                ptimer_transaction_commit(xt->ptimer);
>>
>> Why not move these inside timer_enable()?
>=20
> Because timer_enable() is called from the callback
> function timer_hit(). Since callback functions are called
> from within a begin/commit block, if we called begin
> again in timer_enable() it would assert().

Yes, now I understood the point of this new API ;)

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

