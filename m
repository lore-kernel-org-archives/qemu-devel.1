Return-Path: <SRS0=NumX=A5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C69C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 10:10:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBC8B20702
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 10:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=livius-net.20150623.gappssmtp.com header.i=@livius-net.20150623.gappssmtp.com header.b="BecsKIlq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBC8B20702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=livius.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwjnM-0003Sb-10
	for qemu-devel@archiver.kernel.org; Sat, 18 Jul 2020 06:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1jwjmk-00031T-Oo
 for qemu-devel@nongnu.org; Sat, 18 Jul 2020 06:09:38 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636]:44954)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1jwjmj-0004yE-2H
 for qemu-devel@nongnu.org; Sat, 18 Jul 2020 06:09:38 -0400
Received: by mail-ej1-x636.google.com with SMTP id ga4so13399440ejb.11
 for <qemu-devel@nongnu.org>; Sat, 18 Jul 2020 03:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=livius-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=UnTw6jvFiKrbQMdofmbN5I/qBbGYkSC2HN5uulztFO0=;
 b=BecsKIlqdAQZw7nyEv4sxAYGKx4e8CsYSRa0ie/quRAxE7B1dTT1RpHC6ESuYtsW65
 AW6yoPjdRUp53sSPUbhiRHF5Xx/GSdi89+yAGbvqA/Y5UzYVkA+dU4QZxa2ltuIBn6hz
 okZ71B9KiFOduFLQlECLcWsw9LWw6PUPiOzkDOLoDznUAjovS/+gTGhOu/Kfebk+ai9W
 QnIG8UGk7R8WGO5nojnUWdCbhx//rMzT/+KwRsVmWHQt13YAu9cmuvcRWWDxVLqqTBxM
 jDu9OELiOOS2zeSnNS6Fw8A53BCDcfn8rgDz3HWHCqT5fviglFPGtWF/wbCdYzdn1l1s
 jwLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=UnTw6jvFiKrbQMdofmbN5I/qBbGYkSC2HN5uulztFO0=;
 b=F0X4sLSTZHpvJW0ZKf9aQ8kOEF/gmjZceM6NXSjHygQ0eK2/EA4dFYjrzblgWOYDrA
 cD20FPvj4F9ltOp46oy3H9hkimY8EJxi1buOYjqL37te8xHRvjDg+qHdpAHFxgyhQqAR
 00TA2yOEpMIFwbzEq0RYJof8iFYMkQnNTelImjWyD2oOuB7sh2jzGCwfK+P2I6WmJJ3L
 Ne0ORIfkg+E+MmoCIf9RRp9gPqX/zO/IsACH8N4UU9wKHbHRZS5gMYlwROdOFYKH5pJJ
 xZYJvv5S6dXsbw+hcjbirHTvXtI7x0PR+hksNrPontAhaE663iRQPJe7nrD1ZcS/S3Te
 A4kw==
X-Gm-Message-State: AOAM5311JquA/gRnT2Leiv8yypmFsBdAWuuvbzPep4smVB82+fXvf644
 7SHtLGNumxOmQn/j4ScGirE+3A==
X-Google-Smtp-Source: ABdhPJwPYg6nNaVr6Xzsnew+YiR3dIzOlo9zXrf+gzhI46orORXKXisHSYt6YNqSBoRDOctm3Ky6gw==
X-Received: by 2002:a17:906:cd18:: with SMTP id
 oz24mr12694394ejb.118.1595066975602; 
 Sat, 18 Jul 2020 03:09:35 -0700 (PDT)
Received: from wks.local ([188.26.49.79])
 by smtp.gmail.com with ESMTPSA id d16sm10163731ejo.31.2020.07.18.03.09.34
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 18 Jul 2020 03:09:35 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: instance_init() and the realize() functions
From: Liviu Ionescu <ilg@livius.net>
In-Reply-To: <CAFEAcA_yMhW5CSJBSkAn0opSq4on1N=TfEd8w-KZcYD=ABP9Rw@mail.gmail.com>
Date: Sat, 18 Jul 2020 13:09:34 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <268082DD-5FBB-41CC-8718-7D6BAA0D323A@livius.net>
References: <CA+aXn+E2r1ZFyd1AZnwyvnxB1VsStkJC8vqkhmqZ4JDE_0LwMg@mail.gmail.com>
 <FEBB6630-0908-4097-BA78-ACB12932703A@livius.net>
 <CAFEAcA_yMhW5CSJBSkAn0opSq4on1N=TfEd8w-KZcYD=ABP9Rw@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Received-SPF: none client-ip=2a00:1450:4864:20::636;
 envelope-from=ilg@livius.net; helo=mail-ej1-x636.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Pratik Parvati <pratikp@vayavyalabs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 18 Jul 2020, at 12:43, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> Note that for a lot
> of device state struct members (where they correspond to guest
> registers state), you want to set their values in the
> device's reset method, not in instance_init or realize.
> That's because the guest-visible register state needs to
> be set back to its initial value on a system reset anyway,
> and QEMU guarantees that we will reset a device before
> first use.

Yes, that's a good point, but must be used with caution; since .reset is =
called **after** .realize, if the dynamically allocated structures are =
not set to zero, leaving state members uninitialised up to .reset is =
risky, it may lead to unexpected behaviour during .realize or other =
parts of the code.

That's why I mentioned that .instance_init should ensure that all =
members have default values and properties associated with them, such =
that later code, like .realize, has a deterministic behaviour.


Of course, for consistent results, both .instance_init and .reset can =
call a common internal function.


Regards,

Liviu


