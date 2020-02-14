Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFCEC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 13:24:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48C9E2187F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 13:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h5NhLGgC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48C9E2187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2axM-00056Z-G1
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 08:24:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50654)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j2awU-0004F1-Hv
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 08:23:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j2awT-0005Hd-9l
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 08:23:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59344
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j2awT-0005GM-5m
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 08:23:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581686616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QVG7dnOOpyeOJ2MmPfRfZaFuoRCROWV/UQn1NF0IjF8=;
 b=h5NhLGgCs28GD+vEDFq8Iq6bC9ByB4Xcd2gKQuIyPPQXsRj+oGwCNAUVixfBxil9WNQNh7
 /aLxzCG8pbLbubgWTuv9fP3lKtEMKOmSwHGd07Y8yyANNk706M/udq/POn+oecFKGAE7sn
 PVgpODZwdz/RC8omixVgTlgYAjEBnV4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-nTnUqTYCOPixQIDt8DauRQ-1; Fri, 14 Feb 2020 08:23:26 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A669B13E2;
 Fri, 14 Feb 2020 13:23:25 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.141])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 88CB75DA7D;
 Fri, 14 Feb 2020 13:23:21 +0000 (UTC)
Date: Fri, 14 Feb 2020 13:23:18 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: fengzhimin1@huawei.com, qemu-devel@nongnu.org
Subject: Re: [PATCH RFC 00/14] *** multifd for RDMA v2 ***
Message-ID: <20200214132318.GG3283@work-vm>
References: <20200213093755.370-1-fengzhimin1@huawei.com>
 <158158885089.23372.3307991609443123651@a1bbccc8075a>
MIME-Version: 1.0
In-Reply-To: <158158885089.23372.3307991609443123651@a1bbccc8075a>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: nTnUqTYCOPixQIDt8DauRQ-1
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
Cc: zhang.zhanghailiang@huawei.com, jemmy858585@gmail.com, armbru@redhat.com,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make sure that it compiles OK with RDMA compiled out; I think this is a
windows cross build that's failing, but more generally even a Linux box
with no-RDMA libraries.

Dave

* no-reply@patchew.org (no-reply@patchew.org) wrote:
> Patchew URL: https://patchew.org/QEMU/20200213093755.370-1-fengzhimin1@hu=
awei.com/
>=20
>=20
>=20
> Hi,
>=20
> This series failed the docker-mingw@fedora build test. Please find the te=
sting commands and
> their output below. If you have Docker installed, you can probably reprod=
uce it
> locally.
>=20
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #! /bin/bash
> export ARCH=3Dx86_64
> make docker-image-fedora V=3D1 NETWORK=3D1
> time make docker-test-mingw@fedora J=3D14 NETWORK=3D1
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>=20
> /tmp/qemu-test/src/migration/multifd.c:663: undefined reference to `multi=
fd_channel_rdma_connect'
> ../migration/multifd.o: In function `multifd_load_cleanup':
> /tmp/qemu-test/src/migration/multifd.c:843: undefined reference to `qemu_=
rdma_cleanup'
> collect2: error: ld returned 1 exit status
> make[1]: *** [Makefile:206: qemu-system-x86_64w.exe] Error 1
> make: *** [Makefile:497: x86_64-softmmu/all] Error 2
> make: *** Waiting for unfinished jobs....
> ../migration/multifd.o: In function `multifd_rdma_recv_thread':
> /tmp/qemu-test/src/migration/multifd.c:898: undefined reference to `qemu_=
rdma_registration_handle'
> ---
> /tmp/qemu-test/src/migration/multifd.c:663: undefined reference to `multi=
fd_channel_rdma_connect'
> ../migration/multifd.o: In function `multifd_load_cleanup':
> /tmp/qemu-test/src/migration/multifd.c:843: undefined reference to `qemu_=
rdma_cleanup'
> collect2: error: ld returned 1 exit status
> make[1]: *** [Makefile:206: qemu-system-aarch64w.exe] Error 1
> make: *** [Makefile:497: aarch64-softmmu/all] Error 2
> Traceback (most recent call last):
>   File "./tests/docker/docker.py", line 664, in <module>
>     sys.exit(main())
> ---
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run', '=
--label', 'com.qemu.instance.uuid=3D88473d634d6543ea992045cbe9a806e1', '-u'=
, '1003', '--security-opt', 'seccomp=3Dunconfined', '--rm', '-e', 'TARGET_L=
IST=3D', '-e', 'EXTRA_CONFIGURE_OPTS=3D', '-e', 'V=3D', '-e', 'J=3D14', '-e=
', 'DEBUG=3D', '-e', 'SHOW_ENV=3D', '-e', 'CCACHE_DIR=3D/var/tmp/ccache', '=
-v', '/home/patchew2/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', '/=
var/tmp/patchew-tester-tmp-yiq7aevf/src/docker-src.2020-02-13-05.11.35.1374=
:/var/tmp/qemu:z,ro', 'qemu:fedora', '/var/tmp/qemu/run', 'test-mingw']' re=
turned non-zero exit status 2.
> filter=3D--filter=3Dlabel=3Dcom.qemu.instance.uuid=3D88473d634d6543ea9920=
45cbe9a806e1
> make[1]: *** [docker-run] Error 1
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-yiq7aevf/src'
> make: *** [docker-run-test-mingw@fedora] Error 2
>=20
> real    2m35.791s
> user    0m7.717s
>=20
>=20
> The full log is available at
> http://patchew.org/logs/20200213093755.370-1-fengzhimin1@huawei.com/testi=
ng.docker-mingw@fedora/?type=3Dmessage.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


