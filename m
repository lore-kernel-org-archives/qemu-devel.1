Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FA2C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 10:36:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DEA020791
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 10:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="hiAoc6WY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DEA020791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY5IF-0006GA-Ao
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 06:36:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kY5H4-0005k2-LA
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 06:35:18 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37868)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kY5H1-0003SK-Ct
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 06:35:18 -0400
Received: by mail-wr1-x444.google.com with SMTP id w1so2181434wrm.4
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 03:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=CGVTHDV0AEXFo+pRYOQ1eaO1sKu3N+Bp0x93r/KffHg=;
 b=hiAoc6WYOitQ6Nyq+dzLNj8zEQCfyZd4BosG49mIHkJTqkj4T4vwphwQma13HQkCRv
 qQoHiUqWaku6M/K9f/Qo9ana9jJ4JHiB8sHNCOa1v4+ql1XgbhI/DQrd0q25+KyCBfsi
 6VFcRc8GaZpuPEr6J80/f8KwtENYqP9Mm1df6lt/osPuj81iX4Ly+8+LZmyj1VJd7tZx
 ecPZt0PZFf3FnQrUdZDtVc+ykof++q6PlGiyaeiLRgggEZy0rg9N68ehU3tNTVuI6UwT
 7/lEYan+ajcCCAMDQXpFpJ6Uv4xWM/awT7bb4IGV/hzeNNhC6ooKLZj3Jix3F7Sdyl/X
 BI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=CGVTHDV0AEXFo+pRYOQ1eaO1sKu3N+Bp0x93r/KffHg=;
 b=dzoLR9j4dXdNFxARstwZWqcV0yzeZBVH1q9Iet2MO5d6kiu49Z80kNJUq1qu9gHchv
 unhunSp6e3TkHhejOIZnMBRBDFQ6sHk7FWtiHQo3velkVBgJuSLwfM9E4/Xay/Zy5xl6
 Q89Xc36zczTeIsGnu85N5mcdmkP9hQPqtQ/ie73wMmqIg9m7YGp6LMjnNd+AcUFvLLp9
 T2GxXm9iEUV7OHgm0eE1hlr8SkBmEmhFCkfyQxLJ65rcAYg86/63xXm5hdjEz/cMqfKT
 3tmMsgJvGonU8NGQ3HNBvC0AuQ9Uw6ireua5sXegWCBHMfzp6KyKmRb1/hNkferOx1Wv
 6ZMA==
X-Gm-Message-State: AOAM532O6G2WNS9HACfAzS2WgToJWWCM6J5M35/jpYThZoHQP6I8HH7y
 z3kugxT3aL6CXGiJHDxbEHTz0EMGIRb58BCguFThtg==
X-Google-Smtp-Source: ABdhPJy6WrFBzg0N0K04JGLAUUijfL4HRF2GZPgImLFUZ6zKXon6eLSdXPRdZkNziE6vi7DgimF3inquDQEzgQkNSOc=
X-Received: by 2002:adf:edcf:: with SMTP id v15mr4401456wro.291.1603967713215; 
 Thu, 29 Oct 2020 03:35:13 -0700 (PDT)
MIME-Version: 1.0
References: <20201004180443.2035359-1-f4bug@amsat.org>
 <20201004180443.2035359-10-f4bug@amsat.org>
 <CAARzgwxSaePpn75Y6=YvCm9QG8OewSrEgt5DEtqt+ntnkxm=Vg@mail.gmail.com>
In-Reply-To: <CAARzgwxSaePpn75Y6=YvCm9QG8OewSrEgt5DEtqt+ntnkxm=Vg@mail.gmail.com>
From: Ani Sinha <ani@anisinha.ca>
Date: Thu, 29 Oct 2020 16:05:02 +0530
Message-ID: <CAARzgwzQjv3MtFm4Uop6_UxEM2jz-7jqpf--=3dh9tSQp+L70A@mail.gmail.com>
Subject: Re: [RFC PATCH 09/21] contrib/gitdm: Add Nutanix to the domain map
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::444;
 envelope-from=ani@anisinha.ca; helo=mail-wr1-x444.google.com
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
Cc: Mike Cui <cui@nutanix.com>, Peter Turschmid <peter.turschm@nutanix.com>,
 Ani Sinha <ani.sinha@nutanix.com>, Swapnil Ingle <swapnil.ingle@nutanix.com>,
 Prerna Saxena <prerna.saxena@nutanix.com>,
 Malcolm Crossley <malcolm@nutanix.com>,
 David Vrabel <david.vrabel@nutanix.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Felipe Franciosi <felipe@nutanix.com>,
 Jonathan Davies <jonathan.davies@nutanix.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 7, 2020 at 9:56 PM Ani Sinha <ani@anisinha.ca> wrote:
>
> On Sun, Oct 4, 2020 at 11:34 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.=
org> wrote:
> >
> > There is a number of contributors from this domain,
> > add its own entry to the gitdm domain map.
> >
> > Cc: Ani Sinha <ani.sinha@nutanix.com>
> > Cc: David Vrabel <david.vrabel@nutanix.com>
> > Cc: Felipe Franciosi <felipe@nutanix.com>
> > Cc: Jonathan Davies <jonathan.davies@nutanix.com>
> > Cc: Malcolm Crossley <malcolm@nutanix.com>
> > Cc: Mike Cui <cui@nutanix.com>
> > Cc: Peter Turschmid <peter.turschm@nutanix.com>
> > Cc: Prerna Saxena <prerna.saxena@nutanix.com>
> > Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>
> > Cc: Swapnil Ingle <swapnil.ingle@nutanix.com>
> > Cc: Ani Sinha <ani@anisinha.ca>
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > ---
> > One Reviewed-by/Ack-by from someone from this domain
> > should be sufficient to get this patch merged.
> >
> > Ani, can you confirm the ani@anisinha.ca email?
> > Should it go into 'individual contributors' instead?
>
> Sent a patch to reflect my status as an individual contributor.

Merged: https://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D4acfca29dbca858c1=
4ed4f14c971fcdd9d1f6a52

>
> > ---
> >  contrib/gitdm/domain-map        | 1 +
> >  contrib/gitdm/group-map-nutanix | 2 ++
> >  gitdm.config                    | 1 +
> >  3 files changed, 4 insertions(+)
> >  create mode 100644 contrib/gitdm/group-map-nutanix
> >
> > diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
> > index 4850eab4c4..39251fd97c 100644
> > --- a/contrib/gitdm/domain-map
> > +++ b/contrib/gitdm/domain-map
> > @@ -24,6 +24,7 @@ linaro.org      Linaro
> >  codesourcery.com Mentor Graphics
> >  microsoft.com   Microsoft
> >  nokia.com       Nokia
> > +nutanix.com     Nutanix
> >  oracle.com      Oracle
> >  proxmox.com     Proxmox
> >  redhat.com      Red Hat
> > diff --git a/contrib/gitdm/group-map-nutanix b/contrib/gitdm/group-map-=
nutanix
> > new file mode 100644
> > index 0000000000..a3f11425b3
> > --- /dev/null
> > +++ b/contrib/gitdm/group-map-nutanix
> > @@ -0,0 +1,2 @@
> > +raphael.s.norwitz@gmail.com
> > +ani@anisinha.ca
> > diff --git a/gitdm.config b/gitdm.config
> > index c01c219078..4f821ab8ba 100644
> > --- a/gitdm.config
> > +++ b/gitdm.config
> > @@ -37,6 +37,7 @@ GroupMap contrib/gitdm/group-map-cadence Cadence Desi=
gn Systems
> >  GroupMap contrib/gitdm/group-map-codeweavers CodeWeavers
> >  GroupMap contrib/gitdm/group-map-ibm IBM
> >  GroupMap contrib/gitdm/group-map-janustech Janus Technologies
> > +GroupMap contrib/gitdm/group-map-nutanix Nutanix
> >
> >  # Also group together our prolific individual contributors
> >  # and those working under academic auspices
> > --
> > 2.26.2
> >

