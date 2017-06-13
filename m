Received: from eggs.gnu.org ([2001:4830:134:3::10]:50565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dKnM2-0003GG-I3
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 11:03:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dKnLy-00036b-88
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 11:03:38 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:44898 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dKnLx-00034e-Su
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 11:03:34 -0400
References: <149736509828.129.3630891448953030106@4a9a010726c0>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <79440064-d904-8e7c-2348-e59d5f4eee4b@virtuozzo.com>
Date: Tue, 13 Jun 2017 18:03:22 +0300
MIME-Version: 1.0
In-Reply-To: <149736509828.129.3630891448953030106@4a9a010726c0>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v21 00/30] qcow2: persistent dirty bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org, kwolf@redhat.com, armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org, jsnow@redhat.com

Looks weird.

13.06.2017 17:44, no-reply@patchew.org wrote:
> Hi,
>
> This series failed automatic build test. Please find the testing comman=
ds and
> their output below. If you have docker installed, you can probably repr=
oduce it
> locally.
>
> Message-id: 20170613140358.81651-1-vsementsov@virtuozzo.com
> Subject: [Qemu-devel] [PATCH v21 00/30] qcow2: persistent dirty bitmaps
> Type: series
>
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> set -e
> git submodule update --init dtc
> # Let docker tests dump environment info
> export SHOW_ENV=3D1
> export J=3D8
> time make docker-test-quick@centos6
> time make docker-test-mingw@fedora
> time make docker-test-build@min-glib
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
>  From https://github.com/patchew-project/qemu
>   - [tag update]      patchew/20170613133329.23653-1-stefanha@redhat.co=
m -> patchew/20170613133329.23653-1-stefanha@redhat.com
>   * [new tag]         patchew/20170613140358.81651-1-vsementsov@virtuoz=
zo.com -> patchew/20170613140358.81651-1-vsementsov@virtuozzo.com
> Switched to a new branch 'test'
> 09d75c7 block: release persistent bitmaps on inactivate
> 837d8c4 qmp: block-dirty-bitmap-remove: remove persistent
> c44d3dc qcow2: add .bdrv_remove_persistent_dirty_bitmap
> 3a2e6d8 block/dirty-bitmap: add bdrv_remove_persistent_dirty_bitmap
> 66e087f iotests: test qcow2 persistent dirty bitmap
> a6c4b98 qmp: add x-debug-block-dirty-bitmap-sha256

[...]

>    CC      hw/net/e1000e_core.o
>    CC      hw/net/rtl8139.o
>    CC      hw/net/vmxnet3.o
>    CC      hw/net/smc91c111.o
> In file included from /tmp/qemu-test/src/hw/net/vmxnet3.c:30:
> /tmp/qemu-test/src/include/migration/register.h:18: error: redefinition=
 of typedef =E2=80=98LoadStateHandler=E2=80=99
> /tmp/qemu-test/src/include/migration/vmstate.h:32: note: previous decla=
ration of =E2=80=98LoadStateHandler=E2=80=99 was here
> make: *** [hw/net/vmxnet3.o] Error 1
> make: *** Waiting for unfinished jobs....
> tests/docker/Makefile.include:118: recipe for target 'docker-run' faile=
d
> make[1]: *** [docker-run] Error 2
> make[1]: Leaving directory '/var/tmp/patchew-tester-tmp-zqsdsd64/src'
> tests/docker/Makefile.include:149: recipe for target 'docker-run-test-q=
uick@centos6' failed
> make: *** [docker-run-test-quick@centos6] Error 2

Hmm.. What? my patches are not related to migration or network.. Also,=20
v21 is very similar with v20, the only change in code is error_report ->=20
error_reportf_err with additional message...


> =3D=3D=3D OUTPUT END =3D=3D=3D
>
> Test command exited with code: 2
>
>
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org


--=20
Best regards,
Vladimir
