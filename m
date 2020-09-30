Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD00C4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:46:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDB5820754
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="lWBTZQcu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDB5820754
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNeJc-00083e-Gc
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 11:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kNeIz-0007dS-EL
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 11:46:09 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36065)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kNeIs-0000gG-2f
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 11:46:09 -0400
Received: by mail-wr1-x441.google.com with SMTP id z1so2361520wrt.3
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 08:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=o9ESt7glrTCg1ZtyepmzJPbDHGX2skVpsfAbtWGHDSk=;
 b=lWBTZQcu/HiXMX4NEiDg2z8j/+Y1H48+IZtug19TfCnZK00Fr/bvRPPf4G/Sv2QMbz
 kr4rRhg17dMkkZgkph0We9mkkuKbRaxArwqHTvqOr3h5m+Or1mrmtMDPxgieUDuzeaUe
 XjtqquieUw6NSgblNeovKNI59sEbR6CFW5mE3Y7A43FqBvlxhnM/8w3VMTumOgdiZ44w
 oGJV0MiQRWfiUH/bHr9vrUB3qfPclLOM3cu9hQrWnGTB1V87kPiwZTzmnV+MrCWjCvlf
 8O9iw0nfjX9VmULg0THIUFQ+1j1nOsJaBsd7/VV6JmBeM8J1jQETovF76g/W2cTtZUpA
 VbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=o9ESt7glrTCg1ZtyepmzJPbDHGX2skVpsfAbtWGHDSk=;
 b=sEvAG+SNvdDOEZQdRSDKXldOSC1vGbCNdatYpezX5vX8vpbaC63H0SN6MkABlVILQw
 J5OF8ZWuMQpmMBUavpzP81QuFuoCblNGmLy2/N3yVSlRT3nErUs2E88NEF1arSWdDfFt
 Pc20bUMH/eTi+6N2IH2CQbP8MbfgLOyVatJGnbyjRYVaT/4VsQTuyY82ZhwkYgJkV9r7
 sASntout2MZz92m/+fVrfYDKkJMB8d26gZfVUnofUYg569Nuq1ctDAnecWIc6mlgXIMH
 OXFqsJQl3BplGpvXNL7jBS4JEL+pPhZF0o2Up2g6FK2UitaZ/nyftFowbEhtq2IhYvP4
 aEOQ==
X-Gm-Message-State: AOAM530yh36QmD6qJyNOhkCfjIZglpQIc5W6ftmqwnzAirTjCTTry17A
 54ME/nefbds4NgKEp6HQBbD7GD1wLkBOXbJIi2OhTw==
X-Google-Smtp-Source: ABdhPJxfA9aa6bLiznyEIDm1UUgL7A4ApZY/TZCbiCoKmRZGejp/v9wcFMYFkLPJtVoPE9k8LLZL6tMnz3AFJw1j5Po=
X-Received: by 2002:a5d:518b:: with SMTP id k11mr3754338wrv.369.1601480759962; 
 Wed, 30 Sep 2020 08:45:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAARzgwzdYfVn6Kdic+rj7xSxdvP6RAM48wr8Pt_MpDwuYvDSiw@mail.gmail.com>
 <20200929073523-mutt-send-email-mst@kernel.org>
 <CAARzgwyNHnG_dzhD9mZbico2V3-c=XL-fNo7xO=rP2jfVMqtdw@mail.gmail.com>
 <20200930033540-mutt-send-email-mst@kernel.org>
 <CAARzgwyAE1bL5VnkH7dKBeMEtwcsZBhuhtRxx+BUxYsd8ZRi_A@mail.gmail.com>
 <20200930034220-mutt-send-email-mst@kernel.org>
 <CAARzgwy_+kVWQs5sQo4qAYC3Gi5LhdLoMQDPzKadwRPZ1D8Brw@mail.gmail.com>
 <20200930040207-mutt-send-email-mst@kernel.org>
 <CAARzgwz1TJpyVZfxJF=yCoj4pBMsUxOvaVmZCCn0Dfni-dB5kw@mail.gmail.com>
 <CAARzgwzDdYnkKGBUdjr367qqZ3As4bqEhhWiaLqRzwXN2VKhHA@mail.gmail.com>
 <20200930112631-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200930112631-mutt-send-email-mst@kernel.org>
From: Ani Sinha <ani@anisinha.ca>
Date: Wed, 30 Sep 2020 21:15:48 +0530
Message-ID: <CAARzgwyt5qwoXXTCbcV0sDnivSBsK3MpkCBYxymXHjL4nXpk-g@mail.gmail.com>
Subject: Re: [PATCH v10 13/13] tests/acpi: add DSDT.hpbrroot DSDT table blob
 to test global i440fx hotplug
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: none client-ip=2a00:1450:4864:20::441;
 envelope-from=ani@anisinha.ca; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 30, 2020 at 8:59 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Sep 30, 2020 at 03:00:56PM +0530, Ani Sinha wrote:
> >
> >     > >     > Please let's not wait another week or so.
> >
> >     > >
> >
> >     > >
> >
> >     > >
> >
> >     > >
> >
> >     > >
> >
> >     > >     OK it's not too much work but ... could you please add
> >     justification
> >
> >     > >
> >
> >     > >     about why adding this one unit test is needed so urgently?
> >
> >     > >
> >
> >     > >     That motivation would be quite helpful for the pull request.
> >
> >     > >
> >
> >     > >
> >
> >     > > A patch without unit test doesn't complete the patch work. A unit test
> >     makes
> >
> >     > > sure that the change would not get broken by other changes that come in
> >     later.
> >
> >     > > Typically all code changes are accompanied by unit test in the same
> >     patch.
> >
> >     > > Hence since the main work has already been merged, the unit test should
> >     merge
> >
> >     > > ASAP so that no breakage can happen in between.
> >
> >     > >
> >
> >     > > Plus this completes an entire series of work which I've been working
> >     for a
> >
> >     > > while. I really would love to see it all merged cleanly and fully
> >     completed.
> >
> >     > >
> >
> >     >
> >
> >     > Absolutely, thanks for the great work!
> >
> >     > I am not sure that's a good justification to rushing a pull request
> >
> >     > though ... are you waiting to get paid and it hinges on the test, or are
> >
> >     > under a deadline, or something like this? It's okay to say so if so.
> >
> >
> >
> >     Yes I am under a deadline too. Unfortunately can't disclose more details.
> >
> >
> > Thanks Michael. Very much appreciate your help here.
> >
>
> OK Peter merged this. Hope this helps.
> Let's not make this a pattern please.

No this is a one time thing. Thanks to you and Peter for making an exception.

>
> --
> MST
>

