Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBE3C4742C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 23:51:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B10E3206A1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 23:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Njglza2J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B10E3206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kap2d-0000wA-JB
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 18:51:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kap1l-0000VQ-Cx
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 18:50:49 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b]:33307)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kap1j-0006N7-Mg
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 18:50:49 -0500
Received: by mail-ed1-x52b.google.com with SMTP id v4so3424967edi.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 15:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=cOB0e/40E6PoIaQbb5Bd5TbOYgiNXc0Lru8syMdSSI4=;
 b=Njglza2Jwut3YCxiX8j/xnbCXk94PeWGpIBAiNQm6cfPdMlcsXXpb2GNvDkTyF/gMq
 tkjBdmuIixgBeMtqDmpeANSUMn1V8bjdYh6pC47vLt3uDjL35iAsyswUhHIt1s455xzr
 PR+6vJCkTUvhB1uQV8icbnaDpeqNPa55VOBOk0UigevSks6qCu9XlsVKaxajmPHuL9ON
 5ML6aq4Vhue4aI7iXkpbfHRcTlp3+b9ueiIAQjkqSfmuR4zKV/M7FFCs/Gc0uhLQAUqv
 t6YyQz5XqpC9FvUek6FEI9UBwWSsRxrsRMrOyYNwMijbNN9EW4xlWmYKES4qAw4lVp8W
 OEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=cOB0e/40E6PoIaQbb5Bd5TbOYgiNXc0Lru8syMdSSI4=;
 b=bkQPDXM6ttLUrTTR1ELlUdtBQYSPkLtJ1/K2ZemLRGTfVnq+oAfMrHi7XlN8FBInIL
 0Mito2IdgnomZIhhkVKoXeI89c7KXQ1lptlyekO1ZX3l6a4vSeYKr4dwmBqWIWRPTAZO
 mcKdcCIIb0xYSm4FtetreaACDVZUnMuPXUHWrwdYZPQf//cn1FO2e8zPsXSEgFVPtkmn
 tBV2j+afhBa0v1On+/2y/x0EJkKhI3L/NQoZzTyyhdF+/buy2G5LhaWObF/P5C3tyIyq
 QzlHYcQqcR1nJnt9jf1usFr0H3mbtQOhO///yGEbgeGP1gGO+jl2n2kBsWzz1Mspuqjj
 YGpw==
X-Gm-Message-State: AOAM5327SrJ8qM9AGbP/hJ9PSAoEncVLAOm8fXBWinzaHN02i77SPd8U
 QtibEBsl6t6nWGggz99ZiXyeWDGpEOFXmqU7SkOYGQ==
X-Google-Smtp-Source: ABdhPJxQssuWLqAIJPSuzWAb7UMlS6iGmUf5XKvCf4Zf11liPzRcZJsNKo0xxSe1kD3MvMV3sg85yaHxDXK+zPXydYg=
X-Received: by 2002:aa7:df82:: with SMTP id b2mr5105509edy.251.1604620246095; 
 Thu, 05 Nov 2020 15:50:46 -0800 (PST)
MIME-Version: 1.0
References: <20201103024343.894221-1-michael.roth@amd.com>
 <20201103024343.894221-7-michael.roth@amd.com>
In-Reply-To: <20201103024343.894221-7-michael.roth@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Nov 2020 23:50:35 +0000
Message-ID: <CAFEAcA8U=B1gg-mqFOPtLdbu3KdbgSkrirRAvCrmX4LRdXejZw@mail.gmail.com>
Subject: Re: [PULL v3 06/12] qga: add implementation of guest-get-disks for
 Linux
To: Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Nov 2020 at 02:45, Michael Roth <michael.roth@amd.com> wrote:
>
> From: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
>
> The command lists all disks (real and virtual) as well as disk
> partitions. For each disk the list of dependent disks is also listed and
> /dev path is used as a handle so it can be matched with "name" field of
> other returned disk entries. For disk partitions the "dependents" list
> is populated with the the parent device for easier tracking of
> hierarchy.

Hi; Coverity points out a resource leak in this function
(CID 1436130):


> +GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
> +{
> +    GuestDiskInfoList *item, *ret =3D NULL;
> +    GuestDiskInfo *disk;
> +    DIR *dp =3D NULL;
> +    struct dirent *de =3D NULL;
> +
> +    g_debug("listing /sys/block directory");
> +    dp =3D opendir("/sys/block");

Here we opendir()...

> +    if (dp =3D=3D NULL) {
> +        error_setg_errno(errp, errno, "Can't open directory \"/sys/block=
\"");
> +        return NULL;
> +    }
> +    while ((de =3D readdir(dp)) !=3D NULL) {
            [stuff]
> +    }
> +    return ret;

...but we forget to closedir() it again.

> +}

thanks
-- PMM

