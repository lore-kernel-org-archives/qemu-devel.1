Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997C4C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 10:26:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 626382070A
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 10:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hAjRygAp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 626382070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jolYi-0003uB-Mc
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 06:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jolXp-0003IV-Rq
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 06:25:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53454
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jolXn-0001Jj-KG
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 06:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593167114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t1RoBaSPs+TD4VwL50CYZEX8XIKOKS1U7Xfk+1PBURM=;
 b=hAjRygApPgdX8cctGAnHkU/1gD7/BMeWQv5tBUUGjh0rRL+dtD+114DP2ZySqO53vD+QEt
 CDgM5sHygzzHtSme9t/yBLh0lJCQTPtMNaDWUk+9MxF9wOW/CXN10MKKcAw8ynz3T3VD/m
 N9t0QRg+ouno1NzwMYOltn8kGsyxcnE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-6s-msAWOMEmB2uFss6TwHg-1; Fri, 26 Jun 2020 06:25:09 -0400
X-MC-Unique: 6s-msAWOMEmB2uFss6TwHg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DC90800C60;
 Fri, 26 Jun 2020 10:25:08 +0000 (UTC)
Received: from localhost (ovpn-114-181.ams2.redhat.com [10.36.114.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D5E085C1BB;
 Fri, 26 Jun 2020 10:25:07 +0000 (UTC)
Date: Fri, 26 Jun 2020 11:25:06 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/12] Block patches
Message-ID: <20200626102506.GD281902@stefanha-x1.localdomain>
References: <20200624100210.59975-1-stefanha@redhat.com>
 <CAFEAcA_K7MtnEjRMZCbmYrJCm6qD4N7ZMHvGuAzXL9gD2zQNuA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_K7MtnEjRMZCbmYrJCm6qD4N7ZMHvGuAzXL9gD2zQNuA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="q9KOos5vDmpwPx9o"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 01:49:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--q9KOos5vDmpwPx9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2020 at 02:31:14PM +0100, Peter Maydell wrote:
> On Wed, 24 Jun 2020 at 11:02, Stefan Hajnoczi <stefanha@redhat.com> wrote=
:
> >
> > The following changes since commit 171199f56f5f9bdf1e5d670d09ef1351d8f0=
1bae:
> >
> >   Merge remote-tracking branch 'remotes/alistair/tags/pull-riscv-to-app=
ly-20200619-3' into staging (2020-06-22 14:45:25 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/stefanha/qemu.git tags/block-pull-request
> >
> > for you to fetch changes up to 7838c67f22a81fcf669785cd6c0876438422071a=
:
> >
> >   block/nvme: support nested aio_poll() (2020-06-23 15:46:08 +0100)
> >
> > ----------------------------------------------------------------
> > Pull request
> >
> > ----------------------------------------------------------------
>=20
> Failure on iotest 030, x86-64 Linux:
>=20
>   TEST    iotest-qcow2: 030 [fail]
> QEMU          --
> "/home/petmay01/linaro/qemu-for-merges/build/alldbg/tests/qemu-iotests/..=
/../x86_64-softmmu/qemu-system-x86_64"
> -nodefaults -display none -accel qtest
> QEMU_IMG      --
> "/home/petmay01/linaro/qemu-for-merges/build/alldbg/tests/qemu-iotests/..=
/../qemu-img"
> QEMU_IO       --
> "/home/petmay01/linaro/qemu-for-merges/build/alldbg/tests/qemu-iotests/..=
/../qemu-io"
>  --cache writeback --aio threads -f qcow2
> QEMU_NBD      --
> "/home/petmay01/linaro/qemu-for-merges/build/alldbg/tests/qemu-iotests/..=
/../qemu-nbd"
> IMGFMT        -- qcow2 (compat=3D1.1)
> IMGPROTO      -- file
> PLATFORM      -- Linux/x86_64 e104462 4.15.0-76-generic
> TEST_DIR      --
> /home/petmay01/linaro/qemu-for-merges/build/alldbg/tests/qemu-iotests/scr=
atch
> SOCK_DIR      -- /tmp/tmp.8tgdDjoZcO
> SOCKET_SCM_HELPER --
> /home/petmay01/linaro/qemu-for-merges/build/alldbg/tests/qemu-iotest/sock=
et_scm_helper
>=20
> --- /home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/030.out
>  2019-07-15 17:18:35.251364738 +0100
> +++ /home/petmay01/linaro/qemu-for-merges/build/alldbg/tests/qemu-iotests=
/030.out.bad
>   2020-06-25 14:04:28.500534007 +0100
> @@ -1,5 +1,17 @@
> -...........................
> +.............F.............
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +FAIL: test_stream_parallel (__main__.TestParallelOps)
> +----------------------------------------------------------------------
> +Traceback (most recent call last):
> +  File "030", line 246, in test_stream_parallel
> +    self.assert_qmp(result, 'return', {})
> +  File "/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/iotests=
.py",
> line 848, in assert_qmp
> +    result =3D self.dictpath(d, path)
> +  File "/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/iotests=
.py",
> line 822, in dictpath
> +    self.fail(f'failed path traversal for "{path}" in "{d}"')
> +AssertionError: failed path traversal for "return" in "{'error':
> {'class': 'DeviceNotActive', 'desc': "Block job 'stream-node8' not
> found"}}"
> +
>  ----------------------------------------------------------------------
>  Ran 27 tests
>=20
> -OK
> +FAILED (failures=3D1)

Strange, I can't reproduce this failure on my pull request branch or on
qemu.git/master.

Is this failure deterministic? Are you sure it is introduced by this
pull request?

Stefan

--q9KOos5vDmpwPx9o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl71zQIACgkQnKSrs4Gr
c8hMGgf/RmAuXh6t+tWHN562QtST23xndCCtYiXMSzk0kwe04kIbbarpXWgXWJbp
+fx7xiKFL2/rq7Ry3dqzNjeFQbG5h8h6YsB7XemeNjDFrMYsHTgVlZ9jpazwRWzs
onNXQ/WmEFLioFhTGJXSZbIrTgmr0h+SPGjc85oQLt5T8kGcfd1MXrEPsNvNqGJO
3REJnHWwIBfOsskYoJ56fZQZBia5QiJcRonhaomKm6q/lHuVnG8XRUbKBIkO72bm
TyKic0v3AkcR8VjcvGP1PxnZjXthSH7NwRaTXpm636g8ImmK8bNm5naVd8IotBBc
Q4NYSLB+7l0zJiSgvS5Ws5gANzSRrw==
=z/qP
-----END PGP SIGNATURE-----

--q9KOos5vDmpwPx9o--


