Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D628C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:20:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55AD420848
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="kfd1z8EY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55AD420848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO1K4-0004vU-TF
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 12:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kO1BU-0003S8-Fm
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 12:11:56 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33862)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kO1BJ-0000dB-Os
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 12:11:55 -0400
Received: by mail-wr1-x443.google.com with SMTP id t10so6480718wrv.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 09:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sDNvrHl40KQkTb1i4J0h8K5tG1fD+O84HIi5cqv91iY=;
 b=kfd1z8EYVLs9Qyp1CdH3oyNYScX4pq7c7uZQXGFez04DcY3RGIbgzZxJ/0EWBiX+sc
 UkHF9XUaf8Tw+OmE8gKMgJZV21WxM+rEF7KmtUe7bFSNfRMXoMBmmBakqXGOzLV0zSdP
 SWUSmZoTB5E+ANdfOrWWXGJoisaFt+P1jc0K1zVP1THzyc8lAns+q9C2SXAacvv8A6r/
 3RTDJwYFQB5P/PESdGWNiqHonM+yuSZmGMzt6YJw9V8RASR/vGPcmpolursoU+x1n00/
 RF2MLZTLsAbwSPBKezAZFU5xdSDsQVm+Rw89gY7q0bas7VNmiiC4Ga+j/FI+7Tjdw/ID
 YOEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sDNvrHl40KQkTb1i4J0h8K5tG1fD+O84HIi5cqv91iY=;
 b=F3N7YRySUzuU0XToY57XzZfp2zWZoHlOl0lqGGPLdZyqcDYuojzpgTz5j59b9um6wi
 PgGsCvN5lu+e+LIA6hv0p1iYon7MyMF0FxEPpd+Rvysv92Z14wdOyZeMFHAb3WS84+Nc
 lXo1phx92SVK9l91oCVJRbp7WMehVkgUamiOf/f5d1UKBJSyU2KGvSJeubFk+q/t62YC
 hKRJ1q6rX0tWKWePhBd861onrRY1sLq9XzDW1y7yWB6qmjYiZw+pO8y5uZipOoxrvJ3d
 cxYc9A6KAo/RSkTL463IgNTbpeNPVVpuniN/3STfluOGRljDxr2Fmx+87aGjLXA762e9
 hrNg==
X-Gm-Message-State: AOAM533xZt7D2HkRkSv9Un8DVi7AqDPft4slWYTqkFdn/3qZlbBpYCrO
 Y4qRhb3BzNcAkpI/6fCNYgVxUrbb7JuCAoNlwu3Flw==
X-Google-Smtp-Source: ABdhPJz1craxprkEThfO8tQ0AXwb6NBWe535MOI26da1FIhOA45j7H9Ynkowpa+1uHb6XDl0RJaAxlywzb/HX8BGLgM=
X-Received: by 2002:adf:e410:: with SMTP id g16mr9782640wrm.76.1601568700665; 
 Thu, 01 Oct 2020 09:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200924070013.165026-1-jusual@redhat.com>
 <20200924050236-mutt-send-email-mst@kernel.org>
 <CAMDeoFU_ZO7UxQsz-tvA6WsFm2qK755W5guGoVHfVs55Gb7aUg@mail.gmail.com>
 <20201001073823-mutt-send-email-mst@kernel.org>
 <CAMDeoFXCApc0zqeXc9AO8smJgLk4EvZA7XdL-dsN9HZTJa4MDA@mail.gmail.com>
In-Reply-To: <CAMDeoFXCApc0zqeXc9AO8smJgLk4EvZA7XdL-dsN9HZTJa4MDA@mail.gmail.com>
From: Ani Sinha <ani@anisinha.ca>
Date: Thu, 1 Oct 2020 21:41:29 +0530
Message-ID: <CAARzgwxL1dftrvjacWcDufv15qg-Pqv42Xhu5puAw2FSQnEoYA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/7] Use ACPI PCI hot-plug for Q35
To: Julia Suvorova <jusual@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000007ca8d605b09e45c1"
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000007ca8d605b09e45c1
Content-Type: text/plain; charset="UTF-8"

On Thu, Oct 1, 2020 at 9:24 PM Julia Suvorova <jusual@redhat.com> wrote:

> On Thu, Oct 1, 2020 at 1:40 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> >
>
> > On Thu, Oct 01, 2020 at 10:55:35AM +0200, Julia Suvorova wrote:
>
> > > On Thu, Sep 24, 2020 at 11:20 AM Michael S. Tsirkin <mst@redhat.com>
> wrote:
>
> > > >
>
> > > > On Thu, Sep 24, 2020 at 09:00:06AM +0200, Julia Suvorova wrote:
>
> > > > > The patch set consists of two parts:
>
> > > > > patches 1-4: introduce new feature
>
> > > > >              'acpi-pci-hotplug-with-bridge-support' on Q35
>
> > > > > patches 5-7: make the feature default along with changes in ACPI
> tables
>
> > > > >
>
> > > > > This way maintainers can decide which way to choose without
> breaking
>
> > > > > the patch set.
>
> > > > >
>
> > > > > With the feature disabled Q35 falls back to the native hot-plug.
>
> > > > >
>
> > > > > Pros
>
> > > > >     * no racy behavior during boot (see 110c477c2ed)
>
> > > > >     * eject is possible - according to PCIe spec, attention button
>
> > > > >       press should lead to power off, and then the adapter should
> be
>
> > > > >       removed manually. As there is no power down state exists in
> QEMU,
>
> > > > >       we cannot distinguish between an eject and a power down
>
> > > > >       request.
>
> > > > >     * no delay during deleting - after the actual power off
> software
>
> > > > >       must wait at least 1 second before indicating about it. This
> case
>
> > > > >       is quite important for users, it even has its own bug:
>
> > > > >           https://bugzilla.redhat.com/show_bug.cgi?id=1594168
>
> > > > >     * no timer-based behavior - in addition to the previous
> example,
>
> > > > >       the attention button has a 5-second waiting period, during
> which
>
> > > > >       the operation can be canceled with a second press. While this
>
> > > > >       looks fine for manual button control, automation will result
> in
>
> > > > >       the need to queue or drop events, and the software receiving
>
> > > > >       events in all sort of unspecified combinations of
> attention/power
>
> > > > >       indicator states, which is racy and uppredictable.
>
> > > > >     * fixes:
>
> > > > >         * https://bugzilla.redhat.com/show_bug.cgi?id=1752465
>
> > > > >         * https://bugzilla.redhat.com/show_bug.cgi?id=1690256
>
> > > > >
>
> > > > > Cons:
>
> > > > >     * lose per-port control over hot-plug (can be resolved)
>
> > > > >     * no access to possible features presented in slot capabilities
>
> > > > >       (this is only surprise removal AFAIK)
>
> > > >
>
> > > > something I don't quite get is whether with this one can still add
>
> > > > new pcie bridges and then hotplug into these with native
>
> > > > hotplug.
>
> > >
>
> > > Right now I disable native if there is acpihp anywhere, but even if
>
> > > you enable it for hotplugged devices, native hot-plug will not work.
>
> >
>
> > So that's a minor regression in functionality, right?
>
> > Why is that the case? Because you disable it in ACPI?
>
> > What if we don't?
>
>
>
> I meant that I disable slot hotplug capabilities, nothing in ACPI
>
> prevents native from working. Actually, I don't see if there's any
>
> regression at all. Configurations like hot-plugging downstream port or
>
> switch to another downstream port haven't worked before, and they
>
> don't work now. I can enable native for hotplugged bridges, but that
>
> doesn't make sense, because you won't be able to hot-plug anything to
>
> it.


Why is that?

It's not an issue of ACPI, it's PCIe behaviour. Also, native-acpi
>
> combination may seem bizarre to os (slot enumeration is independent,
>
> that's why I suggested disabling pcie slot flags).
>
>
>
> > > > the challenge to answering this with certainty is that right now qemu
>
> > > > does not allow hotplugging complex devices such as bridges at all,
>
> > > > we only have a hack for multifunction devices.
>
> > > > Maybe adding a bridge as function 1 on command line, then
> hotplugging another device as
>
> > > > function 0 will work to test this.
>
> > > >
>
> > > >
>
> > > >
>
> > > > > v3:
>
> > > > >     * drop change of _OSC to allow SHPC on hotplugged bridges
>
> > > > >     * use 'acpi-root-pci-hotplug'
>
> > > > >     * add migration states [Igor]
>
> > > > >     * minor style changes
>
> > > > >
>
> > > > > v2:
>
> > > > >     * new ioport range for acpiphp [Gerd]
>
> > > > >     * drop find_pci_host() [Igor]
>
> > > > >     * explain magic numbers in _OSC [Igor]
>
> > > > >     * drop build_q35_pci_hotplug() wrapper [Igor]
>
> > > > >
>
> > > > > Julia Suvorova (7):
>
> > > > >   hw/acpi/pcihp: Enhance acpi_pcihp_disable_root_bus() to support
> Q35
>
> > > > >   hw/i386/acpi-build: Add ACPI PCI hot-plug methods to Q35
>
> > > > >   hw/pci/pcie: Do not initialize slot capability if acpihp is used
>
> > > > >   hw/acpi/ich9: Enable ACPI PCI hot-plug
>
> > > > >   bios-tables-test: Allow changes in DSDT ACPI tables
>
> > > > >   hw/acpi/ich9: Set ACPI PCI hot-plug as default
>
> > > > >   bios-tables-test: Update golden binaries
>
> > > > >
>
> > > > >  hw/i386/acpi-build.h              |   7 ++++
>
> > > > >  include/hw/acpi/ich9.h            |   5 +++
>
> > > > >  include/hw/acpi/pcihp.h           |   3 +-
>
> > > > >  hw/acpi/ich9.c                    |  67
> ++++++++++++++++++++++++++++++
>
> > > > >  hw/acpi/pcihp.c                   |  16 ++++---
>
> > > > >  hw/acpi/piix4.c                   |   4 +-
>
> > > > >  hw/i386/acpi-build.c              |  31 ++++++++------
>
> > > > >  hw/i386/pc.c                      |   1 +
>
> > > > >  hw/pci/pcie.c                     |  16 +++++++
>
> > > > >  tests/data/acpi/q35/DSDT          | Bin 7678 -> 7950 bytes
>
> > > > >  tests/data/acpi/q35/DSDT.acpihmat | Bin 9002 -> 9274 bytes
>
> > > > >  tests/data/acpi/q35/DSDT.bridge   | Bin 7695 -> 9865 bytes
>
> > > > >  tests/data/acpi/q35/DSDT.cphp     | Bin 8141 -> 8413 bytes
>
> > > > >  tests/data/acpi/q35/DSDT.dimmpxm  | Bin 9331 -> 9603 bytes
>
> > > > >  tests/data/acpi/q35/DSDT.ipmibt   | Bin 7753 -> 8025 bytes
>
> > > > >  tests/data/acpi/q35/DSDT.memhp    | Bin 9037 -> 9309 bytes
>
> > > > >  tests/data/acpi/q35/DSDT.mmio64   | Bin 8808 -> 9080 bytes
>
> > > > >  tests/data/acpi/q35/DSDT.numamem  | Bin 7684 -> 7956 bytes
>
> > > > >  tests/data/acpi/q35/DSDT.tis      | Bin 8283 -> 8555 bytes
>
> > > > >  19 files changed, 129 insertions(+), 21 deletions(-)
>
> > > > >
>
> > > > > --
>
> > > > > 2.25.4
>
> > > >
>
> >
>
>
>
>

--0000000000007ca8d605b09e45c1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><br></div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Thu, Oct 1, 2020 at 9:24 PM Julia Suvorova &lt;<a href=
=3D"mailto:jusual@redhat.com">jusual@redhat.com</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t-width:1px;border-left-style:solid;padding-left:1ex;border-left-color:rgb(=
204,204,204)">On Thu, Oct 1, 2020 at 1:40 PM Michael S. Tsirkin &lt;<a href=
=3D"mailto:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&gt; wrote:<=
br><br>&gt;<br><br>&gt; On Thu, Oct 01, 2020 at 10:55:35AM +0200, Julia Suv=
orova wrote:<br><br>&gt; &gt; On Thu, Sep 24, 2020 at 11:20 AM Michael S. T=
sirkin &lt;<a href=3D"mailto:mst@redhat.com" target=3D"_blank">mst@redhat.c=
om</a>&gt; wrote:<br><br>&gt; &gt; &gt;<br><br>&gt; &gt; &gt; On Thu, Sep 2=
4, 2020 at 09:00:06AM +0200, Julia Suvorova wrote:<br><br>&gt; &gt; &gt; &g=
t; The patch set consists of two parts:<br><br>&gt; &gt; &gt; &gt; patches =
1-4: introduce new feature<br><br>&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;acpi-pci-hotplug-with-bridge-support&#39; =
on Q35<br><br>&gt; &gt; &gt; &gt; patches 5-7: make the feature default alo=
ng with changes in ACPI tables<br><br>&gt; &gt; &gt; &gt;<br><br>&gt; &gt; =
&gt; &gt; This way maintainers can decide which way to choose without break=
ing<br><br>&gt; &gt; &gt; &gt; the patch set.<br><br>&gt; &gt; &gt; &gt;<br=
><br>&gt; &gt; &gt; &gt; With the feature disabled Q35 falls back to the na=
tive hot-plug.<br><br>&gt; &gt; &gt; &gt;<br><br>&gt; &gt; &gt; &gt; Pros<b=
r><br>&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0* no racy behavior during boot=
 (see 110c477c2ed)<br><br>&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0* eject is=
 possible - according to PCIe spec, attention button<br><br>&gt; &gt; &gt; =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0press should lead to power off, and then the=
 adapter should be<br><br>&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rem=
oved manually. As there is no power down state exists in QEMU,<br><br>&gt; =
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0we cannot distinguish between an e=
ject and a power down<br><br>&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0=
request.<br><br>&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0* no delay during de=
leting - after the actual power off software<br><br>&gt; &gt; &gt; &gt;=C2=
=A0 =C2=A0 =C2=A0 =C2=A0must wait at least 1 second before indicating about=
 it. This case<br><br>&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0is quit=
e important for users, it even has its own bug:<br><br>&gt; &gt; &gt; &gt;=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://bugzilla.redhat=
.com/show_bug.cgi?id=3D1594168" rel=3D"noreferrer" target=3D"_blank">https:=
//bugzilla.redhat.com/show_bug.cgi?id=3D1594168</a><br><br>&gt; &gt; &gt; &=
gt;=C2=A0 =C2=A0 =C2=A0* no timer-based behavior - in addition to the previ=
ous example,<br><br>&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0the atten=
tion button has a 5-second waiting period, during which<br><br>&gt; &gt; &g=
t; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0the operation can be canceled with a seco=
nd press. While this<br><br>&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0l=
ooks fine for manual button control, automation will result in<br><br>&gt; =
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0the need to queue or drop events, =
and the software receiving<br><br>&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0events in all sort of unspecified combinations of attention/power<br>=
<br>&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0indicator states, which i=
s racy and uppredictable.<br><br>&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0* f=
ixes:<br><br>&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* <a href=
=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D1752465" rel=3D"noreferre=
r" target=3D"_blank">https://bugzilla.redhat.com/show_bug.cgi?id=3D1752465<=
/a><br><br>&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* <a href=
=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D1690256" rel=3D"noreferre=
r" target=3D"_blank">https://bugzilla.redhat.com/show_bug.cgi?id=3D1690256<=
/a><br><br>&gt; &gt; &gt; &gt;<br><br>&gt; &gt; &gt; &gt; Cons:<br><br>&gt;=
 &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0* lose per-port control over hot-plug (c=
an be resolved)<br><br>&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0* no access t=
o possible features presented in slot capabilities<br><br>&gt; &gt; &gt; &g=
t;=C2=A0 =C2=A0 =C2=A0 =C2=A0(this is only surprise removal AFAIK)<br><br>&=
gt; &gt; &gt;<br><br>&gt; &gt; &gt; something I don&#39;t quite get is whet=
her with this one can still add<br><br>&gt; &gt; &gt; new pcie bridges and =
then hotplug into these with native<br><br>&gt; &gt; &gt; hotplug.<br><br>&=
gt; &gt;<br><br>&gt; &gt; Right now I disable native if there is acpihp any=
where, but even if<br><br>&gt; &gt; you enable it for hotplugged devices, n=
ative hot-plug will not work.<br><br>&gt;<br><br>&gt; So that&#39;s a minor=
 regression in functionality, right?<br><br>&gt; Why is that the case? Beca=
use you disable it in ACPI?<br><br>&gt; What if we don&#39;t?<br><br><br><b=
r>I meant that I disable slot hotplug capabilities, nothing in ACPI<br><br>=
prevents native from working. Actually, I don&#39;t see if there&#39;s any<=
br><br>regression at all. Configurations like hot-plugging downstream port =
or<br><br>switch to another downstream port haven&#39;t worked before, and =
they<br><br>don&#39;t work now. I can enable native for hotplugged bridges,=
 but that<br><br>doesn&#39;t make sense, because you won&#39;t be able to h=
ot-plug anything to<br><br>it. </blockquote><div dir=3D"auto"><br></div><di=
v dir=3D"auto">Why is that?</div><div dir=3D"auto"><br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px=
;border-left-style:solid;padding-left:1ex;border-left-color:rgb(204,204,204=
)" dir=3D"auto">It&#39;s not an issue of ACPI, it&#39;s PCIe behaviour. Als=
o, native-acpi<br><br>combination may seem bizarre to os (slot enumeration =
is independent,<br><br>that&#39;s why I suggested disabling pcie slot flags=
).<br><br><br><br>&gt; &gt; &gt; the challenge to answering this with certa=
inty is that right now qemu<br><br>&gt; &gt; &gt; does not allow hotpluggin=
g complex devices such as bridges at all,<br><br>&gt; &gt; &gt; we only hav=
e a hack for multifunction devices.<br><br>&gt; &gt; &gt; Maybe adding a br=
idge as function 1 on command line, then hotplugging another device as<br><=
br>&gt; &gt; &gt; function 0 will work to test this.<br><br>&gt; &gt; &gt;<=
br><br>&gt; &gt; &gt;<br><br>&gt; &gt; &gt;<br><br>&gt; &gt; &gt; &gt; v3:<=
br><br>&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0* drop change of _OSC to allo=
w SHPC on hotplugged bridges<br><br>&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0=
* use &#39;acpi-root-pci-hotplug&#39;<br><br>&gt; &gt; &gt; &gt;=C2=A0 =C2=
=A0 =C2=A0* add migration states [Igor]<br><br>&gt; &gt; &gt; &gt;=C2=A0 =
=C2=A0 =C2=A0* minor style changes<br><br>&gt; &gt; &gt; &gt;<br><br>&gt; &=
gt; &gt; &gt; v2:<br><br>&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0* new iopor=
t range for acpiphp [Gerd]<br><br>&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0* =
drop find_pci_host() [Igor]<br><br>&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0*=
 explain magic numbers in _OSC [Igor]<br><br>&gt; &gt; &gt; &gt;=C2=A0 =C2=
=A0 =C2=A0* drop build_q35_pci_hotplug() wrapper [Igor]<br><br>&gt; &gt; &g=
t; &gt;<br><br>&gt; &gt; &gt; &gt; Julia Suvorova (7):<br><br>&gt; &gt; &gt=
; &gt;=C2=A0 =C2=A0hw/acpi/pcihp: Enhance acpi_pcihp_disable_root_bus() to =
support Q35<br><br>&gt; &gt; &gt; &gt;=C2=A0 =C2=A0hw/i386/acpi-build: Add =
ACPI PCI hot-plug methods to Q35<br><br>&gt; &gt; &gt; &gt;=C2=A0 =C2=A0hw/=
pci/pcie: Do not initialize slot capability if acpihp is used<br><br>&gt; &=
gt; &gt; &gt;=C2=A0 =C2=A0hw/acpi/ich9: Enable ACPI PCI hot-plug<br><br>&gt=
; &gt; &gt; &gt;=C2=A0 =C2=A0bios-tables-test: Allow changes in DSDT ACPI t=
ables<br><br>&gt; &gt; &gt; &gt;=C2=A0 =C2=A0hw/acpi/ich9: Set ACPI PCI hot=
-plug as default<br><br>&gt; &gt; &gt; &gt;=C2=A0 =C2=A0bios-tables-test: U=
pdate golden binaries<br><br>&gt; &gt; &gt; &gt;<br><br>&gt; &gt; &gt; &gt;=
=C2=A0 hw/i386/acpi-build.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 |=C2=A0 =C2=A07 ++++<br><br>&gt; &gt; &gt; &gt;=C2=A0 include/hw/acpi/ich9=
.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A05 +++<br><br>&gt;=
 &gt; &gt; &gt;=C2=A0 include/hw/acpi/pcihp.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A03 +-<br><br>&gt; &gt; &gt; &gt;=C2=A0 hw/acpi/ic=
h9.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 67 ++++++++++++++++++++++++++++++<br><br>&gt; &gt; &gt; &gt;=C2=A0 h=
w/acpi/pcihp.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 16 ++++---<br><br>&gt; &gt; &gt; &gt;=C2=A0 hw/acpi/piix4=
.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A04 +-<br><br>&gt; &gt; &gt; &gt;=C2=A0 hw/i386/acpi-build.c=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 31 ++++++++------<br><br>=
&gt; &gt; &gt; &gt;=C2=A0 hw/i386/pc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br><br>&gt; &gt=
; &gt; &gt;=C2=A0 hw/pci/pcie.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 16 +++++++<br><br>&gt; &gt; &gt; =
&gt;=C2=A0 tests/data/acpi/q35/DSDT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Bin=
 7678 -&gt; 7950 bytes<br><br>&gt; &gt; &gt; &gt;=C2=A0 tests/data/acpi/q35=
/DSDT.acpihmat | Bin 9002 -&gt; 9274 bytes<br><br>&gt; &gt; &gt; &gt;=C2=A0=
 tests/data/acpi/q35/DSDT.bridge=C2=A0 =C2=A0| Bin 7695 -&gt; 9865 bytes<br=
><br>&gt; &gt; &gt; &gt;=C2=A0 tests/data/acpi/q35/DSDT.cphp=C2=A0 =C2=A0 =
=C2=A0| Bin 8141 -&gt; 8413 bytes<br><br>&gt; &gt; &gt; &gt;=C2=A0 tests/da=
ta/acpi/q35/DSDT.dimmpxm=C2=A0 | Bin 9331 -&gt; 9603 bytes<br><br>&gt; &gt;=
 &gt; &gt;=C2=A0 tests/data/acpi/q35/DSDT.ipmibt=C2=A0 =C2=A0| Bin 7753 -&g=
t; 8025 bytes<br><br>&gt; &gt; &gt; &gt;=C2=A0 tests/data/acpi/q35/DSDT.mem=
hp=C2=A0 =C2=A0 | Bin 9037 -&gt; 9309 bytes<br><br>&gt; &gt; &gt; &gt;=C2=
=A0 tests/data/acpi/q35/DSDT.mmio64=C2=A0 =C2=A0| Bin 8808 -&gt; 9080 bytes=
<br><br>&gt; &gt; &gt; &gt;=C2=A0 tests/data/acpi/q35/DSDT.numamem=C2=A0 | =
Bin 7684 -&gt; 7956 bytes<br><br>&gt; &gt; &gt; &gt;=C2=A0 tests/data/acpi/=
q35/DSDT.tis=C2=A0 =C2=A0 =C2=A0 | Bin 8283 -&gt; 8555 bytes<br><br>&gt; &g=
t; &gt; &gt;=C2=A0 19 files changed, 129 insertions(+), 21 deletions(-)<br>=
<br>&gt; &gt; &gt; &gt;<br><br>&gt; &gt; &gt; &gt; --<br><br>&gt; &gt; &gt;=
 &gt; 2.25.4<br><br>&gt; &gt; &gt;<br><br>&gt;<br><br><br><br></blockquote>=
</div></div>

--0000000000007ca8d605b09e45c1--

