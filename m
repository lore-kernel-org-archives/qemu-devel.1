Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BA6C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 18:31:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FC2220639
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 18:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oRkx67Fm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FC2220639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAHFL-0003w1-Hv
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 14:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kAHED-0003PK-9R
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 14:29:57 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535]:40251)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kAHEB-0007hX-Jr
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 14:29:56 -0400
Received: by mail-ed1-x535.google.com with SMTP id w2so8958564edv.7
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 11:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bDylpVgLSJFS/IwFnWT1io7sPQOZLXFSzCahEfZHhbQ=;
 b=oRkx67FmykpzwtOy+U/+pG3ALYGx6LTtz5coSfAmiVZQQfFnaPRbYgllobRt1umMj7
 CoVWdL20ZbQlPmaK8XmJm2MojcqVDpivGgweXUgRnfnlgrzPjRRhoSH/KFUp++tjvNEH
 eBdhNtFFQewzpJGOp8894snWR0vQTf8muXVsu2AGrYYqLszkKCZrztxuvRLG34mwQ3i5
 UBgYHskspzTnjQAFApkksNzROHkHGiWz0MqDJ2KE6iau4cNq7yZlgMcJU6uDbyZvjNxR
 oXJXZn0VJnefvmBefoW4eRiZutNa1aTer5sbTstVY54mp5sRMKTXz1QFEcbstyFGMgOL
 dppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bDylpVgLSJFS/IwFnWT1io7sPQOZLXFSzCahEfZHhbQ=;
 b=kEwqbtM4pOqQesg2oPcJqGHFltD1vnxBJWEC1z+3DGNTo+mdTzL24bUUQSEBAYZUAP
 wUecz1k8OqhxYyCwu5AuUW+vcmrVVHrXqIrO3BwGRPvqxR1D2/rv2hBCkIoPgi2Rlgnf
 pusrlYLl96ip1hGLtkgiISozYv0BEic1rh4ABDmjCGOSani/43ymeu5DT96/Wv7BKE6Y
 SuOGvGgwNbIKQmOYJ36wa5ZYcWhW07A/w6KAkgweJ7VQy3PhU2swyhidH48kvUiFCxap
 V8/U6hyipsMqjmHBhuzqZmd1yluY/MjR+CDt5VpaZDu9E9jmLfpQ3ecqyHqC0qfpKE5g
 xAKg==
X-Gm-Message-State: AOAM530kxz0si92y8qA02r29SLpQP6VIlvrCVfLg5/v5H1JC7SwMEbT8
 XYF0etmed2TPojP/AieKVAH197TDnf9fZ15lNX8=
X-Google-Smtp-Source: ABdhPJyYUxmH6W1KFtRYCXFXT04hBNVb5UPvbsGMGCI708tk2nyiJXRhtEZTuPwGMK7VyrmMwjaDzzlB991f7SwjkwU=
X-Received: by 2002:a50:e844:: with SMTP id k4mr6489060edn.237.1598293793989; 
 Mon, 24 Aug 2020 11:29:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA_0R9mQNFnyzdpR65YRHoDs0uPKWxmCOQUojbpAM-jP8A@mail.gmail.com>
In-Reply-To: <CAFEAcA_0R9mQNFnyzdpR65YRHoDs0uPKWxmCOQUojbpAM-jP8A@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 24 Aug 2020 22:29:41 +0400
Message-ID: <CAJ+F1CL1Hp-g8gNMpdGgk2d0KCzJfBde9f_mX8TLtewe3-B48g@mail.gmail.com>
Subject: Re: meson.build files are missing copyright/license headers
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000d6679605ada3c54d"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ed1-x535.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d6679605ada3c54d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Mon, Aug 24, 2020 at 1:44 PM Peter Maydell <peter.maydell@linaro.org>
wrote:

>  It looks like the new meson.build files are missing the usual
> copyright-and-license header comment. Could somebody add them,
> please?
>
> scripts/ninjatool.py does have a copyright line but is missing
> the license statement.
>
>
Afaik, most makefiles didn't have any, so it falls under the default GPL2+
LICENSE rule.

If it's a matter of prepending

# SPDX-License-Identifier: GPL-2.0-or-later

On each meson.build file, I can prepare a patch. If you expect something
different, it's time to tell.

thanks
--=20
Marc-Andr=C3=A9 Lureau

--000000000000d6679605ada3c54d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi<br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Mon, Aug 24, 2020 at 1:44 PM Peter Maydell=
 &lt;<a href=3D"mailto:peter.maydell@linaro.org" target=3D"_blank">peter.ma=
ydell@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">=C2=A0It looks like the new meson.build files are missing t=
he usual<br>
copyright-and-license header comment. Could somebody add them,<br>
please?<br>
<br>
scripts/ninjatool.py does have a copyright line but is missing<br>
the license statement.<br>
<br></blockquote><div><br></div><div>Afaik, most makefiles didn&#39;t have =
any, so it falls under the default GPL2+ LICENSE rule.</div><div><br></div>=
<div>If it&#39;s a matter of prepending</div><div><br></div><div># SPDX-Lic=
ense-Identifier: GPL-2.0-or-later</div><div><br></div><div>On each meson.bu=
ild file, I can prepare a patch. If you expect something different, it&#39;=
s time to tell.<br></div><br></div><div class=3D"gmail_quote">thanks<br></d=
iv>-- <br><div dir=3D"ltr">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000d6679605ada3c54d--

