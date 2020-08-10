Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BDFC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 15:42:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8853620774
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 15:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="cWscLMTg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8853620774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k59wm-00076w-Gx
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 11:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1k59vd-0006fC-AU
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 11:41:37 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:42196)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1k59vZ-0000bP-DE
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 11:41:37 -0400
Received: by mail-pg1-x543.google.com with SMTP id j21so5091093pgi.9
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 08:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:message-id:in-reply-to:references:subject
 :mime-version; bh=4L9h2n3QypO4wp3CxzhzxR9ce4HwBrQeeuLAORhZt8o=;
 b=cWscLMTgcPROJxqMYpyYrPUFeb+ltqw5FX65sMwwV18Q7tiZYezCGEmmeLxGXYlkeN
 EYfPfjk1iK/b8wW9Pub1QTf50T3at2wkqdYw2npoHLK0IpPZt8gtPO8FBmA6B3a0X0rK
 pykfUQlSX7EE4lp2qH8xNNBvkZ+4+ahHf03vMAy6BK6OQf7BxfvFCAdSoSyGcMTekGO7
 CFaORLphnD87pxxtMhrDpGI75vweebPrtlsYNlrQu2HKd1nnjivmN4Fk8nf13j7ZqJdz
 U5S+k4At06ceCV5SbcL3uLSJBkb9gldGSnaQKFzl7l/fCtWblmMS3LHhaPS/eyHCdGSg
 jDyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
 :references:subject:mime-version;
 bh=4L9h2n3QypO4wp3CxzhzxR9ce4HwBrQeeuLAORhZt8o=;
 b=C5J1PhV5R5JcZ2Sz5Ytp/aODcRQRWQOZ2hJhvdDXsPfvRHX5oOixza5L9VAFGPuyvn
 o2pGLrxkQKC24b+4OVCruIFaRg5+geK1rglaFqqpc36zgPxIAlqm0eAPbK3YGYOCiQO2
 sCZPjBnju7iyDvmtkJrtuiFSRJ4UDmFZc79QzPRrS2QgD3t32HAjwxXvl2Pe8r5qkfLj
 8ZYnCCT2W/YDut8Ri0PhIXN1n+a39HMuRcusfZJ7uJ549gSDoshGSNGZKtnGb82uU08M
 KmrlSXJS2NnzrIn0YFIAy3JpwOg4Q8w2YeqHMiOEONa7I9GAyh+Fek6AvaWPK9r2GXfC
 w/Yw==
X-Gm-Message-State: AOAM530N0Z9Q+6lnTnMVL7Y/OLnK1DGiydjwuoW7o9cMx7Xw6s2YPp/2
 G9j/htRz+G3oPMYnz5qyzjBEVw==
X-Google-Smtp-Source: ABdhPJxV9/VbBolHprkCc2s9xTzolfmhxh3pHEXnVr1n4nCnXFNSeqE/tZrGWIEl4sVvBVzGWQqLeQ==
X-Received: by 2002:a65:6384:: with SMTP id h4mr22221030pgv.196.1597074091357; 
 Mon, 10 Aug 2020 08:41:31 -0700 (PDT)
Received: from [192.168.1.4] ([203.163.233.127])
 by smtp.gmail.com with ESMTPSA id t25sm25504042pfl.198.2020.08.10.08.41.25
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Aug 2020 08:41:30 -0700 (PDT)
Date: Mon, 10 Aug 2020 21:11:17 +0530
From: Ani Sinha <ani@anisinha.ca>
To: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <e6a5ef18-948b-43d9-98f4-28a372c72730@Spark>
In-Reply-To: <20200810111827-mutt-send-email-mst@kernel.org>
References: <1597058982-70090-1-git-send-email-ani@anisinha.ca>
 <20200810104602-mutt-send-email-mst@kernel.org>
 <CAARzgwwsuzw9rcQzu3MF7KZO8F+0PHMs3hCsiSPJCXJS-dEkhw@mail.gmail.com>
 <20200810105634-mutt-send-email-mst@kernel.org>
 <e4f24840-880b-4912-b251-b0e0bc9469b8@Spark>
 <20200810111827-mutt-send-email-mst@kernel.org>
Subject: Re: [PATCH] Introduce global piix flag to disable PCI hotplug
X-Readdle-Message-ID: e6a5ef18-948b-43d9-98f4-28a372c72730@Spark
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="5f316aa3_625558ec_43ef"
Received-SPF: none client-ip=2607:f8b0:4864:20::543;
 envelope-from=ani@anisinha.ca; helo=mail-pg1-x543.google.com
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, jusual@redhat.com,
 qemu-devel@nongnu.org, Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--5f316aa3_625558ec_43ef
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


Ani
On Aug 10, 2020, 20:49 +0530, Michael S. Tsirkin <mst=40redhat.com>, wrot=
e:
> On Mon, Aug 10, 2020 at 08:35:56PM +0530, Ani Sinha wrote:
> >
> > Ani
> > On Aug 10, 2020, 20:30 +0530, Michael S. Tsirkin <mst=40redhat.com>, =
wrote:
> >
> > On Mon, Aug 10, 2020 at 08:24:53PM +0530, Ani Sinha wrote:
> >
> >
> >
> >
> >
> > On Mon, Aug 10, 2020 at 8:17 PM Michael S. Tsirkin <mst=40redhat.com>=

> > wrote:
> >
> >
> >
> > On Mon, Aug 10, 2020 at 04:59:41PM +0530, Ani Sinha wrote:
> >
> > We introduce a new global flag for PIIX with which we can
> >
> > turn on or off PCI device hotplug. This flag can be used
> >
> > to prevent all PCI devices from getting hotplugged/unplugged
> >
> > on the PCI bus. The new options disables all hotpluh HW
> >
> > initialization code as well as the ACPI AMLs.
> >
> >
> >
> > Signed-off-by: Ani Sinha <ani=40anisinha.ca>
> >
> >
> >
> > Well we have a flag like this for pci bridges, right=3F
> >
> > So all that's left is an option to disable hotplug
> >
> > for the pci root, right=3F
> >
> > Wouldn't that be better than disabling it globally=3F
> >
> >
> >
> >
> >
> > The idea is to have just one option to disable all hotplug globally.
> > But if you
> >
> > want to have two flags one for the bridges and one for the pci root, =
we
> > can
> >
> > certainly look into it.
> >
> >
> >
> >
> >
> > I can certainly see the attraction of a global flag.
> >
> >
> >
> > However, with the interface we have for bridges right now, how are we=

> >
> > going to resolve the conflict if hotplug is disabled globally but
> >
> > enabled for a given bridge=3F
> >
> >
> >
> > A reasonable way would be to change the default value for bridges,
> >
> > have a user-specified value override it.
> >
> > This patch doesn't do it, though.
> >
> >
> > I think the global option should override the bridge option. So if th=
e global
> > option disables hotplug, the bridge option should be a noop.
> >
>
> Well just ignoring inconsistent user input does not sound great.
> Tends to create support problems.

Then I suggest we take your original idea - have the new option just disa=
ble hotplug on the pci root bus.

This would be cleaner and would introduce less confusion.=C2=A0=C2=A0Also=
 the patch should be simple.
>
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> > ---
> >
> > hw/acpi/piix4.c =7C 8 ++++++--
> >
> > hw/i386/acpi-build.c =7C 20 ++++++++++++++------
> >
> > 2 files changed, 20 insertions(+), 8 deletions(-)
> >
> >
> >
> > diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> >
> > index 26bac4f..8b13e86 100644
> >
> > --- a/hw/acpi/piix4.c
> >
> > +++ b/hw/acpi/piix4.c
> >
> > =40=40 -78,6 +78,7 =40=40 typedef struct PIIX4PMState =7B
> >
> >
> >
> > AcpiPciHpState acpi=5Fpci=5Fhotplug;
> >
> > bool use=5Facpi=5Fhotplug=5Fbridge;
> >
> > + bool use=5Facpi=5Fpci=5Fhotplug;
> >
> >
> >
> > uint8=5Ft disable=5Fs3;
> >
> > uint8=5Ft disable=5Fs4;
> >
> > =40=40 -595,8 +596,9 =40=40 static void piix4=5Facpi=5Fsystem=5Fhot=5F=
add=5Finit
> >
> > (MemoryRegion *parent,
> >
> > =22acpi-gpe0=22, GPE=5FLEN);
> >
> > memory=5Fregion=5Fadd=5Fsubregion(parent, GPE=5FBASE, &s->io=5Fgpe);
> >
> >
> >
> > - acpi=5Fpcihp=5Finit(OBJECT(s), &s->acpi=5Fpci=5Fhotplug, bus, paren=
t,
> >
> > - s->use=5Facpi=5Fhotplug=5Fbridge);
> >
> > + if (s->use=5Facpi=5Fpci=5Fhotplug)
> >
> > + acpi=5Fpcihp=5Finit(OBJECT(s), &s->acpi=5Fpci=5Fhotplug, bus,
> > parent,
> >
> > + s->use=5Facpi=5Fhotplug=5Fbridge);
> >
> >
> >
> > s->cpu=5Fhotplug=5Flegacy =3D true;
> >
> > object=5Fproperty=5Fadd=5Fbool(OBJECT(s), =22cpu-hotplug-legacy=22,
> >
> > =40=40 -635,6 +637,8 =40=40 static Property piix4=5Fpm=5Fproperties=5B=
=5D =3D =7B
> >
> > DE=46INE=5FPROP=5FUINT8(ACPI=5FPM=5FPROP=5FS4=5FVAL, PIIX4PMState, s4=
=5Fval,
> > 2),
> >
> > DE=46INE=5FPROP=5FBOOL(=22acpi-pci-hotplug-with-bridge-support=22,
> >
> > PIIX4PMState,
> >
> > use=5Facpi=5Fhotplug=5Fbridge, true),
> >
> > + DE=46INE=5FPROP=5FBOOL(=22acpi-pci-hotplug=22, PIIX4PMState,
> >
> > + use=5Facpi=5Fpci=5Fhotplug, true),
> >
> > DE=46INE=5FPROP=5FBOOL(=22memory-hotplug-support=22, PIIX4PMState,
> >
> > acpi=5Fmemory=5Fhotplug.is=5Fenabled, true),
> >
> > DE=46INE=5FPROP=5FEND=5FO=46=5FLIST(),
> >
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> >
> > index b7bcbbb..343b9b6 100644
> >
> > --- a/hw/i386/acpi-build.c
> >
> > +++ b/hw/i386/acpi-build.c
> >
> > =40=40 -95,6 +95,7 =40=40 typedef struct AcpiPmInfo =7B
> >
> > bool s3=5Fdisabled;
> >
> > bool s4=5Fdisabled;
> >
> > bool pcihp=5Fbridge=5Fen;
> >
> > + bool pcihp=5Fen;
> >
> > uint8=5Ft s4=5Fval;
> >
> > Acpi=46adtData fadt;
> >
> > uint16=5Ft cpu=5Fhp=5Fio=5Fbase;
> >
> > =40=40 -245,6 +246,9 =40=40 static void acpi=5Fget=5Fpm=5Finfo(Machin=
eState
> > *machine,
> >
> > AcpiPmInfo *pm)
> >
> > pm->pcihp=5Fbridge=5Fen =3D
> >
> > object=5Fproperty=5Fget=5Fbool(obj,
> >
> > =22acpi-pci-hotplug-with-bridge-support=22,
> >
> > NULL);
> >
> > + pm->pcihp=5Fen =3D
> >
> > + object=5Fproperty=5Fget=5Fbool(obj, =22acpi-pci-hotplug=22, NULL);
> >
> > +
> >
> > =7D
> >
> >
> >
> > static void acpi=5Fget=5Fmisc=5Finfo(AcpiMiscInfo *info)
> >
> > =40=40 -337,14 +341,16 =40=40 static void build=5Fappend=5Fpcihp=5Fno=
tify=5Fentry
> > (Aml
> >
> > *method, int slot)
> >
> > =7D
> >
> >
> >
> > static void build=5Fappend=5Fpci=5Fbus=5Fdevices(Aml *parent=5Fscope,=

> > PCIBus *bus,
> >
> > - bool pcihp=5Fbridge=5Fen)
> >
> > + bool pcihp=5Fbridge=5Fen,
> > bool
> >
> > pcihp=5Fen)
> >
> > =7B
> >
> > Aml *dev, *notify=5Fmethod =3D NULL, *method;
> >
> > - QObject *bsel;
> >
> > + QObject *bsel =3D NULL;
> >
> > PCIBus *sec;
> >
> > int i;
> >
> >
> >
> > - bsel =3D object=5Fproperty=5Fget=5Fqobject(OBJECT(bus),
> >
> > ACPI=5FPCIHP=5FPROP=5FBSEL, NULL);
> >
> > + if (pcihp=5Fen)
> >
> > + bsel =3D object=5Fproperty=5Fget=5Fqobject(OBJECT(bus),
> >
> > + ACPI=5FPCIHP=5FPROP=5FBSEL,
> > NULL);
> >
> > if (bsel) =7B
> >
> > uint64=5Ft bsel=5Fval =3D qnum=5Fget=5Fuint(qobject=5Fto(QNum,
> > bsel));
> >
> >
> >
> > =40=40 -439,7 +445,8 =40=40 static void build=5Fappend=5Fpci=5Fbus=5F=
devices(Aml
> >
> > *parent=5Fscope, PCIBus *bus,
> >
> > */
> >
> > PCIBus *sec=5Fbus =3D pci=5Fbridge=5Fget=5Fsec=5Fbus(PCI=5FBRIDGE
> > (pdev));
> >
> >
> >
> > - build=5Fappend=5Fpci=5Fbus=5Fdevices(dev, sec=5Fbus,
> > pcihp=5Fbridge=5Fen);
> >
> > + build=5Fappend=5Fpci=5Fbus=5Fdevices(dev, sec=5Fbus,
> > pcihp=5Fbridge=5Fen,
> >
> > + pcihp=5Fen);
> >
> > =7D
> >
> > /* slot descriptor has been composed, add it into parent
> > context
> >
> > */
> >
> > aml=5Fappend(parent=5Fscope, dev);
> >
> > =40=40 -468,7 +475,7 =40=40 static void build=5Fappend=5Fpci=5Fbus=5F=
devices(Aml
> >
> > *parent=5Fscope, PCIBus *bus,
> >
> > =7D
> >
> >
> >
> > /* Notify about child bus events in any case */
> >
> > - if (pcihp=5Fbridge=5Fen) =7B
> >
> > + if (pcihp=5Fbridge=5Fen && pcihp=5Fen) =7B
> >
> > QLIST=5F=46OREACH(sec, &bus->child, sibling) =7B
> >
> > int32=5Ft devfn =3D sec->parent=5Fdev->devfn;
> >
> >
> >
> > =40=40 -1818,7 +1825,8 =40=40 build=5Fdsdt(GArray *table=5Fdata, BIOS=
Linker
> > *linker,
> >
> > if (bus) =7B
> >
> > Aml *scope =3D aml=5Fscope(=22PCI0=22);
> >
> > /* Scan all PCI buses. Generate tables to support
> > hotplug. *
> >
> > /
> >
> > - build=5Fappend=5Fpci=5Fbus=5Fdevices(scope, bus, pm->
> >
> > pcihp=5Fbridge=5Fen);
> >
> > + build=5Fappend=5Fpci=5Fbus=5Fdevices(scope, bus, pm->
> >
> > pcihp=5Fbridge=5Fen,
> >
> > + pm->pcihp=5Fen);
> >
> >
> >
> > if (TPM=5FIS=5FTIS=5FISA(tpm)) =7B
> >
> > if (misc->tpm=5Fversion =3D=3D TPM=5FVERSION=5F2=5F0) =7B
> >
> > --
> >
> > 2.7.4
> >
> >
> >
> >
> >
> >
> >
>

--5f316aa3_625558ec_43ef
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html xmlns=3D=22http://www.w3.org/1999/xhtml=22>
<head>
<title></title>
</head>
<body>
<div name=3D=22messageSignatureSection=22><br />
Ani</div>
<div name=3D=22messageReplySection=22>
<div dir=3D=22auto=22>On Aug 10, 2020, 20:49 +0530, Michael S. Tsirkin &l=
t;mst=40redhat.com&gt;, wrote:</div>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>On Mon, Aug 10, 2020 at 08:35:56=
PM +0530, Ani Sinha wrote:</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>Ani</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>On Aug 10, 2020, 20:30 +0530, Mi=
chael S. Tsirkin &lt;mst=40redhat.com&gt;, wrote:</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>On Mon, Aug 10, 2020 at 08:24:53=
PM +0530, Ani Sinha wrote:</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>On Mon, Aug 10, 2020 at 8:17 PM =
Michael S. Tsirkin &lt;mst=40redhat.com&gt;</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>wrote:</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>On Mon, Aug 10, 2020 at 04:59:41=
PM +0530, Ani Sinha wrote:</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>We introduce a new global flag f=
or PIIX with which we can</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>turn on or off PCI device hotplu=
g. This flag can be used</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>to prevent all PCI devices from =
getting hotplugged/unplugged</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>on the PCI bus. The new options =
disables all hotpluh HW</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>initialization code as well as t=
he ACPI AMLs.</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>Signed-off-by: Ani Sinha &lt;ani=
=40anisinha.ca&gt;</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>Well we have a flag like this fo=
r pci bridges, right=3F</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>So all that's left is an option =
to disable hotplug</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>for the pci root, right=3F</bloc=
kquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>Wouldn't that be better than dis=
abling it globally=3F</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>The idea is to have just one opt=
ion to disable all hotplug globally.</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>But if you</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>want to have two flags one for t=
he bridges and one for the pci root, we</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>can</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>certainly look into it.</blockqu=
ote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>I can certainly see the attracti=
on of a global flag.</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>However, with the interface we h=
ave for bridges right now, how are we</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>going to resolve the conflict if=
 hotplug is disabled globally but</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>enabled for a given bridge=3F</b=
lockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>A reasonable way would be to cha=
nge the default value for bridges,</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>have a user-specified value over=
ride it.</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>This patch doesn't do it, though=
.</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>I think the global option should=
 override the bridge option. So if the global</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>option disables hotplug, the bri=
dge option should be a noop.</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>Well just ignoring inconsistent =
user input does not sound great.</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>Tends to create support problems=
.</blockquote>
<div dir=3D=22auto=22><br />
Then I suggest we take your original idea - have the new option just disa=
ble hotplug on the pci root bus.<br />
<br />
This would be cleaner and would introduce less confusion.&=23160;&=23160;=
Also the patch should be simple.<br /></div>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>---</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>hw/acpi/piix4.c =7C 8 ++++++--</=
blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>hw/i386/acpi-build.c =7C 20 ++++=
++++++++++------</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>2 files changed, 20 insertions(+=
), 8 deletions(-)</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>diff --git a/hw/acpi/piix4.c b/h=
w/acpi/piix4.c</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>index 26bac4f..8b13e86 100644</b=
lockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>--- a/hw/acpi/piix4.c</blockquot=
e>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+++ b/hw/acpi/piix4.c</blockquot=
e>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=40=40 -78,6 +78,7 =40=40 typede=
f struct PIIX4PMState =7B</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>AcpiPciHpState acpi=5Fpci=5Fhotp=
lug;</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>bool use=5Facpi=5Fhotplug=5Fbrid=
ge;</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ bool use=5Facpi=5Fpci=5Fhotplu=
g;</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>uint8=5Ft disable=5Fs3;</blockqu=
ote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>uint8=5Ft disable=5Fs4;</blockqu=
ote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=40=40 -595,8 +596,9 =40=40 stat=
ic void piix4=5Facpi=5Fsystem=5Fhot=5Fadd=5Finit</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>(MemoryRegion *parent,</blockquo=
te>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=22acpi-gpe0=22, GPE=5FLEN);</bl=
ockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>memory=5Fregion=5Fadd=5Fsubregio=
n(parent, GPE=5FBASE, &amp;s-&gt;io=5Fgpe);</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>- acpi=5Fpcihp=5Finit(OBJECT(s),=
 &amp;s-&gt;acpi=5Fpci=5Fhotplug, bus, parent,</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>- s-&gt;use=5Facpi=5Fhotplug=5Fb=
ridge);</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ if (s-&gt;use=5Facpi=5Fpci=5Fh=
otplug)</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ acpi=5Fpcihp=5Finit(OBJECT(s),=
 &amp;s-&gt;acpi=5Fpci=5Fhotplug, bus,</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>parent,</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ s-&gt;use=5Facpi=5Fhotplug=5Fb=
ridge);</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>s-&gt;cpu=5Fhotplug=5Flegacy =3D=
 true;</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>object=5Fproperty=5Fadd=5Fbool(O=
BJECT(s), =22cpu-hotplug-legacy=22,</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=40=40 -635,6 +637,8 =40=40 stat=
ic Property piix4=5Fpm=5Fproperties=5B=5D =3D =7B</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>DE=46INE=5FPROP=5FUINT8(ACPI=5FP=
M=5FPROP=5FS4=5FVAL, PIIX4PMState, s4=5Fval,</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>2),</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>DE=46INE=5FPROP=5FBOOL(=22acpi-p=
ci-hotplug-with-bridge-support=22,</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>PIIX4PMState,</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>use=5Facpi=5Fhotplug=5Fbridge, t=
rue),</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ DE=46INE=5FPROP=5FBOOL(=22acpi=
-pci-hotplug=22, PIIX4PMState,</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ use=5Facpi=5Fpci=5Fhotplug, tr=
ue),</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>DE=46INE=5FPROP=5FBOOL(=22memory=
-hotplug-support=22, PIIX4PMState,</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>acpi=5Fmemory=5Fhotplug.is=5Fena=
bled, true),</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>DE=46INE=5FPROP=5FEND=5FO=46=5FL=
IST(),</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>diff --git a/hw/i386/acpi-build.=
c b/hw/i386/acpi-build.c</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>index b7bcbbb..343b9b6 100644</b=
lockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>--- a/hw/i386/acpi-build.c</bloc=
kquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+++ b/hw/i386/acpi-build.c</bloc=
kquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=40=40 -95,6 +95,7 =40=40 typede=
f struct AcpiPmInfo =7B</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>bool s3=5Fdisabled;</blockquote>=

</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>bool s4=5Fdisabled;</blockquote>=

</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>bool pcihp=5Fbridge=5Fen;</block=
quote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ bool pcihp=5Fen;</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>uint8=5Ft s4=5Fval;</blockquote>=

</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>Acpi=46adtData fadt;</blockquote=
>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>uint16=5Ft cpu=5Fhp=5Fio=5Fbase;=
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=40=40 -245,6 +246,9 =40=40 stat=
ic void acpi=5Fget=5Fpm=5Finfo(MachineState</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>*machine,</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>AcpiPmInfo *pm)</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>pm-&gt;pcihp=5Fbridge=5Fen =3D</=
blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>object=5Fproperty=5Fget=5Fbool(o=
bj,</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=22acpi-pci-hotplug-with-bridge-=
support=22,</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>NULL);</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ pm-&gt;pcihp=5Fen =3D</blockqu=
ote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ object=5Fproperty=5Fget=5Fbool=
(obj, =22acpi-pci-hotplug=22, NULL);</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=7D</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>static void acpi=5Fget=5Fmisc=5F=
info(AcpiMiscInfo *info)</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=40=40 -337,14 +341,16 =40=40 st=
atic void build=5Fappend=5Fpcihp=5Fnotify=5Fentry</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>(Aml</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>*method, int slot)</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=7D</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>static void build=5Fappend=5Fpci=
=5Fbus=5Fdevices(Aml *parent=5Fscope,</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>PCIBus *bus,</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>- bool pcihp=5Fbridge=5Fen)</blo=
ckquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ bool pcihp=5Fbridge=5Fen,</blo=
ckquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>bool</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>pcihp=5Fen)</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=7B</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>Aml *dev, *notify=5Fmethod =3D N=
ULL, *method;</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>- QObject *bsel;</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ QObject *bsel =3D NULL;</block=
quote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>PCIBus *sec;</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>int i;</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>- bsel =3D object=5Fproperty=5Fg=
et=5Fqobject(OBJECT(bus),</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>ACPI=5FPCIHP=5FPROP=5FBSEL, NULL=
);</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ if (pcihp=5Fen)</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ bsel =3D object=5Fproperty=5Fg=
et=5Fqobject(OBJECT(bus),</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ ACPI=5FPCIHP=5FPROP=5FBSEL,</b=
lockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>NULL);</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>if (bsel) =7B</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>uint64=5Ft bsel=5Fval =3D qnum=5F=
get=5Fuint(qobject=5Fto(QNum,</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>bsel));</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=40=40 -439,7 +445,8 =40=40 stat=
ic void build=5Fappend=5Fpci=5Fbus=5Fdevices(Aml</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>*parent=5Fscope, PCIBus *bus,</b=
lockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>*/</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>PCIBus *sec=5Fbus =3D pci=5Fbrid=
ge=5Fget=5Fsec=5Fbus(PCI=5FBRIDGE</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>(pdev));</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>- build=5Fappend=5Fpci=5Fbus=5Fd=
evices(dev, sec=5Fbus,</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>pcihp=5Fbridge=5Fen);</blockquot=
e>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ build=5Fappend=5Fpci=5Fbus=5Fd=
evices(dev, sec=5Fbus,</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>pcihp=5Fbridge=5Fen,</blockquote=
>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ pcihp=5Fen);</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=7D</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>/* slot descriptor has been comp=
osed, add it into parent</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>context</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>*/</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>aml=5Fappend(parent=5Fscope, dev=
);</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=40=40 -468,7 +475,7 =40=40 stat=
ic void build=5Fappend=5Fpci=5Fbus=5Fdevices(Aml</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>*parent=5Fscope, PCIBus *bus,</b=
lockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=7D</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>/* Notify about child bus events=
 in any case */</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>- if (pcihp=5Fbridge=5Fen) =7B</=
blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ if (pcihp=5Fbridge=5Fen &amp;&=
amp; pcihp=5Fen) =7B</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>QLIST=5F=46OREACH(sec, &amp;bus-=
&gt;child, sibling) =7B</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>int32=5Ft devfn =3D sec-&gt;pare=
nt=5Fdev-&gt;devfn;</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=40=40 -1818,7 +1825,8 =40=40 bu=
ild=5Fdsdt(GArray *table=5Fdata, BIOSLinker</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>*linker,</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>if (bus) =7B</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>Aml *scope =3D aml=5Fscope(=22PC=
I0=22);</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>/* Scan all PCI buses. Generate =
tables to support</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>hotplug. *</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>/</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>- build=5Fappend=5Fpci=5Fbus=5Fd=
evices(scope, bus, pm-&gt;</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>pcihp=5Fbridge=5Fen);</blockquot=
e>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ build=5Fappend=5Fpci=5Fbus=5Fd=
evices(scope, bus, pm-&gt;</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>pcihp=5Fbridge=5Fen,</blockquote=
>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ pm-&gt;pcihp=5Fen);</blockquot=
e>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>if (TPM=5FIS=5FTIS=5FISA(tpm)) =7B=
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>if (misc-&gt;tpm=5Fversion =3D=3D=
 TPM=5FVERSION=5F2=5F0) =7B</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>--</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>2.7.4</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</div>
</body>
</html>

--5f316aa3_625558ec_43ef--


