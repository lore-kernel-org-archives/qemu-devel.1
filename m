Return-Path: <SRS0=fVwN=XJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A575C4CEC7
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 17:52:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C52C206A4
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 17:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rQepy9M1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C52C206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9CDT-0001xj-3V
	for qemu-devel@archiver.kernel.org; Sat, 14 Sep 2019 13:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46514)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i9CCY-0001T4-T5
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 13:51:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i9CCX-0003yH-93
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 13:51:14 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38756)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i9CCX-0003xh-0O
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 13:51:13 -0400
Received: by mail-wm1-x343.google.com with SMTP id o184so5894967wme.3
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2019 10:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=gg3FSB88XF+bESjLXdCwhE19LAFwKviz5hjlVd0SMgk=;
 b=rQepy9M1WWqSfEaGP1+a7Q6pyJnbRSi+RTrKxus64wZBQ/ehU9jMeBAvj+tbJnftPM
 1pKfH46kAVYU0YpNyB4SrI3ExB9FdeQCeXS+LuC0E9AAgGto2lOLotQg/CL04Uky/Skx
 1JVkRbiq1nHnxp4O/7RZefYS4rb7OoSdDkbOkJJZeJGrgNUrTYvHY/H3cstGx/l4Jk7z
 RWjX3Ba7RaOnIgLYko2OYh4NANsZ7KqWBbvMiy3wY7GMerQo0yMHFvrgdYt+2ICwlj+d
 OiwSl64dZ+WvCtkklZ3AZRtNeSotUO/KXpZCJFLM4J9IFLHc1tokrXgmrVvXTYiAAVRa
 whUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=gg3FSB88XF+bESjLXdCwhE19LAFwKviz5hjlVd0SMgk=;
 b=uUkVi+OrAt7OhrDq4TZOyrna2eISNv1rLbKCfgu1z1ANIfeFpejb9Eu10GaI+w6N3Z
 ybzCeESzUjE5obBmfB/1lW4ybjS7LG1JMLEAp+hlAl42Kyrx+uhRmYAyS7TvdvsNhJt4
 /ZVsurnDEmyvfBkQ6vscX+iBC2yLzQs30vdD5gnZRNNCinkui4OqfFIXIHfEcK0gsVpm
 Q4yHP/juC2s5oJ5e0Yn58HohS4diruXwNHQIFY1Nt/m/Y8jjL7+rgUd76QXKz9PhSvT6
 uE3yraFrv3WTheFg1ITcrRghAJTGiixiQn3/oT8+O+OCH4az5jZMIsS/M6PIY9aEtyOb
 okIg==
X-Gm-Message-State: APjAAAWDVi0v/Of57kTrajR2DYTuMfbsOJ98RPnApp12NbTE+Bsxp4Nx
 C/yr9+d+Y7xeZpzPjf+Ti/UHUg==
X-Google-Smtp-Source: APXvYqxvJrlqGBuO55wKzuNHqFJKikIWeT/e/LGwNTdzG9U3FeXadXH1IznTf0YUnN0NHrG9Ap69LQ==
X-Received: by 2002:a05:600c:34e:: with SMTP id
 u14mr3769215wmd.110.1568483471297; 
 Sat, 14 Sep 2019 10:51:11 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s12sm23273269wrn.90.2019.09.14.10.51.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Sep 2019 10:51:10 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5F27D1FF87;
 Sat, 14 Sep 2019 18:51:09 +0100 (BST)
References: <20190910193408.28917-1-alex.bennee@linaro.org>
 <20190910193408.28917-5-alex.bennee@linaro.org>
 <CAL1e-=giNc1e+kN04KqHFQGkJbP4BKziQyxVd3-RTtL+UOfSoQ@mail.gmail.com>
 <874l1j18vm.fsf@linaro.org>
 <5880b9c9-969f-fa79-f7f4-a45a6568635e@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
In-reply-to: <5880b9c9-969f-fa79-f7f4-a45a6568635e@linaro.org>
Date: Sat, 14 Sep 2019 18:51:09 +0100
Message-ID: <87woeaahrm.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v1 4/4] elf: move ELF_ARCH definition to
 elf-arch.h
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
Cc: peter.maydell@linaro.org, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 9/11/19 5:26 AM, Alex Benn=C3=A9e wrote:
>>
>> Aleksandar Markovic <aleksandar.m.mail@gmail.com> writes:
>>
>>> 10.09.2019. 21.34, "Alex Benn=C3=A9e" <alex.bennee@linaro.org> =D1=98=
=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>>>>
>>>> This is preparatory for plugins which will want to report the
>>>> architecture to plugins. Move the ELF_ARCH definition out of the
>>>> loader and into its own header.
>>>>
>>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>> --
>>>
>>> Hi, Alex.
>>>
>>> I advice some caution here
>>> . For example, EM_NANOMIPS, and some other EM_xxx constants are not
>>> included in the new header.
>>
>> EM_ARCH was never set to EM_NANOMIPS. In fact I can see e_machine is
>> checked against it so I guess it is only ever used to checking the
>> loading elf directly.
>>
>> In fact EM_ARCH is only really the default fallback case for checking
>> the elf type if there is not a more "forgiving" check done by arch
>> specific code (elf_check_arch). The only other cace is the fallback for
>> EM_MACHINE unless PPC does something with it.
>>
>>> I am not sure what exactly you want to achieve
>>> with this refactoring. But you may miss your goal, since some EM_xxx wi=
ll
>>> be missing from your new header. Is this the right way to achieve what =
you
>>> want, and could you unintentionally introduce bugs? Can you outline in =
more
>>> details your intentions around the new header? Is this refactoring the =
only
>>> way?
>>
>> As mentioned in the other reply maybe exposing a value from configure
>> into config-target.[mak|h] would be a better approach?
>
> I think using EM_FOO to tell a plugin about the architecture is just goin=
g to
> be confusing.  As seen here wrt EM_NANOMIPS, but arguably elsewhere with
> EM_SPARC vs EM_SPARC64.
>
> You need to decide what it is that you want the plugin to know.  It is ju=
st be
> gross architecture?  In which case QEMU_ARCH_FOO is probably enough.  Is =
it the
> instruction set currently executing?  In which case neither EM_FOO nor
> QEMU_ARCH_FOO is sufficient -- e.g. arm thumb -- and you'll have to invent
> something new, because no two architectures handle this in the same way. =
 The
> closest you might be able to get without invention from whole cloth is the
> capstone cap_arch+cap_mode values from cc->disas_set_info().  But that on=
ly
> handles the most popular of targets.

I think I'm going to stick with the gross TARGET for now. It mostly
seems a way of avoiding building per-arch plugins. I assume most out of
tree plugins will be targeted at a specific machine anyway.

Anyway I think that means I'll drop this series unless 1-3 are worth
keeping as simple clean-ups leaving out 4?

>
> In any case, a single header that every target must touch is the wrong
> approach.  If you want to do some cleanup, move these defines into e.g.
> linux-user/$TARGET/target_elf.h.  (And I wouldn't bother touching bsd-use=
r in
> its current condition.)
>
>
> r~


--
Alex Benn=C3=A9e

