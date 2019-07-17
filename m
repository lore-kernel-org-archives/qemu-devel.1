Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59BFC76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 13:46:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1574208C0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 13:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qEff6ZID"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1574208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57375 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnkGo-0001jS-Q0
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 09:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56780)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hnkGX-0000kK-OA
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:46:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hnkGV-0006Nd-QK
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:46:41 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:44647)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hnkGU-0006Mm-M3
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:46:38 -0400
Received: by mail-oi1-x241.google.com with SMTP id e189so18471809oib.11
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 06:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=SAU1A+yF3GKBYG0AfK5rJ7p5mbeKqtl5MdzvF/YdnIk=;
 b=qEff6ZID3kZxLlhM8vC4JLtyBoUCZQPCnWLinQHIPXeFwfH3zO1YaEtZXgygggW/ZD
 BItQotLZLJJlklENnesZuJ2+G9CHTeVzVDkxnnB+vRltS2bzn5lhlblEG1FfE2Nr9enC
 VO9khYMrKABebxFLJVUPseM6UAok1KmopA0jSaqxUDUlxWrVWNr5A0ejNGXnDLGMWS7A
 eBrbgXe750LnTjKc78MTsfCuVVprBzC9Vjm5es+aPbH3bi1xKNXTqIeXv7DfDSXBBCuh
 FA6UtK9DPLddBu+Gy+HSB2z9sSJ/XmaPkPX7ZPBKFhRbFNPtw29gLW/oqpOBwl9T4z2M
 uRLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=SAU1A+yF3GKBYG0AfK5rJ7p5mbeKqtl5MdzvF/YdnIk=;
 b=l9zvUnM7rxhBL2UfUnm49yU2Fh7QQNIrkk+G5jVQ5WQwNHKRlJoyC5VA8qVeYNKr2Q
 WzoDRiJEwEOe2UXR5VBFA5U53y8cOGZmRcAHa7imuFVDX9AMxkwbGODkza80E5r8YMgv
 QvgkAmf+xZRPm3XlT8mXiArP9vzM+hCv9yJ04Xyjxxso33XQ0CSzIksBn8iws8MuRiWh
 kSdWQijb2NOWxlYBQUeuITFU5isHqLLfWnSCJsawnLl3OMI6q8ldasXs6lZSeTU9bX4k
 8QJNXzcHKPUni/MwK8Iv7ecxc39HEEEXVb2dQwyhdgps4u1HiLIY3y5xrMSzBuUwxKqF
 u9IA==
X-Gm-Message-State: APjAAAWabAmBQPDOrZZFyKOsYxXCbfTljDcn+YKf92dqjhfAqwaDUPyl
 Oufcjh2YGY0HrdvWcaFri3p/cwvww5ouVRiYf4a+0g==
X-Google-Smtp-Source: APXvYqwarKtZS0SfF0bKxwCaikw+J5FoZ8478txdhTGmIuoEhPE+PmPKG06j02di0W1Uv0z8ejexxj1r7mZIXIkWW7Y=
X-Received: by 2002:aca:5cd7:: with SMTP id
 q206mr18082455oib.146.1563371196665; 
 Wed, 17 Jul 2019 06:46:36 -0700 (PDT)
MIME-Version: 1.0
References: <20181102171638.24069-1-peter.maydell@linaro.org>
 <20181102171638.24069-9-peter.maydell@linaro.org>
 <3e3d2018-3993-f651-8e94-5bea612bd776@redhat.com>
 <CAFEAcA_FtoHOUv_cPgfO7GrZ8Ug9cKCvmY2z75i9DaAQ8Qx+gQ@mail.gmail.com>
 <417cd887-aec4-d8ba-1dd2-810bc4c04977@redhat.com>
 <CAFEAcA_JntiaOOWisqLVqAV6jc=wk4nR548KbbUcG0XLabcNpA@mail.gmail.com>
 <8d06b8f2-7ee8-a77a-81d7-3219d5e43c45@redhat.com>
 <dfeab9fd-7ee1-01f2-dd38-cba449b1de63@redhat.com>
 <f625f1f1-ad97-1c75-e44d-3b0c015312b3@redhat.com>
 <cf9156f6-c3fa-ec7e-c51a-8b8d2fd1e6d6@redhat.com>
 <7b45c073-8653-28e0-9d06-9e3aaa6dc460@redhat.com>
In-Reply-To: <7b45c073-8653-28e0-9d06-9e3aaa6dc460@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 17 Jul 2019 14:46:25 +0100
Message-ID: <CAFEAcA8RZuzv=KkATMozxfp8MTsCOPPsK7mN6oCJq_TfwWiPMA@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PULL 08/10] target/arm: Conditionalize some
 asserts on aarch32 support
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 17 Jul 2019 at 14:36, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
> I still wonder why this didn't assert on Peter's setup.

My setup does not assert because my host kernel correctly
provides the ID register values to QEMU. Laszlo's appears
to be providing all-zeroes, which then obviously breaks
assertions being made about the sanity of those ID register
values...

thanks
-- PMM

