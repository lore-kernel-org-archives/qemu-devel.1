Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA17C1975A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 20:05:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98D1D205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 20:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hRa8bRqW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D1D205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCU4i-0005Bv-Mt
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 16:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46833)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jCTo1-0003kn-Uk
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:47:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jCTo0-0004o5-Dr
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:47:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47672
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jCTo0-0004np-9E
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:47:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584042463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WeGGn3tuYcsSwexU50DeBDd23ygmx98fJfdSJk4l0HA=;
 b=hRa8bRqWfRtLNu+yVs3N3Ssh3zkINz4f2W9+r1R/AYreYCZP2J1DFKmg0DhLKMs+yAEgSe
 4qTXu2NsU06zeZdEIEX7NOlhJjKk/MGylBfAoyNJ5Itz1/QlVUdQ4GfAzlFvvMMuhfbY62
 7F8U3JaO7C0MUXT1FEUiRZjOeDnD6tM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-9Dl0c4YdMVGEeSkenVzonw-1; Thu, 12 Mar 2020 15:47:25 -0400
X-MC-Unique: 9Dl0c4YdMVGEeSkenVzonw-1
Received: by mail-qt1-f197.google.com with SMTP id l21so4903345qtq.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 12:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=SkcYgLGpr3Lsb1aJDuXv9LdnBxIKt6Gcb3cWx5ncf00=;
 b=mOz8LumASUhWGE+tysrZfrsY1ETntF2Bc8xhqDDyCxzeBiCV2DgiOgVPXkn5gMLHkz
 aycIFHEIY3Pjd6uTV6MoXxstM3+so/HJhZOkWm4AC+q4HsZvzBOXUOv8WzNDhj4OPuZE
 tfXmGViBNg9xQlXlQAEeMB5qwYB5K0pheO1iFbZbVvGxv46sLLTsuzv3SFlyn2mIk8iC
 wcZcPGuigRx2pk5/FCVjUhvSmDKpS8Fd8QzidTv840oQCfIuqz5+gGLcWmQHtesvy6hm
 2n0pBk7RrODyU4ikhShGPIAat0JqdJ+RFQruwKlLrQgngLLRWNBniYFpM904nHAHNbGr
 jv8w==
X-Gm-Message-State: ANhLgQ3MkWe+AVCG1GEdR/4SnYlWIqo1WfAJCyvxaDmhDobAPWDoDGp6
 Zb/Oc9IyhR4+8JXdjWPW9lfzV5gcY4B8pjf85YigoaVPM/r7QybM36VJXlAPqoSR3HRYWT9BJh3
 K3OfFmCh03ZzyNh8=
X-Received: by 2002:a05:620a:12d5:: with SMTP id
 e21mr9360747qkl.226.1584042444958; 
 Thu, 12 Mar 2020 12:47:24 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vubRMoG4fHZDvDStmZHVaxeN8T4Zjz6M0iMdsbm9um9qmBHc8uaSsgsgMcmngHIGe/JKU0Tbw==
X-Received: by 2002:a05:620a:12d5:: with SMTP id
 e21mr9360724qkl.226.1584042444685; 
 Thu, 12 Mar 2020 12:47:24 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id x188sm18853664qka.53.2020.03.12.12.47.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 12:47:23 -0700 (PDT)
Date: Thu, 12 Mar 2020 15:47:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH] acpi: Add Windows ACPI Emulated Device Table (WAET)
Message-ID: <20200312154646-mutt-send-email-mst@kernel.org>
References: <20200311170826.79419-1-liran.alon@oracle.com>
 <20200312172745.1b7b2222@redhat.com>
 <8b3f3166-cc60-eae2-c20d-ad4a593c3e30@oracle.com>
MIME-Version: 1.0
In-Reply-To: <8b3f3166-cc60-eae2-c20d-ad4a593c3e30@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com,
 Elad Gabay <elad.gabay@oracle.com>, Igor Mammedov <imammedo@redhat.com>,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 12, 2020 at 07:28:31PM +0200, Liran Alon wrote:
>=20
> On 12/03/2020 18:27, Igor Mammedov wrote:
> > On Wed, 11 Mar 2020 19:08:26 +0200
> > Liran Alon <liran.alon@oracle.com> wrote:
> > > +
> > > +static void
> > > +build_waet(GArray *table_data, BIOSLinker *linker)
> > see build_hmat_lb() for example how to doc comment for such function
> > should look like. Use earliest spec version where table was introduced.
>=20
> Note that WAET is a table that is not part of ACPI spec officially.
> It's specified on it's own document, there is only a single version, and
> there is only a single table in that document describing that table
> structure.
>=20
> Therefore, I cannot write a comment such as build_hmat_lb() have:
> /*
> =A0* ACPI 6.3: 5.2.27.4 System Locality Latency and Bandwidth Information
> =A0* Structure: Table 5-146
> */
>=20
> My best attempt to do something similar in v2 is:
> /*
> =A0* Windows ACPI Emulated Devices Table
> =A0* (Version 1.0 - April 6, 2009)
> =A0* Spec: http://download.microsoft.com/download/7/E/7/7E7662CF-CBEA-470=
B-A97E-CE7CE0D98DC2/WAET.docx
> =A0*
> =A0* Helpful to speedup Windows guests and ignored by others.
> =A0*/
>=20
> If it's not sufficient. Please suggest alternative phrasing which I would
> use in v2.
>=20
> >=20
> > > +{
> > > +    AcpiTableWaet *waet;
> > > +
> > > +    waet =3D acpi_data_push(table_data, sizeof(*waet));
> > > +    waet->emulated_device_flags =3D cpu_to_le32(ACPI_WAET_PM_TIMER_G=
OOD);
> > we don't use packed structures for building ACPI tables anymore (there =
is
> > old code that still does but that's being converted when we touch it)
> >=20
> > pls use build_append_int_noprefix() api instead, see build_amd_iommu() =
as
> > an example how to build binary tables using it and how to use comments
> > to document fields.
> > Basic idea is that api makes function building a table match table's
> > description in spec (each call represents a row in spec) and comment
> > belonging to a row should contain verbatim field name as used by spec
> > so reader could copy/past and grep it easily.
> Thanks for pointing this out.
> I will make sure to update my code accordingly in v2.
> >=20
> >=20
> >=20
> >=20
> > > +
> > > +    build_header(linker, table_data,
> > > +                 (void *)waet, "WAET", sizeof(*waet), 1, NULL, NULL)=
;
> > > +}
> > > +
> > >   /*
> > >    *   IVRS table as specified in AMD IOMMU Specification v2.62, Sect=
ion 5.2
> > >    *   accessible here https://urldefense.com/v3/__http://support.amd=
.com/TechDocs/48882_IOMMU.pdf__;!!GqivPVa7Brio!On_WsDCS8ysOeUG17h1l3dTpWEm7=
9AHwMHLbbUgsvagBSpgZAk5U1cXddn6ZNOU$
> > > @@ -2859,6 +2872,11 @@ void acpi_build(AcpiBuildTables *tables, Machi=
neState *machine)
> > >                             machine->nvdimms_state, machine->ram_slot=
s);
> > >       }
> > > +    if (!pcmc->do_not_add_waet_acpi) {
> > > +        acpi_add_table(table_offsets, tables_blob);
> > > +        build_waet(tables_blob, tables->linker);
> > > +    }
> > we typically do not version ACPI table changes (there might be exceptio=
ns
> > but it should be a justified one).
> > ACPI tables are considered to be a part of firmware (even though they a=
re
> > generated by QEMU) so on QEMU upgrade user gets a new firmware along wi=
th
> > new ACPI tables.
>=20
> Hmm... I would have expected as a QEMU user that upgrading QEMU may updat=
e
> my firmware exposed table (Such as ACPI),
> but only if I don't specify I wish to run on a specific machine-type. In
> that case, I would've expect to be exposed with exact same firmware
> information.
> I understood that this was one of the main reasons why ACPI/SMBIOS
> generation was moved from SeaBIOS to QEMU.
>=20
> If you think this isn't the case, I can just remove this flag (Makes code
> simpler). What do you prefer?
>=20
> Thanks for the review,
> -Liran
>=20

I'm inclined to agree, but no biggie if Igor disagrees let's go along
with his opinion.

--=20
MST


