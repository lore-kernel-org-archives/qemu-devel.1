Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACD7C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 08:52:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BEAE20723
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 08:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwcpnXEO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BEAE20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdrnF-0002yK-JX
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 04:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jdrmi-0002UP-DW
 for qemu-devel@nongnu.org; Wed, 27 May 2020 04:51:36 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43036)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jdrmh-0005gj-Dw
 for qemu-devel@nongnu.org; Wed, 27 May 2020 04:51:35 -0400
Received: by mail-wr1-x442.google.com with SMTP id l10so419474wrr.10
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 01:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=4sLPs2IXHJ1qmyCNMO7TzSN4x8k8WvQ879Jr0upsV/s=;
 b=IwcpnXEO7ZdPXPrn2XPbP6QPfZVetXJegYSHCO24+9aQmYfigPY2pGiiPSUXAPAjRX
 hH3yKmlxzxTKMotvSyuZwhjkatHAnbC02H3HEfZ7mzrLR9OzBtD5TCSeKycE++139yaR
 yFNbHOq7YO60RDdFwskofy7hMdYQcLAQYlYYrTuzoH7mZiCnzYosdvB7rPIOoMfc/NGu
 /bqRAXWLtcLJhUJCjBW+HPymYpqGwvA9b7PD3mSzeKMYEzGNfhHyAsw9lZTBioVY43mU
 L8HO+0Qcf6g4gQDsP/+Bm/W/2iuOPYMcmX0XJr3pHAi3ynNC0wByTki8e1JR3nWMqSom
 Zkcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=4sLPs2IXHJ1qmyCNMO7TzSN4x8k8WvQ879Jr0upsV/s=;
 b=d00uB6uMNeX/UfX7qTKX555ThLMs79yTtag/JUUY5BQGx6SWrWVJylZKuf61LDaMqV
 ZokdkI1K5++oce7LNRNFbJ+ef+ZmYqeSSEq9hYzTOd4iQpvZuNEtOTH5ZHDRcC3aOuVT
 H5QnGHmkCCEYYjM++60Ha4rW9HGBnm/ulgwFk/UJBvlYH/mye7qKLNMq09w5sPH2/Klr
 2XpRsd+gx+0vw9O1dKqYBN0U1XPGfr3BRW3XSf+Bjs0mTqYVZPHPMDpyQf+qldJFZ8ZI
 qjzg3lKZ3soq3iLZMnB3c1K/D1Yhosg6zw+Udr/l/pf50A9vRCxOj3mGiQI7qcjRscrp
 r1uA==
X-Gm-Message-State: AOAM5332m1dnz186qf2uTRRcyW1iOJL5oIik4vOm7aKBUJJlXntMB7O/
 AmI85OL2KpM1Qs2Sg/7ngn30GCYtqcwhPPIo7Jc=
X-Google-Smtp-Source: ABdhPJxVEaoHYfLxBLsbAxV+1csVEVLJzd+WCIrWCMnlpd64AcMwjWYifQRKy+pVQahNS5G9lESKnGRKPlrGxbykhx0=
X-Received: by 2002:adf:dc50:: with SMTP id m16mr23963047wrj.329.1590569493925; 
 Wed, 27 May 2020 01:51:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200526104726.11273-1-f4bug@amsat.org>
 <20200526104726.11273-11-f4bug@amsat.org>
 <20200526115353.GN2995787@angien.pipo.sk>
 <CAHiYmc6csbt=fLhFtCMorCgbLd+kbBRoWO+gKdbDG_0x6NxyhA@mail.gmail.com>
 <20200526125035.GO2995787@angien.pipo.sk>
 <CAHiYmc5mT+10mYBpRnmaKT4hTh=Nd2Kz19T1iHj9Jh=gbEAHFA@mail.gmail.com>
In-Reply-To: <CAHiYmc5mT+10mYBpRnmaKT4hTh=Nd2Kz19T1iHj9Jh=gbEAHFA@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Wed, 27 May 2020 10:51:21 +0200
Message-ID: <CAHiYmc6UqmqAeC0QE=EKRncXGU7wvCAxjQXDawj2rZHYuiQKPQ@mail.gmail.com>
Subject: Re: [PATCH 10/14] hw/mips/fuloong2e: Fix typo in Fuloong machine name
To: Peter Krempa <pkrempa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, libvir-list@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D1=83=D1=82=D0=BE, 26. =D0=BC=D0=B0=D1=98 2020. =D1=83 15:04 Aleksandar Ma=
rkovic
<aleksandar.qemu.devel@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> =D1=83=D1=82=D0=BE, 26. =D0=BC=D0=B0=D1=98 2020. =D1=83 14:50 Peter Kremp=
a <pkrempa@redhat.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=BE/=D0=BB=D0=B0:
> >
> > On Tue, May 26, 2020 at 14:37:41 +0200, Aleksandar Markovic wrote:
> > > > >
> > > > > +mips ``fulong2e`` machine (since 5.1)
> > > > > +'''''''''''''''''''''''''''''''''''''
> > > > > +
> > > > > +This machine has been renamed ``fuloong2e``.
> > > > > +
> > > >
> > > > Libvirt doesn't have any special handling for this machine so this
> > > > shouldn't impact us.
> > > >
> > >
> > > Well, Peter,
> > >
> > > I was also wondering libvirt listed as a recipient, and I think it
> > > creates unneeded noise in your group, but Philippe uses some his
> > > system for automatic picking of recipients, and libivrt somehow
> > > appears there during that process. Philippe, either correct that
> > > detail in this particular component of your workflow, or change
> > > entirely your system for recipient choice - the current workflow
> > > creates incredible amount of noise, wasting time of many people.
> >
> > Note that my message above was not a criticism of why we've got it but
> > more of a review. This review though it just that removing this is okay
> > and no action needs to be taken. Unfortunately I'm usually not familiar
> > enough with qemu to do a full review.
> >
> > >
> > > This happened before in case of deprecating an ancient mips machine,
> > > that absolutely  doesn't have anything to do with linvirt.
> >
> > In some cases it might seem like that. Specifically for things where
> > libvirt isn't impacted such as machine type change because we try to
> > stay machine type agnostic or for something that we don't use.
> >
> > On the other hand there were plenty cases where we were impacted and
> > where we do want to know about these deprecations. It's in fact the
> > primary reason why this was established after an agreement between qemu
> > and libvirt projects and in fact I was one of those who argued for
> > adding such a thing.
> >
> > As I was one of the proponents I feel obliged to always respond to thes=
e
> > notifications as we've more than once encountered something that in the
> > end impacted libvirt.
> >

But, Peter Krempa,

I see libvirt-dev listed as a recipient for a patch (from this series)
that changes an e-mail of a colleague of mine. Why would be
libvirt-dev be interested in that? Is libvirt really so sensitive to
the degree that to be afraid that changing an e-mail of a QEMU
contributor would impact libvirt design and/or its interface towards
QEMU? If you wishes that to remain so, I am of course fine with it,
who am I to determine that, but it looks like a severe overkill to me.

Best Regards,
Aleksandar



>
> Glad to know that you guy have clear division of responsibility between m=
embers.
>
> Good to know the background of all this.
>
> Thanks you,
> Aleksandar
>
> > Please do keep sending these to libvirt. It's appreciated to know that
> > something is going to change! In some cases we don't get a notification
> > (such as in the recent QAPIfication of netdev-add where non-well-formed
> > string stopped to be accepted by qemu) and then we have to figure out
> > only after it trickles down to users.
> >

