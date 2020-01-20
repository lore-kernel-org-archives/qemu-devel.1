Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F5CC33CA1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 08:59:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61CF72077C
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 08:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R7zg/DCS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61CF72077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itSub-0006zv-CQ
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 03:59:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52437)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1itStM-0005e2-32
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 03:58:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1itStI-0005mb-6c
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 03:58:39 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51476
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1itStI-0005mP-33
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 03:58:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579510715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RkazA+hfsTOmMoH8eX9vvyHNvJyqX+2/tRL/trjuIq0=;
 b=R7zg/DCS5JcWIapaAVFzFuxJzianGXm8PJ8NdvBHVu75rgRj8pUI/fhQG1OuR+MEs6w5jj
 gepYJb2OMVksWqHIgGQDnj9wNpNcJAmIzZudWWpRPGGwUzwswmFZfyURx3atICp18bmswZ
 BZFhHmk5XxWJyHZCXTcci5PvWFeEelg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-irP2AYaYMqimnsb_7Tk3UA-1; Mon, 20 Jan 2020 03:58:32 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B79CA0CBF
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 08:58:31 +0000 (UTC)
Received: from gondolin (ovpn-205-161.brq.redhat.com [10.40.205.161])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D6F207DB5D;
 Mon, 20 Jan 2020 08:58:27 +0000 (UTC)
Date: Mon, 20 Jan 2020 09:58:24 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH] qom/object: Display more helpful message when an
 interface is missing
Message-ID: <20200120095824.191e38d1.cohuck@redhat.com>
In-Reply-To: <20200118162348.17823-1-philmd@redhat.com>
References: <20200118162348.17823-1-philmd@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: irP2AYaYMqimnsb_7Tk3UA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 18 Jan 2020 17:23:48 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> When adding new devices implementing QOM interfaces, we might
> forgot to add the Kconfig dependency that pulls the required
> objects in when building.
>=20
> Since QOM dependencies are resolved at runtime, we don't get any
> link-time failures, and QEMU aborts while starting:
>=20
>   $ qemu ...
>   Segmentation fault (core dumped)
>=20
>   (gdb) bt
>   #0  0x00007ff6e96b1e35 in raise () from /lib64/libc.so.6
>   #1  0x00007ff6e969c895 in abort () from /lib64/libc.so.6
>   #2  0x00005572bc5051cf in type_initialize (ti=3D0x5572be6f1200) at qom/=
object.c:323
>   #3  0x00005572bc505074 in type_initialize (ti=3D0x5572be6f1800) at qom/=
object.c:301
>   #4  0x00005572bc505074 in type_initialize (ti=3D0x5572be6e48e0) at qom/=
object.c:301
>   #5  0x00005572bc506939 in object_class_by_name (typename=3D0x5572bc5610=
9a) at qom/object.c:959
>   #6  0x00005572bc503dd5 in cpu_class_by_name (typename=3D0x5572bc56109a,=
 cpu_model=3D0x5572be6d9930) at hw/core/cpu.c:286
>=20
> Since the caller has access to the qdev parent/interface names,
> we can simply display them to avoid starting a debugger:
>=20
>   $ qemu ...
>   qemu: missing interface 'fancy-if' for object 'fancy-dev'
>   Aborted (core dumped)
>=20
> This commit is similar to e02bdf1cecd2 ("Display more helpful message
> when an object type is missing").
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  qom/object.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/qom/object.c b/qom/object.c
> index 0d971ca897..36123fb330 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -317,6 +317,11 @@ static void type_initialize(TypeImpl *ti)
> =20
>          for (i =3D 0; i < ti->num_interfaces; i++) {
>              TypeImpl *t =3D type_get_by_name(ti->interfaces[i].typename)=
;
> +            if (!t) {
> +                error_report("missing interface '%s' for object '%s'",
> +                             ti->interfaces[i].typename, parent->name);
> +                abort();
> +            }
>              for (e =3D ti->class->interfaces; e; e =3D e->next) {
>                  TypeImpl *target_type =3D OBJECT_CLASS(e->data)->type;
> =20

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

...but I'm wondering if there are more cases like this? Just to avoid
playing whack-a-mole.


