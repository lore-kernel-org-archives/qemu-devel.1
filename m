Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B887C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 10:29:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7C2720795
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 10:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lvON8LSL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7C2720795
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVBNC-0003Sz-Cp
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 06:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kVBMX-0002nU-T8
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 06:28:57 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:40034)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kVBMW-0006G3-3F
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 06:28:57 -0400
Received: by mail-ed1-x544.google.com with SMTP id p13so2035232edi.7
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 03:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=GmGPm80VdT0j5JTW7R5DnrwtZRK+dlil9/eIFkBb5zQ=;
 b=lvON8LSLLacsiQvkD02mZEgSbnTM+MtTaNPKKyyI/NKiog02duoTSKCf+1dl8w3q8a
 6vsNL24H6iYt9za3tujs97MfhFt1hyS/T9gLGpdEH/+dnv7XH2655RqQm4AuECGnGHe9
 foyZ0KXoR+4W/+tyYp7ijMq6/yU9rW0ZPE841eXFFRgAOvRobMreI52p3iDyDuE9vzWM
 0Jsk3gv498MKDOlkb/UWzv+vkx/0DJfREAIaMabihIkgD+7J+b526cssd1zmt7+FDcV9
 SDWduIsaHgUQP8X2p1J/3Q3QQCmn+mJfH9BaWC7/bkw8ovxFzIfiwUQ95vWMfo7yLrwl
 fQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=GmGPm80VdT0j5JTW7R5DnrwtZRK+dlil9/eIFkBb5zQ=;
 b=YEszLmURRG52JBHjS4dzxIjP2+RH++Vb8G+JXFOo9tttwnZgSq6yBpgNWrwHc/FsKA
 cEjWsoLToi+M567WGVJaQYMIL+amjwf+lDwWuoxCf32A1jGGzbR5x/BdTdkuKyxBm7Kv
 8ceMx5FxS03rBBGuChih91ecQef5ewGrb/PWuFBuZysydMVfR/uf2VZS8hZaKChksBJM
 P+veg40V45faqQESxYBQnGiQ8xRxWnWgLb34QOe0H38NJIs3ioKA3vbCUcV/25rz8USk
 ShJQLhTJOgPny6BLsEIaPI53giXTNvSCmy/IcF+75o9yNemKBGWsS3uOSpf7M+oDHPng
 mSVg==
X-Gm-Message-State: AOAM53245WsWfmi3Y+C4HiOTzjYjV/BbvLtkgaSKJaVaeL8dt/AwLOX1
 193ZH2GKDSwadQztbYgSBAQIWYYtJQ7SxCynEtN8XA==
X-Google-Smtp-Source: ABdhPJz7mR9EZUCMqAXu6SeVYX+rqXiYcNFEaQuvTDJdJwLuATJex7tjfr6HIMQpw5+hcRRBMXMhGoVFzmhxuMnomYA=
X-Received: by 2002:a50:9ea6:: with SMTP id a35mr2480545edf.52.1603276133988; 
 Wed, 21 Oct 2020 03:28:53 -0700 (PDT)
MIME-Version: 1.0
References: <20201020140050.1623109-1-ppandit@redhat.com>
 <CAFEAcA_Bg12kvGAjg127_XpfeJdj9er-e2VEF9YnkNyVUDQ9OQ@mail.gmail.com>
 <7e971323-0b9a-2c32-2e09-705249f3f2de@redhat.com>
In-Reply-To: <7e971323-0b9a-2c32-2e09-705249f3f2de@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 21 Oct 2020 11:28:42 +0100
Message-ID: <CAFEAcA_yHu88Wf7YgP9gpZ-kQXcSHRV82FX0bE5ScXfMU+7U_g@mail.gmail.com>
Subject: Re: [PATCH v2] net: remove an assert call in eth_get_gso_type
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x544.google.com
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>, Jason Wang <jasowang@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 P J P <ppandit@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Gaoning Pan <pgn@zju.edu.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 21 Oct 2020 at 07:29, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
> During the last 2 years I've been sending patches touching
> various QEMU areas, but I never used qemu_log(). I always
> used:
> - qemu_log_mask(LOG_GUEST_ERROR/LOG_UNIMP, ...
> - error_report/warn_report from "qemu/error-report.h"
> - error_setg* from "qapi/error.h"
> - trace events
>
> $ git grep qemu_log\( | wc -l
> 661
>
> This function seems used mostly by very old code.
>
> It is declared in "qemu/log-for-trace.h" which looks like
> an internal API.
>
> Should we add a checkpatch rule to refuse new uses of qemu_log()?

The major use for qemu_log() is when you're constructing
a multi-line log message or a log message which needs to
do some expensive calculations to work out what it is going
to print. In that case the pattern is:

    if (qemu_loglevel_mask(LOG_WHATEVER)) {
        int x =3D do_my_expensive_calculations();
        qemu_log("line one: foo: 0x%x\n", x);
        for (some loop over a list) {
           qemu_log("and another line per list item\n");
        }
    }

For really complicated logging you might abstract out
the middle bit into functions which call qemu_log()
directly and which are only called inside a check that
some particular log level is enabled.

The uses in tcg/tcg.c are examples of this pattern.

The thing to avoid is a plain qemu_log() call which is
not already guarded by some check on the log-level mask.
You're right that the really common case is fine with
just qemu_log_mask(), but sometimes you need to be
able to split up the "is log level X enabled" and
"log" parts of the task.

thanks
-- PMM

