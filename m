Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5D9C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 12:01:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B268820820
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 12:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q5a5Pyva"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B268820820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY77g-0001Ch-SG
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 08:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jY76p-0000du-Q9
 for qemu-devel@nongnu.org; Mon, 11 May 2020 08:00:35 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:42760)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jY76o-0005oY-Dk
 for qemu-devel@nongnu.org; Mon, 11 May 2020 08:00:35 -0400
Received: by mail-lf1-x141.google.com with SMTP id r17so4203601lff.9
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 05:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=IFvDz2vJ0mARWzTy7OXrniOvsWFLdzSAnR9e4LU4CWA=;
 b=q5a5PyvaDToMi3RmBoGfUn4sVkm7IalmqCZvTwh75TXhqgjPSWgWs9Af8jsgEM02U1
 2T6rFvS5R54OQdzqjF4q5RPg8MNTeSL5TNknBbhA5yrLGzxt+NqnVrIFESKjxcIlnI7Z
 2DBos6QwNY/Kfi//RiPoJuDbLkLRk+3BvZQ24H0Xse/A55fz+8kxoMDHdWgcDedwgmZl
 WQoemxVNNI5huFVIAVwqw6+2b41BN7wUDUVWAmwfg1HHUz0Fy0ptvG4giSprIel2NOEj
 NsDTlLfu6/QcvLwkXnrBuUhQUJxldXaFen2V5w3minJJ9YoNH9ZSKBrrTPQhDiScJlQt
 qJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=IFvDz2vJ0mARWzTy7OXrniOvsWFLdzSAnR9e4LU4CWA=;
 b=NeDmRTWB3pdY7qcHSlxr5AU/D6Jn5Qe7drsv9YsQJFi5EF1+l2LYMbp3SWZ4CnXeAy
 QMLy+bXb+AcoyAKN3Q+r2humYnbDcSfn7bPuUGu/f/Su9tbzfWgV/TFFsV7ZDU3smcMe
 S/TuLWnfXrBJTka/v4EAjGhoE0DZS5wGj9O2l/CodKi14jBV6FegbPHBF9r96KzDjRBa
 6oklShDkGigfWJoE1H7SlObgFnnvhbusWdU729f0vcmjcilmcLbNULl7kyOHTRaY8oLV
 YFXTaXtVrFFwOhYimAIkwvrVi4k98J1n6+UTwNwop+5UHOUZwal6fGc7nlsYDQ27qGii
 8MHQ==
X-Gm-Message-State: AOAM532ILOMZmfDqrdUrNSXiDmiPca1ESKMfabV9/a0nuhXNJwnmkdj0
 EXMBVLT2bAYTJuDX1LxcsENkFdl5DtCEvZ2+k1fdSw==
X-Google-Smtp-Source: ABdhPJwlzaYUrCHX/OO+TdNlZkIjAq8SMEvenwtFkekz8RPuZ+CIIqZG7sGypfumi3PuUz86H5DxOc6hHgPigs4zfhY=
X-Received: by 2002:a19:f804:: with SMTP id a4mr10400004lff.4.1589198431484;
 Mon, 11 May 2020 05:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200312142728.12285-1-robert.foley@linaro.org>
 <20200312142728.12285-5-robert.foley@linaro.org> <87mu6erg0t.fsf@linaro.org>
In-Reply-To: <87mu6erg0t.fsf@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Mon, 11 May 2020 08:00:24 -0400
Message-ID: <CAEyhzFtgyVb1Qj7s+inOrhvHiM54m5U9ka05pgW5VeSQkZ77QQ@mail.gmail.com>
Subject: Re: [PATCH v4 04/10] tests/vm: add --boot-console switch
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=robert.foley@linaro.org; helo=mail-lf1-x141.google.com
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
Cc: Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 11 May 2020 at 05:13, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Robert Foley <robert.foley@linaro.org> writes:
>
> > Added ability to view console during boot via
> > --boot-console switch to basevm.py.  This helps debug issues that occur
> > during the boot sequence.
> > Also added a new special variable to vm-build:
> > BOOT_CONSOLE=3D1 will cause this new --boot-console switch to be set.
>
> Hmm why isn't this output covered by DEBUG=3D1? I'm wary of adding anothe=
r
> debug knob rather than just including the extra information under our
> existing DEBUG output.

This is a good point.  I will add this support under DEBUG=3D1.

Thanks,
-Rob

