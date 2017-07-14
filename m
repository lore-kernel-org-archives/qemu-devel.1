Received: from eggs.gnu.org ([2001:4830:134:3::10]:50417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dVxzL-00016K-0P
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:38:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dVxzH-0002gH-R1
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:38:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dVxzH-0002g3-Kv
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:38:19 -0400
References: <20170714093407.11526-1-pbonzini@redhat.com>
	<87shhzuye8.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <52b9202e-7ad1-e7f8-e916-0f63f9d9b959@redhat.com>
Date: Fri, 14 Jul 2017 12:38:13 +0200
MIME-Version: 1.0
In-Reply-To: <87shhzuye8.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/2] docker: allow running "docker-travis"
 with arbitrary parallelism
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, famz@redhat.com

On 14/07/2017 12:05, Alex Benn=C3=A9e wrote:
>=20
> Paolo Bonzini <pbonzini@redhat.com> writes:
>=20
>> docker-travis is limited to the -j3 flag specified for running on the
>> SaaS Travis CI infrastructure.
>>
>> When running the test matrix locally with docker, however, we can run
>> much more jobs at the same time on a suitably beefy server.  Let peopl=
e
>> do that with the usual J=3Dnn option already supported by the other
>> docker-based tests.
>=20
> Eh, I was debugging stuff on our beefy server with J=3D20 and then I
> realised I was just running:
>=20
>   make docker-test-quick@travis J=3D20
>=20
> So I guess some people do use the pseudo Travis expansion then?

How would that end up running tests/docker/travis?

Paolo

>>
>> Paolo
>>
>> Paolo Bonzini (2):
>>   docker: allow customizing Travis global_env variables
>>   travis: move make -j flag out of script
>>
>>  .travis.yml            | 3 ++-
>>  tests/docker/travis.py | 6 +++---
>>  2 files changed, 5 insertions(+), 4 deletions(-)
>=20
>=20
> --
> Alex Benn=C3=A9e
>=20
