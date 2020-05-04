Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1DBC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 13:21:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCA762073E
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 13:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ROetIawK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCA762073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVb1t-0000p6-T5
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 09:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jVb18-0008T0-57
 for qemu-devel@nongnu.org; Mon, 04 May 2020 09:20:18 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45803
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jVb16-0002uO-M1
 for qemu-devel@nongnu.org; Mon, 04 May 2020 09:20:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588598414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gmWeAY18qjn9vN8LnqI+ui2DoJ+OzT7wNrk2/xRMQ74=;
 b=ROetIawKMpl4psUQQFBkoiJeNn7OvxmOWPeGyuVKy8nsqZtbAZbiNqwxf1t/1D6k/GlwVu
 /j9nl/vjKr/fy2uq2OrRAM8NoIPUeBhoaBJuOKbobSwK1Zro+P/F28E5Iv5PHkV+dBXF/b
 Uds0VJNDV0Uc2Fwkolpv172Pvz+h3b0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72--T1pOcztMt-U7hesQs_cHQ-1; Mon, 04 May 2020 09:20:13 -0400
X-MC-Unique: -T1pOcztMt-U7hesQs_cHQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50F65107ACF4;
 Mon,  4 May 2020 13:20:06 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7514062486;
 Mon,  4 May 2020 13:19:56 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 5BCA917477; Mon,  4 May 2020 15:19:55 +0200 (CEST)
Date: Mon, 4 May 2020 15:19:55 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v3 08/15] acpi: serial: don't use _STA method
Message-ID: <20200504131955.356mjjafk4aq43ko@sirius.home.kraxel.org>
References: <20200429140003.7336-1-kraxel@redhat.com>
 <20200429140003.7336-9-kraxel@redhat.com>
 <f79d7f70-7377-3740-69c9-687641565fce@redhat.com>
MIME-Version: 1.0
In-Reply-To: <f79d7f70-7377-3740-69c9-687641565fce@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 01:21:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> > -static Aml *build_com_device_aml(uint8_t uid)
> > +static void build_com_device_aml(Aml *scope, uint8_t uid)
> >   {
> >       Aml *dev;
> >       Aml *crs;
> > -    Aml *method;
> > -    Aml *if_ctx;
> > -    Aml *else_ctx;
> > -    Aml *zero =3D aml_int(0);
> > -    Aml *is_present =3D aml_local(0);
> > -    const char *enabled_field =3D "CAEN";
> >       uint8_t irq =3D 4;
> >       uint16_t io_port =3D 0x03F8;
> >       assert(uid =3D=3D 1 || uid =3D=3D 2);
> >       if (uid =3D=3D 2) {
> > -        enabled_field =3D "CBEN";
> >           irq =3D 3;
> >           io_port =3D 0x02F8;
> >       }
> > +    if (!memory_region_present(get_system_io(), io_port)) {
> > +        return;
> > +    }
>=20
> The patch looks OK, but an you split this check into a separate (previous=
?)
> patch please?

I don't think this belongs to a separate patch.  It is basically the
same check the lpc bridge is doing when filling the pci config space
(see hw/isa/lpc_ich9.c).  So this effectively maintains the existing
logic, only that we now check directly instead of letting the guest
check the pci config space bit via _STA method.

Also note this is only temporary for bisecting, the next patch in the
series moves the code to a device callback so this kind of "device
exists" check is not needed any more.

take care,
  Gerd


