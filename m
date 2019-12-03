Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6965C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 17:50:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B9CB2080F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 17:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sWq0YalM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B9CB2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icCJG-00076L-KZ
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 12:50:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60842)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1icBWC-0005pM-Tv
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 11:59:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1icBVb-0000S7-5A
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 11:58:45 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37294)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1icBVa-0008Mw-RH
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 11:58:43 -0500
Received: by mail-wr1-x443.google.com with SMTP id w15so4598992wru.4
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 08:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=fgwrBoEgFCj6X+c+Lv4zS+gVY0feypXSrxEfcql/KZw=;
 b=sWq0YalMGt8EFxctHNLewUEYPURigce6Vw9H+sjPH7K0tb7eo1/wACEoZdNjUy4aI8
 DRnsa6dUngdGCaJa+0x+dI4Sk+k+dJ5XVb/thAYS3YfYOilqUzWqXn6hlWPkJvLJ7R62
 RdaGTqZ9L779zhP7nvQnAPNTkMsTcTn72VjdKfwwQJanZSuRoCxZoU6ZvW/UDpvremF1
 IrArHp28PMaAeK3egTQ0Pn8MOm8p3a/jMraDhODuzHi4zkxqtXahhTI99D3Ri2OQOnpD
 EvWjqlvNTFU2WPfQtVpTPayk9wF2xIUuhYNBWGc1Hw/KYsCOPYzASwDC5U4gsmNQiK7H
 wkeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=fgwrBoEgFCj6X+c+Lv4zS+gVY0feypXSrxEfcql/KZw=;
 b=V3clkRZjf1TaqtgGWzlLBb+4Seh+3uhAHAM1x3P84gbwbV/dopGBFGhns5juIULmf7
 a+n8IIhg5lxXWneoIFFuhqcG06YMJli29JcjkTl1aW9/7tFHQZuSBMUSyncOvwiKmZrw
 hgHyORba4IBRlNCIdR2e8J8O52QP8ns6AuHiuJOlplFqWfRThYgtYkAZPpZfJBavpiD2
 yRrdefI/yehNmpK6xROz1638vhHhsCRgrfz9PofurtzUOafoWxd8qT9J6JkVVNaGUPTc
 L1DKdOkqzEHHUNtPA88U3UvSy9KZ5TyNGIsrkYMNmFPb9kFoU31sHMIP0KHXc+On0WkG
 lbOQ==
X-Gm-Message-State: APjAAAWgOdUhjfr1P6ZhslHBmfyMShPEBItEV6TjFQzRJeFguShnThl9
 kkArtgafgymlNTb1WocQWAfDHw==
X-Google-Smtp-Source: APXvYqygcg65/fAJdAjuumDcrOkzejN7Tju1f5KWBZnFFGWW571cYFVaKlEPvfBAsAtZFQaFrC74OQ==
X-Received: by 2002:a5d:6089:: with SMTP id w9mr6272728wrt.228.1575392313398; 
 Tue, 03 Dec 2019 08:58:33 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t81sm3805569wmg.6.2019.12.03.08.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2019 08:58:32 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 870761FF87;
 Tue,  3 Dec 2019 16:58:31 +0000 (GMT)
References: <20191115180829.10275-1-wainersm@redhat.com>
 <20191115180829.10275-4-wainersm@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: Re: [PATCH 3/4] python/qemu: accel: Strengthen kvm_available() checks
In-reply-to: <20191115180829.10275-4-wainersm@redhat.com>
Date: Tue, 03 Dec 2019 16:58:31 +0000
Message-ID: <87r21l9wi0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: fam@euphon.net, ehabkost@redhat.com, jsnow@redhat.com,
 qemu-devel@nongnu.org, crosa@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Wainer dos Santos Moschetta <wainersm@redhat.com> writes:

> Currently kvm_available() checks for the presence of kvm module
> and, if target and host arches don't mismatch. This patch adds
> an 3rd checking: if QEMU binary was compiled with kvm
> support.
>
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  python/qemu/accel.py | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/python/qemu/accel.py b/python/qemu/accel.py
> index a63ff980a9..1978fbee4e 100644
> --- a/python/qemu/accel.py
> +++ b/python/qemu/accel.py
> @@ -48,9 +48,24 @@ def list_accel(qemu_bin):
>      # Skip the first line which is the header.
>      return [l.strip() for l in lines[1:] if l]
>=20=20
> -def kvm_available(target_arch=3DNone):
> -    host_arch =3D os.uname()[4]
> -    if target_arch and target_arch !=3D host_arch:
> -        if target_arch !=3D ADDITIONAL_ARCHES.get(host_arch):
> -            return False
> -    return os.access("/dev/kvm", os.R_OK | os.W_OK)
> +def kvm_available(target_arch=3DNone, qemu_bin=3DNone):
> +    """
> +    Check if KVM is available using the following heuristic:
> +      - Kernel module is present in the host;
> +      - Target and host arches don't mismatch;
> +      - KVM is enabled in the QEMU binary.
> +
> +    @param target_arch (str): target architecture
> +    @param qemu_bin (str): path to the QEMU binary
> +    @return True if kvm is available, otherwise False.
> +    """
> +    if not os.access("/dev/kvm", os.R_OK | os.W_OK):
> +        return False
> +    if target_arch:
> +        host_arch =3D os.uname()[4]
> +        if target_arch !=3D host_arch:
> +            if target_arch !=3D ADDITIONAL_ARCHES.get(host_arch):
> +                return False
> +    if qemu_bin and "kvm" not in list_accel(qemu_bin):
> +        return False
> +    return True


--=20
Alex Benn=C3=A9e

