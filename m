Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557EEC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 13:05:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A471204EF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 13:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBbIbDvO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A471204EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdZGQ-0006FA-8o
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 09:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jdZFs-0005b9-Gr
 for qemu-devel@nongnu.org; Tue, 26 May 2020 09:04:28 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51865)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jdZFq-0000vw-NS
 for qemu-devel@nongnu.org; Tue, 26 May 2020 09:04:28 -0400
Received: by mail-wm1-x344.google.com with SMTP id u13so3067924wml.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 06:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=puabBlZw+L/g5G37nIfdUe3SUkyXV9onEuFSCQLh1UA=;
 b=nBbIbDvO7EKEkMaoAsWX3h8RA98ts0qJgRg/vZSGcwQubhie78HxHwtdLUTpssWGYT
 Fhb2XKWzYYOKHx0dn775viebcTGk9tawLFjkxxYokA4muMtUC3NlyYGpoHWID3BfbHPS
 WIoYhswiGaNajouIbCUW8mbl+I7E12YABho5dp/ElzluAIGjUFIGLubmWjaligaTuKUe
 NtmxxwLKnJifWSBn5krKiv6kOoTErTUb+Mxm7qN3Uo4vNAsR9ye3U/KvUVKXRhoFo09u
 NfxZZQOSBMXIjZkEKnP4mNjJX/OH3edim+8u+Ip4Y2HcJK+GDR4Yb/Y22mhLUdiUROMb
 ErHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=puabBlZw+L/g5G37nIfdUe3SUkyXV9onEuFSCQLh1UA=;
 b=rfHxaw6YvkTTJlaAOphq8tbd8R6f3TliPOHxRD+o40bg6AGi4ZjDCjpGEhshZVA5gK
 TRivs8SpzPZeLR/qM2AMqJXyBC4aJHwfZTViLcKAiGus8Zlhxg9UAggag6XrEbRjlu/d
 zSmeHw42XrmrAK1QwfTXt2zTARvAmHhepttsXA4e0g838Yf7uj3XA+iObOOKTFSKP4a9
 Crm7jbFu+BLMSnzfKTF1hnzHgvAJ86dyIWXiqyJ97mCSDtl+42SE63LJJ/d4+QvmRwTM
 gHTQDISetByY3qakvTONz+FCvUHqHCPxRfG7DDnBR9Xg59NJO6XVYRQMdPjYnR1uKjAq
 t4Cw==
X-Gm-Message-State: AOAM532agutstoKWDtnadwlxGdWUbO/N9BqS6piDNLUgvJtgD1O/puCL
 WG7r3VepSjIg8mUxhLSeLTEbcERuOVzNc2rA9eA=
X-Google-Smtp-Source: ABdhPJy5YsOfYlwNyg81XPdVV2wqLyOm0OGVkFh7q61Fsy8nMwQwJgbORNF1aTDiTcnt9r6fEflrt1N8yKtGd5eXQUs=
X-Received: by 2002:a1c:46c3:: with SMTP id t186mr1304154wma.36.1590498265195; 
 Tue, 26 May 2020 06:04:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200526104726.11273-1-f4bug@amsat.org>
 <20200526104726.11273-11-f4bug@amsat.org>
 <20200526115353.GN2995787@angien.pipo.sk>
 <CAHiYmc6csbt=fLhFtCMorCgbLd+kbBRoWO+gKdbDG_0x6NxyhA@mail.gmail.com>
 <20200526125035.GO2995787@angien.pipo.sk>
In-Reply-To: <20200526125035.GO2995787@angien.pipo.sk>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 26 May 2020 15:04:10 +0200
Message-ID: <CAHiYmc5mT+10mYBpRnmaKT4hTh=Nd2Kz19T1iHj9Jh=gbEAHFA@mail.gmail.com>
Subject: Re: [PATCH 10/14] hw/mips/fuloong2e: Fix typo in Fuloong machine name
To: Peter Krempa <pkrempa@redhat.com>
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

=D1=83=D1=82=D0=BE, 26. =D0=BC=D0=B0=D1=98 2020. =D1=83 14:50 Peter Krempa =
<pkrempa@redhat.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=BE/=D0=BB=D0=B0:
>
> On Tue, May 26, 2020 at 14:37:41 +0200, Aleksandar Markovic wrote:
> > > >
> > > > +mips ``fulong2e`` machine (since 5.1)
> > > > +'''''''''''''''''''''''''''''''''''''
> > > > +
> > > > +This machine has been renamed ``fuloong2e``.
> > > > +
> > >
> > > Libvirt doesn't have any special handling for this machine so this
> > > shouldn't impact us.
> > >
> >
> > Well, Peter,
> >
> > I was also wondering libvirt listed as a recipient, and I think it
> > creates unneeded noise in your group, but Philippe uses some his
> > system for automatic picking of recipients, and libivrt somehow
> > appears there during that process. Philippe, either correct that
> > detail in this particular component of your workflow, or change
> > entirely your system for recipient choice - the current workflow
> > creates incredible amount of noise, wasting time of many people.
>
> Note that my message above was not a criticism of why we've got it but
> more of a review. This review though it just that removing this is okay
> and no action needs to be taken. Unfortunately I'm usually not familiar
> enough with qemu to do a full review.
>
> >
> > This happened before in case of deprecating an ancient mips machine,
> > that absolutely  doesn't have anything to do with linvirt.
>
> In some cases it might seem like that. Specifically for things where
> libvirt isn't impacted such as machine type change because we try to
> stay machine type agnostic or for something that we don't use.
>
> On the other hand there were plenty cases where we were impacted and
> where we do want to know about these deprecations. It's in fact the
> primary reason why this was established after an agreement between qemu
> and libvirt projects and in fact I was one of those who argued for
> adding such a thing.
>
> As I was one of the proponents I feel obliged to always respond to these
> notifications as we've more than once encountered something that in the
> end impacted libvirt.
>

Glad to know that you guy have clear division of responsibility between mem=
bers.

Good to know the background of all this.

Thanks you,
Aleksandar

> Please do keep sending these to libvirt. It's appreciated to know that
> something is going to change! In some cases we don't get a notification
> (such as in the recent QAPIfication of netdev-add where non-well-formed
> string stopped to be accepted by qemu) and then we have to figure out
> only after it trickles down to users.
>

