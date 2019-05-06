Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24160C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 08:08:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA2832082F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 08:08:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA2832082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52127 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNYgA-0002E4-7k
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 04:08:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hNYf0-0001d0-8r
	for qemu-devel@nongnu.org; Mon, 06 May 2019 04:07:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hNYey-0007wk-Bt
	for qemu-devel@nongnu.org; Mon, 06 May 2019 04:07:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hNYew-0007uF-Ev
	for qemu-devel@nongnu.org; Mon, 06 May 2019 04:07:40 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BBE9630832C2;
	Mon,  6 May 2019 08:07:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E100512F9;
	Mon,  6 May 2019 08:07:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 9B2101132B35; Mon,  6 May 2019 10:07:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
References: <20190427135642.16464-1-philmd@redhat.com>
Date: Mon, 06 May 2019 10:07:26 +0200
In-Reply-To: <20190427135642.16464-1-philmd@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Sat,
	27 Apr 2019 15:56:42 +0200")
Message-ID: <87woj4roox.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Mon, 06 May 2019 08:07:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] qom/object: Display more helpful message
 when an object type is missing
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Eduardo Habkost <ehabkost@redhat.com>,
	Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> When writing a new board, adding device which uses other devices
> (container) or simply refactoring, one can discover the hard way
> his machine misses some devices. In the case of containers, the
> error is not obvious:
>
>   $ qemu-system-microblaze -M xlnx-zynqmp-pmu
>   **
>   ERROR:/source/qemu/qom/object.c:454:object_initialize_with_type: assert=
ion failed: (type !=3D NULL)
>   Aborted (core dumped)
>
> And we have to look at the coredump to figure the error:
>
>   (gdb) bt
>   #1  0x00007f84773cf895 in abort () at /lib64/libc.so.6
>   #2  0x00007f847961fb53 in  () at /lib64/libglib-2.0.so.0
>   #3  0x00007f847967a4de in g_assertion_message_expr () at /lib64/libglib=
-2.0.so.0
>   #4  0x000055c4bcac6c11 in object_initialize_with_type (data=3Ddata@entr=
y=3D0x55c4bdf239e0, size=3Dsize@entry=3D2464, type=3D<optimized out>) at /s=
ource/qemu/qom/object.c:454
>   #5  0x000055c4bcac6e6d in object_initialize (data=3Ddata@entry=3D0x55c4=
bdf239e0, size=3Dsize@entry=3D2464, typename=3Dtypename@entry=3D0x55c4bcc7c=
643 "xlnx.zynqmp_ipi") at /source/qemu/qom/object.c:474
>   #6  0x000055c4bc9ea474 in xlnx_zynqmp_pmu_init (machine=3D0x55c4bdd4600=
0) at /source/qemu/hw/microblaze/xlnx-zynqmp-pmu.c:176
>   #7  0x000055c4bca3b6cb in machine_run_board_init (machine=3D0x55c4bdd46=
000) at /source/qemu/hw/core/machine.c:1030
>   #8  0x000055c4bc95f6d2 in main (argc=3D<optimized out>, argv=3D<optimiz=
ed out>, envp=3D<optimized out>) at /source/qemu/vl.c:4479
>
> Since the caller knows the type name requested, we can simply display it
> to ease development.
>
> With this patch applied we get:
>
>   $ qemu-system-microblaze -M xlnx-zynqmp-pmu
>   qemu-system-microblaze: missing object type 'xlnx.zynqmp_ipi'
>   Aborted (core dumped)

I'd phrase it like "object type '%s' missing from build".  Suggestion,
not demand.

> Since the assert(type) check in object_initialize_with_type() is
> now impossible, remove it.

You're right, it's impossible (I checked).  Are we sure it'll stay
impossible?

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  qom/object.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/qom/object.c b/qom/object.c
> index e3206d6799e..b1ba62c5b9e 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -28,6 +28,7 @@
>  #include "qapi/qmp/qbool.h"
>  #include "qapi/qmp/qnum.h"
>  #include "qapi/qmp/qstring.h"
> +#include "qemu/error-report.h"
>=20=20
>  #define MAX_INTERFACES 32
>=20=20
> @@ -451,7 +452,6 @@ static void object_initialize_with_type(void *data, s=
ize_t size, TypeImpl *type)
>  {
>      Object *obj =3D data;
>=20=20
> -    g_assert(type !=3D NULL);
>      type_initialize(type);
>=20=20
>      g_assert(type->instance_size >=3D sizeof(Object));
> @@ -471,6 +471,11 @@ void object_initialize(void *data, size_t size, cons=
t char *typename)
>  {
>      TypeImpl *type =3D type_get_by_name(typename);
>=20=20
> +    if (!type) {
> +        error_report("missing object type '%s'", typename);
> +        abort();
> +    }
> +
>      object_initialize_with_type(data, size, type);
>  }

