Received: from eggs.gnu.org ([2001:4830:134:3::10]:52137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYWmB-0007Mh-Uw
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:15:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYWm8-00060X-ND
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:15:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50958 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fYWm8-0005zw-Gr
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:15:52 -0400
References: <20180608131604.16826-1-berrange@redhat.com>
	<20180628130959.GA13043@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0da81870-5036-209e-0202-6a240fd18491@redhat.com>
Date: Thu, 28 Jun 2018 15:15:47 +0200
MIME-Version: 1.0
In-Reply-To: <20180628130959.GA13043@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/3] glib: update the min required
 version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Olaf Hering <olaf@aepfle.de>

On 28/06/2018 15:09, Daniel P. Berrang=C3=A9 wrote:
> Ping, Paolo:
>=20
> Peter confirmed he'd updated his mingw cross env now, so should be
> safe to include this in a PULL before soft-freeze on tuesday.

Go ahead and send it yourself, mine is already big enough and this would
be more risky than everything else together.

Thanks,

Paolo

> On Fri, Jun 08, 2018 at 02:16:01PM +0100, Daniel P. Berrang=C3=A9 wrote=
:
>> The previous patch to bump glib to 2.42 hit problems with Peter's buil=
d
>> environment for testing merge:
>>
>>   https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg02557.html
>>
>> This posting drops back to 2.40, which allows Ubuntu 14.04 from GLibC
>> compile farm to be supported.
>>
>> It does NOT try to go back to 2.34, because it is hoped that the mxe.c=
c
>> Debian packages will be suitable for Peter to test Windows
>> cross-compile. Alternatively the docker environments provided in tree
>> can be used for mingw build testing on any host able to run docker.
>>
>> I also dropped some more GLIB_CHECK_VERSION checks that are redundant
>> given the new min version.
>>
>> Changed in v3:
>>
>>  - Use #pragma instead of _Pragma
>>  - Move dockerfile deletion to earlier patch
>>  - Add missing osdep.h include
>>  - Reorder patches to preserve bisectability
>>
>> Daniel P. Berrang=C3=A9 (3):
>>   util: remove redundant include of glib.h and add osdep.h
>>   glib: bump min required glib library version to 2.40
>>   glib: enforce the minimum required version and warn about old APIs
>>
>>  configure                                |   6 +-
>>  crypto/hash-glib.c                       |   4 -
>>  crypto/hmac-glib.c                       |  36 ---
>>  include/glib-compat.h                    | 373 ++++------------------=
-
>>  include/qemu/iova-tree.h                 |   1 -
>>  qga/commands.c                           |  11 +-
>>  tests/docker/dockerfiles/centos6.docker  |  30 --
>>  tests/docker/dockerfiles/min-glib.docker |   8 -
>>  tests/ivshmem-test.c                     |   6 -
>>  tests/test-qga.c                         |   2 -
>>  tests/test-qmp-event.c                   |   8 +-
>>  tests/tpm-emu.h                          |   4 +-
>>  tests/vhost-user-test.c                  |  26 +-
>>  trace/simple.c                           |   6 +-
>>  util/iova-tree.c                         |   2 +-
>>  util/osdep.c                             |  14 -
>>  16 files changed, 73 insertions(+), 464 deletions(-)
>>  delete mode 100644 tests/docker/dockerfiles/centos6.docker
>>  delete mode 100644 tests/docker/dockerfiles/min-glib.docker
>>
>> --=20
>> 2.17.0
>>
>=20
> Regards,
> Daniel
>=20
