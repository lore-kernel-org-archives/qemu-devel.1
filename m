Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF64AC33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 16:24:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7867F214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 16:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EFJjjzfx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7867F214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izjwu-0004Bp-Ez
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 11:24:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45462)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1izjv2-0002YU-3K
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 11:22:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1izjv0-0000Uh-Q5
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 11:22:20 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39076)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1izjv0-0000Sg-J3
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 11:22:18 -0500
Received: by mail-wm1-x342.google.com with SMTP id c84so685427wme.4
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 08:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=xg36Oqft5UpM2R0tq9tEEyPRrWKISNjPrttXE2uphwQ=;
 b=EFJjjzfx/sHkHhIiFFtqXbLO5sQube5RGFQxvtCWtZEq5uNc3YR1RuK5yVdhE/JnEm
 F+7eoKR8YDQbcKQRISBEuSK19Ga3GlxH+e4KyQCBWov3Ws2r2DbbOQsEXiev9cYZ09eI
 3SpgJuOFlAZXjiCJ7+gdumbVvy9+bJqJA64z77JkQQ5XGvuxjgty0KmumHJZh9DSmo7n
 xZfoSyrczqbU4vKwJUSz0p4Vj4t1X4R72NTzGFlTy94AnkePTaEIl8fiRDcsuVlT0bGF
 cQpHY+4NM8X2NUzfCfqBsb1giNjr+Kw6SVNO9O1sjZQSaqSJdC2/RY6Ov36FaS/Twspv
 VMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=xg36Oqft5UpM2R0tq9tEEyPRrWKISNjPrttXE2uphwQ=;
 b=nVG0EYNTaYk9x02osw6Amqm5EtSg7SyehYzmV8cQJ5H3/GMGGIiApZ2Jkh8kcsb6VU
 2Af9nSY+YuNBmUhytUC8wRXljN0AIlQZVid80bYRL9QV6VXjq9jo5+1KELa17eluUlHN
 d+Hz6BKt6ZUFHkD2mIGNUOunZzG+RPdCQlMqO5twW+yyAwrWow9hBagSxeTtzZcIkeAm
 fu0Kwb6w/26Bku1+RltMReUthErTZmPOOpQ2yPbnfNjnCnchzVEoq9moWhINwGkhptYG
 xWyUUSJFMuksdpvOiGU2akmvtc0u1clOa+RBs1LohDCt+lgyAG/g25lUsRCl/MNWeDXq
 ImNQ==
X-Gm-Message-State: APjAAAUvOzXXAiYgU7rgOwfu0hM6g9KWCdeJHS/KSJosBHpNVZ4yHO49
 oHuKTS8SMQqcFiguQbfk0uIi5g==
X-Google-Smtp-Source: APXvYqzyU9C3Te1KKU0oaxUpbAUfLGxoZlz+L1Xmphyf4sYtXK4866FC8Ei+20SFr2QNNmpkgxjl/A==
X-Received: by 2002:a1c:a9c4:: with SMTP id s187mr5241487wme.97.1581006137179; 
 Thu, 06 Feb 2020 08:22:17 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b13sm5012942wrq.48.2020.02.06.08.22.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 08:22:16 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8066B1FF87;
 Thu,  6 Feb 2020 16:22:15 +0000 (GMT)
References: <20200206093238.203984-1-kuhn.chenqun@huawei.com>
 <87d0ar995e.fsf@linaro.org>
 <7412CDE03601674DA8197E2EBD8937E83B10AD31@dggemm511-mbx.china.huawei.com>
User-agent: mu4e 1.3.7; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
Subject: Re: [PATCH] tests/plugin: prevent uninitialized warning
In-reply-to: <7412CDE03601674DA8197E2EBD8937E83B10AD31@dggemm511-mbx.china.huawei.com>
Date: Thu, 06 Feb 2020 16:22:15 +0000
Message-ID: <877e0z8z48.fsf@linaro.org>
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Chenqun (kuhn) <kuhn.chenqun@huawei.com> writes:

>>-----Original Message-----
>>From: Alex Benn=C3=A9e [mailto:alex.bennee@linaro.org]
>>Sent: Thursday, February 6, 2020 8:46 PM
>>To: Chenqun (kuhn) <kuhn.chenqun@huawei.com>
>>Cc: qemu-devel@nongnu.org; Zhanghailiang
>><zhang.zhanghailiang@huawei.com>; qemu-trivial@nongnu.org;
>>richard.henderson@linaro.org
>>Subject: Re: [PATCH] tests/plugin: prevent uninitialized warning
>>
>>
>>kuhn.chenqun@huawei.com writes:
>>
>>> From: Chen Qun <kuhn.chenqun@huawei.com>
>>>
>>> According to the glibc function requirements, we need initialise  the
>>> variable. Otherwise there will be compilation warnings:
>>>
>>> glib-autocleanups.h:28:3: warning: =E2=80=98out=E2=80=99 may be used un=
initialized in
>>> this function [-Wmaybe-uninitialized]
>>>    g_free (*pp);
>>>    ^~~~~~~~~~~~
>>>
>>> Reported-by: Euler Robot <euler.robot@huawei.com>
>>> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
>>
>>Queued to plugins/next with Thomas' single line suggestion, thanks.
>
> Thank you!
> By the way,  what is plugins/next connection address?

My tree is on github:

  https://github.com/stsquad/qemu/tree/plugins/next

>
>>
>>> ---
>>>  tests/plugin/bb.c   | 2 +-
>>>  tests/plugin/insn.c | 2 +-
>>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tests/plugin/bb.c b/tests/plugin/bb.c index
>>> f30bea08dc..8b9da23a04 100644
>>> --- a/tests/plugin/bb.c
>>> +++ b/tests/plugin/bb.c
>>> @@ -22,7 +22,7 @@ static bool do_inline;
>>>
>>>  static void plugin_exit(qemu_plugin_id_t id, void *p)  {
>>> -    g_autofree gchar *out;
>>> +    g_autofree gchar *out =3D NULL;
>>>      out =3D g_strdup_printf("bb's: %" PRIu64", insns: %" PRIu64 "\n",
>>>                            bb_count, insn_count);
>>>      qemu_plugin_outs(out);
>>> diff --git a/tests/plugin/insn.c b/tests/plugin/insn.c index
>>> 0a8f5a0000..c83b1c0157 100644
>>> --- a/tests/plugin/insn.c
>>> +++ b/tests/plugin/insn.c
>>> @@ -44,7 +44,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id,
>>> struct qemu_plugin_tb *tb)
>>>
>>>  static void plugin_exit(qemu_plugin_id_t id, void *p)  {
>>> -    g_autofree gchar *out;
>>> +    g_autofree gchar *out =3D NULL;
>>>      out =3D g_strdup_printf("insns: %" PRIu64 "\n", insn_count);
>>>      qemu_plugin_outs(out);
>>>  }
>>
>>
>>--
>>Alex Benn=C3=A9e


--=20
Alex Benn=C3=A9e

