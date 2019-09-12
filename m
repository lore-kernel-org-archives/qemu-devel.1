Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9279DC49ED9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 08:04:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6818B2075C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 08:04:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6818B2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8K5D-000299-KZ
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 04:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57029)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i8K4R-0001fg-47
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 04:03:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i8K4P-0004EW-Tm
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 04:03:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59200)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i8K4L-0004CL-NP; Thu, 12 Sep 2019 04:03:09 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4735CC051688;
 Thu, 12 Sep 2019 08:03:08 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-179.ams2.redhat.com [10.36.116.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EF9AA60852;
 Thu, 12 Sep 2019 08:03:04 +0000 (UTC)
Date: Thu, 12 Sep 2019 10:03:03 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190912080303.GB5383@linux.fritz.box>
References: <20190911220849.30840-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190911220849.30840-1-philmd@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Thu, 12 Sep 2019 08:03:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] block/create: Do not abort if a block
 driver is not available
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 12.09.2019 um 00:08 hat Philippe Mathieu-Daud=E9 geschrieben:
> The 'blockdev-create' QMP command was introduced as experimental
> feature in commit b0292b851b8, using the assert() debug call.
> It got promoted to 'stable' command in 3fb588a0f2c, but the
> assert call was not removed.
>=20
> Some block drivers are optional, and bdrv_find_format() might
> return a NULL value, triggering the assertion.
>=20
> Stable code is not expected to abort, so return an error instead.
>=20
> This is easily reproducible when libnfs is not installed:
>=20
>   ./configure
>   [...]
>   module support    no
>   Block whitelist (rw)
>   Block whitelist (ro)
>   libiscsi support  yes
>   libnfs support    no
>   [...]
>=20
> Start QEMU:
>=20
>   $ qemu-system-x86_64 -S -qmp unix:/tmp/qemu.qmp,server,nowait
>=20
> Send the 'blockdev-create' with the 'nfs' driver:
>=20
>   $ ( cat << 'EOF'
>   {'execute': 'qmp_capabilities'}
>   {'execute': 'blockdev-create', 'arguments': {'job-id': 'x', 'options'=
: {'size': 0, 'driver': 'nfs', 'location': {'path': '/', 'server': {'host=
': '::1', 'type': 'inet'}}}}, 'id': 'x'}
>   EOF
>   ) | socat STDIO UNIX:/tmp/qemu.qmp
>   {"QMP": {"version": {"qemu": {"micro": 50, "minor": 1, "major": 4}, "=
package": "v4.1.0-733-g89ea03a7dc"}, "capabilities": ["oob"]}}
>   {"return": {}}
>=20
> QEMU crashes:
>=20
>   $ gdb qemu-system-x86_64 core
>   Program received signal SIGSEGV, Segmentation fault.
>   (gdb) bt
>   #0  0x00007ffff510957f in raise () at /lib64/libc.so.6
>   #1  0x00007ffff50f3895 in abort () at /lib64/libc.so.6
>   #2  0x00007ffff50f3769 in _nl_load_domain.cold.0 () at /lib64/libc.so=
.6
>   #3  0x00007ffff5101a26 in .annobin_assert.c_end () at /lib64/libc.so.=
6
>   #4  0x0000555555d7e1f1 in qmp_blockdev_create (job_id=3D0x555556baee4=
0 "x", options=3D0x555557666610, errp=3D0x7fffffffc770) at block/create.c=
:69
>   #5  0x0000555555c96b52 in qmp_marshal_blockdev_create (args=3D0x7fffd=
c003830, ret=3D0x7fffffffc7f8, errp=3D0x7fffffffc7f0) at qapi/qapi-comman=
ds-block-core.c:1314
>   #6  0x0000555555deb0a0 in do_qmp_dispatch (cmds=3D0x55555645de70 <qmp=
_commands>, request=3D0x7fffdc005c70, allow_oob=3Dfalse, errp=3D0x7ffffff=
fc898) at qapi/qmp-dispatch.c:131
>   #7  0x0000555555deb2a1 in qmp_dispatch (cmds=3D0x55555645de70 <qmp_co=
mmands>, request=3D0x7fffdc005c70, allow_oob=3Dfalse) at qapi/qmp-dispatc=
h.c:174
>=20
> With this patch applied, QEMU returns a QMP error:
>=20
>   {'execute': 'blockdev-create', 'arguments': {'job-id': 'x', 'options'=
: {'size': 0, 'driver': 'nfs', 'location': {'path': '/', 'server': {'host=
': '::1', 'type': 'inet'}}}}, 'id': 'x'}
>   {"id": "x", "error": {"class": "GenericError", "desc": "Block driver =
'nfs' not found or not supported"}}
>=20
> Reported-by: Xu Tian <xutian@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Thanks, applied to the block branch.

Kevin

