Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A0DC55199
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 11:12:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C5EB2063A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 11:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NJC9ds9o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C5EB2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT1gG-00085J-I2
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 07:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50264)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jT1ev-0005uA-PO
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 07:10:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jT1eu-00027P-NY
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 07:10:45 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:33354)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jT1eu-00025l-5K
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 07:10:44 -0400
Received: by mail-wm1-x343.google.com with SMTP id v8so15701746wma.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 04:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=f8b3DYniiVN97d5itQTkh4SofIBR7r1R1IctXCYJ5D8=;
 b=NJC9ds9ofb7uxD9Fw1ew5GW5m9fVQa1fUIgDIp7X89oqCiDhS9F2F9+JlyBb2gVjyd
 xJjeE21/TL4NZAR+2i5oVZ6LESOp6W4sIS4+bGSidi0ZzkvvKn3AKnunMGVUYkGQ0TTc
 V5wSTUCjlShN5DwZG3QXp5DsW/6uVWLK51ygYmmdq/8c0c6LQcKJlQI5TfvJWC1lsU8Q
 XUQDvM+xI4+GReYNaMRF5aeKR/OcHZzCWUwPPP/4foj2fNNrV6kuwcacjJxuaEulwugv
 TdasE+UG8u7iq5Qy2thCmuCv2ZW9qwRa0dThEB5IqQp205OJwekdmg1vAnWzIkDUdpMe
 R4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=f8b3DYniiVN97d5itQTkh4SofIBR7r1R1IctXCYJ5D8=;
 b=LKM0qo3lpQa8J0JliHHOSZPxbk0whdgpR2+KzFsMBj5oJ88HN1crLTbJHcPw4fubMf
 QYcktfE0qz9WD9I9kC2vq6GO1VmS2Bku66dOFg7rGCe3t70j6aRiKCrAlV4ODSsRvwx8
 Gy/TAX1XiT+4Gb2nF8piG3iF4GQlAIguVVPSlOlATwj5lJypragEcbA3KPL8TAwSlVu6
 QVHnQsPxalt+zlSw+cNQ/g0UoS6xgCKy6+GXlNrFcVhqr2S2ywzbU86Pxne9ILDEdVZE
 eo+lL78FLMzQdPeEdFd1N61QaFbnnrXKIvBvuJC9ZWqaEEKWlbpJCbDt/Y5JYT0WZCbh
 Rzcg==
X-Gm-Message-State: AGi0PuYKdFQ6rzyhQVNxvl053ccpKp+o0oAXktDtfEQNgBwEKcb3IoLn
 pQO9czfkDYOTzDtEwlYQsA7Rtw==
X-Google-Smtp-Source: APiQypKfcl62PTbSj0b1cYR+BZCIbJv+wJ5gzcgebJX8VCZOv1eSWnORXTkfXPja9aYXbKmDmo0HkA==
X-Received: by 2002:a1c:3b09:: with SMTP id i9mr25113866wma.19.1587985842341; 
 Mon, 27 Apr 2020 04:10:42 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y18sm17001214wmc.45.2020.04.27.04.10.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 04:10:41 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 511AC1FF7E;
 Mon, 27 Apr 2020 12:10:40 +0100 (BST)
References: <CAE2XoE-ZSgtceSe5wYDm3cXf8+hTvJhD5PqZSrrFW5625LcSWg@mail.gmail.com>
 <87lfmhl0xa.fsf@linaro.org>
 <alpine.BSF.2.22.395.2004271212520.94232@zero.eik.bme.hu>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: About hardfloat in ppc
In-reply-to: <alpine.BSF.2.22.395.2004271212520.94232@zero.eik.bme.hu>
Date: Mon, 27 Apr 2020 12:10:40 +0100
Message-ID: <87imhlkwun.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::343
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
Cc: luoyonggang@gmail.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


BALATON Zoltan <balaton@eik.bme.hu> writes:

> On Mon, 27 Apr 2020, Alex Benn=C3=A9e wrote:
>> =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) <luoyonggang@gmail.com> writes:
>>> Because ppc fpu-helper are always clearing float_flag_inexact,
>>> So is that possible to optimize the performance when  float_flag_inexact
>>> are cleared?
>>
>> There was some discussion about this in the last thread about enabling
>> hardfloat for PPC. See the thread:
>>
>>  Subject: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
>>  Date: Tue, 18 Feb 2020 18:10:16 +0100
>>  Message-Id: <20200218171702.979F074637D@zero.eik.bme.hu>
>
> I've answered this already with link to that thread here:
>
> On Fri, 10 Apr 2020, BALATON Zoltan wrote:
> : Date: Fri, 10 Apr 2020 20:04:53 +0200 (CEST)
> : From: BALATON Zoltan <balaton@eik.bme.hu>
> : To: "=E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo)" <luoyonggang@gmail.com>
> : Cc: qemu-devel@nongnu.org, Mark Cave-Ayland, John Arbuckle, qemu-ppc@no=
ngnu.org, Paul Clarke, Howard Spoelstra, David Gibson
> : Subject: Re: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
> :
> : On Fri, 10 Apr 2020, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
> :> Are this stable now? I'd like to see hard float to be landed:)
> :
> : If you want to see hardfloat for PPC then you should read the
> replies to : this patch which can be found here:
> :
> : http://patchwork.ozlabs.org/patch/1240235/
> :
> : to understand what's needed then try to implement the solution with
> FP : exceptions cached in a global that maybe could work. I won't be
> able to : do that as said here:
> :
> : https://lists.nongnu.org/archive/html/qemu-ppc/2020-03/msg00006.html
> :
> : because I don't have time to learn all the details needed. I think :
> others are in the same situation so unless somebody puts in the :
> necessary effort this won't change.
>
> Which also had a proposed solution to the problem that you could try
> to implement, in particular see this message:
>
> http://patchwork.ozlabs.org/project/qemu-devel/patch/20200218171702.979F0=
74637D@zero.eik.bme.hu/#2375124
>
> amd Richard's reply immediately below that. In short to optimise FPU
> emulation we would either find a way to compute inexact flag quickly=20
> without reading the FPU status (this may not be possible) or somehow
> get status from the FPU but the obvious way of claring the flag and
> reading them after each operation is too slow. So maybe using
> exceptions and only clearing when actually there's a change could be
> faster.
>
> As to how to use exceptions see this message in above thread:
>
> https://lists.nongnu.org/archive/html/qemu-ppc/2020-03/msg00005.html
>
> But that's only to show how to hook in an exception handler what it
> does needs to be implemented. Then tested and benchmarked.
>
> I still don't know where are the extensive PPC floating point tests to
> use for checking results though as that was never answered.

Specifically for PPC we don't have them. We use the softfloat test cases
to exercise our softfloat/hardfloat code as part of "make
check-softfloat". You can also re-build fp-bench for each guest target
to measure raw throughput.

>> However in short the problem is if the float_flag_inexact is clear you
>> must use softfloat so you can properly calculate the inexact status. We
>> can't take advantage of the inexact stickiness without loosing the
>> fidelity of the calculation.
>
> I still don't get why can't we use hardware via exception handler to
> detect flags for us and why do we only use hardfloat in some corner
> cases. If reading the status is too costly then we could mirror it in
> a global which is set by an FP exception handler. Shouldn't that be
> faster? Is there a reason that can't work?

It would work but it would be slow. Almost every FP operation sets
the inexact flag so it would generate an exception and exceptions take
time to process.

For the guests where we use hardfloat operations with inexact already
latched is not a corner case - it is the common case which is why it
helps.

>
> Regards,
> BALATON Zoltan


--=20
Alex Benn=C3=A9e

