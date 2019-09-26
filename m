Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC54C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 15:44:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 571E221D56
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 15:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bBoa/YDo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 571E221D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDVwL-0002lN-9k
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 11:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55326)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iDVhL-0007FR-NK
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 11:28:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iDVhK-0000UC-Fb
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 11:28:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40492)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iDVhK-0000Tt-AP
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 11:28:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id l3so3261448wru.7
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 08:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=mGjZ/f9Mfy06GuCl82Qx4t10JpZXeUei72SAbH8i5R4=;
 b=bBoa/YDobD4tiLpD2vW6YeSaFyylmDnEb2FOowokVRyIo5LoTO1lnmIWYJIWiisxBG
 FrH1bREpo6g09q7ECInHqCswA9o7gJk3pP7Pz3nXvoKBgwUbvouVvQNKLeLKZhAXH0/R
 T0JqcjvOaRhfYmC5hTL8/TJg4C8iJKWRgLYpzlMWGn0dVCmelFilBwfl0UOdWh3pwh1Y
 BkRdz7QTdlgjlq7jTCiooAolm9lJQANGUedadDjelHkcIwyz3f5FOF99nPuC36j8FXpz
 a6eMkczaXfkShPejzgJ+H3+HQDG2zbDDPgsFAFHUK0f09Tcr7KveDTRvE/xsnQuD6VAY
 O4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=mGjZ/f9Mfy06GuCl82Qx4t10JpZXeUei72SAbH8i5R4=;
 b=XAWS3bkeECCEMa41AYSmrsxQs0XeKRMiwgJktOZ9fphmwjzHuqJK6Vavep0IIldIo4
 dWZ2JzYGh2VolCIFFDwx1K4CjgjOJM2q2Wpb/QtwgGdN13dyWfi4oLCFaDtyxhI7QtVD
 koIE2U9rySsrXG6B3o5lIUw7X120/DOuFTxQhQ3UNQRIL89EoxdHhOJgE6zlbbL7n3zo
 PgVL3vnqfaW42EE9viRNxybk81YCPUyWKb8KORGA0z+sy6px95TMDXpe8FnRDM8pIygY
 cTwAlGyBx50Pgslx9lVwWH+SlYOBxHPAFne0oS9kcv17OTfkmEYF2wEOCaGXdudabEFN
 3Zcg==
X-Gm-Message-State: APjAAAUF0Iju5YIr3rHApTO7cHt/G/dcvaa39OnCYN4XQpzYBfmyjv8P
 99l2x2AbDR3lzpPphw9q7RaZgw==
X-Google-Smtp-Source: APXvYqw4M7neN9JKLkd7H0+xTNQm30uMgCYtMFbSRdwTlRR7lvWxtdKcgqDqplVIT/8vpkNQpxPhwg==
X-Received: by 2002:adf:f708:: with SMTP id r8mr3377598wrp.187.1569511669203; 
 Thu, 26 Sep 2019 08:27:49 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b186sm9232360wmd.16.2019.09.26.08.27.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 08:27:48 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D86A11FF87;
 Thu, 26 Sep 2019 16:27:47 +0100 (BST)
References: <20190925233013.6449-1-alex.bennee@linaro.org>
 <CAFEAcA9vb5_Mi_axWpu7269Zg0xMLbiiV80ofLeyDpfws3G4nQ@mail.gmail.com>
 <20190926125817.GB19660@redhat.com>
 <ea6b671a-0c05-d880-3b9f-62a4f8626ec1@de.ibm.com>
 <19efe3ee-a532-cf66-a5a7-03a7c053737c@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [RFC PATCH] configure: deprecate 32 bit build hosts
In-reply-to: <19efe3ee-a532-cf66-a5a7-03a7c053737c@redhat.com>
Date: Thu, 26 Sep 2019 16:27:47 +0100
Message-ID: <87d0fn9ix8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Daniel_P=2E?= =?utf-8?Q?_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 qemu-discuss <qemu-discuss@nongnu.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-ppc@nongnu.org, "open list:RISC-V" <qemu-riscv@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> On 26/09/2019 15.46, Christian Borntraeger wrote:
>>
>>
>> On 26.09.19 14:58, Daniel P. Berrang=C3=A9 wrote:
>>> On Thu, Sep 26, 2019 at 08:50:36AM +0100, Peter Maydell wrote:
>>>> On Thu, 26 Sep 2019 at 00:31, Alex Benn=C3=A9e <alex.bennee@linaro.org=
> wrote:
>>>>>
>>>>> The 32 bit hosts are already a second class citizen especially with
>>>>> support for running 64 bit guests under TCG. We are also limited by
>>>>> testing as actual working 32 bit machines are getting quite rare in
>>>>> developers personal menageries. For TCG supporting newer types like
>>>>> Int128 is a lot harder with 32 bit calling conventions compared to
>>>>> their larger bit sized cousins. Fundamentally address space is the
>>>>> most useful thing for the translator to have even for a 32 bit guest a
>>>>> 32 bit host is quite constrained.
>>>>>
>>>>> As far as I'm aware 32 bit KVM users are even less numerous. Even
>>>>> ILP32 doesn't make much sense given the address space QEMU needs to
>>>>> manage.
>>>>
>>>> For KVM we should wait until the kernel chooses to drop support,
>>>> I think.
>>>
>>> What if the kernel is waiting for QEMU to drop support too ;-P
>>
>> For what its worth on kvm/s390 we never cared about implementing
>> 32 bit.
>
> Looking at tcg/s390/tcg-target.inc.c :
>
> ...
> /* We only support generating code for 64-bit mode.  */
> #if TCG_TARGET_REG_BITS !=3D 64
> #error "unsupported code generation mode"
> #endif
> ...
>
> ... it seems to me that TCG does not support 32-bit on s390 either. I
> think we can remove s390 (32-bit) from the list completely?

It's the same for riscv32 I think.

>
>  Thomas


--
Alex Benn=C3=A9e

