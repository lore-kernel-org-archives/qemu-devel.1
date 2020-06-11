Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA77BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 17:20:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94B552082E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 17:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z10hLBWf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94B552082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjQs8-0007cz-RR
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 13:20:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jjQph-000637-VT
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 13:17:42 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39890)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jjQpg-0001mB-1k
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 13:17:41 -0400
Received: by mail-wm1-x341.google.com with SMTP id k26so5791559wmi.4
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 10:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=N9t4an2YUtQd9OOXCTmDsS0GqoclUO94HhnL+d428LA=;
 b=z10hLBWfGrC25gAXsS/4+7/4LFhd+vxmnuDd6AnXVekXr2Sgowch49W0ZKkJMTrCKF
 kvJkKaL9V4Z6pe0x+YuNnl67t6KzuGTKPuX0fJpCa8a9GIJFOCpiTchgiqPSBKXPuiCr
 SKK/PM/KQ+EWoGAtwL31I6AaRUlglOCqgvfGxBCqpsnNq0HrJDDg4UAFMOimyy0klLKV
 JpTPi+pwT2zkx7U8vvBgFIvbi36xH4P682undDeaCW1AqeJBAn/9nVvFXFMJGokkIKe/
 7nG7GWVl8R2mFIVfb3UAvOhpDSmhM6nsUOUDeLorpFlfLoOXfpI1P0+2/Pun4i++twBp
 uoQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=N9t4an2YUtQd9OOXCTmDsS0GqoclUO94HhnL+d428LA=;
 b=GGp+6ywVq3Ia9t1kQb1EGLfRk3r6JvMSBZYG6Qe4gP2O3AlYnh8KHxzEe1liWPmIj6
 533P805Ch2+KZViPseNVYFlLiQjIaLc1lHnz+werPlkbr4MYX16IMVorgbK2vyzrXUft
 7WNhqnFZdBBAMSTgUrOO5WpIPaJx079gDFsCUBB70xPvSvSsVA0RgvFpgVimKEsdhRR3
 RsmJMAqKUShU5wERbuuOjpa6N/oDDIUojIIz6JFavf3AbWt9ssIaPp84xDmnxtzrkwU2
 p7v2yJTfZ3BMXn8H+Z15n+oc2H5Tptq64nVKj38Bpq0kmR73C7qnCkIMvxTMmFZhwNaL
 FO9A==
X-Gm-Message-State: AOAM530QFD3UBw48Ume+nBJcbRDqVy8Xmf6UTEQOCbcAnDAbgKN48Zr8
 pwDVTMXES6maZ1ee09yyKt8d/A==
X-Google-Smtp-Source: ABdhPJy6yACDaz2EcAQxT2tu0ooyEWVZHAFlu5RsiCks9MxHpGKsei1NaPj9kwkJoWO34ntoVan4XQ==
X-Received: by 2002:a1c:771a:: with SMTP id t26mr3207993wmi.65.1591895850620; 
 Thu, 11 Jun 2020 10:17:30 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m24sm4876832wmi.14.2020.06.11.10.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2020 10:17:29 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 68DFA1FF7E;
 Thu, 11 Jun 2020 18:17:28 +0100 (BST)
References: <20200610203942.887374-1-richard.henderson@linaro.org>
 <20200610203942.887374-6-richard.henderson@linaro.org>
 <87bllp4kn1.fsf@linaro.org>
 <9d416d2e-593d-61c5-ab20-7b182a7bb757@linaro.org>
User-agent: mu4e 1.5.2; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 5/5] configure: Add -Wno-psabi
In-reply-to: <9d416d2e-593d-61c5-ab20-7b182a7bb757@linaro.org>
Date: Thu, 11 Jun 2020 18:17:28 +0100
Message-ID: <877dwd4j4n.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 6/11/20 9:44 AM, Alex Benn=C3=A9e wrote:
>>=20
>> Richard Henderson <richard.henderson@linaro.org> writes:
>>=20
>>> On aarch64, gcc 9.3 is generating
>>>
>>> qemu/exec.c: In function =E2=80=98address_space_translate_iommu=E2=80=
=99:
>>> qemu/exec.c:431:28: note: parameter passing for argument of type \
>>>   =E2=80=98MemTxAttrs=E2=80=99 {aka =E2=80=98struct MemTxAttrs=E2=80=99=
} changed in GCC 9.1
>>>
>>> and many other reptitions.  This structure, and the functions
>>> amongst which it is passed, are not part of a QEMU public API.
>>> Therefore we do not care how the compiler passes the argument,
>>> so long as the compiler is self-consistent.
>>>
>>> Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>> Cc: Peter Maydell <peter.maydell@linaro.org>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>> TODO: The only portion of QEMU which does have a public api,
>>> and so must have a stable abi, is "qemu/plugin.h".  We could
>>> test this by forcing -Wpsabi or -Werror=3Dpsabi in tests/plugin.
>>> I can't seem to make that work -- Alex?
>>=20
>> modified   plugins/Makefile.objs
>> @@ -5,6 +5,7 @@
>>  obj-y +=3D loader.o
>>  obj-y +=3D core.o
>>  obj-y +=3D api.o
>> +api.o-cflags :=3D -Wpsabi
>>=20=20
>>  # Abuse -libs suffix to only link with --dynamic-list/-exported_symbols=
_list
>>  # when the final binary includes the plugin object.
>>=20
>> Seems to work for me.
>
> Wrong directory -- that's the part that goes into qemu, which also uses o=
ther
> qemu internal headers.  As opposed to the tests/, which only use the one
> "qemu/plugins.h" header (plus libc).

It's a sub-make so I just did:

modified   tests/plugin/Makefile
@@ -18,7 +18,7 @@ NAMES +=3D hwprofile
=20
 SONAMES :=3D $(addsuffix .so,$(addprefix lib,$(NAMES)))
=20
-QEMU_CFLAGS +=3D -fPIC
+QEMU_CFLAGS +=3D -fPIC -Wpsabi
 QEMU_CFLAGS +=3D -I$(SRC_PATH)/include/qemu
=20
--=20
Alex Benn=C3=A9e

