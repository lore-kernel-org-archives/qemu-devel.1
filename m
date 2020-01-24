Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0DDC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 18:11:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 998422071A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 18:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sWPiSaLQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 998422071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv3Qq-0007FI-OS
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 13:11:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36448)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iv3Q4-0005wv-82
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 13:11:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iv3Q3-0008Fm-1t
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 13:11:00 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34427)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iv3Q2-0008D4-Pj
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 13:10:58 -0500
Received: by mail-wr1-x441.google.com with SMTP id t2so3110389wrr.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 10:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=J2YJMGDddkGlNZgbZfO+LPfPsL7DVmh3wByqFMcxuTQ=;
 b=sWPiSaLQH0tnAtza/bI5lc5w+EJjKnM/1GJFWwQ5HOCWMSTCIrslXzeWTX6eKVxr/O
 u7S/Zs3+Q57TfHxmYpFIrgg850GLJWcTexIV4eAKdvaahf+HM0AqxwnbHD5amhTif1w0
 ST6H4k2KZg/7TtyEeuA2odlpW4PKveu/T5yA/bjHBNR2F9QP4S/V5pphSTGEWMBikSFi
 r3C4YjK1W+yjDXS425wXD3RKeAtXCWgdj9EHUa6MPE8oIjpbnlgZ1WHWUGjw65agd/dP
 aURNtKRBDrF+oejDaSesBcKMqT1Lm7MMZ7nmv0NuRoTgpGrgXRqR6wjTRcUuf7rQs6Cb
 UsVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=J2YJMGDddkGlNZgbZfO+LPfPsL7DVmh3wByqFMcxuTQ=;
 b=nseQVlZ6G7psnQ8MC9mKIe/NjP3a9huHXxGPfOn73gKnUKkEuPlJjzvW9c7ZKFpSRF
 o+i4Bro7mC2yM6dOWu6/Hgp5wx1dza+Dk8SUFUt0+VZSuMJcdih7WFA0hovvnqWDp4uw
 NMOjgF3ilIcNZxZQbduFgnVNSQCuLAxUI0ud3JjtmMEji5CRlYI+NxxSFpzE/95F8/J4
 1h2L257r6cUclNcQLKJbkDRs8OL3uCItylY9JQe1Fr02/rq/Z35/JyfpdwCoQ7XfcVqe
 YOIzHI7xdXN3rWT46lwyqe5nwCSP9rNHMJqk0tpEW0s9pjBPlXY4NgJeuZrn53e1SNbJ
 3WtA==
X-Gm-Message-State: APjAAAUPAzWlEEkYN/P3jdqMBxBxQIGBsvXxIECuln2KEsvlV2+ooPMA
 M9sO2rjMWaX9VAOIK6LFYVQyPg==
X-Google-Smtp-Source: APXvYqyBp3nBzEc3AP5iY+yGb7kWJoPqHaNsrrokvAGNxlRWMeM4HXvGUpeK3KRWz+IZuM90PuvIDA==
X-Received: by 2002:a5d:4b88:: with SMTP id b8mr5631490wrt.343.1579889457092; 
 Fri, 24 Jan 2020 10:10:57 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r15sm7553523wmh.21.2020.01.24.10.10.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2020 10:10:56 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 108D71FF87;
 Fri, 24 Jan 2020 18:10:55 +0000 (GMT)
References: <20200124162606.8787-1-peter.maydell@linaro.org>
 <20200124162606.8787-3-peter.maydell@linaro.org>
User-agent: mu4e 1.3.7; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 2/8] hxtool: Support SRST/ERST directives
In-reply-to: <20200124162606.8787-3-peter.maydell@linaro.org>
Date: Fri, 24 Jan 2020 18:10:55 +0000
Message-ID: <878slwafo0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Greg Kurz <groug@kaod.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> We want to add support for including rST document fragments
> in our .hx files, in the same way we currently have texinfo
> fragments. These will be delimited by SRST and ERST directives,
> in the same way the texinfo is delimited by STEXI/ETEXI.
> The rST fragments will not be extracted by the hxtool
> script, but by a different mechanism, so all we need to
> do in hxtool is have it ignore all the text inside a
> SRST/ERST section, with suitable error-checking for
> mismatched rST-vs-texi fragment delimiters.
>
> The resulting effective state machine has only three states:
>  * flag =3D 0, rstflag =3D 0 : reading section for C output
>  * flag =3D 1, rstflag =3D 0 : reading texi fragment
>  * flag =3D 0, rstflag =3D 1 : reading rST fragment
> and flag =3D 1, rstflag =3D 1 is not possible. Using two
> variables makes the parallel between the rST handling and
> the texi handling clearer; in any case all this code will
> be deleted once we've converted entirely to rST.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

