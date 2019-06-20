Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0173C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 17:07:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A4DA20675
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 17:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S+RaOlJw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A4DA20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50596 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1he0Wv-0006JT-1e
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 13:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40491)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1he0HM-0005TJ-Ly
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 12:51:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1he0HK-0007EU-I6
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 12:51:16 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33499)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1he0HK-0007BU-3j
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 12:51:14 -0400
Received: by mail-wr1-x442.google.com with SMTP id n9so3801814wru.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 09:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=DSvnA8H3FdZL1YIuyfSjH9NcqXg4cHzyyZM4xstBFjA=;
 b=S+RaOlJwW9hIqxgQ5iPzEYu4YpI5RbJZbBdd3Rr1jX95CGi/TOrmV7p1baC43UAAne
 61pltsekN6WcT+QKFyOAXVmaIOo8Z4XcVaHpV/DCvS0cqJZgE0hFLwrH29d+Hs2zDABi
 Ug1ZeInlqKw/FFr+5Fr/SYlygPEBu4HazeDPD9Y9jRQKVXVQZpePvqPUjyMu/SV+Kkdx
 JLcDwNslznnvqeu9khnbVW0RZw6KULUgZV6msCCmum1SVjEk1xFLJt8KBxkzFA2W/3g1
 TqjhUm+mzvo6E4+iOES/Qbxp2nzNAE/VIamy7vt3vTMQz3hQvOMFXwRhSyTF1kX9KNgv
 E/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=DSvnA8H3FdZL1YIuyfSjH9NcqXg4cHzyyZM4xstBFjA=;
 b=AgJ2YC2MJ4a7Hw6HL66G+roq3Jb62ZDCfioVmM98k488DZN5N7qJBbhQcy2Lmf4yeP
 jS+LKZfQN7gu0PadC1xlcWki+rv+UiPzXq2SUWiUPMnYgK2MICyt2qbPt5RnvTI39L2T
 IreUwiZezbGGUrCom6cLSOwALdp02CCykZA0d2BBpQ4y4cA52thMBmfjnNxZD75KAul9
 rZLuovWgK9U5fm8d3anSDJMp5bXIgne8c8D1uw6iOI+NSK9IsaxRMOglwZP6nby72GYz
 lrZyVauVrsiw3lMczYWsKgF9NFs5ng0+8PC0VnIlC9YGBzdY9hlS5mhLnV5wAjyohmw9
 rjEA==
X-Gm-Message-State: APjAAAVEKwQInOW291fqW8uQ/XIdD+jwIVtEk/J+Dpbz/j3cKQLdVL+q
 eIpfxEMUq2ClTFOh9mCAfOZxfg==
X-Google-Smtp-Source: APXvYqxaSsCmddgXKleCsEs3kDkGxrlaVjFaTrn3AnGugnfmqOqXeMmm9mLhiXDMkBJgV5IBK8tYyg==
X-Received: by 2002:adf:fbd0:: with SMTP id d16mr8255779wrs.341.1561049471171; 
 Thu, 20 Jun 2019 09:51:11 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id y17sm256915wrg.18.2019.06.20.09.51.10
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 20 Jun 2019 09:51:10 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 241501FF87;
 Thu, 20 Jun 2019 17:51:10 +0100 (BST)
References: <20190614171200.21078-1-alex.bennee@linaro.org>
 <20190614171200.21078-38-alex.bennee@linaro.org>
 <53e14a5c-0689-17d7-2b62-1649398561a9@linaro.org>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
In-reply-to: <53e14a5c-0689-17d7-2b62-1649398561a9@linaro.org>
Date: Thu, 20 Jun 2019 17:51:10 +0100
Message-ID: <87sgs48akh.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v3 37/50] translator: inject
 instrumentation from plugins
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Emilio G. Cota" <cota@braap.org>,
 qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 6/14/19 10:11 AM, Alex Benn=C3=A9e wrote:
>> @@ -95,6 +103,10 @@ void translator_loop(const TranslatorOps *ops, Disas=
ContextBase *db,
>>              ops->translate_insn(db, cpu);
>>          }
>>
>> +        if (plugin_enabled) {
>> +            plugin_gen_insn_end();
>> +        }
>> +
>>          /* Stop translation if translate_insn so indicated.  */
>>          if (db->is_jmp !=3D DISAS_NEXT) {
>
> This will of course not be reachable if db->is_jmp =3D=3D DISAS_NORETURN.
> Do we want to not bother calling the plugin for this case?

Hmm good point. Are you just suggesting:

  if (plugin_enabled && db->is_jmp !=3D DISAS_NORETURN)

to be explicit?

>
>
> r~


--
Alex Benn=C3=A9e

