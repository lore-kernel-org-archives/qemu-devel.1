Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257E2C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 16:48:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E224521741
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 16:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OeicHXsk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E224521741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j06oI-00028t-4J
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 11:48:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60301)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j06n0-0000Pq-FA
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:47:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j06mz-0002Oy-Ei
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:47:34 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38929)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j06mz-0002Nj-7X
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:47:33 -0500
Received: by mail-wm1-x342.google.com with SMTP id c84so3503316wme.4
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 08:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=LNw2FhTum83IdLGLuHvU4zODZnUfWu2+BgAE22VgIUo=;
 b=OeicHXskihtzj8TpQU5QIvQG/RlrN1DtuvdhAkHGmoRiOiFsyUq7Q0TmkJo6gwsSk7
 E8k1lI8Hbw+ygKqsmiNW36lSJaYP5gP4ffHFGz/XyHHgSRgY+v1nsb9KAwmBlDuKBglO
 kLa99tMt3EzjNMySYvP6LPtf9LUsMJSSBGeVC5U77vGUvSIjhWiKbmquJB51rjou0tjk
 5pDZABGfF/TUwBWNYjieinm0sGrJKb+U9WPXyVgcdfg3M54TFu6KS8w3CflQGlMgTJ3c
 w8azSCzX8gfRXIOqo8j8HIQTA38xECOcSczG4gfqmOuAs89776xzZfpprIQWcZgpe57C
 oPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=LNw2FhTum83IdLGLuHvU4zODZnUfWu2+BgAE22VgIUo=;
 b=PWCIRizJVTK+mCveUusjrTe+0JPmrqhL8duziC2ao/WigDc8spMk2HBNQ1LEHqWhKL
 rU5il/H0XFYEsRpXLyScZzUxVJvj/AN4PL54+bYcU1UWvNaMHv0NuFscem/m0s86G+VZ
 gtObaan9yCtI69svo7vLMj5pdxMij1Ag/sY84VdUdz/3HE4I86yXLdWG/tOLmvSM0eOo
 seww+TD93Sr8nT0jRM1b7HXZLF+LfTgs19Jw3lMkonjP2XcABlwEaFfEEVU/g62FRc8N
 TsnlQfsgQYKccaDATAYkEBZjsqlbd5ud2pRxRYstfvkg1L8aEUwDdcULqapR/RhjegMn
 GfHQ==
X-Gm-Message-State: APjAAAW+FOzJ8CW3oFdp817GU/VoAvAuzP18kbbFLp0TF9EuZQ/7CF0/
 rlNuu87dSDbxrykEdMqgedxY4Q==
X-Google-Smtp-Source: APXvYqx5FRgfgzACu86iP1GsPQenRq7PsSr7FYXcgBfNDRwhNo2M56aJbw7c0MPLB9VmmDDYh4jbyA==
X-Received: by 2002:a7b:c386:: with SMTP id s6mr5218747wmj.105.1581094052162; 
 Fri, 07 Feb 2020 08:47:32 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a184sm4119373wmf.29.2020.02.07.08.47.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 08:47:30 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3BD341FF87;
 Fri,  7 Feb 2020 16:47:30 +0000 (GMT)
References: <20200207150118.23007-1-alex.bennee@linaro.org>
 <20200207150118.23007-5-alex.bennee@linaro.org>
 <CAEyhzFuaDk6CCO72UD0vE9j+Eo=StnoEpWEg5iqOubGhdzXxag@mail.gmail.com>
User-agent: mu4e 1.3.7; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v1 4/5] target/riscv: progressively load the instruction
 during decode
In-reply-to: <CAEyhzFuaDk6CCO72UD0vE9j+Eo=StnoEpWEg5iqOubGhdzXxag@mail.gmail.com>
Date: Fri, 07 Feb 2020 16:47:30 +0000
Message-ID: <87blqa73a5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org,
 robhenry@microsoft.com, aaron@os.amperecomputing.com, cota@braap.org,
 Palmer Dabbelt <palmer@dabbelt.com>, kuhn.chenqun@huawei.com,
 Peter Puhov <peter.puhov@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> Hi,
> On Fri, 7 Feb 2020 at 10:01, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>> -static void decode_RV32_64C0(DisasContext *ctx)
>> +static void decode_RV32_64C0(DisasContext *ctx, uint16_t opcode)
>>  {
>> -    uint8_t funct3 =3D extract32(ctx->opcode, 13, 3);
>> -    uint8_t rd_rs2 =3D GET_C_RS2S(ctx->opcode);
>> -    uint8_t rs1s =3D GET_C_RS1S(ctx->opcode);
>> +    uint8_t funct3 =3D extract32(opcode, 13, 3);
>
> We noticed that a uint16_t opcode is passed into this function and
> then passed on to extract32().
> This is a minor point, but the extract32() will validate the start and
> length values passed in according to 32 bits, not 16 bits.
> static inline uint32_t extract32(uint32_t value, int start, int length)
> {
>     assert(start >=3D 0 && length > 0 && length <=3D 32 - start);
> Since we have an extract32() and extract64(), maybe we could add an
> extract16() and use it here?

Yeah - I did consider if it would be worth adding a extract16 helper.
There are a fair number of places in the code base where uint16_t is
silently promoted to a uint32_t (and a couple where it is downcast).

I guess 16 bit instruction words are common enough we should support
them in the utils.

--=20
Alex Benn=C3=A9e

