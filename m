Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7173BC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 11:15:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B90D206D4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 11:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ci7/qOVF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B90D206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuaSq-0000Ed-1x
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 06:15:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57540)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iuaRi-0007Wy-A4
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:14:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iuaRg-0006kn-IP
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:14:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25293
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iuaRg-0006jl-Ex
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:14:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579778083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rEebFBw7SpbmOI2hX22NWiear+WhBl1mdoSJbxzjPVw=;
 b=ci7/qOVFWdOSvgzMc5pv6PZVHnZOmjL2vGGfyXjfWBYJEBbqWGBL7r9Vc7W4mobpgbUtSJ
 oqZe2OKmHLDNce2IY2BbSAHpw3ttOgBsMFIyJR64HGsYcLaMSSQfD41/PRccknybTra3yr
 WLN4/8YKuBnAjjS7DiYMpkyrHmo9pJE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-ngHRShHgN3CU5WS3-gRB1g-1; Thu, 23 Jan 2020 06:14:41 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D8F28010D6;
 Thu, 23 Jan 2020 11:14:39 +0000 (UTC)
Received: from gondolin (ovpn-116-120.ams2.redhat.com [10.36.116.120])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B88D186456;
 Thu, 23 Jan 2020 11:14:26 +0000 (UTC)
Date: Thu, 23 Jan 2020 12:14:23 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH v5 2/2] tests: add virtio-scsi and virtio-blk
 seg_max_adjust test
Message-ID: <20200123121423.591c5f5d.cohuck@redhat.com>
In-Reply-To: <98adffe7-447f-0b9a-6317-29116067e3fe@redhat.com>
References: <20191220140905.1718-1-dplotnikov@virtuozzo.com>
 <20191220140905.1718-3-dplotnikov@virtuozzo.com>
 <f36d9b80-68d5-016b-310d-44ae671ae68a@redhat.com>
 <98adffe7-447f-0b9a-6317-29116067e3fe@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: ngHRShHgN3CU5WS3-gRB1g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, fam@euphon.net, Hannes Reinecke <hare@suse.com>,
 ehabkost@redhat.com, mst@redhat.com, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Denis Plotnikov <dplotnikov@virtuozzo.com>,
 stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com,
 mreitz@redhat.com, Christoph Hellwig <hch@lst.de>, den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 22 Jan 2020 22:47:42 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:


> > This test is failing on OSX:
> >=20
> > TestFail: machine type pc-i440fx-2.0: <class 'TypeError'>
> >=20
> > Looking at my job-results/job-2020-01-22T17.54-92b7fae/job.log:
> >=20
> > Unexpected error in object_property_find() at qom/object.c:1201:
> > qemu-system-x86_64: -device virtio-blk-pci,id=3Dscsi0,drive=3Ddrive0: c=
an't=20
> > apply global virtio-blk-device.scsi=3Dtrue: Property '.scsi' not found
> >=20
> > Which makes sense looking at hw/block/virtio-blk.c:
> >=20
> > 1261 static Property virtio_blk_properties[] =3D {
> > 1262=C2=A0=C2=A0=C2=A0=C2=A0 DEFINE_BLOCK_PROPERTIES(VirtIOBlock, conf.=
conf),
> > ...
> > 1268 #ifdef __linux__
> > 1269=C2=A0=C2=A0=C2=A0=C2=A0 DEFINE_PROP_BIT64("scsi", VirtIOBlock, hos=
t_features,
> > 1270=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VIRTIO_B=
LK_F_SCSI, false),
> > 1271 #endif
> >=20
> > Except code moved around, origin is:
> >=20
> > $ git show 1063b8b15
> > commit 1063b8b15fb49fcf88ffa282b19aaaf7ca9c678c
> > Author: Christoph Hellwig <hch@lst.de>
> > Date:=C2=A0=C2=A0 Mon Apr 27 10:29:14 2009 +0200
> >=20
> >  =C2=A0=C2=A0=C2=A0 virtio-blk: add SGI_IO passthru support
> >=20
> >  =C2=A0=C2=A0=C2=A0 Add support for SG_IO passthru (packet commands) to=
 the virtio-blk
> >  =C2=A0=C2=A0=C2=A0 backend.=C2=A0 Conceptually based on an older patch=
 from Hannes Reinecke
> >  =C2=A0=C2=A0=C2=A0 but largely rewritten to match the code structure a=
nd layering in
> >  =C2=A0=C2=A0=C2=A0 virtio-blk.
> >=20
> >  =C2=A0=C2=A0=C2=A0 Note that currently we issue the hose SG_IO synchro=
nously.=C2=A0 We could
> >  =C2=A0=C2=A0=C2=A0 easily switch to async I/O, but that would required=
 either bloating
> >  =C2=A0=C2=A0=C2=A0 the VirtIOBlockReq by the size of struct sg_io_hdr =
or an additional
> >  =C2=A0=C2=A0=C2=A0 memory allocation for each SG_IO request.
> >=20
> > I'm not sure what is the correct way to fix this. =20
>=20
> ... because of:
>=20
> $ git show ed65fd1a27
> commit ed65fd1a2750d24290354cc7ea49caec7c13e30b
> Author: Cornelia Huck <cornelia.huck@de.ibm.com>
> Date:   Fri Oct 16 12:25:54 2015 +0200
>=20
>      virtio-blk: switch off scsi-passthrough by default
>=20
>      Devices that are compliant with virtio-1 do not support scsi
>      passthrough any more (and it has not been a recommended setup
>      anyway for quite some time). To avoid having to switch it off
>      explicitly in newer qemus that turn on virtio-1 by default, let's
>      switch the default to scsi=3Dfalse for 2.5.
>=20
>      Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
>      Message-id: 1444991154-79217-4-git-send-email-cornelia.huck@de.ibm.c=
om
>      Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> diff --git a/include/hw/compat.h b/include/hw/compat.h
> index 095de5d12f..93e71afb4a 100644
> --- a/include/hw/compat.h
> +++ b/include/hw/compat.h
> @@ -2,7 +2,11 @@
>   #define HW_COMPAT_H
>=20
>   #define HW_COMPAT_2_4 \
> -        /* empty */
> +        {\
> +            .driver   =3D "virtio-blk-device",\
> +            .property =3D "scsi",\
> +            .value    =3D "true",\
> +        },

This code has changed a lot in the meantime...

>=20
>   #define HW_COMPAT_2_3 \
>           {\
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 3e230debb8..45a24e4fa6 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -972,7 +972,7 @@ static Property virtio_blk_properties[] =3D {
>       DEFINE_PROP_STRING("serial", VirtIOBlock, conf.serial),
>       DEFINE_PROP_BIT("config-wce", VirtIOBlock, conf.config_wce, 0, true=
),
>   #ifdef __linux__
> -    DEFINE_PROP_BIT("scsi", VirtIOBlock, conf.scsi, 0, true),
> +    DEFINE_PROP_BIT("scsi", VirtIOBlock, conf.scsi, 0, false),
>   #endif
>       DEFINE_PROP_BIT("request-merging", VirtIOBlock,=20
> conf.request_merging, 0,
>                       true),
>=20
> Should this HW_COMPAT_2_4 entry be guarded with ifdef __linux__?

... so something like the following might do the trick:

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 3e288bfceb7f..d8e30e4895d8 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -148,7 +148,8 @@ GlobalProperty hw_compat_2_5[] =3D {
 const size_t hw_compat_2_5_len =3D G_N_ELEMENTS(hw_compat_2_5);
=20
 GlobalProperty hw_compat_2_4[] =3D {
-    { "virtio-blk-device", "scsi", "true" },
+    /* Optional because the 'scsi' property is Linux-only */
+    { "virtio-blk-device", "scsi", "true", .optional =3D true },
     { "e1000", "extra_mac_registers", "off" },
     { "virtio-pci", "x-disable-pcie", "on" },
     { "virtio-pci", "migrate-extra", "off" },


>=20
> Probably nobody ran a pre-2.4 machine out of Linux =3D)
>=20

Yeah. I'm wondering if there's more compat stuff in there that should
be optional. Devices that simply do not exist are not a problem, but
properties that not always exist are.


