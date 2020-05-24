Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F6EC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 17:51:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA06620787
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 17:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="osW4ngVd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA06620787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcumN-0007ZA-Rt
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 13:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jcull-00074q-Fi
 for qemu-devel@nongnu.org; Sun, 24 May 2020 13:50:41 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:35365)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jculk-0000US-FY
 for qemu-devel@nongnu.org; Sun, 24 May 2020 13:50:40 -0400
Received: by mail-oi1-x244.google.com with SMTP id z9so9455335oid.2
 for <qemu-devel@nongnu.org>; Sun, 24 May 2020 10:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hRHamlA+RMn+rh97TiS7hYdIrsKZTshasvJ1Dvn8F4c=;
 b=osW4ngVd2mlgXQFwLZv5m6Kp5ZgjecQH7SeAUqU5v27x5a4r38Mc0XIF01sioGWWPC
 R9RfOFf9qQKhROtCbXUY2bGBLAxTIEfxfjOJaJZE/EWCS9Nod1puZqp/1lJk1Ehk//mD
 6+ooBUWC3LZAGDMQ65yy9NwHv8UX5pOZHoS6xruA6vYTWhtn6RrQjQLsTInR9sJAlfYt
 Qvhkiy4JDjVypZ4J+KTVZrY0zSOmHOL8KPu6hTWtwqGOXn9XHkihKVQgP9R7ILGgf0CW
 M2BtKcvWr17Dm4fKAnMoo7lwAY+MGIQBYOOg+yU6Y5dhgTttJvCWs2czaY4HXdZYT1m6
 Q2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hRHamlA+RMn+rh97TiS7hYdIrsKZTshasvJ1Dvn8F4c=;
 b=bL5eh/wisUGAY9g4Zrwn7Nr8YCanfqzM/Csxs44yVGWFiuiyUgsD1QmDioeQleR6kH
 3l3OlOZ38gEq1yUvSealYVVsSotuYdC3jvkk/2u9aG/ujGF3cQhHqm/S1BFe1DjmpOVc
 IXgEs79eq/V4Bs8E6io0cIs82L5PFX1sp3RnrVNgblgggiU39UnkhAPEUGOM99fniSfV
 lMi1ex0bXmsBoAot+ZluvXhSk/+kUw0xOLGBrg3tO4rNbLAmtrT1uIADVrN4m8yu0Jii
 8j7/3I8E+ufQI5c2lROSBRjWKr/WUUwJ43MPdbpmFUZwOVOTTaFT2c9/5UZKNJV5ewkR
 ed6g==
X-Gm-Message-State: AOAM532LHdPxgktjCDmGKx9NbguRRIkUcgT9WQpAYydN+ofmcU4TvDv0
 15SwD4IcEtb8aVl86cLUHIscdaAWgaUwkuzmdDmwiA==
X-Google-Smtp-Source: ABdhPJylYelD2mM/dYmSAy5QgK2kgLBmlUF4457rKC1EiKinVbtwIzE3a54ECcTz4NWsRIocT4kU/Crflru8qteegR0=
X-Received: by 2002:aca:eb96:: with SMTP id j144mr8414235oih.48.1590342639145; 
 Sun, 24 May 2020 10:50:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200523232035.1029349-1-peterx@redhat.com>
 <20200523232035.1029349-2-peterx@redhat.com>
 <CAFEAcA9jq6UbaZAT-itF5Kswy1YSAocKa8mVVh0hNF7DuLGBqA@mail.gmail.com>
 <20200524140655.GA1058657@xz-x1>
In-Reply-To: <20200524140655.GA1058657@xz-x1>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 24 May 2020 18:50:28 +0100
Message-ID: <CAFEAcA9Sbo0hsmqoVcvv7wvvDVc9JdEep8n9mYgsnFFkmVckwQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3 01/11] linux-headers: Update
To: Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 24 May 2020 at 15:07, Peter Xu <peterx@redhat.com> wrote:
>
> Hi, Peter,
>
> On Sun, May 24, 2020 at 02:27:14PM +0100, Peter Maydell wrote:
> > On Sun, 24 May 2020 at 00:21, Peter Xu <peterx@redhat.com> wrote:
> > >
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> >
> > Header updates should always include the upstream
> > kernel commit against which you ran the scripts/update-linux-headers.sh
> > script, please.
>
> This is based on a kernel series that hasn't yet been merged, so I didn't tag
> it (so this is still a RFC series).  Will do when it's merged.

Ah, cool. (It's helpful to note in the commit message for the
header-update patch if it's a not-yet-upstream set of changes.)

thanks
-- PMM

