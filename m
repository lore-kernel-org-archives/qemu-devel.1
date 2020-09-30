Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44349C4727F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 07:40:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6389F20789
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 07:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="tqgsPut5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6389F20789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNWiv-0002Qf-Dq
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 03:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kNWhx-00020n-7b
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 03:39:25 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33824)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kNWhu-0003sF-Ll
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 03:39:24 -0400
Received: by mail-wr1-x443.google.com with SMTP id t10so607328wrv.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 00:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZhIU78QnSK7Z81YTXtozvIpK/Yv+bjjsO1JeuJH/Wl0=;
 b=tqgsPut5h0CnlBb0KOF0m0DjESm/plRKCTf8p5CIthuX9TKBv33HQ44eAghBB1vto8
 elpu3t/XAUdH1dyBLxqgutJ8b696Sqt044NwLaf1AYZiswKyWr/rN2ss/gf5iVhPI1I6
 DjkQ7ZnRHRgVWmIyw1RQoz+HsGLnR6zaQBXGSdRK9Vw2B67AeoZLVUKINiyg2PsqT2Aw
 4v6uDOdl9ACn3mlOf0lYsUoTMB6n5fqjhNXMRTLWjLR17T6v9TiMp/F/9cV9hy9Xy3DP
 5ngEBkh1TGA1lyDclgkchcKMPozdPu2kHftqJk97bPhp7n0z3031c8EFoPMjB+QDdZbS
 f6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZhIU78QnSK7Z81YTXtozvIpK/Yv+bjjsO1JeuJH/Wl0=;
 b=tjjhyZX81OwwC/w72MEXYb4TNDxzRztxCN/NVW0ZsdQup5OIk/W2l9I9M2PfgvNiA5
 gfAMv+3KupYvyPKd37wStmOju+1X/Ua43ZJrNBW1Pd9FsiyPbCERt/bI1wmdmgUpEBgt
 ntFdDtpCde75Oubtw9qRYkPvhuzhhSm1WFM+YPnGsTwW6gbtQ7I/+5YqI0TgzQHKdPyu
 T5Lz8XotTXJSX6tP4QwfsMBBqC3SuEo+gsfUBN9kK7dGoX8+U8yOO9c4vwuFsgX5TzjV
 Cn9gkz+Hf29ALBN9AogkPfOpO3JfYjodm4dS3rrSkz7CdSph88LpZyBYGWzhS4Ty+Esw
 NqXQ==
X-Gm-Message-State: AOAM533u4ScoyMt4brIKBJ44lAlsSJt1bokzBdKT/V4osoEcxNFQsIbR
 Tfwhd0uBOimwOTed/qpJW/qTXXmvvDexGsfl2xXO2w==
X-Google-Smtp-Source: ABdhPJylnKfu20SeimhxiO7OyfFgcGLputut7OCR8xAX5//VjiwHcMRIZvJ6w28tdZMcNpKTVvk+Lfh496d6hs+8SFQ=
X-Received: by 2002:adf:e410:: with SMTP id g16mr1575468wrm.76.1601451560636; 
 Wed, 30 Sep 2020 00:39:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAARzgwy8QNw=OD6cOEkDY-x9mC10ry+NTdCH2gNKuLXp8bAAyg@mail.gmail.com>
 <CAARzgwyNPZB5PGc-B9vDn9V-uEwVCiCvXgvamMaGTvBCPJQiCg@mail.gmail.com>
 <20200929063539-mutt-send-email-mst@kernel.org>
 <CAARzgwz6iTsO9Z1ACAHmbSteGYfetDgnSRYc-xnaqjYyJ4yEHA@mail.gmail.com>
 <20200929064858-mutt-send-email-mst@kernel.org>
 <CAARzgwwFeSPd=JGjdk-uj=uuLb+HcfMfGTe1_GmbFRTkP-jZdQ@mail.gmail.com>
 <20200929071412-mutt-send-email-mst@kernel.org>
 <CAARzgwzdYfVn6Kdic+rj7xSxdvP6RAM48wr8Pt_MpDwuYvDSiw@mail.gmail.com>
 <20200929073523-mutt-send-email-mst@kernel.org>
 <CAARzgwyNHnG_dzhD9mZbico2V3-c=XL-fNo7xO=rP2jfVMqtdw@mail.gmail.com>
 <20200930033540-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200930033540-mutt-send-email-mst@kernel.org>
From: Ani Sinha <ani@anisinha.ca>
Date: Wed, 30 Sep 2020 13:09:09 +0530
Message-ID: <CAARzgwyAE1bL5VnkH7dKBeMEtwcsZBhuhtRxx+BUxYsd8ZRi_A@mail.gmail.com>
Subject: Re: [PATCH v10 13/13] tests/acpi: add DSDT.hpbrroot DSDT table blob
 to test global i440fx hotplug
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000065a68b05b082ff3e"
Received-SPF: none client-ip=2a00:1450:4864:20::443;
 envelope-from=ani@anisinha.ca; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--00000000000065a68b05b082ff3e
Content-Type: text/plain; charset="UTF-8"

On Wed, Sep 30, 2020 at 1:06 PM Michael S. Tsirkin <mst@redhat.com> wrote:

> On Tue, Sep 29, 2020 at 06:03:00PM +0530, Ani Sinha wrote:
>
> > On Tue, Sep 29, 2020 at 5:05 PM Michael S. Tsirkin <mst@redhat.com>
> wrote:
>
> > >
>
> > > On Tue, Sep 29, 2020 at 04:58:03PM +0530, Ani Sinha wrote:
>
> > > > On Tue, Sep 29, 2020 at 4:45 PM Michael S. Tsirkin <mst@redhat.com>
> wrote:
>
> > > > >
>
> > > > > On Tue, Sep 29, 2020 at 04:35:50PM +0530, Ani Sinha wrote:
>
> > > > > > On Tue, Sep 29, 2020 at 4:25 PM Michael S. Tsirkin <
> mst@redhat.com> wrote:
>
> > > > > > >
>
> > > > > > > On Tue, Sep 29, 2020 at 04:11:45PM +0530, Ani Sinha wrote:
>
> > > > > > > > On Tue, Sep 29, 2020 at 4:07 PM Michael S. Tsirkin <
> mst@redhat.com> wrote:
>
> > > > > > > > >
>
> > > > > > > > > On Tue, Sep 29, 2020 at 04:02:07PM +0530, Ani Sinha wrote:
>
> > > > > > > > > > On Tue, Sep 29, 2020 at 4:00 PM Ani Sinha <
> ani@anisinha.ca> wrote:
>
> > > > > > > > > > >
>
> > > > > > > > > > > In your pull request the following patch is completely
> screwed up:
>
> > > > > > > > > > >
>
> > > > > > > > > > > commit cda2006eded0ed91974e1d9e7f9f288e65812a3e
>
> > > > > > > > > > > Author: Ani Sinha <ani@anisinha.ca>
>
> > > > > > > > > > > Date:   Tue Sep 29 03:22:52 2020 -0400
>
> > > > > > > > > > >
>
> > > > > > > > > > >     tests/acpi: update golden master DSDT binary table
> blobs for q35
>
> > > > > > > > > > >
>
> > > > > > > > > > >
>
> > > > > > > > > > > This is not my patch. It has all sorts of changes
> which does not
>
> > > > > > > > > > > belong there. Can you please check?
>
> > > > > > > > > >
>
> > > > > > > > > > See
> https://patchew.org/QEMU/20200929071948.281157-1-mst@redhat.com/20200929071948.281157-46-mst@redhat.com/
>
> > > > > > > > >
>
> > > > > > > > >
>
> > > > > > > > > I had to regenerate the binary, yes. That's par for the
> course.
>
> > > > > > > > > But it looks like I added disasssembled files. Will fix up
> and drop,
>
> > > > > > > > > thanks for noticing this.
>
> > > > > > >
>
> > > > > > > OK I pushed out a fixed variant. Pls take a look.
>
> > > > > >
>
> > > > > > OK I am not used to this workflow. How am I supposed to get it?
> Which tag?
>
> > > > >
>
> > > > > New for_upstream tag - I just sent in a pull request.
>
> > > >
>
> > > > Can you please point me to your tree?
>
> > >
>
> > >
>
> > >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> >
>
> > I have sent the updated patches based on your pull request tag. I just
>
> > had to regenrated the blob for tests/data/acpi/pc/DSDT.hpbrroot.
>
> >
>
> > make && make check-qtest-x86_64 V=1 passes.
>
> >
>
> > The diff looks good.
>
> >
>
> > Can you please send a pull request with these two patches ASAP?
>
>
>
>
>
> Thanks, I will queue them and merge in the next pull request.


I'm willing to get down on my knees begging you to just do one another pull
request for these two patches. Were so close with my entire work merged.

Please let's not wait another week or so.


>
>
>
> > >
>
> > >
>
> > >
>
> > > > >
>
> > > > > >
>
> > > > > > >
>
> > > > > > > > I think DSDT.hbridge is wrong. The checksum looks weird:
>
> > > > > > > >
>
> > > > > > > >
>
> > > > > > > > + *     Length           0x00000B89 (2953)
>
> > > > > > > >   *     Revision         0x01 **** 32-bit table (V1), no
> 64-bit math support
>
> > > > > > > > - *     Checksum         0x05
>
> > > > > > >
>
> > > > > > > What is weird about it?
>
> > > > > > >
>
> > > > > > > >
>
> > > > > > > > This file should be introduced just by one patch. my patch.
>
> > > > > > >
>
> > > > > > > I just re-run rebuild-expected-aml, no changes.
>
> > > > > > >
>
> > > > > > > I have this:
>
> > > > > > > commit 5e3a486211f02d9ecb18939ca21087515ec81883
>
> > > > > > > Author: Ani Sinha <ani@anisinha.ca>
>
> > > > > > > Date:   Fri Sep 18 14:11:05 2020 +0530
>
> > > > > > >
>
> > > > > > >     tests/acpi: unit test for
> 'acpi-pci-hotplug-with-bridge-support' bridge flag
>
> > > > > > >
>
> > > > > > >     This change adds a new unit test for the global flag
>
> > > > > > >     'acpi-pci-hotplug-with-bridge-support' which is available
> for cold plugged pci
>
> > > > > > >     bridges in i440fx. The flag can be used to turn off ACPI
> based hotplug support
>
> > > > > > >     on all pci bridges.
>
> > > > > > >
>
> > > > > > >
>
> > > > > > > Here is the full DSDT header, attached:
>
> > > > > > >
>
> > > > > > > /*
>
> > > > > > >  * Intel ACPI Component Architecture
>
> > > > > > >  * AML/ASL+ Disassembler version 20190509 (64-bit version)
>
> > > > > > >  * Copyright (c) 2000 - 2019 Intel Corporation
>
> > > > > > >  *
>
> > > > > > >  * Disassembling to symbolic ASL+ operators
>
> > > > > > >  *
>
> > > > > > >  * Disassembly of tests/data/acpi/pc/DSDT.hpbridge, Tue Sep 29
> 06:51:03 2020
>
> > > > > > >  *
>
> > > > > > >  * Original Table Header:
>
> > > > > > >  *     Signature        "DSDT"
>
> > > > > > >  *     Length           0x0000139D (5021)
>
> > > > > > >  *     Revision         0x01 **** 32-bit table (V1), no 64-bit
> math support
>
> > > > > > >  *     Checksum         0x05
>
> > > > > > >  *     OEM ID           "BOCHS "
>
> > > > > > >  *     OEM Table ID     "BXPCDSDT"
>
> > > > > > >  *     OEM Revision     0x00000001 (1)
>
> > > > > > >  *     Compiler ID      "BXPC"
>
> > > > > > >  *     Compiler Version 0x00000001 (1)
>
> > > > > > >  */
>
> > > > > > > DefinitionBlock ("", "DSDT", 1, "BOCHS ", "BXPCDSDT",
> 0x00000001)
>
> > > > > > >
>
> > > > > > > --
>
> > > > > > > MST
>
> > > > > > >
>
> > > > >
>
> > >
>
>
>
>

--00000000000065a68b05b082ff3e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><br></div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Wed, Sep 30, 2020 at 1:06 PM Michael S. Tsirkin &lt;<a h=
ref=3D"mailto:mst@redhat.com">mst@redhat.com</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-w=
idth:1px;border-left-style:solid;padding-left:1ex;border-left-color:rgb(204=
,204,204)">On Tue, Sep 29, 2020 at 06:03:00PM +0530, Ani Sinha wrote:<br><b=
r>&gt; On Tue, Sep 29, 2020 at 5:05 PM Michael S. Tsirkin &lt;<a href=3D"ma=
ilto:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&gt; wrote:<br><br=
>&gt; &gt;<br><br>&gt; &gt; On Tue, Sep 29, 2020 at 04:58:03PM +0530, Ani S=
inha wrote:<br><br>&gt; &gt; &gt; On Tue, Sep 29, 2020 at 4:45 PM Michael S=
. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com" target=3D"_blank">mst@redha=
t.com</a>&gt; wrote:<br><br>&gt; &gt; &gt; &gt;<br><br>&gt; &gt; &gt; &gt; =
On Tue, Sep 29, 2020 at 04:35:50PM +0530, Ani Sinha wrote:<br><br>&gt; &gt;=
 &gt; &gt; &gt; On Tue, Sep 29, 2020 at 4:25 PM Michael S. Tsirkin &lt;<a h=
ref=3D"mailto:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&gt; wrot=
e:<br><br>&gt; &gt; &gt; &gt; &gt; &gt;<br><br>&gt; &gt; &gt; &gt; &gt; &gt=
; On Tue, Sep 29, 2020 at 04:11:45PM +0530, Ani Sinha wrote:<br><br>&gt; &g=
t; &gt; &gt; &gt; &gt; &gt; On Tue, Sep 29, 2020 at 4:07 PM Michael S. Tsir=
kin &lt;<a href=3D"mailto:mst@redhat.com" target=3D"_blank">mst@redhat.com<=
/a>&gt; wrote:<br><br>&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br><br>&gt; &=
gt; &gt; &gt; &gt; &gt; &gt; &gt; On Tue, Sep 29, 2020 at 04:02:07PM +0530,=
 Ani Sinha wrote:<br><br>&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; On Tu=
e, Sep 29, 2020 at 4:00 PM Ani Sinha &lt;<a href=3D"mailto:ani@anisinha.ca"=
 target=3D"_blank">ani@anisinha.ca</a>&gt; wrote:<br><br>&gt; &gt; &gt; &gt=
; &gt; &gt; &gt; &gt; &gt; &gt;<br><br>&gt; &gt; &gt; &gt; &gt; &gt; &gt; &=
gt; &gt; &gt; In your pull request the following patch is completely screwe=
d up:<br><br>&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br><br>&gt; =
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; commit cda2006eded0ed91974e1d9=
e7f9f288e65812a3e<br><br>&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; =
Author: Ani Sinha &lt;<a href=3D"mailto:ani@anisinha.ca" target=3D"_blank">=
ani@anisinha.ca</a>&gt;<br><br>&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=
 &gt; Date:=C2=A0 =C2=A0Tue Sep 29 03:22:52 2020 -0400<br><br>&gt; &gt; &gt=
; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br><br>&gt; &gt; &gt; &gt; &gt; &gt; &=
gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0tests/acpi: update golden master DSDT=
 binary table blobs for q35<br><br>&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; =
&gt; &gt;<br><br>&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br><br>&=
gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; This is not my patch. It h=
as all sorts of changes which does not<br><br>&gt; &gt; &gt; &gt; &gt; &gt;=
 &gt; &gt; &gt; &gt; belong there. Can you please check?<br><br>&gt; &gt; &=
gt; &gt; &gt; &gt; &gt; &gt; &gt;<br><br>&gt; &gt; &gt; &gt; &gt; &gt; &gt;=
 &gt; &gt; See <a href=3D"https://patchew.org/QEMU/20200929071948.281157-1-=
mst@redhat.com/20200929071948.281157-46-mst@redhat.com/" rel=3D"noreferrer"=
 target=3D"_blank">https://patchew.org/QEMU/20200929071948.281157-1-mst@red=
hat.com/20200929071948.281157-46-mst@redhat.com/</a><br><br>&gt; &gt; &gt; =
&gt; &gt; &gt; &gt; &gt;<br><br>&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>=
<br>&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; I had to regenerate the binary,=
 yes. That&#39;s par for the course.<br><br>&gt; &gt; &gt; &gt; &gt; &gt; &=
gt; &gt; But it looks like I added disasssembled files. Will fix up and dro=
p,<br><br>&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; thanks for noticing this.=
<br><br>&gt; &gt; &gt; &gt; &gt; &gt;<br><br>&gt; &gt; &gt; &gt; &gt; &gt; =
OK I pushed out a fixed variant. Pls take a look.<br><br>&gt; &gt; &gt; &gt=
; &gt;<br><br>&gt; &gt; &gt; &gt; &gt; OK I am not used to this workflow. H=
ow am I supposed to get it? Which tag?<br><br>&gt; &gt; &gt; &gt;<br><br>&g=
t; &gt; &gt; &gt; New for_upstream tag - I just sent in a pull request.<br>=
<br>&gt; &gt; &gt;<br><br>&gt; &gt; &gt; Can you please point me to your tr=
ee?<br><br>&gt; &gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0git://<a=
 href=3D"http://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git" rel=3D"norefe=
rrer" target=3D"_blank">git.kernel.org/pub/scm/virt/kvm/mst/qemu.git</a> ta=
gs/for_upstream<br><br>&gt; <br><br>&gt; I have sent the updated patches ba=
sed on your pull request tag. I just<br><br>&gt; had to regenrated the blob=
 for tests/data/acpi/pc/DSDT.hpbrroot.<br><br>&gt; <br><br>&gt; make &amp;&=
amp; make check-qtest-x86_64 V=3D1 passes.<br><br>&gt; <br><br>&gt; The dif=
f looks good.<br><br>&gt; <br><br>&gt; Can you please send a pull request w=
ith these two patches ASAP?<br><br><br><br><br><br>Thanks, I will queue the=
m and merge in the next pull request.</blockquote><div dir=3D"auto"><br></d=
iv><div dir=3D"auto">I&#39;m willing to get down on my knees begging you to=
 just do one another pull request for these two patches. Were so close with=
 my entire work merged.</div><div dir=3D"auto"><br></div><div dir=3D"auto">=
Please let&#39;s not wait another week or so.=C2=A0</div><div dir=3D"auto">=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left-width:1px;border-left-style:solid;padding-left:1ex;border-le=
ft-color:rgb(204,204,204)" dir=3D"auto"><br><br><br><br>&gt; &gt;<br><br>&g=
t; &gt;<br><br>&gt; &gt;<br><br>&gt; &gt; &gt; &gt;<br><br>&gt; &gt; &gt; &=
gt; &gt;<br><br>&gt; &gt; &gt; &gt; &gt; &gt;<br><br>&gt; &gt; &gt; &gt; &g=
t; &gt; &gt; I think DSDT.hbridge is wrong. The checksum looks weird:<br><b=
r>&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br><br>&gt; &gt; &gt; &gt; &gt; &gt; &=
gt;<br><br>&gt; &gt; &gt; &gt; &gt; &gt; &gt; + *=C2=A0 =C2=A0 =C2=A0Length=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x00000B89 (2953)<br><br>&gt; &gt;=
 &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0*=C2=A0 =C2=A0 =C2=A0Revision=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A00x01 **** 32-bit table (V1), no 64-bit math supp=
ort<br><br>&gt; &gt; &gt; &gt; &gt; &gt; &gt; - *=C2=A0 =C2=A0 =C2=A0Checks=
um=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x05<br><br>&gt; &gt; &gt; &gt; &gt; &g=
t;<br><br>&gt; &gt; &gt; &gt; &gt; &gt; What is weird about it?<br><br>&gt;=
 &gt; &gt; &gt; &gt; &gt;<br><br>&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br><br>=
&gt; &gt; &gt; &gt; &gt; &gt; &gt; This file should be introduced just by o=
ne patch. my patch.<br><br>&gt; &gt; &gt; &gt; &gt; &gt;<br><br>&gt; &gt; &=
gt; &gt; &gt; &gt; I just re-run rebuild-expected-aml, no changes.<br><br>&=
gt; &gt; &gt; &gt; &gt; &gt;<br><br>&gt; &gt; &gt; &gt; &gt; &gt; I have th=
is:<br><br>&gt; &gt; &gt; &gt; &gt; &gt; commit 5e3a486211f02d9ecb18939ca21=
087515ec81883<br><br>&gt; &gt; &gt; &gt; &gt; &gt; Author: Ani Sinha &lt;<a=
 href=3D"mailto:ani@anisinha.ca" target=3D"_blank">ani@anisinha.ca</a>&gt;<=
br><br>&gt; &gt; &gt; &gt; &gt; &gt; Date:=C2=A0 =C2=A0Fri Sep 18 14:11:05 =
2020 +0530<br><br>&gt; &gt; &gt; &gt; &gt; &gt;<br><br>&gt; &gt; &gt; &gt; =
&gt; &gt;=C2=A0 =C2=A0 =C2=A0tests/acpi: unit test for &#39;acpi-pci-hotplu=
g-with-bridge-support&#39; bridge flag<br><br>&gt; &gt; &gt; &gt; &gt; &gt;=
<br><br>&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0This change adds a=
 new unit test for the global flag<br><br>&gt; &gt; &gt; &gt; &gt; &gt;=C2=
=A0 =C2=A0 =C2=A0&#39;acpi-pci-hotplug-with-bridge-support&#39; which is av=
ailable for cold plugged pci<br><br>&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=
=A0 =C2=A0bridges in i440fx. The flag can be used to turn off ACPI based ho=
tplug support<br><br>&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0on al=
l pci bridges.<br><br>&gt; &gt; &gt; &gt; &gt; &gt;<br><br>&gt; &gt; &gt; &=
gt; &gt; &gt;<br><br>&gt; &gt; &gt; &gt; &gt; &gt; Here is the full DSDT he=
ader, attached:<br><br>&gt; &gt; &gt; &gt; &gt; &gt;<br><br>&gt; &gt; &gt; =
&gt; &gt; &gt; /*<br><br>&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 * Intel ACPI C=
omponent Architecture<br><br>&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 * AML/ASL+=
 Disassembler version 20190509 (64-bit version)<br><br>&gt; &gt; &gt; &gt; =
&gt; &gt;=C2=A0 * Copyright (c) 2000 - 2019 Intel Corporation<br><br>&gt; &=
gt; &gt; &gt; &gt; &gt;=C2=A0 *<br><br>&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =
* Disassembling to symbolic ASL+ operators<br><br>&gt; &gt; &gt; &gt; &gt; =
&gt;=C2=A0 *<br><br>&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 * Disassembly of te=
sts/data/acpi/pc/DSDT.hpbridge, Tue Sep 29 06:51:03 2020<br><br>&gt; &gt; &=
gt; &gt; &gt; &gt;=C2=A0 *<br><br>&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 * Ori=
ginal Table Header:<br><br>&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 *=C2=A0 =C2=
=A0 =C2=A0Signature=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;DSDT&quot;<br><br>&gt;=
 &gt; &gt; &gt; &gt; &gt;=C2=A0 *=C2=A0 =C2=A0 =C2=A0Length=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A00x0000139D (5021)<br><br>&gt; &gt; &gt; &gt; &gt=
; &gt;=C2=A0 *=C2=A0 =C2=A0 =C2=A0Revision=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A00x01 **** 32-bit table (V1), no 64-bit math support<br><br>&gt; &gt; &gt=
; &gt; &gt; &gt;=C2=A0 *=C2=A0 =C2=A0 =C2=A0Checksum=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A00x05<br><br>&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 *=C2=A0 =C2=A0=
 =C2=A0OEM ID=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;BOCHS &quot;<br=
><br>&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 *=C2=A0 =C2=A0 =C2=A0OEM Table ID=
=C2=A0 =C2=A0 =C2=A0&quot;BXPCDSDT&quot;<br><br>&gt; &gt; &gt; &gt; &gt; &g=
t;=C2=A0 *=C2=A0 =C2=A0 =C2=A0OEM Revision=C2=A0 =C2=A0 =C2=A00x00000001 (1=
)<br><br>&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 *=C2=A0 =C2=A0 =C2=A0Compiler =
ID=C2=A0 =C2=A0 =C2=A0 &quot;BXPC&quot;<br><br>&gt; &gt; &gt; &gt; &gt; &gt=
;=C2=A0 *=C2=A0 =C2=A0 =C2=A0Compiler Version 0x00000001 (1)<br><br>&gt; &g=
t; &gt; &gt; &gt; &gt;=C2=A0 */<br><br>&gt; &gt; &gt; &gt; &gt; &gt; Defini=
tionBlock (&quot;&quot;, &quot;DSDT&quot;, 1, &quot;BOCHS &quot;, &quot;BXP=
CDSDT&quot;, 0x00000001)<br><br>&gt; &gt; &gt; &gt; &gt; &gt;<br><br>&gt; &=
gt; &gt; &gt; &gt; &gt; --<br><br>&gt; &gt; &gt; &gt; &gt; &gt; MST<br><br>=
&gt; &gt; &gt; &gt; &gt; &gt;<br><br>&gt; &gt; &gt; &gt;<br><br>&gt; &gt;<b=
r><br><br><br></blockquote></div></div>

--00000000000065a68b05b082ff3e--

