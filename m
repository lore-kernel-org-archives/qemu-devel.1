Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D72C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 10:22:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B2A9206C3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 10:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kpVwfA4u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B2A9206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k54wx-0005Bw-QV
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 06:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k54vH-00032S-Io
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 06:20:55 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:53774)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k54vF-0000ts-Mj
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 06:20:55 -0400
Received: by mail-wm1-x332.google.com with SMTP id g8so7157717wmk.3
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 03:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=e6Vb6IkqDbUOZ5J3X3KGuKQpJ72KxPCtIr+Kqb+qCt0=;
 b=kpVwfA4uZZqHMJA9k9QCjFcEURZDR19Rrfna0RLgQQSXrL9w7ZA7j+sybaY7ocWRJA
 /W9LQfh3nFqlJe8JEgFPhMU4ZaJgG5BjS5CiRniCgs6OkqAfuRFnh1cxeTdyUxn3PlhJ
 mI8+Iy0LRLFV5hvbaVuQX3HZUe1ZAUI4eKeN+oA2ySt8zGuYb9T54/A+YuNq6LCfWYNP
 LPLOZTEJpT7EkFfvanK2RNWDSDJxHMuMb5MUvo8/mRGYtz0EzvpEIph1rMLM3MH3vHWp
 fXOGKNZsO9ZelT9yNIMfF0frKUAWgCJlWK/8+wVCXtOafMYE0ZiLMI6j+qlIIs1uOxr5
 y4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=e6Vb6IkqDbUOZ5J3X3KGuKQpJ72KxPCtIr+Kqb+qCt0=;
 b=rSosL5O3OX2UXXHOocUvIaflkXKKOU77qVuinBhCEKNzu9Wu5KxhAHeIEm6z+iTwqe
 undb8qwLDua6eBRa0r5QmFS+qfrOxUhuHUuA5yUGqqStaaDQfMfISaPH5mJ+WxumcDqV
 ymfEo2ueJy7kZbPEoIR8wAZtVQTTiIIM3OpQtVLSC2cWNIMaJeSvv5bktbZiOS5X9TFs
 +l8fPob3LhLcTF9GKnMg29UtyX6vqK3xsnVZNcLfhzG3s2G9qs9f/U7I3s/P8vnP6hgJ
 WjOsSsaQD7I4UJwbw4bp0nACT7eT9OLhmkeyQX8ITWKkq1vNm3q6UmVBnm/MAi5TY7gV
 SneQ==
X-Gm-Message-State: AOAM533wujw+8JIFlQAf3dyVOAAZ3rRGZObG4N54LBEnH7KvaoDzzwdj
 hgbQrMHYIR86fwg9BXjlGSX/fmzf/sU=
X-Google-Smtp-Source: ABdhPJwg8oFchEXcUmlh7z0u8HQ2fkRDmXUaBcaF7Q0yxtSH6HYbuWE48bpzGJLrSvIEQ/do6alO1Q==
X-Received: by 2002:a1c:98c1:: with SMTP id
 a184mr25219325wme.116.1597054851046; 
 Mon, 10 Aug 2020 03:20:51 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o2sm21584002wrh.70.2020.08.10.03.20.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2020 03:20:49 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 400A71FF7E;
 Mon, 10 Aug 2020 11:20:49 +0100 (BST)
References: <CA+aXn+GrFDssmZWBCL0gh3QLX5BMhmgTQUywLSSQn=cpF2P1ZQ@mail.gmail.com>
 <87r1se3k7m.fsf@linaro.org>
 <CA+aXn+ETrBneXK3N6+gzO_7R=6mdxXr_Oig7MjOe7VzO5OD0mg@mail.gmail.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pratik Parvati <pratikp@vayavyalabs.com>
Subject: Re: QEMU Library support
In-reply-to: <CA+aXn+ETrBneXK3N6+gzO_7R=6mdxXr_Oig7MjOe7VzO5OD0mg@mail.gmail.com>
Date: Mon, 10 Aug 2020 11:20:49 +0100
Message-ID: <87lfim3ipq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Pratik Parvati <pratikp@vayavyalabs.com> writes:

> As an experiment, I have modelled non-existing ARM Watchdog model (SP805)
> interfaced to the versatile PB platform. What actually I was looking is -
> some sort of QEMU library, where I can model new device outside the QEMU
> source hierarchy and still be able to compile it using QEMU library and
> include files to add support for the new device. If QEMU doesn't provide a
> library, Is there a flexibly that I can tweak something inside the QEMU to
> generate it?

Not really. While most devices are fairly standalone they can access all
sorts of QEMU APIs. Why not just implement your device inside the QEMU
source tree?

>
> Regards,
> Pratik
>
>
> On Mon, Aug 10, 2020 at 3:18 PM Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
>
>>
>> Pratik Parvati <pratikp@vayavyalabs.com> writes:
>>
>> > Hi team,
>> >
>> > Lately, I have been working on QEMU modeling and interfacing it into t=
he
>> > existing platform. What actually I wanted to check is; whether QEMU
>> > supports library that gives developers a clean interface to develop and
>> > integrate peripheral model in to QEMU. I know of the Greensocs SystemC
>> > bridge - but that was quite difficult to work with in past.
>>
>> Not really - with a few exceptions like vhost-user and in KVM device
>> emulation all devices are emulated in the QEMU code base. As a result
>> the best way to maintain a device is to have it integrated upstream
>> (along with some tests to ensure it is working).
>>
>> As you note there are various forks of QEMU that support device
>> modelling but none of these features have been merged upstream and would
>> likely need to assuage worries about such interfaces being used to avoid
>> GPL compliance.
>>
>> What sort of devices are you looking to model? Are these existing
>> devices or experimental/research things?
>>
>> --
>> Alex Benn=C3=A9e
>>


--=20
Alex Benn=C3=A9e

