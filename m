Return-Path: <SRS0=+z+v=72=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A30C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 16:30:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EE892078A
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 16:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lud70OFl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EE892078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jk92m-000755-I3
	for qemu-devel@archiver.kernel.org; Sat, 13 Jun 2020 12:30:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jk921-0006L9-RB; Sat, 13 Jun 2020 12:29:21 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:33661)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jk920-00072H-03; Sat, 13 Jun 2020 12:29:21 -0400
Received: by mail-ej1-x642.google.com with SMTP id n24so13139421ejd.0;
 Sat, 13 Jun 2020 09:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uatsu9mHhKIA6c1jG2JglrXLJNvoevvsx4EjKK88bwk=;
 b=Lud70OFlbpOekQ/1akd3CXKPJz0G5qaa6+lTl014vN0sY29e1Jl+KxqzIR6nAsV99j
 QE9Sd33TmnaShKIzarYqHWuI2UaTRZzaKcHseKb/2sKFmhn4ctYvVZOs97W+PPdj9sRh
 751jTrWNng0j3i/cPobbqKEE+W1+D+DNt3DCQ9t9i43QnCNuwJHSFC/lmzG7+9pueIzO
 9t8RE1RzQx/YdSM7QtFmCyTgnXUBQM13d84EsZqLGnbn/qukCebkHeSSGmvj4Zfr1SUD
 71S5dUvffqMtZgqMz9ioi40Q4i9FZOruW15Pa1e/sD7O17TSgK11YEYAZi3xfzhIN/gJ
 y8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uatsu9mHhKIA6c1jG2JglrXLJNvoevvsx4EjKK88bwk=;
 b=fEewMO5kdGhI7cAXM2zMnDK7EWWaTrMlKvccpI71MKrWFTdVp74KX2vRtPb/kvfsBZ
 dnopumEzBvVcAi1jujVvDobTLZINkUJfxkKiMXMq3nfpDdXOZXRodtu6na9L0VtlpVSr
 923oeN8CBTzqB8+xfzjGnNPfxq9INtStjoxdthwlVu2s/b29x6gR3L8uXJWX4qzYEPbL
 i3nEzY8R77V6Cqmbeuja/8QIz3tOlIoJo1Frr2SkW9dANECUdM5R6/O5IUX0K7TFFOG6
 3qxergfxlFCrMaYSfL5C3OjQ2kNjmmmHCI4C3l3ZxE1tGhYEet5wRS2v6Xihx4pFDkQh
 zT+A==
X-Gm-Message-State: AOAM530BjraqA23PmnF0TPImkmvDt1wv4sWPgwVBCA3DAZ+N5vw1SsnZ
 dZSoFjgEwkkDiJpNJX2OoPNovF5LCAeafepbLws=
X-Google-Smtp-Source: ABdhPJwV2lTazTeL2QN3zm0QY0DkgwcDT7DZSBX1j5XGsGa+0miKCrWJDajQ/YdPnYcg39R3yu6/jyexYhWs9ZnCpKU=
X-Received: by 2002:a17:906:e47:: with SMTP id
 q7mr18293279eji.279.1592065748002; 
 Sat, 13 Jun 2020 09:29:08 -0700 (PDT)
MIME-Version: 1.0
References: <20191008082815.8267-1-thuth@redhat.com>
 <CAL1e-=gYkhM99Ee0LxZJ5dCjeEdC08G4_Tm3WCZpCSWvJ=b26Q@mail.gmail.com>
 <4bfea125-eb63-f4a2-bca0-bce462f73d89@redhat.com>
 <CAFEAcA_+V7SNsxPSgsd04s8f7PnP3qdyXMp6NvS2inHjE08pJw@mail.gmail.com>
In-Reply-To: <CAFEAcA_+V7SNsxPSgsd04s8f7PnP3qdyXMp6NvS2inHjE08pJw@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 13 Jun 2020 18:28:55 +0200
Message-ID: <CAL1e-=ijjbTG19NHnsDrcJdb7kajBdcndMT8JXymqC6UViiitQ@mail.gmail.com>
Subject: Re: [PATCH v2] Makefile: Remove generated files when doing
 'distclean' (and 'clean')
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=aleksandar.m.mail@gmail.com; helo=mail-ej1-x642.google.com
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 8, 2019 at 2:41 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 8 Oct 2019 at 13:37, Thomas Huth <thuth@redhat.com> wrote:
> >
> > On 08/10/2019 14.18, Aleksandar Markovic wrote:
> > > If I remember well, QAPI-related c files are generated while doing
> > > 'make'. If that is true, these files should be deleted by 'make clean',
> > > shouldn't they?
> >
> > I think that's a philosophical question. Should "make clean" delete all
> > files that have been generated by a Makefile (i.e. not by "configure"),
> > or rather mainly the binary files?
>
> https://www.gnu.org/software/automake/manual/html_node/Clean.html
>
> The autoconf manual suggests some heuristics:
>  - If make built it, and it is commonly something that one would want
>    to rebuild (for instance, a .o file), then mostlyclean should delete it.
>  - Otherwise, if make built it, then clean should delete it.
>  - If configure built it, then distclean should delete it.
>  - If the maintainer built it (for instance, a .info file), then
>    maintainer-clean should delete it. However maintainer-clean should
>    not delete anything that needs to exist in order to run
> './configure && make'.
>

Thomas, can we reincarnate this patch? It needs only fairly simple
corrections, as said by Peter above. It would be nice to have at least
one release of QEMU with clean clean and distclean.

Yours,
Aleksandar
> Not all of that applies for QEMU, but it seems like a reasonable
> set of ideas.
>
> thanks
> -- PMM

