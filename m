Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7821BC0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 12:43:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4186920693
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 12:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hRQoaM7P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4186920693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsRTM-000353-JZ
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 08:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37759)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hsRRR-0000fq-JO
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 08:41:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hsRRP-0007y2-Qt
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 08:41:21 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44710)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hsRRP-0007x1-2O
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 08:41:19 -0400
Received: by mail-wr1-x441.google.com with SMTP id p17so65593686wrf.11
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 05:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=HSajL510A12WGwHFHorNgqsJmQZJjvkUpk1fsQfA9PA=;
 b=hRQoaM7PJrENTdcuT27ORwxX+80vpb8nLw3oPfpe+5cGa7vf5ybnxnoAmmEV7Xm6Ba
 +dns4dMmTHuWrTzQjczPMLT40FxN9iwegRHn4Z11M19PUnt7iYm/JszyD5qBS7LeM7+K
 HmjgtOMndVbKaU6FF29vQj2fTagXNk9YsGxjv+qMtuoVI4pKikY5IrK9vaiCiWjHLAB5
 Zt6OOry4qcxeU5Y6jenCFixzCEVSr7SADHNpUFWN3J3aAQ5IuNCqX//tXAHX3qXaVKMH
 yAWJB7DnCkWbn9nDUB+MUoEs/ysGx9eZYh/wXbYOaTgusg2uojXXo8MwygvkKRPNITE3
 51pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=HSajL510A12WGwHFHorNgqsJmQZJjvkUpk1fsQfA9PA=;
 b=Z8rS3jEw5pa2dXwYJ+x8ACPGJEJFO9IR1lG0gn03O8x9u+qdC2p7xzAwW1r7fhGJpv
 dZAwO8dfQSRKiRTgSflmnaEQeVY3SARu8tfn5eIlbXH2/p9RpRbiudHt2CoYzyOOJwCk
 U1cO9qI4/ohZMmTuAMcPfb6sRsooOpemnRIiaeT6FOQZUjC3tO0IyQodGSeNLxJZJDYd
 lxCt2Fo5XzFi6fy9Q3SrJ0UUF7OaXC1+iLwXtCUNcBAwK/vMvvmgOCr5IC7a8Jecflxg
 POmrV3moMrs2gdcUPn6hJ8iOA35/W/iLjwdlLRSm6VFYm1/ZcF5UGZMw4a/uYIu/OQwP
 NvoQ==
X-Gm-Message-State: APjAAAXNN6AgA5F5fDVOWPkawHHjKdoV1BqoAxx+1azJJYIlmWR/t580
 m+MQRxkP91FJvPdxmdtkI6YqyZtfvMQ=
X-Google-Smtp-Source: APXvYqx7rZdbRd/jRlQFJy5ROZN/BZ2FHTq3uKJbNUO5BzOuEuhnBOi5s2yR6b1KF0nOLpLmo/T2gg==
X-Received: by 2002:adf:fa42:: with SMTP id y2mr46430804wrr.170.1564490475910; 
 Tue, 30 Jul 2019 05:41:15 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id x24sm60303828wmh.5.2019.07.30.05.41.14
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 30 Jul 2019 05:41:14 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9648B1FF87;
 Tue, 30 Jul 2019 13:41:14 +0100 (BST)
References: <20190614171200.21078-1-alex.bennee@linaro.org>
 <20190614171200.21078-26-alex.bennee@linaro.org>
 <bd131b16-2f38-4112-4e09-6a2f63908bf2@linaro.org>
User-agent: mu4e 1.3.3; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
In-reply-to: <bd131b16-2f38-4112-4e09-6a2f63908bf2@linaro.org>
Date: Tue, 30 Jul 2019 13:41:14 +0100
Message-ID: <87ftmnitjp.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v3 25/50] translator: add translator_ld{ub,
 sw, uw, l, q}
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
Cc: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 6/14/19 10:11 AM, Alex Benn=C3=A9e wrote:
>> +#define GEN_TRANSLATOR_LD(fullname, name, type, swap_fn)               =
 \
>> +    static inline type                                                 =
 \
>> +    fullname ## _swap(CPUArchState *env, abi_ptr pc, bool do_swap)     =
 \
>> +    {                                                                  =
 \
>> +        type ret =3D cpu_ ## name ## _code(env, pc);                   =
   \
>> +                                                                       =
 \
>> +        if (do_swap) {                                                 =
 \
>> +            ret =3D swap_fn(ret);                                      =
   \
>> +        }                                                              =
 \
>
> This feels like we should have done this at a different level.  We alread=
y have
> lower-level functions that read from memory with the proper
> endianness.

Yeah - this really only caters to the translator for guests which can
switch their mode.

> It seems that we don't have them for *_code, but that could be fixed.  Or,
> indeed, bypassed, since these could be the new official interface, deprec=
ating
> the *_code functions.

Hmm how to properly audit that _code isn't being used elsewhere. You get
lost in a maze of macros pretty quickly :-/

So you are proposing dropping the _code helpers from cpu_ldst_*_template
and directly binding to the low level load/softmmu function from
translator.h? Do we ever need _code access that isn't part of the
translator loading instructions?

>
>
> r~


--
Alex Benn=C3=A9e

