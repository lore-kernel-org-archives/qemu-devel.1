Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922ADC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 11:04:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5338220868
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 11:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ax5/8cYj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5338220868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33773 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTlWN-0004S5-N4
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 07:04:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTlQb-00008B-Us
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:58:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTlQX-00073g-Jz
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:58:27 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35163)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hTlQV-00070h-M1
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:58:24 -0400
Received: by mail-wr1-x442.google.com with SMTP id m3so5761062wrv.2
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 03:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=QGXEl1MRbGuUWR3YTp2HAaTeKzvO6AugOLeNiqUyoBM=;
	b=Ax5/8cYjJf2fhIXomRpQoosWaf0mnIAM0l6c4QKC0TZc31i0vD0BKS+vFriqxbWLza
	EIUfw3iJjw/TcJwpgK0as9m27GmngfBZ/zW3jLnwz3q85Fs2ddm+zaCGksajaBl107VP
	LVPleycOcYZDYpwFmXeMTJAJwaSmukVz1XvDVbPKPx7GiCl4OAUp+P/ns8me9if36N1h
	p/aB4DlCEIA6ct7hqSbJAqRPthe8m5vXTBGhNsqBV9T6xELLA1pIIA9ULnPjEoklm79u
	PWuMiO7DDWes1JvHntJhlGuP00JR7k5fO8ku5ulHgoC8aEwSMm+91fflIHLupVo6i5hZ
	N85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=QGXEl1MRbGuUWR3YTp2HAaTeKzvO6AugOLeNiqUyoBM=;
	b=rrG9BOZExniLXCsoW6D0zVRfGLyqbAKK1Y2lnFWQp4tCCPSWjJ3rbgOOhRV00uBniJ
	9D3qhQR3YuCUXgy8kLdd1+o1GHWw8rb0FS2qjRygBBnzlsGUZt83LyAb+i944TO/nQbN
	o+wbk6RC5yuRQJDdgwaG8wzTwFM6D/yxsaj6lQlxaIzGlKc7/sAObT4yQ+E1AQandzPE
	hC79Nis0Z5RJMMvILrYbMrcKr7wgj+XvuGYyoOyk2eWY+h+mLuhJNNcslRWr2QGVMpPz
	sJ+Txg5rn5f4aBUd7EHvdS3TBLVnwnwOXrdilnXl6er1f5QkwZWpSFA3QigSo24Lo71h
	nCyQ==
X-Gm-Message-State: APjAAAXlcDB41nYmPY+9ZZIrbt6zQMbrpnLUjQaJCn+1TOyAE5KyHcFs
	yfHsdOkW1N9UlvHN1xWVmJyujw==
X-Google-Smtp-Source: APXvYqx7JPPNMD+fe97IrcDS+FQMGMra1oOw5xIJp583j+6CqO5d9lK62WRdo5VAA2Qy9QRm4UJzuw==
X-Received: by 2002:adf:e4d2:: with SMTP id v18mr18807137wrm.189.1558609098908;
	Thu, 23 May 2019 03:58:18 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	s13sm20873328wrw.17.2019.05.23.03.58.18
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 23 May 2019 03:58:18 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id C2B3E1FF87;
	Thu, 23 May 2019 11:58:17 +0100 (BST)
References: <20190515203112.506-1-david@redhat.com>
	<20190515203112.506-2-david@redhat.com>
	<b3611279-15c4-f9b7-2a91-051ac6431b2c@linaro.org>
	<44d7ddb4-040f-6778-7439-043b94e354ec@redhat.com>
	<0935643f-941f-5883-c481-8ac18d57c98d@linaro.org>
	<1f6001a2-e1d3-2b6f-e84a-8b9963302a3c@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <1f6001a2-e1d3-2b6f-e84a-8b9963302a3c@redhat.com>
Date: Thu, 23 May 2019 11:58:17 +0100
Message-ID: <87k1eh1lpy.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v1 1/5] s390x/tcg: Implement VECTOR FIND
 ANY ELEMENT EQUAL
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


David Hildenbrand <david@redhat.com> writes:

> On 22.05.19 13:09, Richard Henderson wrote:
>> On 5/22/19 7:01 AM, David Hildenbrand wrote:
>>>
>>>> I also think that, if we create a bunch more of these wrappers:
>>>>
>>>>> +DEF_VFAE_HELPER(8)
>>>>> +DEF_VFAE_HELPER(16)
>>>>> +DEF_VFAE_HELPER(32)
>>>>
>>>> then RT and ZS can be passed in as constant parameters to the above, a=
nd then
>>>> the compiler will fold away all of the stuff that's not needed for each
>>>> different case.  Which, I think, is significant.  These are practically
>>>> different instructions with the different modifiers.
>>>>
>>>
>>> So, we have 4 flags, resulting in 16 variants. Times 3 element sizes ...
>>> 48 helpers in total. Do we really want to go down that path?
>>
>> Maybe?
>
> Hope my fingers won't bleed from all the copy-pasting ;)

An alternative is to generalise the code into a helper and then just use
macros to instantiate a series of calls to it (c.f. softfloat). The idea
is you can use flatten/inline to keep it efficient but you don't have a
bunch of logic obscured by macro stuff.


--
Alex Benn=C3=A9e

