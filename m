Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2531C74A36
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 18:19:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FB5A214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 18:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cPA2C7/L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FB5A214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlHC4-0005nH-IY
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 14:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38646)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hlH8W-0005Bp-Ku
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 14:16:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hlH8U-0007TQ-SM
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 14:16:12 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54026)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hlH8T-000740-75
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 14:16:10 -0400
Received: by mail-wm1-x341.google.com with SMTP id x15so3237095wmj.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 11:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=+Ncv5Iz5yE6MhpUYoiTKxog1m6fceFWz1R5CKvxRCnw=;
 b=cPA2C7/LMs450qgd9/mfiPM2teeZUz0EgK1V5q6LZ1MrFEcCR6+M0zAzqMQ2vebx7Z
 3oXGZZgX5Tlv/cWiOeTX7GRZH+gatXA9i0t7dDnHAWo/ZmPvFk5z3VmEdQ2rwhmFBlbH
 vd9oGrJPjnxIEF6ciGP8Nn37DzrYcjizWFJ4l/fNf84CKKtP9d05iSRSuAlX0X3fOh0T
 X2aKxKB7RVoqppcPPRExg+nrs+RuCLP0hfj/h0HajliKhcRAHeDiW33sfdBDJ1draOzv
 fO/TJST6v2HfhZYFk2MYHfE9JnUvNZgEV/eVWqE3+c9ONJZ4yQ4cA4f2oQaTw+DcigPA
 XYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=+Ncv5Iz5yE6MhpUYoiTKxog1m6fceFWz1R5CKvxRCnw=;
 b=fkDLGJa8tfuYfXAEMhu0FVkc+uul5FpO8Yohx38ISlQgHBjKm3D0FFbEls0NOBz/ZT
 OMX+wwb+trKQMhXOm5ZfOxy8wMM65qgKaCgcE2SzJo4V9Jk4woPYQ5mrRpZbBL1WTcjv
 u5wq3hcfm1+ZukBm91D6IsKp/hnmt1We+vnbJOka+o602RzXLUOaBsjwgXsEQSjl32sU
 Mz4YkhvY6U/Ho+kTdm4oJF2PQzZNE/vcYEh4uZaXh37s4i2xXSBxOi7mOndGwFSbgERA
 z94nzhrTGCs6S/1VeCJqds0AKvWjsk/xiG0gU/sff/1q5pNWC+GYnBpTRIbD9D/fH5YW
 9v4w==
X-Gm-Message-State: APjAAAUWzF617aWS8lfTf18QbUnmvLFTbQOY5g4Shj8pnnlf36wsVSiN
 JWuQQt1SJ8NidoUpSiG/SDkmlw==
X-Google-Smtp-Source: APXvYqz2JYBtu8nUf47zXiQeuLIGDramWtYkTsrTPrkL2rZf9rxQaA6I/+Wg15jvdzrKPcrDYzYNxQ==
X-Received: by 2002:a05:600c:2102:: with SMTP id
 u2mr6530940wml.105.1562782552525; 
 Wed, 10 Jul 2019 11:15:52 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id g8sm3171811wmf.17.2019.07.10.11.15.51
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 10 Jul 2019 11:15:51 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DFEBE1FF87;
 Wed, 10 Jul 2019 19:15:50 +0100 (BST)
References: <2136180936.260219.1561641583358.ref@mail.yahoo.com>
 <2136180936.260219.1561641583358@mail.yahoo.com>
 <1079763171.281101.1561641752988@mail.yahoo.com>
 <e4c1fbc4-3e43-5df4-a17c-527d98d9763c@linaro.org>
 <20190628002713.GA19257@localhost.localdomain>
 <eadb57ae-256d-0bb7-5988-f493662a5caf@linaro.org>
 <20190628155030.GA34320@localhost.localdomain>
 <ea16a81c-5b94-8dd0-8339-2bd82733aed2@linaro.org>
 <20190629163621.GA111724@localhost.localdomain>
 <CAFEAcA9sfNisAz-zAZAx=ZNFmsEpP0Ec2DeRedtZSd9KQ4fvNA@mail.gmail.com>
 <1399218244.1210557.1561982640362@mail.yahoo.com>
 <CAFEAcA-0vGg_1nfkbq+o6JwoDsRyP=6mnv6ADi-atV0ROX269Q@mail.gmail.com>
 <CALvKS=GvAkNr3OKZzjGoTGG_Eys76zjcjodiN4hKXjFM5B0a4A@mail.gmail.com>
 <d9e5602c-bb33-1812-ebc2-b533e9dd5f25@linaro.org>
 <CALvKS=EbuQOvRx+bmRnqCD6JuHK87dnkx00EiH--aXYWuNF0VQ@mail.gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <CALvKS=EbuQOvRx+bmRnqCD6JuHK87dnkx00EiH--aXYWuNF0VQ@mail.gmail.com>
Date: Wed, 10 Jul 2019 19:15:50 +0100
Message-ID: <87ims9eox5.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] RFC: Why does target/m68k RTE insn. use
 gen_exception
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
 Lucien Anti-Spam <lucienmp_antispam@yahoo.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Lucien Murray-Pitts <lucienmp.qemu@gmail.com> writes:

>> On Wed, Jul 10, 2019 at 4:04 AM Richard Henderson <
> richard.henderson@linaro.org> wrote:
>
>> > I did have a suggestion.  It was fairly detailed.
>> > https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg06522.html
>>
>> Your solution is elegant at about 10 lines that return getl_ilen(pc), but
> it seems the s390 has a far simpler
> instruction word format than the m68k.
>
> However then that got me to thinking, it seems that we can call a portion
> of the TCG system to disassemble a single instruction.
>     TranslationBlock tb;
>     tb.pc =3D env->pc;
>     gen_intermediate_code(cs, &tb, /* max isn */ 1);
>     int ilen =3D tb.size;
>     printf( "PC: %08x sz:%08x\n", env->pc, tb, ilen ) ;
>
> I am very new to TCG, so it does seem there is a lot of code in the
> translator_loop that appears to be interacting with the CPU model/state.
> Should I be worried about this, or is this a safe function to call outside
> of the translator core proper?

I would recommend against it - the time to do stuff like this would be
during translation phase where you can save the data. Don't re-invoke the
translator while trying to process an exception.

Is the instruction format that irregular that you can't do a simple
disassembly in a helper?

> (if everyone is too busy I can dig by myself but I think its going to take
> some time)
>
> Cheers,
> Luc


--
Alex Benn=C3=A9e

