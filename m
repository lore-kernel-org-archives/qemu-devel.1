Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AECC28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 11:09:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3793257C9
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 11:09:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3793257C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52120 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWIvv-0006My-JE
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 07:09:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hWIqp-0002HE-Nh
	for qemu-devel@nongnu.org; Thu, 30 May 2019 07:04:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hWIqo-0005Vq-Hs
	for qemu-devel@nongnu.org; Thu, 30 May 2019 07:04:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hWIql-0005LV-Mk; Thu, 30 May 2019 07:03:59 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 00775307D848;
	Thu, 30 May 2019 11:03:59 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-119.ams2.redhat.com [10.36.116.119])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E673717C4A;
	Thu, 30 May 2019 11:03:57 +0000 (UTC)
Date: Thu, 30 May 2019 13:03:56 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190530110356.GD4890@linux.fritz.box>
References: <20190530073205.5293-1-kwolf@redhat.com>
	<155920284527.9187.14210063698054538086@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <155920284527.9187.14210063698054538086@ce79690b2cb9>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Thu, 30 May 2019 11:03:59 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 0/6] file-posix: Add
 dynamic-auto-read-only QAPI feature
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
Cc: pkrempa@redhat.com, armbru@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 30.05.2019 um 09:54 hat no-reply@patchew.org geschrieben:
> Patchew URL: https://patchew.org/QEMU/20190530073205.5293-1-kwolf@redhat.=
com/
>=20
>=20
>=20
> Hi,
>=20
> This series failed the asan build test. Please find the testing commands =
and
> their output below. If you have Docker installed, you can probably reprod=
uce it
> locally.
>=20
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> time make docker-test-debug@fedora TARGET_LIST=3Dx86_64-softmmu J=3D14 NE=
TWORK=3D1
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>=20
> clang++ -L/tmp/qemu-test/build/dtc/libfdt  -I/usr/include/pixman-1  -I/tm=
p/qemu-test/src/dtc/libfdt -Werror -DHAS_LIBSSH2_SFTP_FSYNC  -pthread -I/us=
r/include/glib-2.0 -I/usr/lib64/glib-2.0/include  -fPIE -DPIE -m64 -mcx16 -=
D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototyp=
es -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fn=
o-strict-aliasing -fno-common -fwrapv -std=3Dgnu99  -Wno-string-plus-int -W=
no-typedef-redefinition -Wno-initializer-overrides -Wexpansion-to-defined -=
Wendif-labels -Wno-shift-negative-value -Wno-missing-include-dirs -Wempty-b=
ody -Wnested-externs -Wformat-security -Wformat-y2k -Winit-self -Wignored-q=
ualifiers -Wold-style-definition -Wtype-limits -fstack-protector-strong  -I=
/usr/include/p11-kit-1     -I/usr/include/libpng16  -I/usr/include/spice-1 =
-I/usr/include/spice-server -I/usr/include/cacard -I/usr/include/glib-2.0 -=
I/usr/lib64/glib-2.0/include -I/usr/include/nss3 -I/usr/include/nspr4 -pthr=
ead -I/usr/include/libmount -I/usr/include/blkid -I/usr/include/uuid -I/usr=
/include/pixman-1   -I/tmp/qemu-test/src/tests -fsanitize=3Dundefined -fsan=
itize=3Daddress -g  -Wl,--warn-common -Wl,-z,relro -Wl,-z,now -pie -m64 -g =
 -o tests/test-opts-visitor tests/test-opts-visitor.o tests/test-qapi-types=
=2Eo tests/include/test-qapi-types-sub-module.o tests/test-qapi-types-sub-s=
ub-module.o tests/test-qapi-visit.o tests/include/test-qapi-visit-sub-modul=
e.o tests/test-qapi-visit-sub-sub-module.o tests/test-qapi-introspect.o qom=
/object.o qom/container.o qom/qom-qobject.o qom/object_interfaces.o  libqem=
uutil.a   -lm -lz  -lgthread-2.0 -pthread -lglib-2.0  -lnettle  -lgnutls   =
-lrt -lz -lutil -lcap-ng=20
> /usr/bin/ld: tests/test-qapi-commands.o: in function `qmp_marshal_test_fe=
atures':
> /tmp/qemu-test/build/tests/test-qapi-commands.c:693: undefined reference =
to `qmp_test_features'
> clang-7: error: linker command failed with exit code 1 (use -v to see inv=
ocation)
> make: *** [/tmp/qemu-test/src/rules.mak:124: tests/test-qmp-cmds] Error 1
> make: *** Waiting for unfinished jobs....
> make[1]: Leaving directory '/tmp/qemu-test/build/tests/fp'

*sigh*

Not sure how this happened, I thought I had run a full 'make check'...
Anyway, v4 incoming.

Kevin

