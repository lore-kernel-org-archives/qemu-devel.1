Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EBCC5DF60
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 00:33:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4736E2178F
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 00:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V87fgJc0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4736E2178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS9Gk-0000As-J2
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 19:33:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41263)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iS9Fw-0007yu-O2
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 19:33:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iS9Ft-0005DN-Pg
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 19:33:02 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46191
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iS9Fs-0005Cy-T8
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 19:33:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573000379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uVAohLZyMeaFd5udwwS+Q0XZlDtEGCtmAeka3la7w2c=;
 b=V87fgJc0FRk0G2CpopW4WQp+YAcq/LN7UoWf1ZKmgJo2tpiEkbrguT2nUJQWa5gQafJ2hP
 hSbchrixAHFWGreCR+je29vUDdDNaOy4x99C4Qlo1ilCekc46IQ2P8CKwlS2+5/LhBsLZq
 n3JdWVmTQb4s1K9e4Z7mF3QrEGw2f6w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-UhaxHdauMFuFt5G0oEN7Bw-1; Tue, 05 Nov 2019 19:32:56 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0563C1800D53;
 Wed,  6 Nov 2019 00:32:55 +0000 (UTC)
Received: from localhost (ovpn-116-57.gru2.redhat.com [10.97.116.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CEBEB19C4F;
 Wed,  6 Nov 2019 00:32:51 +0000 (UTC)
Date: Tue, 5 Nov 2019 21:32:50 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: "Moger, Babu" <Babu.Moger@amd.com>
Subject: Re: [PATCH 1/2] i386: Add missing cpu feature bits in EPYC model
Message-ID: <20191106003250.GM3812@habkost.net>
References: <157298859935.17394.17194072829278152009.stgit@naples-babu.amd.com>
 <157298864859.17394.12763030347823834590.stgit@naples-babu.amd.com>
 <20191105214325.GL3812@habkost.net>
 <DM5PR12MB247163587352C674296256A795790@DM5PR12MB2471.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <DM5PR12MB247163587352C674296256A795790@DM5PR12MB2471.namprd12.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: UhaxHdauMFuFt5G0oEN7Bw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 06, 2019 at 12:16:53AM +0000, Moger, Babu wrote:
[...]
> > > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > > index 51b72439b4..a72fe1db31 100644
> > > --- a/hw/i386/pc.c
> > > +++ b/hw/i386/pc.c
> > > @@ -105,7 +105,13 @@ struct hpet_fw_config hpet_cfg =3D {.count =3D
> > UINT8_MAX};
> > >  /* Physical Address of PVH entry point read from kernel ELF NOTE */
> > >  static size_t pvh_start_addr;
> > >
> > > -GlobalProperty pc_compat_4_1[] =3D {};
> > > +GlobalProperty pc_compat_4_1[] =3D {
> > > +    { "EPYC" "-" TYPE_X86_CPU, "perfctr-core", "off" },
> > > +    { "EPYC" "-" TYPE_X86_CPU, "clzero", "off" },
> > > +    { "EPYC" "-" TYPE_X86_CPU, "xsaveerptr", "off" },
> > > +    { "EPYC" "-" TYPE_X86_CPU, "ibpb", "off" },
> > > +    { "EPYC" "-" TYPE_X86_CPU, "xsaves", "off" },
> > > +};
> >=20
> > machine-type-based CPU compatibility was now replaced by
> > versioned CPU models.  Please use the X86CPUDefinition.versions
> > field to add a new version of EPYC instead.
>=20
> Ok. Did  you mean like this commit  below?
> fd63c6d1a5f77d68 ("i386: Add Cascadelake-Server-v2 CPU model")

Correct.  Thanks!

--=20
Eduardo


