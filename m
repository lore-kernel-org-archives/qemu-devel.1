Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E744EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 15:07:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 724BD2076B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 15:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="O4XoeudK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 724BD2076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k59Ok-0008HP-Lo
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 11:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1k59NY-0007C8-6n
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 11:06:24 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:32821)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1k59NU-0004R8-R9
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 11:06:23 -0400
Received: by mail-pl1-x643.google.com with SMTP id g19so5051092plq.0
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 08:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:message-id:in-reply-to:references:subject
 :mime-version; bh=ZEK7bzFZPS6prxacvPGBRFSWNaG64KwCkSw0PqbTSB4=;
 b=O4XoeudKCu55C9iDyvCPgJCUmGWnSXbB0iAKCWaBVYX69gnuNlbLBvfjmL5CrDbcpJ
 x05gTQ0nKGUoqJc9OQ6rseE6fqCEJVcl2omaoypc9LRk4X+J8OWW1Qo/KAFFXG8WhZ4a
 Ix56yeDnKuNpcLXzMxxARX4bLlmUFE5MdC9QVUCKMRptZjI+gwK5kDqCbXlR1b3KVGiF
 wCi/QiYct+Aou90MVEz495hOFEDr3qLkFOH3b/d714fPCm2yuac/DD5jru1/QynLRDvW
 jEhgk/cvarqx5wtk7VO7L7uTnGZWxfYE9GVZmjO5AlBfyNkgiO6+NyqNsr7G36pPJhFB
 BrkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
 :references:subject:mime-version;
 bh=ZEK7bzFZPS6prxacvPGBRFSWNaG64KwCkSw0PqbTSB4=;
 b=ZHzojC7TEp86IS6ryRuM5aag4kDWNFDmKjwU5WN6Y8iMpsU0BpqiGxKSt6zI4qIGwf
 pkUhS6F+5UQfAQC5te9xegsM5gTUNP/1j3kJH37ZX5zKoPgG2iL7WSzASALHYu1HOf71
 A6XYkisQp/d0T8Oy6A+ItgxDtl+PMROTHOTio79hgyWxcsviPdjlBMmov0OEJ/0XyB7r
 l3hcbRiKrph2bWpv6u1ZSMdEAYOXML4GUHvxKQ/XNK7A9tBB6niQixK8jmlzVY4U1rSp
 duYuI3dktANDIIDndRj3EvMzrzyx/1vkVjLBpasEwOtaPUpY2r2IMTnWE8EWd7rhtKP0
 dbzw==
X-Gm-Message-State: AOAM533ezxQ/PttRgELP6tBqd79W2wypAKvy+9Lee0R5Ayjf/mLbZXEn
 cGQZjZkaTNCx6mshmWK1jyqZIQ==
X-Google-Smtp-Source: ABdhPJxB28L+M26XBNsjrM5t15OeZmquAVTKm8oTSEsGVlx7nNoEWfzc5XvvkwHDaydsAwUv2y08eg==
X-Received: by 2002:a17:90a:eb06:: with SMTP id
 j6mr28118221pjz.227.1597071979172; 
 Mon, 10 Aug 2020 08:06:19 -0700 (PDT)
Received: from [192.168.1.4] ([203.163.233.127])
 by smtp.gmail.com with ESMTPSA id k12sm19799352pjp.38.2020.08.10.08.06.13
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Aug 2020 08:06:18 -0700 (PDT)
Date: Mon, 10 Aug 2020 20:35:56 +0530
From: Ani Sinha <ani@anisinha.ca>
To: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <e4f24840-880b-4912-b251-b0e0bc9469b8@Spark>
In-Reply-To: <20200810105634-mutt-send-email-mst@kernel.org>
References: <1597058982-70090-1-git-send-email-ani@anisinha.ca>
 <20200810104602-mutt-send-email-mst@kernel.org>
 <CAARzgwwsuzw9rcQzu3MF7KZO8F+0PHMs3hCsiSPJCXJS-dEkhw@mail.gmail.com>
 <20200810105634-mutt-send-email-mst@kernel.org>
Subject: Re: [PATCH] Introduce global piix flag to disable PCI hotplug
X-Readdle-Message-ID: e4f24840-880b-4912-b251-b0e0bc9469b8@Spark
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="5f316263_66334873_43ef"
Received-SPF: none client-ip=2607:f8b0:4864:20::643;
 envelope-from=ani@anisinha.ca; helo=mail-pl1-x643.google.com
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

--5f316263_66334873_43ef
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


Ani
On Aug 10, 2020, 20:30 +0530, Michael S. Tsirkin <mst=40redhat.com>, wrot=
e:
> On Mon, Aug 10, 2020 at 08:24:53PM +0530, Ani Sinha wrote:
> >
> >
> > On Mon, Aug 10, 2020 at 8:17 PM Michael S. Tsirkin <mst=40redhat.com>=
 wrote:
> >
> > On Mon, Aug 10, 2020 at 04:59:41PM +0530, Ani Sinha wrote:
> > > We introduce a new global flag for PIIX with which we can
> > > turn on or off PCI device hotplug. This flag can be used
> > > to prevent all PCI devices from getting hotplugged/unplugged
> > > on the PCI bus. The new options disables all hotpluh HW
> > > initialization code as well as the ACPI AMLs.
> > >
> > > Signed-off-by: Ani Sinha <ani=40anisinha.ca>
> >
> > Well we have a flag like this for pci bridges, right=3F
> > So all that's left is an option to disable hotplug
> > for the pci root, right=3F
> > Wouldn't that be better than disabling it globally=3F
> >
> >
> > The idea is to have just one option to disable all hotplug globally. =
But if you
> > want to have two flags one for the bridges and one for the pci root, =
we can
> > certainly look into it.
> >
>
> I can certainly see the attraction of a global flag.
>
> However, with the interface we have for bridges right now, how are we
> going to resolve the conflict if hotplug is disabled globally but
> enabled for a given bridge=3F
>
> A reasonable way would be to change the default value for bridges,
> have a user-specified value override it.
> This patch doesn't do it, though.

I think the global option should override the bridge option. So if the gl=
obal option disables hotplug, the bridge option should be a noop.
>
>
>
>
> >
> >
> > > ---
> > > =C2=A0=C2=A0hw/acpi/piix4.c=C2=A0=C2=A0 =C2=A0 =C2=A0=7C=C2=A0=C2=A0=
8 ++++++--
> > > =C2=A0=C2=A0hw/i386/acpi-build.c =7C 20 ++++++++++++++------
> > > =C2=A0=C2=A02 files changed, 20 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> > > index 26bac4f..8b13e86 100644
> > > --- a/hw/acpi/piix4.c
> > > +++ b/hw/acpi/piix4.c
> > > =40=40 -78,6 +78,7 =40=40 typedef struct PIIX4PMState =7B
> > >
> > > =C2=A0=C2=A0 =C2=A0 =C2=A0AcpiPciHpState acpi=5Fpci=5Fhotplug;
> > > =C2=A0=C2=A0 =C2=A0 =C2=A0bool use=5Facpi=5Fhotplug=5Fbridge;
> > > +=C2=A0=C2=A0 =C2=A0bool use=5Facpi=5Fpci=5Fhotplug;
> > >
> > > =C2=A0=C2=A0 =C2=A0 =C2=A0uint8=5Ft disable=5Fs3;
> > > =C2=A0=C2=A0 =C2=A0 =C2=A0uint8=5Ft disable=5Fs4;
> > > =40=40 -595,8 +596,9 =40=40 static void piix4=5Facpi=5Fsystem=5Fhot=
=5Fadd=5Finit
> > (MemoryRegion *parent,
> > > =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=22acpi-gpe0=22, GPE=5FLEN);
> > > =C2=A0=C2=A0 =C2=A0 =C2=A0memory=5Fregion=5Fadd=5Fsubregion(parent,=
 GPE=5FBASE, &s->io=5Fgpe);
> > >
> > > -=C2=A0=C2=A0 =C2=A0acpi=5Fpcihp=5Finit(OBJECT(s), &s->acpi=5Fpci=5F=
hotplug, bus, parent,
> > > -=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0s->use=5Facpi=5Fhotplug=5Fbridge);
> > > +=C2=A0=C2=A0 =C2=A0if (s->use=5Facpi=5Fpci=5Fhotplug)
> > > +=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0acpi=5Fpcihp=5Finit(OBJECT(s), &s=
->acpi=5Fpci=5Fhotplug, bus, parent,
> > > +=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0s->use=5Facpi=5Fhotplug=5Fbridge);
> > >
> > > =C2=A0=C2=A0 =C2=A0 =C2=A0s->cpu=5Fhotplug=5Flegacy =3D true;
> > > =C2=A0=C2=A0 =C2=A0 =C2=A0object=5Fproperty=5Fadd=5Fbool(OBJECT(s),=
 =22cpu-hotplug-legacy=22,
> > > =40=40 -635,6 +637,8 =40=40 static Property piix4=5Fpm=5Fproperties=
=5B=5D =3D =7B
> > > =C2=A0=C2=A0 =C2=A0 =C2=A0DE=46INE=5FPROP=5FUINT8(ACPI=5FPM=5FPROP=5F=
S4=5FVAL, PIIX4PMState, s4=5Fval, 2),
> > > =C2=A0=C2=A0 =C2=A0 =C2=A0DE=46INE=5FPROP=5FBOOL(=22acpi-pci-hotplu=
g-with-bridge-support=22,
> > PIIX4PMState,
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0use=5Facpi=5Fhotplug=5Fbridge, true),
> > > +=C2=A0=C2=A0 =C2=A0DE=46INE=5FPROP=5FBOOL(=22acpi-pci-hotplug=22, =
PIIX4PMState,
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0use=5Facpi=5Fpci=5Fhotplug, true),
> > > =C2=A0=C2=A0 =C2=A0 =C2=A0DE=46INE=5FPROP=5FBOOL(=22memory-hotplug-=
support=22, PIIX4PMState,
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0acpi=5Fmemory=5Fhotplug.is=5Fenabled, true),
> > > =C2=A0=C2=A0 =C2=A0 =C2=A0DE=46INE=5FPROP=5FEND=5FO=46=5FLIST(),
> > > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > > index b7bcbbb..343b9b6 100644
> > > --- a/hw/i386/acpi-build.c
> > > +++ b/hw/i386/acpi-build.c
> > > =40=40 -95,6 +95,7 =40=40 typedef struct AcpiPmInfo =7B
> > > =C2=A0=C2=A0 =C2=A0 =C2=A0bool s3=5Fdisabled;
> > > =C2=A0=C2=A0 =C2=A0 =C2=A0bool s4=5Fdisabled;
> > > =C2=A0=C2=A0 =C2=A0 =C2=A0bool pcihp=5Fbridge=5Fen;
> > > +=C2=A0=C2=A0 =C2=A0bool pcihp=5Fen;
> > > =C2=A0=C2=A0 =C2=A0 =C2=A0uint8=5Ft s4=5Fval;
> > > =C2=A0=C2=A0 =C2=A0 =C2=A0Acpi=46adtData fadt;
> > > =C2=A0=C2=A0 =C2=A0 =C2=A0uint16=5Ft cpu=5Fhp=5Fio=5Fbase;
> > > =40=40 -245,6 +246,9 =40=40 static void acpi=5Fget=5Fpm=5Finfo(Mach=
ineState *machine,
> > AcpiPmInfo *pm)
> > > =C2=A0=C2=A0 =C2=A0 =C2=A0pm->pcihp=5Fbridge=5Fen =3D
> > > =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0object=5Fproperty=5Fget=5Fb=
ool(obj,
> > =22acpi-pci-hotplug-with-bridge-support=22,
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL);
> > > +=C2=A0=C2=A0 =C2=A0pm->pcihp=5Fen =3D
> > > +=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0object=5Fproperty=5Fget=5Fbool(ob=
j, =22acpi-pci-hotplug=22, NULL);
> > > +
> > > =C2=A0=C2=A0=7D
> > >
> > > =C2=A0=C2=A0static void acpi=5Fget=5Fmisc=5Finfo(AcpiMiscInfo *info=
)
> > > =40=40 -337,14 +341,16 =40=40 static void build=5Fappend=5Fpcihp=5F=
notify=5Fentry(Aml
> > *method, int slot)
> > > =C2=A0=C2=A0=7D
> > >
> > > =C2=A0=C2=A0static void build=5Fappend=5Fpci=5Fbus=5Fdevices(Aml *p=
arent=5Fscope, PCIBus *bus,
> > > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0bool pcihp=5Fbridge=5Fen)
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0bool pcihp=5Fbridge=5Fen, bool
> > pcihp=5Fen)
> > > =C2=A0=C2=A0=7B
> > > =C2=A0=C2=A0 =C2=A0 =C2=A0Aml *dev, *notify=5Fmethod =3D NULL, *met=
hod;
> > > -=C2=A0=C2=A0 =C2=A0QObject *bsel;
> > > +=C2=A0=C2=A0 =C2=A0QObject *bsel =3D NULL;
> > > =C2=A0=C2=A0 =C2=A0 =C2=A0PCIBus *sec;
> > > =C2=A0=C2=A0 =C2=A0 =C2=A0int i;
> > >
> > > -=C2=A0=C2=A0 =C2=A0bsel =3D object=5Fproperty=5Fget=5Fqobject(OBJE=
CT(bus),
> > ACPI=5FPCIHP=5FPROP=5FBSEL, NULL);
> > > +=C2=A0=C2=A0 =C2=A0if (pcihp=5Fen)
> > > +=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0bsel =3D object=5Fproperty=5Fget=5F=
qobject(OBJECT(bus),
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0ACPI=5FPCIHP=5FPROP=5FBSEL, NULL);
> > > =C2=A0=C2=A0 =C2=A0 =C2=A0if (bsel) =7B
> > > =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64=5Ft bsel=5Fval =3D q=
num=5Fget=5Fuint(qobject=5Fto(QNum, bsel));
> > >
> > > =40=40 -439,7 +445,8 =40=40 static void build=5Fappend=5Fpci=5Fbus=5F=
devices(Aml
> > *parent=5Fscope, PCIBus *bus,
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> > > =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PCIBus *sec=5F=
bus =3D pci=5Fbridge=5Fget=5Fsec=5Fbus(PCI=5FBRIDGE(pdev));
> > >
> > > -=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0build=5Fappend=5Fpc=
i=5Fbus=5Fdevices(dev, sec=5Fbus, pcihp=5Fbridge=5Fen);
> > > +=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0build=5Fappend=5Fpc=
i=5Fbus=5Fdevices(dev, sec=5Fbus, pcihp=5Fbridge=5Fen,
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0pcihp=5Fen);
> > > =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=7D
> > > =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* slot descriptor has been=
 composed, add it into parent context
> > */
> > > =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0aml=5Fappend(parent=5Fscope=
, dev);
> > > =40=40 -468,7 +475,7 =40=40 static void build=5Fappend=5Fpci=5Fbus=5F=
devices(Aml
> > *parent=5Fscope, PCIBus *bus,
> > > =C2=A0=C2=A0 =C2=A0 =C2=A0=7D
> > >
> > > =C2=A0=C2=A0 =C2=A0 =C2=A0/* Notify about child bus events in any c=
ase */
> > > -=C2=A0=C2=A0 =C2=A0if (pcihp=5Fbridge=5Fen) =7B
> > > +=C2=A0=C2=A0 =C2=A0if (pcihp=5Fbridge=5Fen && pcihp=5Fen) =7B
> > > =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QLIST=5F=46OREACH(sec, &bus=
->child, sibling) =7B
> > > =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int32=5Ft dev=
fn =3D sec->parent=5Fdev->devfn;
> > >
> > > =40=40 -1818,7 +1825,8 =40=40 build=5Fdsdt(GArray *table=5Fdata, BI=
OSLinker *linker,
> > > =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (bus) =7B
> > > =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Aml *scope =3D=
 aml=5Fscope(=22PCI0=22);
> > > =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Scan all P=
CI buses. Generate tables to support hotplug. *
> > /
> > > -=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0build=5Fappend=5Fpc=
i=5Fbus=5Fdevices(scope, bus, pm->
> > pcihp=5Fbridge=5Fen);
> > > +=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0build=5Fappend=5Fpc=
i=5Fbus=5Fdevices(scope, bus, pm->
> > pcihp=5Fbridge=5Fen,
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0pm->pcihp=5Fen);
> > >
> > > =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (TPM=5FIS=5F=
TIS=5FISA(tpm)) =7B
> > > =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
if (misc->tpm=5Fversion =3D=3D TPM=5FVERSION=5F2=5F0) =7B
> > > --
> > > 2.7.4
> >
> >
>

--5f316263_66334873_43ef
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
<div dir=3D=22auto=22>On Aug 10, 2020, 20:30 +0530, Michael S. Tsirkin &l=
t;mst=40redhat.com&gt;, wrote:</div>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>On Mon, Aug 10, 2020 at 08:24:53=
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
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>On Mon, Aug 10, 2020 at 8:17 PM =
Michael S. Tsirkin &lt;mst=40redhat.com&gt; wrote:</blockquote>
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
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>We introduce a new global flag f=
or PIIX with which we can</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>turn on or off PCI device hotplu=
g. This flag can be used</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>to prevent all PCI devices from =
getting hotplugged/unplugged</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>on the PCI bus. The new options =
disables all hotpluh HW</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>initialization code as well as t=
he ACPI AMLs.</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>Signed-off-by: Ani Sinha &lt;ani=
=40anisinha.ca&gt;</blockquote>
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
adding-bottom: 5px; padding-top: 5px;=22>Well we have a flag like this fo=
r pci bridges, right=3F</blockquote>
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
adding-bottom: 5px; padding-top: 5px;=22>for the pci root, right=3F</bloc=
kquote>
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
adding-bottom: 5px; padding-top: 5px;=22>The idea is to have just one opt=
ion to disable all hotplug globally. But if you</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>want to have two flags one for t=
he bridges and one for the pci root, we can</blockquote>
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
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>I can certainly see the attracti=
on of a global flag.</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>However, with the interface we h=
ave for bridges right now, how are we</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>going to resolve the conflict if=
 hotplug is disabled globally but</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>enabled for a given bridge=3F</b=
lockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>A reasonable way would be to cha=
nge the default value for bridges,</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>have a user-specified value over=
ride it.</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>This patch doesn't do it, though=
.</blockquote>
<div dir=3D=22auto=22><br />
I think the global option should override the bridge option. So if the gl=
obal option disables hotplug, the bridge option should be a noop.<br /></=
div>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
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
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>---</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;&=23160;hw/acpi/piix4.c&=
=23160;&=23160; &=23160; &=23160;=7C&=23160;&=23160;8 ++++++--</blockquot=
e>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;&=23160;hw/i386/acpi-bui=
ld.c =7C 20 ++++++++++++++------</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;&=23160;2 files changed,=
 20 insertions(+), 8 deletions(-)</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>diff --git a/hw/acpi/piix4.c b/h=
w/acpi/piix4.c</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>index 26bac4f..8b13e86 100644</b=
lockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>--- a/hw/acpi/piix4.c</blockquot=
e>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+++ b/hw/acpi/piix4.c</blockquot=
e>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=40=40 -78,6 +78,7 =40=40 typede=
f struct PIIX4PMState =7B</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;&=23160; &=23160; &=2316=
0;AcpiPciHpState acpi=5Fpci=5Fhotplug;</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;&=23160; &=23160; &=2316=
0;bool use=5Facpi=5Fhotplug=5Fbridge;</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+&=23160;&=23160; &=23160;bool u=
se=5Facpi=5Fpci=5Fhotplug;</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;&=23160; &=23160; &=2316=
0;uint8=5Ft disable=5Fs3;</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;&=23160; &=23160; &=2316=
0;uint8=5Ft disable=5Fs4;</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=40=40 -595,8 +596,9 =40=40 stat=
ic void piix4=5Facpi=5Fsystem=5Fhot=5Fadd=5Finit</blockquote>
</blockquote>
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
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;&=23160; &=23160; &=2316=
0; &=23160; &=23160; &=23160; &=23160; &=23160; &=23160; &=23160; &=23160=
; &=23160; &=23160; &=23160;=22acpi-gpe0=22, GPE=5FLEN);</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;&=23160; &=23160; &=2316=
0;memory=5Fregion=5Fadd=5Fsubregion(parent, GPE=5FBASE, &amp;s-&gt;io=5Fg=
pe);</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>-&=23160;&=23160; &=23160;acpi=5F=
pcihp=5Finit(OBJECT(s), &amp;s-&gt;acpi=5Fpci=5Fhotplug, bus, parent,</bl=
ockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>-&=23160;&=23160; &=23160; &=231=
60; &=23160; &=23160; &=23160; &=23160; &=23160; &=23160; &=23160;s-&gt;u=
se=5Facpi=5Fhotplug=5Fbridge);</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+&=23160;&=23160; &=23160;if (s-=
&gt;use=5Facpi=5Fpci=5Fhotplug)</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+&=23160;&=23160; &=23160; &=231=
60; &=23160;acpi=5Fpcihp=5Finit(OBJECT(s), &amp;s-&gt;acpi=5Fpci=5Fhotplu=
g, bus, parent,</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+&=23160;&=23160; &=23160; &=231=
60; &=23160; &=23160; &=23160; &=23160; &=23160; &=23160; &=23160; &=2316=
0; &=23160;s-&gt;use=5Facpi=5Fhotplug=5Fbridge);</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;&=23160; &=23160; &=2316=
0;s-&gt;cpu=5Fhotplug=5Flegacy =3D true;</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;&=23160; &=23160; &=2316=
0;object=5Fproperty=5Fadd=5Fbool(OBJECT(s), =22cpu-hotplug-legacy=22,</bl=
ockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=40=40 -635,6 +637,8 =40=40 stat=
ic Property piix4=5Fpm=5Fproperties=5B=5D =3D =7B</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;&=23160; &=23160; &=2316=
0;DE=46INE=5FPROP=5FUINT8(ACPI=5FPM=5FPROP=5FS4=5FVAL, PIIX4PMState, s4=5F=
val, 2),</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;&=23160; &=23160; &=2316=
0;DE=46INE=5FPROP=5FBOOL(=22acpi-pci-hotplug-with-bridge-support=22,</blo=
ckquote>
</blockquote>
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
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160; &=23160; &=23160; &=231=
60; &=23160; &=23160; &=23160; &=23160; &=23160; &=23160; &=23160; &=2316=
0;use=5Facpi=5Fhotplug=5Fbridge, true),</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+&=23160;&=23160; &=23160;DE=46I=
NE=5FPROP=5FBOOL(=22acpi-pci-hotplug=22, PIIX4PMState,</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+&=23160; &=23160; &=23160; &=23=
160; &=23160; &=23160; &=23160; &=23160; &=23160; &=23160; &=23160;use=5F=
acpi=5Fpci=5Fhotplug, true),</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;&=23160; &=23160; &=2316=
0;DE=46INE=5FPROP=5FBOOL(=22memory-hotplug-support=22, PIIX4PMState,</blo=
ckquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160; &=23160; &=23160; &=231=
60; &=23160; &=23160; &=23160; &=23160; &=23160; &=23160; &=23160; &=2316=
0;acpi=5Fmemory=5Fhotplug.is=5Fenabled, true),</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;&=23160; &=23160; &=2316=
0;DE=46INE=5FPROP=5FEND=5FO=46=5FLIST(),</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>diff --git a/hw/i386/acpi-build.=
c b/hw/i386/acpi-build.c</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>index b7bcbbb..343b9b6 100644</b=
lockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>--- a/hw/i386/acpi-build.c</bloc=
kquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+++ b/hw/i386/acpi-build.c</bloc=
kquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=40=40 -95,6 +95,7 =40=40 typede=
f struct AcpiPmInfo =7B</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;&=23160; &=23160; &=2316=
0;bool s3=5Fdisabled;</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;&=23160; &=23160; &=2316=
0;bool s4=5Fdisabled;</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;&=23160; &=23160; &=2316=
0;bool pcihp=5Fbridge=5Fen;</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+&=23160;&=23160; &=23160;bool p=
cihp=5Fen;</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;&=23160; &=23160; &=2316=
0;uint8=5Ft s4=5Fval;</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;&=23160; &=23160; &=2316=
0;Acpi=46adtData fadt;</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;&=23160; &=23160; &=2316=
0;uint16=5Ft cpu=5Fhp=5Fio=5Fbase;</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=40=40 -245,6 +246,9 =40=40 stat=
ic void acpi=5Fget=5Fpm=5Finfo(MachineState *machine,</blockquote>
</blockquote>
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
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;&=23160; &=23160; &=2316=
0;pm-&gt;pcihp=5Fbridge=5Fen =3D</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;&=23160; &=23160; &=2316=
0; &=23160; &=23160;object=5Fproperty=5Fget=5Fbool(obj,</blockquote>
</blockquote>
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
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160; &=23160; &=23160; &=231=
60; &=23160; &=23160; &=23160; &=23160; &=23160; &=23160; &=23160; &=2316=
0; &=23160; &=23160; &=23160; &=23160; &=23160; &=23160;NULL);</blockquot=
e>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+&=23160;&=23160; &=23160;pm-&gt=
;pcihp=5Fen =3D</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+&=23160;&=23160; &=23160; &=231=
60; &=23160;object=5Fproperty=5Fget=5Fbool(obj, =22acpi-pci-hotplug=22, N=
ULL);</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;&=23160;=7D</blockquote>=

</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;&=23160;static void acpi=
=5Fget=5Fmisc=5Finfo(AcpiMiscInfo *info)</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=40=40 -337,14 +341,16 =40=40 st=
atic void build=5Fappend=5Fpcihp=5Fnotify=5Fentry(Aml</blockquote>
</blockquote>
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
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;&=23160;=7D</blockquote>=

</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;&=23160;static void buil=
d=5Fappend=5Fpci=5Fbus=5Fdevices(Aml *parent=5Fscope, PCIBus *bus,</block=
quote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>-&=23160; &=23160; &=23160; &=23=
160; &=23160; &=23160; &=23160; &=23160; &=23160; &=23160; &=23160; &=231=
60; &=23160; &=23160; &=23160; &=23160; &=23160; &=23160; &=23160; &=2316=
0; &=23160;bool pcihp=5Fbridge=5Fen)</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+&=23160; &=23160; &=23160; &=23=
160; &=23160; &=23160; &=23160; &=23160; &=23160; &=23160; &=23160; &=231=
60; &=23160; &=23160; &=23160; &=23160; &=23160; &=23160; &=23160; &=2316=
0; &=23160;bool pcihp=5Fbridge=5Fen, bool</blockquote>
</blockquote>
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
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;&=23160;=7B</blockquote>=

</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;&=23160; &=23160; &=2316=
0;Aml *dev, *notify=5Fmethod =3D NULL, *method;</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>-&=23160;&=23160; &=23160;QObjec=
t *bsel;</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+&=23160;&=23160; &=23160;QObjec=
t *bsel =3D NULL;</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;&=23160; &=23160; &=2316=
0;PCIBus *sec;</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;&=23160; &=23160; &=2316=
0;int i;</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>-&=23160;&=23160; &=23160;bsel =3D=
 object=5Fproperty=5Fget=5Fqobject(OBJECT(bus),</blockquote>
</blockquote>
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
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+&=23160;&=23160; &=23160;if (pc=
ihp=5Fen)</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+&=23160;&=23160; &=23160; &=231=
60; &=23160;bsel =3D object=5Fproperty=5Fget=5Fqobject(OBJECT(bus),</bloc=
kquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+&=23160; &=23160; &=23160; &=23=
160; &=23160; &=23160; &=23160; &=23160; &=23160; &=23160; &=23160; &=231=
60; &=23160; &=23160; &=23160; &=23160; &=23160; &=23160; &=23160; &=2316=
0; &=23160; &=23160;ACPI=5FPCIHP=5FPROP=5FBSEL, NULL);</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;&=23160; &=23160; &=2316=
0;if (bsel) =7B</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;&=23160; &=23160; &=2316=
0; &=23160; &=23160;uint64=5Ft bsel=5Fval =3D qnum=5Fget=5Fuint(qobject=5F=
to(QNum, bsel));</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=40=40 -439,7 +445,8 =40=40 stat=
ic void build=5Fappend=5Fpci=5Fbus=5Fdevices(Aml</blockquote>
</blockquote>
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
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160; &=23160; &=23160; &=231=
60; &=23160; &=23160; &=23160; &=23160;*/</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;&=23160; &=23160; &=2316=
0; &=23160; &=23160; &=23160; &=23160;PCIBus *sec=5Fbus =3D pci=5Fbridge=5F=
get=5Fsec=5Fbus(PCI=5FBRIDGE(pdev));</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>-&=23160;&=23160; &=23160; &=231=
60; &=23160; &=23160; &=23160;build=5Fappend=5Fpci=5Fbus=5Fdevices(dev, s=
ec=5Fbus, pcihp=5Fbridge=5Fen);</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+&=23160;&=23160; &=23160; &=231=
60; &=23160; &=23160; &=23160;build=5Fappend=5Fpci=5Fbus=5Fdevices(dev, s=
ec=5Fbus, pcihp=5Fbridge=5Fen,</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+&=23160; &=23160; &=23160; &=23=
160; &=23160; &=23160; &=23160; &=23160; &=23160; &=23160; &=23160; &=231=
60; &=23160; &=23160; &=23160; &=23160; &=23160; &=23160; &=23160; &=2316=
0; &=23160;pcihp=5Fen);</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;&=23160; &=23160; &=2316=
0; &=23160; &=23160;=7D</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;&=23160; &=23160; &=2316=
0; &=23160; &=23160;/* slot descriptor has been composed, add it into par=
ent context</blockquote>
</blockquote>
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
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;&=23160; &=23160; &=2316=
0; &=23160; &=23160;aml=5Fappend(parent=5Fscope, dev);</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=40=40 -468,7 +475,7 =40=40 stat=
ic void build=5Fappend=5Fpci=5Fbus=5Fdevices(Aml</blockquote>
</blockquote>
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
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;&=23160; &=23160; &=2316=
0;=7D</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;&=23160; &=23160; &=2316=
0;/* Notify about child bus events in any case */</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>-&=23160;&=23160; &=23160;if (pc=
ihp=5Fbridge=5Fen) =7B</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+&=23160;&=23160; &=23160;if (pc=
ihp=5Fbridge=5Fen &amp;&amp; pcihp=5Fen) =7B</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;&=23160; &=23160; &=2316=
0; &=23160; &=23160;QLIST=5F=46OREACH(sec, &amp;bus-&gt;child, sibling) =7B=
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;&=23160; &=23160; &=2316=
0; &=23160; &=23160; &=23160; &=23160;int32=5Ft devfn =3D sec-&gt;parent=5F=
dev-&gt;devfn;</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=40=40 -1818,7 +1825,8 =40=40 bu=
ild=5Fdsdt(GArray *table=5Fdata, BIOSLinker *linker,</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;&=23160; &=23160; &=2316=
0; &=23160; &=23160;if (bus) =7B</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;&=23160; &=23160; &=2316=
0; &=23160; &=23160; &=23160; &=23160;Aml *scope =3D aml=5Fscope(=22PCI0=22=
);</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;&=23160; &=23160; &=2316=
0; &=23160; &=23160; &=23160; &=23160;/* Scan all PCI buses. Generate tab=
les to support hotplug. *</blockquote>
</blockquote>
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
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>-&=23160;&=23160; &=23160; &=231=
60; &=23160; &=23160; &=23160;build=5Fappend=5Fpci=5Fbus=5Fdevices(scope,=
 bus, pm-&gt;</blockquote>
</blockquote>
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
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+&=23160;&=23160; &=23160; &=231=
60; &=23160; &=23160; &=23160;build=5Fappend=5Fpci=5Fbus=5Fdevices(scope,=
 bus, pm-&gt;</blockquote>
</blockquote>
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
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+&=23160; &=23160; &=23160; &=23=
160; &=23160; &=23160; &=23160; &=23160; &=23160; &=23160; &=23160; &=231=
60; &=23160; &=23160; &=23160; &=23160; &=23160; &=23160; &=23160; &=2316=
0; &=23160;pm-&gt;pcihp=5Fen);</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;&=23160; &=23160; &=2316=
0; &=23160; &=23160; &=23160; &=23160;if (TPM=5FIS=5FTIS=5FISA(tpm)) =7B<=
/blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>&=23160;&=23160; &=23160; &=2316=
0; &=23160; &=23160; &=23160; &=23160; &=23160; &=23160;if (misc-&gt;tpm=5F=
version =3D=3D TPM=5FVERSION=5F2=5F0) =7B</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>--</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>2.7.4</blockquote>
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
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</div>
</body>
</html>

--5f316263_66334873_43ef--


