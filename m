Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD24EC4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 11:19:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF35520708
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 11:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R22+LHNu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF35520708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNa8z-0006eN-Tk
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 07:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kNa89-0006Dz-JW
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 07:18:41 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42743)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kNa87-0002wZ-Qx
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 07:18:41 -0400
Received: by mail-wr1-x443.google.com with SMTP id c18so1336514wrm.9
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 04:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=wMZ5Ij++IeecN8Sx3NM4s64oMZmw5Awbb8mIkxxgHQk=;
 b=R22+LHNuaYXZRsPe0D2q47SGLuuepzMVTGREPw4/4ZOt3AFICChCgUOKZxEaDiPdtg
 O3R+kKlbbiJSRMpYJZz8hBTbytMdcWiaxgC6aqdfMr9hTZPP9/pGj37nth8IuiZhZAqw
 xMs8uP6rX7TVRSlhT7cusaFAOsO8wQUnvtnm4h3KbroGXr8j0Ph8HY/jq9FEENXPmCL5
 nRjrIYYUD97aBFHU+M+2TSW0gD6MctbZx4P1DDImpWNtv1RFgfwoqB76Yci7+CpczS7J
 DU6POwS1/0FAQQWCl7mskW5E93mghYBxaz5Gp1jeHhJJZUH0fnlUP50ZaQhRkyoSSDdp
 EDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=wMZ5Ij++IeecN8Sx3NM4s64oMZmw5Awbb8mIkxxgHQk=;
 b=fC/DciH2MrR//qp+Y4hG6socWDe6OYywKqNGmg055ef2MuRN9+6nB5ccd0Y109aFka
 oZAWh5KdnxRxpbuibDYqA6GhPwUG9nt4h7nqrgABtaq/JGZjXPqQnpVFrCL+khcEM4Eo
 /2vJgW2GDyfQ9fAv9FGnHx2YZb5TYY+dCYvkXeEJzyvloPNT9SnM5pb+oGZCozkz+2hb
 5cv9sinueurprqChxfJcHy0RTCtJkZLEvFykNUsyfHB/B7vuPKoEUIAxnAPTyY8l6qKO
 OX7nVtBPtNn/tVivxlF4gfqlGqW0kbrrxPMceXr6PirtwIABRHnral6y5DVuyVdJLl4Z
 Vb8Q==
X-Gm-Message-State: AOAM5305r4eDlr/nRxjYvtNSO5iAb8fWrfK0IDmNVD7yGIdH+aA+CFXL
 hFCUhfGz/Plxr7rjwvsdqkMRAvSIxsyNag==
X-Google-Smtp-Source: ABdhPJzKFgMkHItvcV0GLvkyngtrLkAf4/gCs7qcBeg6mXtJCh5DLV7G8rPTnW8bbEazjYLFCGpuYA==
X-Received: by 2002:a5d:43cf:: with SMTP id v15mr2794787wrr.149.1601464717417; 
 Wed, 30 Sep 2020 04:18:37 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l10sm2410476wru.59.2020.09.30.04.18.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 04:18:36 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C698F1FF7E;
 Wed, 30 Sep 2020 12:18:35 +0100 (BST)
References: <20200925154027.12672-1-alex.bennee@linaro.org>
 <20200925154027.12672-4-alex.bennee@linaro.org>
 <f5fc27fa-0c02-b1a9-7f29-dd48aa40fd6a@redhat.com>
 <87ft70pgpq.fsf@linaro.org>
 <0e0ebdd5-d9b9-17dd-82c9-2c63a73f4eea@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v1 03/15] meson: move libmpathpersist test
In-reply-to: <0e0ebdd5-d9b9-17dd-82c9-2c63a73f4eea@redhat.com>
Date: Wed, 30 Sep 2020 12:18:35 +0100
Message-ID: <87y2kro6lw.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> On 30/09/2020 12.51, Alex Benn=C3=A9e wrote:
>>=20
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>=20
>>> On 25/09/20 17:40, Alex Benn=C3=A9e wrote:
>>>> From: Paolo Bonzini <pbonzini@redhat.com>
>>>>
>>>> This is the first compiler/linker test that has been moved to Meson.
>>>> Add more section headings to keep things clearer.
>>>>
>>>> [thuth: Add check for mpathpersist.found() before showing mpathpersist=
_new_api]
>>>>
>>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> Message-Id: <20200918103430.297167-3-thuth@redhat.com>
>>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> <snip>
>>>
>>> This is not the latest version of the series, can you drop patches 2
>>> and 3?
>>=20
>> Hmm so now I'm seeing failures in the bionic builds thanks to libmpath:
>
> Paolo's PR with the fix is still not merged yet (see "[PULL v7 00/87]
> Misc patches for 2020-09-24") ... but maybe you could pick the newer
> version of the libmpath patches from his PR into your queue?

I did pick it as an experiment - but it's still broken and I haven't had
a chance to dig into the failure yet.

>
>  Thomas


--=20
Alex Benn=C3=A9e

