Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91454C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 11:28:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AD0F20734
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 11:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZznGED4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AD0F20734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiytk-000837-Lg
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 07:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jiysu-0007Uh-LR; Wed, 10 Jun 2020 07:27:08 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33288)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jiyst-0004i2-MX; Wed, 10 Jun 2020 07:27:08 -0400
Received: by mail-wm1-x344.google.com with SMTP id j198so4431185wmj.0;
 Wed, 10 Jun 2020 04:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=4cz8Yz9EBltYxVtzbxMsJ+h47Bfpbc9WgipIpZnUMhw=;
 b=hZznGED4wt4hg2zwqby+yPeS6TsdH77MCKruRw9toswMWacI24FMFcFxo70eqN1D35
 gqsTEzURk/1dVWLYMe1RS5JJJRxN2g6QbX4yeYrc5uEEJltOGVh/3PrKyhrYadWBUmWg
 kmFiUGVDV98nXPokGakEAZgGkyk/jSrGoWig5cHbHpb/yYpnE8U+f72jCSRkHf22WgsZ
 4N07iqT/gZJpDPUqLOrUJPUvMrGzAqT54GXTR9sUYocGIxnH3aTM9i/5DRWsjb1M4Tmg
 hnaNgA2V9iy5qI6QeUX7IU6mkB91iSKbZUQlrwRzXedcoPDgiaawewNhFrat56ThGdgU
 ETJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=4cz8Yz9EBltYxVtzbxMsJ+h47Bfpbc9WgipIpZnUMhw=;
 b=nkEENTOwrNNUT9MUWIsRfUuBLdyEPYdQBtAjaLMvSd3qaAVP9hfedKpNnMeaVZm6a4
 RHMnfkt303B+sIuXrpGn1ze6WF9LnKygu/8pmqYzgHv4k9wa+mvlKwh3Kw5reNhQvy+m
 m1pzcQ6JPqPVWcs60ZiHcfTPmgyf5rVuDlvFzjwknr/iWkx15czIMaocxgJy2WcOf4lW
 1ztQP34Or2HmXMf44gY9QZLUCIMs7r46K8nPRPM84zeNf3nwDQQniqO0s1u9lBpwhq99
 tzjL6sB0HZO0zOe1eObSCcqsG4lBj2VHpmfNa3iP/b6U2Sk+sl9CGChZiac7O2VzNaJG
 0pxw==
X-Gm-Message-State: AOAM530mtuDVFMg/zKt3qT2py9E9v/4ygup4EqnGjhR6wOJWs+YUgtTu
 lyTmfK6RX949jjcAoRz/nUYrZuuve8OJpfXKe20=
X-Google-Smtp-Source: ABdhPJwcRIohPtTJVLuamcH4XP9B8Xmyj/DhquE6/+aCQlveByzbrjMIoiUs056FGMpJU+6VgSTsyFyNNVPSKwUU3WY=
X-Received: by 2002:a05:600c:22c1:: with SMTP id
 1mr2903112wmg.50.1591788425918; 
 Wed, 10 Jun 2020 04:27:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200608090142.6793-1-f4bug@amsat.org>
 <20200608090142.6793-2-f4bug@amsat.org>
 <CAHiYmc5UUaSKB6Ee0ds_hj0FBTzt0iLxzNWySt0mcZ9dvtZNyA@mail.gmail.com>
 <5712d31d-93b1-4254-893a-93c2fc7e6502@redhat.com>
In-Reply-To: <5712d31d-93b1-4254-893a-93c2fc7e6502@redhat.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Wed, 10 Jun 2020 13:26:53 +0200
Message-ID: <CAHiYmc4163d=w3CeNSBoLyZy3qKBiOM4zDihxCVc5MSLSUCnow@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] MAINTAINERS: Mark SH4 hardware orphan
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D1=81=D1=80=D0=B5, 10. =D1=98=D1=83=D0=BD 2020. =D1=83 13:17 Thomas Huth <=
thuth@redhat.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=
=D0=BB=D0=B0:
>
> On 10/06/2020 13.08, Aleksandar Markovic wrote:
> > =D0=BF=D0=BE=D0=BD, 8. =D1=98=D1=83=D0=BD 2020. =D1=83 11:05 Philippe M=
athieu-Daud=C3=A9 <f4bug@amsat.org> =D1=98=D0=B5
> > =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >>
> >> Aurelien Jarno expressed his desire to orphan the SH4 hardware [*]:
> >>
> >>   I don't mind being [...] removed from there.
> >>   I do not really have time to work on that.
> >>
> >> Mark the SH4 emulated hardware orphan.
> >>
> >> Many thanks to Aurelien for his substantial contributions to QEMU,
> >> and for maintaining the SH4 hardware for various years!
> >>
> >> [*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg708400.html
> >>
> >> Message-Id: <20200601214125.GA1924990@aurel32.net>
> >> Acked-by: Aurelien Jarno <aurelien@aurel32.net>
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >> ---
> >
> > The basic idea of the patch (as read from the title and the commit
> > message) is good and positive.
> >
> > The problem is that the patch does something different than the commit
> > message says - pretending that it just orphans something. Which is not
> > good. Actually, very clumsy and bad.
>
> Aleksandar, could you please stop being so negative? If you've got
> issues with a patch, that's fair, but you can then also simply express
> your opinion in a professional and constructive way. Calling the work of
> someone else "clumsy" is really not something that I want to read on the
> qemu-devel mailing list.
>

Ok, than delete mentally that word, and focus on the substance.

>  Thanks,
>   Thomas
>

