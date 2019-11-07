Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1D8C5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 17:02:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A86662077C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 17:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sVCgwPo+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A86662077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSlAY-0000NG-Mt
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 12:02:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45762)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iSl66-0003aL-96
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:57:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iSl65-0004dl-0J
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:57:26 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43488)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iSl64-0004dL-PW
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:57:24 -0500
Received: by mail-wr1-x442.google.com with SMTP id n1so3821922wra.10
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 08:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=znn+Vm40PAk/QJjJU7FrrrHdqE72Q5vig/mwIoB7lhY=;
 b=sVCgwPo+V4Jn9mzRcSh5fT4OxCiZZfVaC20khNf/fyS1S8leJiXXytKTdc0ccp/3fr
 D8f6rnlhXSWyt4v36GpRfIz4AP1+/45torsPHzkR19qeLJVb7t07HiTxQWNSOZkc6kh5
 BcWsjjLfScSI1v/xBLgWhczIJzNBlihYG1+YEMYcZvYjF7Nk+1iMtNj4CsExoWSibEXN
 73FDVTL9bifpP3iPwwY4NAzkP3LcngMfxafopcaoOL2cpaOzHEsdmMngtmM9H8AYOVpL
 13/+04VdXELY37PcQGOKxJQD1TPD7tQQlhlwwrYC7rllmY+NhMmzauNPqa5TcsPEYX91
 5hTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=znn+Vm40PAk/QJjJU7FrrrHdqE72Q5vig/mwIoB7lhY=;
 b=ZmmqxIcUyzsWid9AHAVesgr421hgQLhhURmDq9s0K4bseRL1W9bHqQDWcheJnwtiU1
 dfARoGjCeVl6tCSPb43kVsFlnkTngNA1Cik/dn1s/OvQ6ObsOko94/0ahNoHWII/hk2B
 yvsFiszm7uim5GXGi+4PQMQkuMgJWBtSTTocacwUoZT+GKVqyeo4zDvYN5axMa/2h07f
 xdd/d0vFfoGD5GlgzNnZb8XEuw/UfEU9N26SjOkVGOjxJMlWl8obCJEMECb4gt9TqPII
 NqMrXNk2Chg6bO9kar2Uur2gqO2tMq3RAWVonG7ted5x7h5a+OM6lfJtlwkR0ZHP2AUv
 MQYQ==
X-Gm-Message-State: APjAAAX7Stv55GteV4YRVfcBsLRm75EChN4EucGx9IvQqyiZ/kqXet6h
 7lElcMhH1TWGDQ4Ij2lNEJfaLQ==
X-Google-Smtp-Source: APXvYqz+rVy0W8eVMpOas8II7S2Nl9O0taKcfSDvG4L+Rj1nyLX211cSfMRxVwNXhDbtcAIRrvlA5A==
X-Received: by 2002:adf:97dd:: with SMTP id t29mr3719224wrb.283.1573145843207; 
 Thu, 07 Nov 2019 08:57:23 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z189sm3213392wmc.25.2019.11.07.08.57.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2019 08:57:21 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 324681FF87;
 Thu,  7 Nov 2019 16:57:21 +0000 (GMT)
References: <20191105234100.22052-1-beata.michalska@linaro.org>
 <20191105234100.22052-3-beata.michalska@linaro.org>
 <5c75bd31-213f-88a4-2eee-0046f99f65fe@linaro.org>
 <CADSWDztHetgmbUOp4WyRAkR0daAG6kkwhUTcyKWiCTWHQ1XB=w@mail.gmail.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Beata Michalska <beata.michalska@linaro.org>
Subject: Re: [PATCH v2 2/4] Memory: Enable writeback for given memory region
In-reply-to: <CADSWDztHetgmbUOp4WyRAkR0daAG6kkwhUTcyKWiCTWHQ1XB=w@mail.gmail.com>
Date: Thu, 07 Nov 2019 16:57:21 +0000
Message-ID: <87lfsrhbf2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Peter Maydell <peter.maydell@linaro.org>, quintela@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 shameerali.kolothum.thodi@huawei.com,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, eric.auger@redhat.com,
 qemu-arm@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Beata Michalska <beata.michalska@linaro.org> writes:

> On Wed, 6 Nov 2019 at 12:20, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 11/6/19 12:40 AM, Beata Michalska wrote:
>> > +void qemu_ram_writeback(RAMBlock *block, ram_addr_t start, ram_addr_t=
 length)
>> > +{
>> > +    void *addr =3D ramblock_ptr(block, start);
>> > +
>> > +    /*
>> > +     * The requested range might spread up to the very end of the blo=
ck
>> > +     */
>> > +    if ((start + length) > block->used_length) {
>> > +        qemu_log("%s: sync range outside the block boundaries: "
>> > +                     "start: " RAM_ADDR_FMT " length: " RAM_ADDR_FMT
>> > +                     " block length: " RAM_ADDR_FMT " Narrowing down =
..." ,
>> > +                     __func__, start, length, block->used_length);
>> > +        length =3D block->used_length - start;
>> > +    }
>>
>> qemu_log_mask w/ GUEST_ERROR?  How do we expect the length to overflow?
>
> In theory it shouldn't, at least with current usage.
> I guess the probe_access will make sure of that.
> This was more of a precaution to enable catching potential/future misuses
> aka debugging purpose. I can get rid of that it that's playing too
> safe.

If the internal code might get it wrong and that would be a bug then the
g_assert(), if the values are ultimately from the guest then log with
GUEST_ERROR as Richard suggests.

<snip>

--
Alex Benn=C3=A9e

