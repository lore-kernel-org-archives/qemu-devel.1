Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2D5C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 08:34:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 897C020848
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 08:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nn2AX22a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 897C020848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j930L-0005II-QW
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 03:34:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39100)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j92zd-0004gi-HS
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 03:33:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j92zc-0003oP-1s
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 03:33:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33223
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j92zb-0003oE-Ul
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 03:33:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583224410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+9eRQ5M1MwVllmK5P1A1czUNLUQyb8yCSf1kS0QzY/o=;
 b=Nn2AX22aB6eKXTpGX7er1wFhUw45OaARLCrNr2Ey3Uf9vizfAOZXeIQ1gAw1H+dH2cAe1L
 G6WX5ObWRsCFg+qqTUCoi082JL2hYYJ8N1DKEQNVXcDLbRqP8/qrCAASlRKHCtP0o5XSPg
 t2F/uzZ85kG0oa1hVxOMfSKkUNzeZcs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-0Mcjol3hPceDhkzIOhUiyA-1; Tue, 03 Mar 2020 03:33:28 -0500
X-MC-Unique: 0Mcjol3hPceDhkzIOhUiyA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A4AADBA3;
 Tue,  3 Mar 2020 08:33:27 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 85C8E5C1D6;
 Tue,  3 Mar 2020 08:33:23 +0000 (UTC)
Date: Tue, 3 Mar 2020 09:33:21 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Heyi Guo <guoheyi@huawei.com>
Subject: Re: [PATCH v3] hw/smbios: add options for type 4 max-speed and
 current-speed
Message-ID: <20200303093321.262ff477@redhat.com>
In-Reply-To: <997b0093-6820-0c27-0d73-55afb97019f1@huawei.com>
References: <20200303010158.52994-1-guoheyi@huawei.com>
 <997b0093-6820-0c27-0d73-55afb97019f1@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: wanghaibin.wang@huawei.com,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Mar 2020 11:18:56 +0800
Heyi Guo <guoheyi@huawei.com> wrote:

> One comment from myself after going through the code...
>=20
> On 2020/3/3 9:01, Heyi Guo wrote:
> > Common VM users sometimes care about CPU speed, so we add two new
> > options to allow VM vendors to present CPU speed to their users.
> > Normally these information can be fetched from host smbios.
> >
> > Strictly speaking, the "max speed" and "current speed" in type 4
> > are not really for the max speed and current speed of processor, for
> > "max speed" identifies a capability of the system, and "current speed"
> > identifies the processor's speed at boot (see smbios spec), but some
> > applications do not tell the differences.
> >
> > Signed-off-by: Heyi Guo <guoheyi@huawei.com>
> > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> >
> > ---
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Igor Mammedov <imammedo@redhat.com>
> > Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >
> > v2 -> v3:
> > - Refine comments per Igor's suggestion.
> >
> > v1 -> v2:
> > - change "_" in option names to "-"
> > - check if option value is too large to fit in SMBIOS type 4 speed
> > fields.
> > ---
> >   hw/smbios/smbios.c | 29 ++++++++++++++++++++++++++---
> >   qemu-options.hx    |  3 ++-
> >   2 files changed, 28 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> > index ffd98727ee..4c5992241c 100644
> > --- a/hw/smbios/smbios.c
> > +++ b/hw/smbios/smbios.c
> > @@ -94,6 +94,8 @@ static struct {
> >  =20
> >   static struct {
> >       const char *sock_pfx, *manufacturer, *version, *serial, *asset, *=
part;
> > +    uint32_t max_speed;
> > +    uint32_t current_speed; =20
>=20
> How about defining these two fields as uint16_t, just like "speed" in=20
> type17? Then we can also drop the range check against UIN16_MAX.
Well,
someone should check if values provided by user make sense anyway
so check should be there but in some other form.

>=20
> Please advise.
>=20
> Thanks,
>=20
> Heyi
>=20
>=20
> >   } type4;
> >  =20
> >   static struct {
> > @@ -272,6 +274,14 @@ static const QemuOptDesc qemu_smbios_type4_opts[] =
=3D {
> >           .name =3D "version",
> >           .type =3D QEMU_OPT_STRING,
> >           .help =3D "version number",
> > +    },{
> > +        .name =3D "max-speed",
> > +        .type =3D QEMU_OPT_NUMBER,
> > +        .help =3D "max speed in MHz",
> > +    },{
> > +        .name =3D "current-speed",
> > +        .type =3D QEMU_OPT_NUMBER,
> > +        .help =3D "speed at system boot in MHz",
> >       },{
> >           .name =3D "serial",
> >           .type =3D QEMU_OPT_STRING,
> > @@ -586,9 +596,8 @@ static void smbios_build_type_4_table(MachineState =
*ms, unsigned instance)
> >       SMBIOS_TABLE_SET_STR(4, processor_version_str, type4.version);
> >       t->voltage =3D 0;
> >       t->external_clock =3D cpu_to_le16(0); /* Unknown */
> > -    /* SVVP requires max_speed and current_speed to not be unknown. */
> > -    t->max_speed =3D cpu_to_le16(2000); /* 2000 MHz */
> > -    t->current_speed =3D cpu_to_le16(2000); /* 2000 MHz */
> > +    t->max_speed =3D cpu_to_le16(type4.max_speed);
> > +    t->current_speed =3D cpu_to_le16(type4.current_speed);
> >       t->status =3D 0x41; /* Socket populated, CPU enabled */
> >       t->processor_upgrade =3D 0x01; /* Other */
> >       t->l1_cache_handle =3D cpu_to_le16(0xFFFF); /* N/A */
> > @@ -1129,6 +1138,20 @@ void smbios_entry_add(QemuOpts *opts, Error **er=
rp)
> >               save_opt(&type4.serial, opts, "serial");
> >               save_opt(&type4.asset, opts, "asset");
> >               save_opt(&type4.part, opts, "part");
> > +            /*
> > +             * SVVP requires max_speed and current_speed to be set and=
 not being
> > +             * 0 which counts as unknown (SMBIOS 3.1.0/Table 21). Set =
the
> > +             * default value to 2000MHz as we did before.
> > +             */
> > +            type4.max_speed =3D qemu_opt_get_number(opts, "max-speed",=
 2000);
> > +            type4.current_speed =3D qemu_opt_get_number(opts, "current=
-speed",
> > +                                                      2000);
> > +            if (type4.max_speed > UINT16_MAX ||
> > +                type4.current_speed > UINT16_MAX) {
> > +                error_setg(errp, "SMBIOS CPU speed is too large (> %d)=
",
> > +                           UINT16_MAX);
> > +            }
> > +
> >               return;
> >           case 11:
> >               qemu_opts_validate(opts, qemu_smbios_type11_opts, &err);
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index ac315c1ac4..7a2f7c1f66 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -2233,6 +2233,7 @@ DEF("smbios", HAS_ARG, QEMU_OPTION_smbios,
> >       "                specify SMBIOS type 3 fields\n"
> >       "-smbios type=3D4[,sock_pfx=3Dstr][,manufacturer=3Dstr][,version=
=3Dstr][,serial=3Dstr]\n"
> >       "              [,asset=3Dstr][,part=3Dstr]\n"
> > +    "              [,max-speed=3D%d][,current-speed=3D%d]\n"
> >       "                specify SMBIOS type 4 fields\n"
> >       "-smbios type=3D17[,loc_pfx=3Dstr][,bank=3Dstr][,manufacturer=3Ds=
tr][,serial=3Dstr]\n"
> >       "               [,asset=3Dstr][,part=3Dstr][,speed=3D%d]\n"
> > @@ -2255,7 +2256,7 @@ Specify SMBIOS type 2 fields
> >   @item -smbios type=3D3[,manufacturer=3D@var{str}][,version=3D@var{str=
}][,serial=3D@var{str}][,asset=3D@var{str}][,sku=3D@var{str}]
> >   Specify SMBIOS type 3 fields
> >  =20
> > -@item -smbios type=3D4[,sock_pfx=3D@var{str}][,manufacturer=3D@var{str=
}][,version=3D@var{str}][,serial=3D@var{str}][,asset=3D@var{str}][,part=3D@=
var{str}]
> > +@item -smbios type=3D4[,sock_pfx=3D@var{str}][,manufacturer=3D@var{str=
}][,version=3D@var{str}][,serial=3D@var{str}][,asset=3D@var{str}][,part=3D@=
var{str}][,max-speed=3D@var{%d}][,current-speed=3D@var{%d}]
> >   Specify SMBIOS type 4 fields
> >  =20
> >   @item -smbios type=3D17[,loc_pfx=3D@var{str}][,bank=3D@var{str}][,man=
ufacturer=3D@var{str}][,serial=3D@var{str}][,asset=3D@var{str}][,part=3D@va=
r{str}][,speed=3D@var{%d}] =20
>=20


