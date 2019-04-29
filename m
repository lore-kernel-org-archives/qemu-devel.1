Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65339C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 07:14:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 356882053B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 07:14:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 356882053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53272 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL0Uk-0002zp-GH
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 03:14:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hL0TW-0002OG-46
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 03:13:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hL0TV-0000GH-3o
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 03:13:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1hL0TU-0000Fv-UO
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 03:13:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4B53E307D92F;
	Mon, 29 Apr 2019 07:13:15 +0000 (UTC)
Received: from gondolin (dhcp-192-187.str.redhat.com [10.33.192.187])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3B989608C2;
	Mon, 29 Apr 2019 07:13:11 +0000 (UTC)
Date: Mon, 29 Apr 2019 09:13:09 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Message-ID: <20190429091309.24c240d4.cohuck@redhat.com>
In-Reply-To: <20190427135642.16464-1-philmd@redhat.com>
References: <20190427135642.16464-1-philmd@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Mon, 29 Apr 2019 07:13:15 +0000 (UTC)
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
Cc: Markus Armbruster <armbru@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429071309.wfPddQ58-4_cBS5FfpITESgMbl0UoQdNUX_VrztyIEk@z>

On Sat, 27 Apr 2019 15:56:42 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> When writing a new board, adding device which uses other devices
> (container) or simply refactoring, one can discover the hard way
> his machine misses some devices. In the case of containers, the
> error is not obvious:
>=20
>   $ qemu-system-microblaze -M xlnx-zynqmp-pmu
>   **
>   ERROR:/source/qemu/qom/object.c:454:object_initialize_with_type: assert=
ion failed: (type !=3D NULL)
>   Aborted (core dumped)
>=20
> And we have to look at the coredump to figure the error:
>=20
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
>=20
> Since the caller knows the type name requested, we can simply display it
> to ease development.
>=20
> With this patch applied we get:
>=20
>   $ qemu-system-microblaze -M xlnx-zynqmp-pmu
>   qemu-system-microblaze: missing object type 'xlnx.zynqmp_ipi'
>   Aborted (core dumped)
>=20
> Since the assert(type) check in object_initialize_with_type() is
> now impossible, remove it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  qom/object.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Way more helpful error message :)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

