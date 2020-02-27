Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8FCC4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 09:20:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D65E21556
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 09:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KNuSCAtx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D65E21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7FLc-0006He-K6
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 04:20:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45655)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jtomko@redhat.com>) id 1j7FKx-0005it-Rb
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:20:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jtomko@redhat.com>) id 1j7FKw-0007TX-HW
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:20:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47340
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jtomko@redhat.com>) id 1j7FKv-0007SX-Cm
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:20:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582795205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ggc48hQP7lEqc9Z++UVVC4kuuDpGVV9zn5U7YzBr8Qo=;
 b=KNuSCAtxBAy065nEABhvCPX482yvLCDCUrwspA2ZQc4zffZRgGkVr/AzwrRYimJNHcF47B
 ZJQSK88WRK14OLVoK/nvHn9YaSCcpJQcyek6EQdQSullYVo7Hknk9ASpNnFn4RKAZlHkrg
 qHVVfcVXjaPlIv7SRG9l2HzpY0TWyss=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-U2RQQRHNPZqdav-7JZIQ8w-1; Thu, 27 Feb 2020 04:20:02 -0500
X-MC-Unique: U2RQQRHNPZqdav-7JZIQ8w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC5EA107ACCA;
 Thu, 27 Feb 2020 09:20:01 +0000 (UTC)
Received: from lpt (unknown [10.43.2.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D3F031001925;
 Thu, 27 Feb 2020 09:19:57 +0000 (UTC)
Date: Thu, 27 Feb 2020 10:19:55 +0100
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 1/3] iotests: Specify explicit backing format where
 sensible
Message-ID: <20200227091955.GD2262365@lpt>
References: <20200227023928.1021959-1-eblake@redhat.com>
 <20200227023928.1021959-2-eblake@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200227023928.1021959-2-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Q0rSlbzrZN6k9QnT"
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
Cc: Kevin Wolf <kwolf@redhat.com>, pkrempa@redhat.com, qemu-block@nongnu.org,
 libvir-list@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Q0rSlbzrZN6k9QnT
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On a Wednesday in 2020, Eric Blake wrote:
>There are many existing qcow2 images that specify a backing file but
>no format.  This has been the source of CVEs in the past, but has
>become more prominent of a problem now that libvirt has switched to
>-blockdev.  With older -drive, at least the probing was always done by
>qemu (so the only risk of a changed format between successive boots of
>a guest was if qemu was upgraded and probed differently).  But with
>newer -blockdev, libvirt must specify a format; if libvirt guesses raw
>where the image was formatted, this results in data corruption visible
>to the guest; conversely, if libvirt guesses qcow2 where qemu was
>using raw, this can result in potential security holes, so modern
>libvirt instead refuses to use images without explicit backing format.
>
>The change in libvirt to reject images without explicit backing format
>has pointed out that a number of tools have been far too reliant on
>probing in the past.  It's time to set a better example in our own
>iotests of properly setting this parameter.
>
>iotest calls to create, rebase, convert, and amend are all impacted to
>some degree.  It's a bit annoying that we are inconsistent on command
>line - while all of those accept -o backing_file=3D...,backing_fmt=3D...,
>the shortcuts are different: create and rebase have -b and -F, convert
>has -B but no -F, and amend has no shortcuts.
>
>Signed-off-by: Eric Blake <eblake@redhat.com>
>---

[...]

Test #225 still uses -b without a format:

./check -vmdk 225
QEMU          -- "/home/jtomko/work/qemu/build/tests/qemu-iotests/../../x86=
_64-softmmu/qemu-system-x86_64" -nodefaults -display none -accel qtest
QEMU_IMG      -- "/home/jtomko/work/qemu/build/tests/qemu-iotests/../../qem=
u-img"=20
QEMU_IO       -- "/home/jtomko/work/qemu/build/tests/qemu-iotests/../../qem=
u-io"  --cache writeback --aio threads -f vmdk
QEMU_NBD      -- "/home/jtomko/work/qemu/build/tests/qemu-iotests/../../qem=
u-nbd"=20
IMGFMT        -- vmdk
IMGPROTO      -- file
PLATFORM      -- Linux/x86_64 lpt 5.4.18-200.fc31.x86_64
TEST_DIR      -- /home/jtomko/work/qemu/build/tests/qemu-iotests/scratch
SOCK_DIR      -- /tmp/tmp.OQIdhLcITP
SOCKET_SCM_HELPER -- /home/jtomko/work/qemu/build/tests/qemu-iotests/socket=
_scm_helper

225      fail       [10:02:31] [10:02:32]                    output mismatc=
h (see 225.out.bad)
--- /home/jtomko/work/qemu/tests/qemu-iotests/225.out   2018-09-07 17:21:39=
.633931691 +0200
+++ /home/jtomko/work/qemu/build/tests/qemu-iotests/225.out.bad 2020-02-27 =
10:02:32.362755677 +0100
@@ -1,6 +1,7 @@
  QA output created by 225
  Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D1048576
  Formatting 'TEST_DIR/t.IMGFMT.not_base', fmt=3DIMGFMT size=3D1048576
+qemu-img: warning: Deprecated use of backing file without explicit backing=
 format (detected format of IMGFMT)
  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 backing_file=
=3DTEST_DIR/t.IMGFMT.base
 =20
  =3D=3D=3D Testing fitting VMDK backing image =3D=3D=3D
Failures: 225
Failed 1 of 1 iotests

>diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
>index aa911d266a13..322e31e2cd93 100755
>--- a/tests/qemu-iotests/030
>+++ b/tests/qemu-iotests/030
>@@ -32,8 +32,12 @@ class TestSingleDrive(iotests.QMPTestCase):
>
>     def setUp(self):
>         iotests.create_image(backing_img, TestSingleDrive.image_len)
>-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%s=
' % backing_img, mid_img)
>-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%s=
' % mid_img, test_img)
>+        qemu_img('create', '-f', iotests.imgfmt,
>+                 '-o', 'backing_file=3D%s' % backing_img,
>+                 '-F', 'raw', mid_img)
>+        qemu_img('create', '-f', iotests.imgfmt,
>+                 '-o', 'backing_file=3D%s' % mid_img,
>+                 '-F', iotests.imgfmt, test_img)

Consider not mixing shortcuts with -o options.

>         qemu_io('-f', 'raw', '-c', 'write -P 0x1 0 512', backing_img)
>         qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0x1 524288 512', mi=
d_img)
>         self.vm =3D iotests.VM().add_drive("blkdebug::" + test_img,

With test #225 fixed:
Reviewed-by: J=E1n Tomko <jtomko@redhat.com>

Jano

--Q0rSlbzrZN6k9QnT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEQeJGMrnL0ADuclbP+YPwO/Mat50FAl5XibcACgkQ+YPwO/Ma
t506XQf9EbQsdTlFKYh8WLsWl4Rj4UOa73vFH93nhEVkTnZLI5trcSm1hlqM/cMK
MD9I/tukrqXzMyRESdRFiziLEstx535M9WVUkD9IZHhkWC1ZVlJZCxrWUYntDB5y
GRqpRsqq65gtkT/lvEpFjeQhwCPa8OaxiaE4RykJ8TgQlSh+WngHKxcJAnruYg2M
N7akz7+RuYM0k6xFrttc7dCRPIHA/D128dIqIO14L54df/+aIXvmA6GcvVtB8pqW
XXAxYSt/uTzAff08aCqZb1Eow/xHuG1xGQnr5qp5bathHv8QVYAuOhTbq7wZrBzt
09ugC7F+dzPuOzJvAjgPMAApe5fyGQ==
=1Dqd
-----END PGP SIGNATURE-----

--Q0rSlbzrZN6k9QnT--


