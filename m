Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050C1C43468
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 16:32:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 619A4235F9
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 16:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vIqM2w7N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 619A4235F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKOjT-0004xL-31
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 12:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kKOgO-0003rs-Lj
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 12:28:52 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:33425)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kKOgM-0007IH-4C
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 12:28:52 -0400
Received: by mail-ej1-x643.google.com with SMTP id j11so18685074ejk.0
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 09:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vB5P+vbBf2tpLX35MjeiE5Z9As8fXD0i7w1HciKVTWo=;
 b=vIqM2w7N76lXF/Ra15AKrQ+RR3i8WnB2QTvmykgwpbLJyLdoG3vQeIkaIuiGeggYxM
 sb4EaaiwECUTzIGi2g/3M6aU00YK/kj+QNrmmBlgykZHF1Np+v+IMfv+olrDJBNfPPhu
 GXdkxHWLjodtpaMSV5RiCLlUgcJ86/FLUOGdNKSOU3S60KKoeivJ9kLcLIkwOJQM0tXH
 jwLnZj1I4YKGh7hIxw70rpVC5AjyDs4RXjonIXOShxurss8g1oDdGTaH+4Xy9iiUCYbZ
 lg0rcNDNWor3UvMM+Be7gNiXnO5jbBtQ3leBset20eetFq8L97Ty7YQ+l1Yo0+KEBtxx
 OzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vB5P+vbBf2tpLX35MjeiE5Z9As8fXD0i7w1HciKVTWo=;
 b=D+Plk22uh+//HU15yuWCFnsnQ/g3bJtAWzSWKuLT4Mk71s3WqOuD0XMAt/Xhg6LiTu
 Uh0dQ4BJMF+DcmVwuTmVVIJGZtSrEjL4ZbKqKyM5QnQ7kZq1b4wyXtoa7Kkyolq7hn/J
 N90gSC1JWJbnNHLV1qRWt8p1P4L4GZHAtewykx2cZtY/GrKogKkf+cElQ6uGCPCgGp+9
 du7CPQu4e43MOxo41gbY8yzzONE4VG3BAKKFTrwO7xAsDn9yjnMsnhUNwEJxX810MT14
 j+tK5ZZjq7oZASRCCygccYZjCbjR6ZQCAZNtt9KEFkmGhDs3m6tjtoo9orLjWx50DaOX
 Ju4Q==
X-Gm-Message-State: AOAM533g6RHUl42pNncnZ1PyDmaaufJ2nieK6NnZiPyvcd+kFtvM+tXu
 lLixTgBVvtH/Ub0RNX1AMe+YeoVhcPy6xuBSKlH0KQ==
X-Google-Smtp-Source: ABdhPJyQBx0QkSYeYxkuFfdhKSoBS34JCWqWPGEXZfaZNM0Sgjoj/ZUv9pNai9RyDWxFP1ScYJ88x0U0R5Qpg9X4OjY=
X-Received: by 2002:a17:906:d936:: with SMTP id
 rn22mr303378ejb.4.1600705728492; 
 Mon, 21 Sep 2020 09:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200914084802.4185028-1-armbru@redhat.com>
 <CAFEAcA9qPx=rtNcQ5FJk8a3YjZN7XyD1cJddQbD7Km9fBpm-0A@mail.gmail.com>
 <875z8718j8.fsf@dusky.pond.sub.org>
In-Reply-To: <875z8718j8.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Sep 2020 17:28:37 +0100
Message-ID: <CAFEAcA-XJB2D2KJaPe5PGhprm6n5rLw+QU+E2SFXASK0mmYoyw@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] Configurable policy for handling deprecated
 interfaces
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x643.google.com
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
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, Libvirt <libvir-list@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
 libguestfs@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 21 Sep 2020 at 15:58, Markus Armbruster <armbru@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
> > If this only covers QMP, should we make the argument to -compat
> > have a name that expresses that? eg deprecated-qmp-input,
> > deprecated-qmp-output ?
>
> It's only implemented for QMP so far.  But we really want it for all
> external interfaces for use by machines.  Today, that's QMP and CLI.
>
> Naming the parameters deprecated-qmp-{input,output} leads to separate
> settings for QMP and CLI.

I think that's a good thing. I might have fixed up my handling
of QMP to avoid deprecated behaviours but not yet got round to
doing that for my command line option choices (or vice-versa).

> > Also, it seems a bit repetitive to say 'deprecated' here all
> > the time -- do you have a future use of -compat in mind which
> > would be to adjust something that is *not* deprecated ? If
> > not, maybe the 'deprecated' part should be in the option name
> > rather than in every argument, eg
> >
> >   -deprecation-compat qmp-input=crash,qmp-output=hide,cli-option=reject
> >
> > ?
>
> My cover letter hints at such future uses: "We may want to extend it to
> cover [...] experimental features."

Ah, I read "-compat covers only deprecated syntactic aspects of QMP.  We
may want to extend it to cover semantic aspects, CLI, and experimental
features." as implying "deprecated semantic aspects, deprecated CLI,
and deprecated experimental features"...

thanks
-- PMM

