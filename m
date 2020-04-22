Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7133C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 17:58:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92E772075A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 17:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cBIr2fZ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92E772075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRJdJ-00017c-Kc
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 13:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43578)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRJcT-0000fC-1H
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:57:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRJcS-00018d-Ai
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:57:08 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37747)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jRJcR-000131-QC
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:57:08 -0400
Received: by mail-wr1-x444.google.com with SMTP id k1so3559654wrx.4
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 10:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ZqSO1eqqXFB6zFA+keKPaZ3VSOTmZx4d4OEEtxuVrZw=;
 b=cBIr2fZ7CIUyKeWxXwfs0nOMV2BAwiubHCGn42jtmIZoB5d+t8BUaIgm6CdktAuVnA
 9nL+UgQRLqNTB/LN+uI0BgWnMX3BXJY5W7j1fkzzoQVY9EzDQm1tLe1JcrgRqUrSKiLt
 LhAON3Me2JWBtSc0zQ0utqfGrQ+LTko7VbFFS+ft3fJcHm6qAmYid5ZLzpMw7CzLNcjX
 5I19NZ9xPVjw2ps/svir1iVgUMpzMJ3c51E84vEPgR1HJT5Z8hg+vZWIWzo2/nxFi1nA
 4AWO7ZXE1e4VXfcESQXRzmV+OA4iFm0MrkexSy7lGDJZA0mFCH76aQek5KAimzcZ5mER
 kMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ZqSO1eqqXFB6zFA+keKPaZ3VSOTmZx4d4OEEtxuVrZw=;
 b=H9gu69Whse2fMEBIfNN3GEU2j2I8QtSDquhpLm/FvE6X72ERNzOLdK50QNBNigk28C
 +yXOJIyNsa/tDjcqpC8Fs/ZFl6j/vCC47APNn6ueFc7OoJ+Iel1078B6/L0QgBxmv8wd
 0JyfXRKnkqjx9Rae0dBCDWdwxI0wlX6/M07ocjpOu3sMs8BhemnNcGw5B6PKr36j8n3+
 BFMul1FgUMMg2aDfdG42ivT/M31vTgJgqC4Kg2+XTbykR4Ldojt2ZaE4eihJwpDUVdaH
 tJPMdJV+iIJEQ3WAiiGXhzbGk5nPwCwOK4YVUJrNgLhtJFJhabsQ7zJthiP19y4ytGxC
 Tegw==
X-Gm-Message-State: AGi0PuZSBwNEUcqghE0DrNJr6URIqgbrPIFLcIEnpHkqdCMfSfn6KiXj
 QM4TR4sO+dzEe03pwEl1vQ+T8/U3DkQ=
X-Google-Smtp-Source: APiQypKcSzNITZbU1gjLseNYI7N4aKGvvaUDv4TXxl9N8/21aWIqWODa+iDg3HyJ4dPvvCRw5PCvTQ==
X-Received: by 2002:adf:f5c4:: with SMTP id k4mr242205wrp.294.1587578226063;
 Wed, 22 Apr 2020 10:57:06 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j68sm9218922wrj.32.2020.04.22.10.57.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2020 10:57:05 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4947C1FF7E;
 Wed, 22 Apr 2020 18:57:04 +0100 (BST)
References: <20200422011722.13287-1-richard.henderson@linaro.org>
 <20200422011722.13287-14-richard.henderson@linaro.org>
 <87k127cx3l.fsf@linaro.org>
 <b0e95ae2-657d-8d74-686d-17375c090e02@linaro.org>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 13/36] tcg: Use tcg_constant_{i32,i64} with tcg int
 expanders
In-reply-to: <b0e95ae2-657d-8d74-686d-17375c090e02@linaro.org>
Date: Wed, 22 Apr 2020 18:57:04 +0100
Message-ID: <875zdrcsjz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::444
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 4/22/20 9:18 AM, Alex Benn=C3=A9e wrote:
>>>  void tcg_gen_brcondi_i64(TCGCond cond, TCGv_i64 arg1, int64_t arg2, TC=
GLabel *l)
>>>  {
>>> -    if (cond =3D=3D TCG_COND_ALWAYS) {
>>> +    if (TCG_TARGET_REG_BITS =3D=3D 64) {
>>> +        tcg_gen_brcond_i64(cond, arg1, tcg_constant_i64(arg2), l);
>>> +    } else if (cond =3D=3D TCG_COND_ALWAYS) {
>>>          tcg_gen_br(l);
>>>      } else if (cond !=3D TCG_COND_NEVER) {
>>> -        TCGv_i64 t0 =3D tcg_const_i64(arg2);
>>> -        tcg_gen_brcond_i64(cond, arg1, t0, l);
>>> -        tcg_temp_free_i64(t0);
>>> +        l->refs++;
>>=20
>> Hmm is this a separate fix?
>
> No, it's expanding what tcg_gen_brcond_i64 would do for TCG_TARGET_REG_BI=
TS =3D=3D 32.
>
>>> +        tcg_gen_op6ii_i32(INDEX_op_brcond2_i32,
>>> +                          TCGV_LOW(arg1), TCGV_HIGH(arg1),
>>> +                          tcg_constant_i32(arg2),
>>> +                          tcg_constant_i32(arg2 >> 32),
>>> +                          cond, label_arg(l));
>
> Because we have two separate TCGv_i32, from tcg_constant_i32(), which can=
not be
> packaged up with TCGV_HIGH/LOW.
>
>
> r~

OK I see that now - the r-b stands ;-)

--=20
Alex Benn=C3=A9e

