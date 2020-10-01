Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7154DC4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 13:03:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0C5C2075F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 13:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="c/GxFBNK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0C5C2075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNyEy-0001U1-At
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 09:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kNyDu-00012Y-2V
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 09:02:14 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53387)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kNyDo-0005FY-Dq
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 09:02:13 -0400
Received: by mail-wm1-x342.google.com with SMTP id x23so2818799wmi.3
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 06:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZKdhxhSHBy82moCtAfNox32R86O5F0qKR+rJyrNJK+w=;
 b=c/GxFBNKl9ItBWYYlmlfGO1nzJbdg7rPdxJn5FOANE7/wxaQZzUiu8fhUVcBfXOuNU
 Zm0dfAZ4oPcHcXWxGvlrwtn4Izo39cAIpo0mZtoUPRWBpDUukO6rLzIZ3IGu+AtFFwVX
 tzMk90piOPZSmPeEbJL/JiPs+FDHSANCvAVSltUKLpnBTMewWHRmMndrlkmeXWsJ3H2P
 kF/N0ZzWbfkSgUsVxRYbYs+xapGIZoSRf6sn7km7gK+z8CBX6NJ+wu/lv6R59AJVgkYb
 NM9rxOqHsPeq2xNHUT7WWhyTxiYFGev5A5K/nWs+7YhZ/4m8R1kVl9wWmAGtEv3Vzosu
 gSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZKdhxhSHBy82moCtAfNox32R86O5F0qKR+rJyrNJK+w=;
 b=j88oYg45CYrNJbmZvfYXVVBtV+2rT9Yb/l0lJgQUslxOmLCccNllwT4IEhP7CDTjYh
 MGdwdMT91X3WEUMVezKWiTrhGQ8PxfVt/WNFFyXtF+dEPQBFroq+pEsuJojLUxKrC2G3
 t40Fmw+ZS0HTJznzrG0DhyTypgcxskuR0Ms5+C4i23v//lb9E2qxHbey0q4QYY4b8Q4Q
 2vmNL9Jy3mSvQSdfEYRdzLCdMoUL7uo2KlLTz7H4PwT/xjGaCRSfSyWKNrWDbl9rAgUv
 tTBw5Y1RW5K6TGWHIKc0S4f277mgFsbt5v+GcyT3jcx30MB3RTicUao5UAv8DaWZcwkV
 q/7A==
X-Gm-Message-State: AOAM531uhgkd+G0nh30mmVrq+i8dHU6VjSMsBiJNxKOAnPXfjY7V+oFQ
 MQAcqJs6XtJIkFVhU/FuIRd7zQsiHuAvN5ChoZN9eA==
X-Google-Smtp-Source: ABdhPJwIHWDHH9MLLbNVtVMiAd2TjbDq4BzlSNbIRrjUYWN0xjzIoXCSfiJFvepjlIHNGv7LwQ8Tjyar89Fh1lO6oTo=
X-Received: by 2002:a1c:7405:: with SMTP id p5mr8421074wmc.35.1601557326768;
 Thu, 01 Oct 2020 06:02:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200924070013.165026-1-jusual@redhat.com>
 <20200924050236-mutt-send-email-mst@kernel.org>
 <CAMDeoFU_ZO7UxQsz-tvA6WsFm2qK755W5guGoVHfVs55Gb7aUg@mail.gmail.com>
 <20201001073823-mutt-send-email-mst@kernel.org>
In-Reply-To: <20201001073823-mutt-send-email-mst@kernel.org>
From: Ani Sinha <ani@anisinha.ca>
Date: Thu, 1 Oct 2020 18:31:54 +0530
Message-ID: <CAARzgwyGm=U4hN0XGuuh=CeBaJN=MYHDmKPOOWEr6rHCsYF_hA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/7] Use ACPI PCI hot-plug for Q35
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000008cc3ad05b09b9f4c"
Received-SPF: none client-ip=2a00:1450:4864:20::342;
 envelope-from=ani@anisinha.ca; helo=mail-wm1-x342.google.com
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
Cc: Igor Mammedov <imammedo@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000008cc3ad05b09b9f4c
Content-Type: text/plain; charset="UTF-8"

On Thu, Oct 1, 2020 at 17:10 Michael S. Tsirkin <mst@redhat.com> wrote:

> On Thu, Oct 01, 2020 at 10:55:35AM +0200, Julia Suvorova wrote:
> > On Thu, Sep 24, 2020 at 11:20 AM Michael S. Tsirkin <mst@redhat.com>
> wrote:
> > >
> > > On Thu, Sep 24, 2020 at 09:00:06AM +0200, Julia Suvorova wrote:
> > > > The patch set consists of two parts:
> > > > patches 1-4: introduce new feature
> > > >              'acpi-pci-hotplug-with-bridge-support' on Q35
> > > > patches 5-7: make the feature default along with changes in ACPI
> tables
> > > >
> > > > This way maintainers can decide which way to choose without breaking
> > > > the patch set.
> > > >
> > > > With the feature disabled Q35 falls back to the native hot-plug.
> > > >
> > > > Pros
> > > >     * no racy behavior during boot (see 110c477c2ed)
> > > >     * eject is possible - according to PCIe spec, attention button
> > > >       press should lead to power off, and then the adapter should be
> > > >       removed manually. As there is no power down state exists in
> QEMU,
> > > >       we cannot distinguish between an eject and a power down
> > > >       request.
> > > >     * no delay during deleting - after the actual power off software
> > > >       must wait at least 1 second before indicating about it. This
> case
> > > >       is quite important for users, it even has its own bug:
> > > >           https://bugzilla.redhat.com/show_bug.cgi?id=1594168
> > > >     * no timer-based behavior - in addition to the previous example,
> > > >       the attention button has a 5-second waiting period, during
> which
> > > >       the operation can be canceled with a second press. While this
> > > >       looks fine for manual button control, automation will result in
> > > >       the need to queue or drop events, and the software receiving
> > > >       events in all sort of unspecified combinations of
> attention/power
> > > >       indicator states, which is racy and uppredictable.
> > > >     * fixes:
> > > >         * https://bugzilla.redhat.com/show_bug.cgi?id=1752465
> > > >         * https://bugzilla.redhat.com/show_bug.cgi?id=1690256
> > > >
> > > > Cons:
> > > >     * lose per-port control over hot-plug (can be resolved)
> > > >     * no access to possible features presented in slot capabilities
> > > >       (this is only surprise removal AFAIK)
> > >
> > > something I don't quite get is whether with this one can still add
> > > new pcie bridges and then hotplug into these with native
> > > hotplug.
> >
> > Right now I disable native if there is acpihp anywhere, but even if
> > you enable it for hotplugged devices, native hot-plug will not work.
>
> So that's a minor regression in functionality, right?
> Why is that the case? Because you disable it in ACPI?
> What if we don't?


Stupid question. If both native and acpi is enabled which one does OS
chose? Does this choice vary between OSes and different flavours of the
same OS like Windows?


>
> > > the challenge to answering this with certainty is that right now qemu
> > > does not allow hotplugging complex devices such as bridges at all,
> > > we only have a hack for multifunction devices.
> > > Maybe adding a bridge as function 1 on command line, then hotplugging
> another device as
> > > function 0 will work to test this.
> > >
> > >
> > >
> > > > v3:
> > > >     * drop change of _OSC to allow SHPC on hotplugged bridges
> > > >     * use 'acpi-root-pci-hotplug'
> > > >     * add migration states [Igor]
> > > >     * minor style changes
> > > >
> > > > v2:
> > > >     * new ioport range for acpiphp [Gerd]
> > > >     * drop find_pci_host() [Igor]
> > > >     * explain magic numbers in _OSC [Igor]
> > > >     * drop build_q35_pci_hotplug() wrapper [Igor]
> > > >
> > > > Julia Suvorova (7):
> > > >   hw/acpi/pcihp: Enhance acpi_pcihp_disable_root_bus() to support Q35
> > > >   hw/i386/acpi-build: Add ACPI PCI hot-plug methods to Q35
> > > >   hw/pci/pcie: Do not initialize slot capability if acpihp is used
> > > >   hw/acpi/ich9: Enable ACPI PCI hot-plug
> > > >   bios-tables-test: Allow changes in DSDT ACPI tables
> > > >   hw/acpi/ich9: Set ACPI PCI hot-plug as default
> > > >   bios-tables-test: Update golden binaries
> > > >
> > > >  hw/i386/acpi-build.h              |   7 ++++
> > > >  include/hw/acpi/ich9.h            |   5 +++
> > > >  include/hw/acpi/pcihp.h           |   3 +-
> > > >  hw/acpi/ich9.c                    |  67
> ++++++++++++++++++++++++++++++
> > > >  hw/acpi/pcihp.c                   |  16 ++++---
> > > >  hw/acpi/piix4.c                   |   4 +-
> > > >  hw/i386/acpi-build.c              |  31 ++++++++------
> > > >  hw/i386/pc.c                      |   1 +
> > > >  hw/pci/pcie.c                     |  16 +++++++
> > > >  tests/data/acpi/q35/DSDT          | Bin 7678 -> 7950 bytes
> > > >  tests/data/acpi/q35/DSDT.acpihmat | Bin 9002 -> 9274 bytes
> > > >  tests/data/acpi/q35/DSDT.bridge   | Bin 7695 -> 9865 bytes
> > > >  tests/data/acpi/q35/DSDT.cphp     | Bin 8141 -> 8413 bytes
> > > >  tests/data/acpi/q35/DSDT.dimmpxm  | Bin 9331 -> 9603 bytes
> > > >  tests/data/acpi/q35/DSDT.ipmibt   | Bin 7753 -> 8025 bytes
> > > >  tests/data/acpi/q35/DSDT.memhp    | Bin 9037 -> 9309 bytes
> > > >  tests/data/acpi/q35/DSDT.mmio64   | Bin 8808 -> 9080 bytes
> > > >  tests/data/acpi/q35/DSDT.numamem  | Bin 7684 -> 7956 bytes
> > > >  tests/data/acpi/q35/DSDT.tis      | Bin 8283 -> 8555 bytes
> > > >  19 files changed, 129 insertions(+), 21 deletions(-)
> > > >
> > > > --
> > > > 2.25.4
> > >
>
>

--0000000000008cc3ad05b09b9f4c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><br></div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Thu, Oct 1, 2020 at 17:10 Michael S. Tsirkin &lt;<a href=
=3D"mailto:mst@redhat.com">mst@redhat.com</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-widt=
h:1px;border-left-style:solid;padding-left:1ex;border-left-color:rgb(204,20=
4,204)">On Thu, Oct 01, 2020 at 10:55:35AM +0200, Julia Suvorova wrote:<br>
&gt; On Thu, Sep 24, 2020 at 11:20 AM Michael S. Tsirkin &lt;<a href=3D"mai=
lto:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; On Thu, Sep 24, 2020 at 09:00:06AM +0200, Julia Suvorova wrote:<b=
r>
&gt; &gt; &gt; The patch set consists of two parts:<br>
&gt; &gt; &gt; patches 1-4: introduce new feature<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;acpi-pc=
i-hotplug-with-bridge-support&#39; on Q35<br>
&gt; &gt; &gt; patches 5-7: make the feature default along with changes in =
ACPI tables<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; This way maintainers can decide which way to choose without =
breaking<br>
&gt; &gt; &gt; the patch set.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; With the feature disabled Q35 falls back to the native hot-p=
lug.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Pros<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0* no racy behavior during boot (see 110c4=
77c2ed)<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0* eject is possible - according to PCIe s=
pec, attention button<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0press should lead to power off, an=
d then the adapter should be<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0removed manually. As there is no p=
ower down state exists in QEMU,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0we cannot distinguish between an e=
ject and a power down<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0request.<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0* no delay during deleting - after the ac=
tual power off software<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0must wait at least 1 second before=
 indicating about it. This case<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0is quite important for users, it e=
ven has its own bug:<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://b=
ugzilla.redhat.com/show_bug.cgi?id=3D1594168" rel=3D"noreferrer" target=3D"=
_blank">https://bugzilla.redhat.com/show_bug.cgi?id=3D1594168</a><br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0* no timer-based behavior - in addition t=
o the previous example,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0the attention button has a 5-secon=
d waiting period, during which<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0the operation can be canceled with=
 a second press. While this<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0looks fine for manual button contr=
ol, automation will result in<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0the need to queue or drop events, =
and the software receiving<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0events in all sort of unspecified =
combinations of attention/power<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0indicator states, which is racy an=
d uppredictable.<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0* fixes:<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* <a href=3D"https://bugzil=
la.redhat.com/show_bug.cgi?id=3D1752465" rel=3D"noreferrer" target=3D"_blan=
k">https://bugzilla.redhat.com/show_bug.cgi?id=3D1752465</a><br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* <a href=3D"https://bugzil=
la.redhat.com/show_bug.cgi?id=3D1690256" rel=3D"noreferrer" target=3D"_blan=
k">https://bugzilla.redhat.com/show_bug.cgi?id=3D1690256</a><br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Cons:<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0* lose per-port control over hot-plug (ca=
n be resolved)<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0* no access to possible features presente=
d in slot capabilities<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0(this is only surprise removal AFA=
IK)<br>
&gt; &gt;<br>
&gt; &gt; something I don&#39;t quite get is whether with this one can stil=
l add<br>
&gt; &gt; new pcie bridges and then hotplug into these with native<br>
&gt; &gt; hotplug.<br>
&gt; <br>
&gt; Right now I disable native if there is acpihp anywhere, but even if<br=
>
&gt; you enable it for hotplugged devices, native hot-plug will not work.<b=
r>
<br>
So that&#39;s a minor regression in functionality, right?<br>
Why is that the case? Because you disable it in ACPI?<br>
What if we don&#39;t?</blockquote><div dir=3D"auto"><br></div><div dir=3D"a=
uto">Stupid question. If both native and acpi is enabled which one does OS =
chose? Does this choice vary between OSes and different flavours of the sam=
e OS like Windows?</div><div dir=3D"auto"><br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-l=
eft-style:solid;padding-left:1ex;border-left-color:rgb(204,204,204)" dir=3D=
"auto"><br>
<br>
&gt; &gt; the challenge to answering this with certainty is that right now =
qemu<br>
&gt; &gt; does not allow hotplugging complex devices such as bridges at all=
,<br>
&gt; &gt; we only have a hack for multifunction devices.<br>
&gt; &gt; Maybe adding a bridge as function 1 on command line, then hotplug=
ging another device as<br>
&gt; &gt; function 0 will work to test this.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; &gt; v3:<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0* drop change of _OSC to allow SHPC on ho=
tplugged bridges<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0* use &#39;acpi-root-pci-hotplug&#39;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0* add migration states [Igor]<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0* minor style changes<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; v2:<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0* new ioport range for acpiphp [Gerd]<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0* drop find_pci_host() [Igor]<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0* explain magic numbers in _OSC [Igor]<br=
>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0* drop build_q35_pci_hotplug() wrapper [I=
gor]<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Julia Suvorova (7):<br>
&gt; &gt; &gt;=C2=A0 =C2=A0hw/acpi/pcihp: Enhance acpi_pcihp_disable_root_b=
us() to support Q35<br>
&gt; &gt; &gt;=C2=A0 =C2=A0hw/i386/acpi-build: Add ACPI PCI hot-plug method=
s to Q35<br>
&gt; &gt; &gt;=C2=A0 =C2=A0hw/pci/pcie: Do not initialize slot capability i=
f acpihp is used<br>
&gt; &gt; &gt;=C2=A0 =C2=A0hw/acpi/ich9: Enable ACPI PCI hot-plug<br>
&gt; &gt; &gt;=C2=A0 =C2=A0bios-tables-test: Allow changes in DSDT ACPI tab=
les<br>
&gt; &gt; &gt;=C2=A0 =C2=A0hw/acpi/ich9: Set ACPI PCI hot-plug as default<b=
r>
&gt; &gt; &gt;=C2=A0 =C2=A0bios-tables-test: Update golden binaries<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 hw/i386/acpi-build.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 |=C2=A0 =C2=A07 ++++<br>
&gt; &gt; &gt;=C2=A0 include/hw/acpi/ich9.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A05 +++<br>
&gt; &gt; &gt;=C2=A0 include/hw/acpi/pcihp.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A03 +-<br>
&gt; &gt; &gt;=C2=A0 hw/acpi/ich9.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 67 ++++++++++++++++++++++++++++++<b=
r>
&gt; &gt; &gt;=C2=A0 hw/acpi/pcihp.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 16 ++++---<br>
&gt; &gt; &gt;=C2=A0 hw/acpi/piix4.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +-<br>
&gt; &gt; &gt;=C2=A0 hw/i386/acpi-build.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 |=C2=A0 31 ++++++++------<br>
&gt; &gt; &gt;=C2=A0 hw/i386/pc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt; &gt; &gt;=C2=A0 hw/pci/pcie.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 16 +++++++<br>
&gt; &gt; &gt;=C2=A0 tests/data/acpi/q35/DSDT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | Bin 7678 -&gt; 7950 bytes<br>
&gt; &gt; &gt;=C2=A0 tests/data/acpi/q35/DSDT.acpihmat | Bin 9002 -&gt; 927=
4 bytes<br>
&gt; &gt; &gt;=C2=A0 tests/data/acpi/q35/DSDT.bridge=C2=A0 =C2=A0| Bin 7695=
 -&gt; 9865 bytes<br>
&gt; &gt; &gt;=C2=A0 tests/data/acpi/q35/DSDT.cphp=C2=A0 =C2=A0 =C2=A0| Bin=
 8141 -&gt; 8413 bytes<br>
&gt; &gt; &gt;=C2=A0 tests/data/acpi/q35/DSDT.dimmpxm=C2=A0 | Bin 9331 -&gt=
; 9603 bytes<br>
&gt; &gt; &gt;=C2=A0 tests/data/acpi/q35/DSDT.ipmibt=C2=A0 =C2=A0| Bin 7753=
 -&gt; 8025 bytes<br>
&gt; &gt; &gt;=C2=A0 tests/data/acpi/q35/DSDT.memhp=C2=A0 =C2=A0 | Bin 9037=
 -&gt; 9309 bytes<br>
&gt; &gt; &gt;=C2=A0 tests/data/acpi/q35/DSDT.mmio64=C2=A0 =C2=A0| Bin 8808=
 -&gt; 9080 bytes<br>
&gt; &gt; &gt;=C2=A0 tests/data/acpi/q35/DSDT.numamem=C2=A0 | Bin 7684 -&gt=
; 7956 bytes<br>
&gt; &gt; &gt;=C2=A0 tests/data/acpi/q35/DSDT.tis=C2=A0 =C2=A0 =C2=A0 | Bin=
 8283 -&gt; 8555 bytes<br>
&gt; &gt; &gt;=C2=A0 19 files changed, 129 insertions(+), 21 deletions(-)<b=
r>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; --<br>
&gt; &gt; &gt; 2.25.4<br>
&gt; &gt;<br>
<br>
</blockquote></div></div>

--0000000000008cc3ad05b09b9f4c--

