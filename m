Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2427FC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 12:39:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E37CE206F4
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 12:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OF6xoDeS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E37CE206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j429i-0001H0-2j
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 07:39:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38212)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j4296-0000e2-53
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:38:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j4294-0007Bx-LS
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:38:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45899
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j4294-0007BT-HU
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:38:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582029513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F1FKo9mYOSiFcQ4sNOs0P0U4UFNYW2/4fafzSI2lt/M=;
 b=OF6xoDeS9HYvmzDhHZ0ALaBQVxJMhls2/Ad7T7joUazbsdVDn7wKTXEb0FEqipw+3cjR1Z
 cWGy5DlgX7ztDKDVzTmmT28TVsk9/EAVY/AsLymCnOPBI6ft8rTMIKQBCqfZZiKX/Sxlgl
 uFZ2bJJWQIS/ltGiqHMKLgGokpH+Q8s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-VWeRu1dOPcWZmoFEqOXLAA-1; Tue, 18 Feb 2020 07:38:31 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5660713E4;
 Tue, 18 Feb 2020 12:38:30 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-181.ams2.redhat.com [10.36.117.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 25C2A5C1B2;
 Tue, 18 Feb 2020 12:38:28 +0000 (UTC)
Date: Tue, 18 Feb 2020 13:38:27 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v4 18/19] iotests: Add tests for invalid Quorum @replaces
Message-ID: <20200218123827.GC6157@linux.fritz.box>
References: <20200218103454.296704-1-mreitz@redhat.com>
 <20200218103454.296704-19-mreitz@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200218103454.296704-19-mreitz@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: VWeRu1dOPcWZmoFEqOXLAA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 18.02.2020 um 11:34 hat Max Reitz geschrieben:
> Add two tests to see that you cannot replace a Quorum child with the
> mirror job while the child is in use by a different parent.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  tests/qemu-iotests/041     | 70 +++++++++++++++++++++++++++++++++++++-
>  tests/qemu-iotests/041.out |  4 +--
>  2 files changed, 71 insertions(+), 3 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
> index 1d9e64ff6d..53c8671969 100755
> --- a/tests/qemu-iotests/041
> +++ b/tests/qemu-iotests/041
> @@ -20,6 +20,7 @@
> =20
>  import time
>  import os
> +import re
>  import iotests
>  from iotests import qemu_img, qemu_io
> =20
> @@ -34,6 +35,8 @@ quorum_img3 =3D os.path.join(iotests.test_dir, 'quorum3=
.img')
>  quorum_repair_img =3D os.path.join(iotests.test_dir, 'quorum_repair.img'=
)
>  quorum_snapshot_file =3D os.path.join(iotests.test_dir, 'quorum_snapshot=
.img')
> =20
> +nbd_sock_path =3D os.path.join(iotests.test_dir, 'nbd.sock')
> +
>  class TestSingleDrive(iotests.QMPTestCase):
>      image_len =3D 1 * 1024 * 1024 # MB
>      qmp_cmd =3D 'drive-mirror'
> @@ -892,7 +895,8 @@ class TestRepairQuorum(iotests.QMPTestCase):
> =20
>      def tearDown(self):
>          self.vm.shutdown()
> -        for i in self.IMAGES + [ quorum_repair_img, quorum_snapshot_file=
 ]:
> +        for i in self.IMAGES + [ quorum_repair_img, quorum_snapshot_file=
,
> +                                 nbd_sock_path ]:
>              # Do a try/except because the test may have deleted some ima=
ges
>              try:
>                  os.remove(i)
> @@ -1032,6 +1036,70 @@ class TestRepairQuorum(iotests.QMPTestCase):
>          self.assert_has_block_node("repair0", quorum_repair_img)
>          self.vm.assert_block_path('quorum0', '/children.1', 'repair0')
> =20
> +    def test_with_other_parent(self):
> +        """
> +        Check that we cannot replace a Quorum child when it has other
> +        parents.
> +        """
> +        result =3D self.vm.qmp('nbd-server-start',
> +                             addr=3D{
> +                                 'type': 'unix',
> +                                 'data': {'path': nbd_sock_path}
> +                             })
> +        self.assert_qmp(result, 'return', {})
> +
> +        result =3D self.vm.qmp('nbd-server-add', device=3D'img1')
> +        self.assert_qmp(result, 'return', {})
> +
> +        result =3D self.vm.qmp('drive-mirror', job_id=3D'mirror', device=
=3D'quorum0',
> +                             sync=3D'full', node_name=3D'repair0', repla=
ces=3D'img1',
> +                             target=3Dquorum_repair_img, format=3Diotest=
s.imgfmt)
> +        self.assert_qmp(result, 'error/desc',
> +                        "Cannot replace 'img1' by a node mirrored from "
> +                        "'quorum0', because it cannot be guaranteed that=
 doing "
> +                        "so would not lead to an abrupt change of visibl=
e data")
> +
> +    def test_with_other_parents_after_mirror_start(self):
> +        """
> +        The same as test_with_other_parent(), but add the NBD server
> +        only when the mirror job is already running.
> +        """
> +        result =3D self.vm.qmp('nbd-server-start',
> +                             addr=3D{
> +                                 'type': 'unix',
> +                                 'data': {'path': nbd_sock_path}
> +                             })
> +        self.assert_qmp(result, 'return', {})
> +
> +        result =3D self.vm.qmp('drive-mirror', job_id=3D'mirror', device=
=3D'quorum0',
> +                             sync=3D'full', node_name=3D'repair0', repla=
ces=3D'img1',
> +                             target=3Dquorum_repair_img, format=3Diotest=
s.imgfmt)
> +        self.assert_qmp(result, 'return', {})
> +
> +        result =3D self.vm.qmp('nbd-server-add', device=3D'img1')
> +        self.assert_qmp(result, 'return', {})
> +
> +        # The full error message goes to stderr, we will check it later
> +        self.complete_and_wait('mirror',
> +                               completion_error=3D'Operation not permitt=
ed')
> +
> +        # Should not have been replaced
> +        self.vm.assert_block_path('quorum0', '/children.1', 'img1')
> +
> +        # Check the full error message now
> +        self.vm.shutdown()
> +        log =3D self.vm.get_log()
> +        log =3D re.sub(r'^\[I \d+\.\d+\] OPENED\n', '', log)
> +        log =3D re.sub(r'^Formatting.*\n', '', log)
> +        log =3D re.sub(r'\n\[I \+\d+\.\d+\] CLOSED\n?$', '', log)
> +        log =3D re.sub(r'^qemu-system-[^:]*: ', '', log)

I would have applied the series, but:

+.........................F................................................=
....................
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+FAIL: test_with_other_parents_after_mirror_start (__main__.TestRepairQuoru=
m)
+----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "041", line 1099, in test_with_other_parents_after_mirror_start
+    "it can no longer be guaranteed that doing so would " +
+AssertionError: "qemu: Can no longer replace 'img1' by 're[107 chars]data"=
 !=3D "Can no longer replace 'img1' by 'repair0'[101 chars]data"
+- qemu: Can no longer replace 'img1' by 'repair0', because it can no longe=
r be guaranteed that doing so would not lead to an abrupt change of visible=
 data
+? ------
++ Can no longer replace 'img1' by 'repair0', because it can no longer be g=
uaranteed that doing so would not lead to an abrupt change of visible data
+
+

If you agree, I can just change this line while applying into:

    log =3D re.sub(r'^qemu[^:]*: ', '', log)

Kevin


