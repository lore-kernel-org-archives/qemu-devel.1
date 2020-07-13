Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954D7C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 15:55:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 628CA20663
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 15:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kf9QJcm7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 628CA20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv0nQ-00085T-NC
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 11:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jv0mh-0007f8-U6
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 11:54:27 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:39836)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jv0mg-0007wa-6p
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 11:54:27 -0400
Received: by mail-ej1-x644.google.com with SMTP id w6so17776784ejq.6
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 08:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Mrd9Zm92CktrNp5kQQxcVTDgdNGmZdF8lBIIoEaQxjE=;
 b=kf9QJcm77sz0INFEdsKYst6DQZcFxKJQ/B/J82ye6y/5A3umzdUWIIiVmBV7V/LgKH
 bikznVkVTF/afqBhU1E4KPJj2HloskvuQaeGu3T3hEUL3dKL7SEWEOSWSH8iSU0v5LO9
 tHmG/DNOYAhJaJYx5EpS6RI3U05A1LtK937TNyPG0jRuKvC2QztsovxVtzVYXGTHYd0D
 KG+0AttEeap5iGRzBzOvXccnj7oXHyKMzODoxv4mf+MLMKaI1FrDKZpangy1MLn+Kvyl
 WiWmLzVZq5NpeaLqq/Y+g74QAnMwExV4BJ3MHaVuV2KWwc6MPa+O4d9dRdzo499+6eDT
 bZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Mrd9Zm92CktrNp5kQQxcVTDgdNGmZdF8lBIIoEaQxjE=;
 b=K/8TqbOX9zmCV2wLjUBEmUmtJL1+0FG/1ZsVyOmJ5vgmp4/klPCFjAcXMGX3X001aq
 bZKC9fuA/smK/FM+GreplYMs2qFtbvUzl3XL/YLcM8Vx9Y5WGC1SaE6VI4i1PU8x1dPA
 pII6LHSumCaFJD3mPfwz/dmr0OmaGwO+bQ7lUMuCsOMr9GNFNGIoJjzZ+4xWkpHKxtvc
 2O+0p+SA+xbZF+84e3e99sEIpV4DUtaBNZmlR3Y4mqrGTHmlhUe5qEveOQ+Wq1potsTJ
 PufWdey75BA/lZzNhD/gExhmEa+ggL+D6gkRR9IlhYOTZ4VKNbV1SSVIwDlk/GggL/uh
 8f2w==
X-Gm-Message-State: AOAM531MnuD1/q6OIyjse/w/x+uKyvVLWPY2yd2c/EQowqEDJdmndaTY
 AWjfn1+Erzrt5Cyym9td3fTbSrvlctkstjRCEZY=
X-Google-Smtp-Source: ABdhPJzCEKVF6cJQ33hA9GXIPpBwsAb8KRxw/Mk7x8eRYZIVtwrGy2WPs/atgDNJxO2f115PS0hKr8ed8eJPviLwz8c=
X-Received: by 2002:a17:906:2988:: with SMTP id
 x8mr391203eje.141.1594655664251; 
 Mon, 13 Jul 2020 08:54:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200625045011.1075314-1-arilou@gmail.com>
 <20200713104402.38e8369e@redhat.com>
In-Reply-To: <20200713104402.38e8369e@redhat.com>
From: Jon Doron <arilou@gmail.com>
Date: Mon, 13 Jul 2020 18:54:12 +0300
Message-ID: <CAP7QCog6RbTiXD-+yK=UF7P-Z4R9CQQLqeS6CAj7qeuJqvg6QA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] hyperv: vmbus: ACPI various corrections
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000068279305aa54b4ff"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=arilou@gmail.com; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: rvkagan@yandex-team.ru, pbonzini@redhat.com,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 QEMU <qemu-devel@nongnu.org>, vkuznets@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000068279305aa54b4ff
Content-Type: text/plain; charset="UTF-8"

Sure thing I'll try to take a look at it this weekend.

Jon.

On Mon, Jul 13, 2020, 11:44 Igor Mammedov <imammedo@redhat.com> wrote:

> On Thu, 25 Jun 2020 07:50:09 +0300
> Jon Doron <arilou@gmail.com> wrote:
>
> > After doing further tests and looking at the latest HyperV ACPI DSDT.
> > Do minor fix to our VMBus ACPI entry.
>
> Jon,
> vmbus feature needs a testcase, could you look into it please?
> (see tests/qtest/bios-tables-test.c for an example.
> also look into comment blob at the top for the propper process
> for acpi patches/tests)
>
>
> > v4:
> > * Removed the patch which adds _ADR definition to the VMBus
> > * Correct the change which moves the VMBus under the SB
> >
> > v3:
> > Removed accidental change for the dct submodule head
> >
> > v2:
> > Renamed irq0 to irq now that there is a single IRQ required
> >
> > Jon Doron (2):
> >   hyperv: vmbus: Remove the 2nd IRQ
> >   acpi: i386: Move VMBus DSDT entry to SB
> >
> >  hw/hyperv/vmbus.c                |  3 +--
> >  hw/i386/acpi-build.c             | 16 ++++++++--------
> >  include/hw/hyperv/vmbus-bridge.h |  3 +--
> >  3 files changed, 10 insertions(+), 12 deletions(-)
> >
>
>

--00000000000068279305aa54b4ff
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Sure thing I&#39;ll try to take a look at it this weekend=
.<div dir=3D"auto"><br></div><div dir=3D"auto">Jon.=C2=A0</div></div><br><d=
iv class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul =
13, 2020, 11:44 Igor Mammedov &lt;<a href=3D"mailto:imammedo@redhat.com">im=
ammedo@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On=
 Thu, 25 Jun 2020 07:50:09 +0300<br>
Jon Doron &lt;<a href=3D"mailto:arilou@gmail.com" target=3D"_blank" rel=3D"=
noreferrer">arilou@gmail.com</a>&gt; wrote:<br>
<br>
&gt; After doing further tests and looking at the latest HyperV ACPI DSDT.<=
br>
&gt; Do minor fix to our VMBus ACPI entry.<br>
<br>
Jon,<br>
vmbus feature needs a testcase, could you look into it please? <br>
(see tests/qtest/bios-tables-test.c for an example.<br>
also look into comment blob at the top for the propper process<br>
for acpi patches/tests)<br>
<br>
<br>
&gt; v4:<br>
&gt; * Removed the patch which adds _ADR definition to the VMBus<br>
&gt; * Correct the change which moves the VMBus under the SB<br>
&gt; <br>
&gt; v3:<br>
&gt; Removed accidental change for the dct submodule head<br>
&gt; <br>
&gt; v2:<br>
&gt; Renamed irq0 to irq now that there is a single IRQ required<br>
&gt; <br>
&gt; Jon Doron (2):<br>
&gt;=C2=A0 =C2=A0hyperv: vmbus: Remove the 2nd IRQ<br>
&gt;=C2=A0 =C2=A0acpi: i386: Move VMBus DSDT entry to SB<br>
&gt; <br>
&gt;=C2=A0 hw/hyperv/vmbus.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 3 +--<br>
&gt;=C2=A0 hw/i386/acpi-build.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 16 ++++++++--------<br>
&gt;=C2=A0 include/hw/hyperv/vmbus-bridge.h |=C2=A0 3 +--<br>
&gt;=C2=A0 3 files changed, 10 insertions(+), 12 deletions(-)<br>
&gt; <br>
<br>
</blockquote></div>

--00000000000068279305aa54b4ff--

