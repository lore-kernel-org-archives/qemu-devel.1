Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD80BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 08:22:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7219E2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 08:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UD//r3+9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7219E2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbgT3-0002DV-Lh
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 04:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jbgSS-0001bF-9H
 for qemu-devel@nongnu.org; Thu, 21 May 2020 04:21:40 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:45466)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jbgSR-0004cb-6u
 for qemu-devel@nongnu.org; Thu, 21 May 2020 04:21:39 -0400
Received: by mail-ej1-x641.google.com with SMTP id yc10so7717408ejb.12
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 01:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=OMw43quhwDvr8YM34+2OA0PExH0CGujLiL9X+yF0Djg=;
 b=UD//r3+9uGv57NR0jSEMcPUq08OVJE05M9h8gaaJXRJCjVU95pj8nijc9UDYb53BmM
 SDP9J4MYZHdsBybWszdpq2uncfYYhM9fUjf+GH5vT3SYSXgRUFvSZIR/4PoK2Jhw7RcY
 +aC1OxB8KpfpNBBq6E1fsbZYlIiewp1olU/6/+serJ4qiFXcyiSkCOPqO8wULpnuLhMU
 Y+P8zS2FsMtbuLCUeOwufdR+vBy48PG5/JlBexNA7UXS51+fTnIcdwc5u8c9jSUd95Ah
 OPfRpOxK+R/itz/SWxj1SrTo4QRFhimemE2jYnxdLMIl8qdeXPS/NYxEfk2T2pV+8Ois
 Sr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=OMw43quhwDvr8YM34+2OA0PExH0CGujLiL9X+yF0Djg=;
 b=AfZoBuvlNUbHcfWwAT+g18UBQjAdCJw2jF9ECHt6J5Y9gtC9QbK83KHEhuunThyQWS
 UOv7SyGtZpZEW2spObtJa41cq3b8/PN+ufHlgKudQHVnMJHXegA5HtVwsNkq9alVB0T3
 k0tIWiKtzFb/h2m+TUZAkfhD+pJU6WdA6iPQGiFKfRdaaYk+qIZQeJoSDpctPir6DGus
 I1d1vN3G9QUlDTgwbcRWiBWTv6M/22aW+/YHIPgXzx088QD5s0MVWMv0hIpKtl+mBpqM
 Bo1HHs1kRXuOs7JZG6awPXFLzsu9uWsaXGJEqkVqeV+eXwnzDl+nMs+DDL76Hq728pLE
 2kxg==
X-Gm-Message-State: AOAM532pVdl5CyIBbGyrDB4BvaaUVIrqt6LEwrYIkOGiJS710eFelLyU
 UoFU5EXpOifijBteXl/ci2bt4w==
X-Google-Smtp-Source: ABdhPJx3m/yMalOrKnqsnMwUQaXFogH6WO/VrJ4FahWE/REyGkf1b8JgH1jMDEbS/UDImu/XmCf/rQ==
X-Received: by 2002:a17:906:195a:: with SMTP id
 b26mr2425887eje.534.1590049297352; 
 Thu, 21 May 2020 01:21:37 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id cm26sm3971934edb.87.2020.05.21.01.21.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 01:21:35 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C74411FF7E;
 Thu, 21 May 2020 09:21:34 +0100 (BST)
References: <20200513175134.19619-1-alex.bennee@linaro.org>
 <20200513175134.19619-5-alex.bennee@linaro.org>
 <958a1d7e-305d-96f5-2e0c-f8a2dd53e1c0@redhat.com>
User-agent: mu4e 1.4.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v1 04/10] linux-user: completely re-write init_guest_space
In-reply-to: <958a1d7e-305d-96f5-2e0c-f8a2dd53e1c0@redhat.com>
Date: Thu, 21 May 2020 09:21:34 +0100
Message-ID: <87eerdg0kx.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x641.google.com
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
Cc: Cornelia Huck <cohuck@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> On 13/05/2020 19.51, Alex Benn=C3=A9e wrote:
>> First we ensure all guest space initialisation logic comes through
>> probe_guest_base once we understand the nature of the binary we are
>> loading. The convoluted init_guest_space routine is removed and
>> replaced with a number of pgb_* helpers which are called depending on
>> what requirements we have when loading the binary.
>>=20
>> We first try to do what is requested by the host. Failing that we try
>> and satisfy the guest requested base address. If all those options
>> fail we fall back to finding a space in the memory map using our
>> recently written read_self_maps() helper.
>>=20
>> There are some additional complications we try and take into account
>> when looking for holes in the address space. We try not to go directly
>> after the system brk() space so there is space for a little growth. We
>> also don't want to have to use negative offsets which would result in
>> slightly less efficient code on x86 when it's unable to use the
>> segment offset register.
>>=20
>> Less mind-binding gotos and hopefully clearer logic throughout.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Acked-by: Laurent Vivier <laurent@vivier.eu>
<snip>
>> +    } else {
>> +        if ((guest_hiaddr - guest_base) > ~(uintptr_t)0) {
>> +            error_report("%s: requires more virtual address space "
>> +                         "than the host can provide (0x%" PRIx64 ")",
>> +                         image_name, (uint64_t)guest_hiaddr - guest_bas=
e);
>> +            exit(EXIT_FAILURE);
>>          }
>
>  Hi Alex,
>
> this causes an error with newer versions of Clang:
>
> linux-user/elfload.c:2076:41: error: result of comparison 'unsigned
> long' > 18446744073709551615 is always false
> [-Werror,-Wtautological-type-limit-compare]
> 4685         if ((guest_hiaddr - guest_base) > ~(uintptr_t)0) {
> 4686             ~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~
> 4687 1 error generated.
>
> Any ideas how to fix this?

I guess this check only makes sense when abi_ulong > uintptr_t or IOW 64
bit guests running on 32 bit hosts. We could just wrap that check in:

#if HOST_LONG_BITS =3D=3D 32

#endif

>
>  Thomas


--=20
Alex Benn=C3=A9e

