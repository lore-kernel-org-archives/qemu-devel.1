Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE5EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 17:01:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EE4E206B6
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 17:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wuh+8Mzq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EE4E206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbS5Z-0003tO-DH
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 13:01:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jbS4a-0002tG-3s
 for qemu-devel@nongnu.org; Wed, 20 May 2020 13:00:04 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b]:34721)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jbS4Y-0007vt-MW
 for qemu-devel@nongnu.org; Wed, 20 May 2020 13:00:03 -0400
Received: by mail-ej1-x62b.google.com with SMTP id j21so4864211ejy.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 10:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=dWUQ3BprChLjhkvCeE+yi/Pe8ndEBtn//oMnHkXYygE=;
 b=wuh+8MzqQErNiYDLuM0a+aUXkQalXYRcWwkMuyPjB0pkco2/y3d6QUUHCnNJl/eVzC
 A93O6bFTVeavpj8HzAKqP9iEiRkMJ22n9Eo4o69whgfC1xzrJbWQ8zH+k3nOOtVi6XO+
 0357BxW85B2H79QAjzzA4vBm8EyFRq4SuTH/Jl0fCTbKUOuaokkG603nesI6UN/5ZCml
 rbxd9szekz7YIhwGfRuSLhmkD/X+Xt0E48vA8d29kevaoAi4H16RmfRhRJdoCdtsiuNN
 5xLG2wPrOWflAjyaX1aq+lyclCYWu8Icfkl/iqXnYBGlgwuw3bmeoITgYyahKkGbRoYR
 MR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=dWUQ3BprChLjhkvCeE+yi/Pe8ndEBtn//oMnHkXYygE=;
 b=l0DYrI9t2GzmZ33jXxtK+s3NbLgO6+fLoJhuk8FjqwQmKRgaK8VgpPiOhGuBzwI1sP
 ZcUftJgyQ/WgKbnRFU47FjZHnBSvkyFFurSJBMqV++2e39YOsXKxwS1tzvgagp/ylySm
 JF5P1CylDrtfLFzTqEiKekSyJbvAxc8nzG/4v5OMH9ez/egaqsDckX2YsNOQiRF6Ep1e
 AYIkUBu7OESfPMHcMdqbaOL4uwATWkftBYE2eWGERHhm/ocwtx3YdPynCXP0rW5d8Amb
 jYVQZtsvCNqTD5WLg1mIbYZg6NpTyu6xuLa59M6WpUzAwszhdywAq+YpF0vJl/wkx+bB
 RcKw==
X-Gm-Message-State: AOAM531jB3FiFknP1XtdIcywhgBb5d2a7YoYiNZcEtwtK4BI5oXFn4cC
 YL3/YzbTPM6EIf/DODdHJCyXjQ==
X-Google-Smtp-Source: ABdhPJziJduHR8WNbGT81befY1V2Oi2KMHJAFhWXkjP+FzAZzWjeikWb53e7H2GSfhyF6IS3A8Ik6A==
X-Received: by 2002:a17:906:63c9:: with SMTP id
 u9mr4654046ejk.439.1589994000665; 
 Wed, 20 May 2020 10:00:00 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y10sm2292929ejw.25.2020.05.20.09.59.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2020 09:59:59 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 66C301FF7E;
 Wed, 20 May 2020 17:59:57 +0100 (BST)
References: <20200519025355.4420-1-richard.henderson@linaro.org>
 <20200519025355.4420-15-richard.henderson@linaro.org>
 <0cba90b4-e1c3-8cb9-a405-c5447a1aa17f@linaro.org>
User-agent: mu4e 1.4.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RISU v2 14/17] Add magic and size to the trace header
In-reply-to: <0cba90b4-e1c3-8cb9-a405-c5447a1aa17f@linaro.org>
Date: Wed, 20 May 2020 17:59:57 +0100
Message-ID: <87v9kqfsoi.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 5/18/20 7:53 PM, Richard Henderson wrote:
>> +    if (master_header.magic !=3D RISU_MAGIC ||
>> +        master_header.risu_op !=3D op ||
>> +        master_header.size !=3D extra_size) {
>> +        res =3D RES_MISMATCH_HEAD;
>> +        goto fail_header;
>>      }
>
> Hmm.  This isn't ideal.
>
> Consider e.g. an insn being tested that should pass, so master steps past=
 the
> insn to the UDF and sends OP_COMPARE.  But there's a bug in the emulator =
being
> tested so the apprentice gets SIGILL on the insn and so op =3D=3D
> OP_SIGILL.

In my experience this is one of the major failure modes as usually it's
a decode error or a -cpu version error that leads you to go astray.

That said most useful additional piece of information to dump would be
the insn word of the failing PC. We even know if one is on a RISU_OP and
one isn't so we can be a bit more expressive.

> So risu_op !=3D op, but we only report the header difference.
>
> Perhaps that's good enough to understand the this particular problem, wit=
hout
> the clutter of printing the rest of the reginfo frame -- at least if
> report_mismatch_header is improved to print risu_op names instead of numb=
ers.
>
> Consider if master and apprentice are run with different --test-sve=3D<vq>
> values.  That will produce a mismatch in size.
>
> Which could be a serious problem, if master_header.size > sizeof(master_r=
i) --
> we can't even receive the data.  In that case, what I'm doing here printi=
ng the
> size mismatch is all that's possible.
>
> But suppose master_header.size <=3D sizeof(master_ri), so we can receive =
the
> data.  So long as master_header.size =3D=3D reginfo_size(&master_ri), the=
n at least
> the data is self-consistent, and we *can* print out the difference in
> report_mismatch_reg().  Which in this case is going to be the difference =
in the
> two ri->sve_vl values.  That difference is likely to be easiest to unders=
tand
> for the end user.
>
> I should probably split out this receive logic from
> recv_and_compare_register_info so that it can be reused by dump.
>
>
> r~


--=20
Alex Benn=C3=A9e

