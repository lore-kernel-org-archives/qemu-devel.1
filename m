Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EADAC54FCB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 12:49:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD75F20728
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 12:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bLywChFB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD75F20728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRxm8-0001YA-MB
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 08:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37226)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jRxl4-0000yN-50
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 08:48:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jRxl2-0004SL-WF
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 08:48:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24034
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jRxl2-0004MI-G3
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 08:48:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587732519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IsbDPoI4pFf4k+Qgnoz7h7oaAxz+dWgBMri81x3Askc=;
 b=bLywChFBIzo/ecqe8qDzIu2nQHxgMJR/vIRY/FLEp3Y7TklQ4BLhDuU0XSfiShthtfQW8s
 urSdhm9ZEKppaxIbTmFWOT9WJNpx95Qb94/CLKV6So+LYA1osJQV+53L+b2eRVJp3juOxM
 X/IqI4XRJaDBHl0Aw6vkcm3C9OeG+QE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-DtINiFQxMBazekGSTBg4kQ-1; Fri, 24 Apr 2020 08:48:33 -0400
X-MC-Unique: DtINiFQxMBazekGSTBg4kQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04F021005510;
 Fri, 24 Apr 2020 12:48:31 +0000 (UTC)
Received: from localhost (ovpn-114-136.ams2.redhat.com [10.36.114.136])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E7BDA60CD3;
 Fri, 24 Apr 2020 12:48:24 +0000 (UTC)
Date: Fri, 24 Apr 2020 13:48:23 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH RESEND v6 00/36] Initial support for multi-process qemu
Message-ID: <20200424124823.GC189569@stefanha-x1.localdomain>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <cover.1587614626.git.elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3siQDZowHQqNOShm"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 03:07:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, liran.alon@oracle.com,
 thanos.makatos@nutanix.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--3siQDZowHQqNOShm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2020 at 09:13:35PM -0700, elena.ufimtseva@oracle.com wrote:
> There is an error in travis-ci build test which does not get reproduced.
>=20
>  TEST    iotest-qcow2: 041 [fail]
> QEMU          -- "/home/travis/build/elena-ufimtseva/qemu-multiprocess/ou=
t-of-tree/build/dir/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86=
_64" -nodefaults -display none -accel qtest
> QEMU_IMG      -- "/home/travis/build/elena-ufimtseva/qemu-multiprocess/ou=
t-of-tree/build/dir/tests/qemu-iotests/../../qemu-img"=20
> QEMU_IO       -- "/home/travis/build/elena-ufimtseva/qemu-multiprocess/ou=
t-of-tree/build/dir/tests/qemu-iotests/../../qemu-io"  --cache writeback --=
aio threads -f qcow2
> QEMU_NBD      -- "/home/travis/build/elena-ufimtseva/qemu-multiprocess/ou=
t-of-tree/build/dir/tests/qemu-iotests/../../qemu-nbd"=20
> IMGFMT        -- qcow2 (compat=3D1.1)
> IMGPROTO      -- file
> PLATFORM      -- Linux/x86_64 travis-job-fc4e2553-b470-4a8b-812e-a4fcf8ba=
094f 5.0.0-1031-gcp
> TEST_DIR      -- /home/travis/build/elena-ufimtseva/qemu-multiprocess/out=
-of-tree/build/dir/tests/qemu-iotests/scratch
> SOCK_DIR      -- /tmp/tmp.LOmYANt5Od
> SOCKET_SCM_HELPER -- /home/travis/build/elena-ufimtseva/qemu-multiprocess=
/out-of-tree/build/dir/tests/qemu-iotests/socket_scm_helper
> --- /home/travis/build/elena-ufimtseva/qemu-multiprocess/tests/qemu-iotes=
ts/041.out=092020-04-22 00:17:23.701844698 +0000
> +++ /home/travis/build/elena-ufimtseva/qemu-multiprocess/out-of-tree/buil=
d/dir/tests/qemu-iotests/041.out.bad=092020-04-22 00:24:39.234343858 +0000
> @@ -1,5 +1,29 @@
> -........................................................................=
......................
> +........................FF..............................................=
......................
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +FAIL: test_with_other_parent (__main__.TestRepairQuorum)
> +----------------------------------------------------------------------
> +Traceback (most recent call last):
> +  File "041", line 1049, in test_with_other_parent
> +    self.assert_qmp(result, 'return', {})
> +  File "/home/travis/build/elena-ufimtseva/qemu-multiprocess/tests/qemu-=
iotests/iotests.py", line 821, in assert_qmp
> +    result =3D self.dictpath(d, path)
> +  File "/home/travis/build/elena-ufimtseva/qemu-multiprocess/tests/qemu-=
iotests/iotests.py", line 797, in dictpath
> +    self.fail('failed path traversal for "%s" in "%s"' % (path, str(d)))
> +AssertionError: failed path traversal for "return" in "{'error': {'class=
': 'GenericError', 'desc': "UNIX socket path '/home/travis/build/elena-ufim=
tseva/qemu-multiprocess/out-of-tree/build/dir/tests/qemu-iotests/scratch/nb=
d.sock' is too long"}}"

UNIX Domain Socket paths have to be 108 characters or less.  The path in
the failed test case is 110 characters long.  You could rename your
branch to "mpqemu" to solve this failure.

Stefan

--3siQDZowHQqNOShm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6i4BcACgkQnKSrs4Gr
c8jyEwf9E7WuRRQv0pc3L2lujkRpCkEzdila1lXJt0GY3rxhpOg6QaOvJk3f69X8
bUNzqFPkyqQJ3p53iMlLhp4/SpXNGL8+3f2QrruGBCoA0RSLkgq+1WomrODr2WO1
NuGDz5ZrFdGB9cfm0YE3yS8Jxy2nVUBlRHNzi4IqHuvEGoFW/2dTC/Mq9l5ARIoX
nPALuJMsn2NNFek7Wq7W+Beh6A/8zCrlxLPbr+RIyawqU63z1oSpOVO2Q5EXG3Ll
bZeKLiVO1ba9wO36OHbuXlsUUI4JiqgbHULn7m/DtSf7AvIi8qEG3IbX69sPPZWO
3qXQ6ElXWclyZTVXzju9t0JASJGJLA==
=YL4C
-----END PGP SIGNATURE-----

--3siQDZowHQqNOShm--


