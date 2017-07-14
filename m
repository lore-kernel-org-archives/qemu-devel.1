Received: from eggs.gnu.org ([2001:4830:134:3::10]:56767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dW1xL-0004qS-Vn
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 10:52:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dW1xH-0001nC-4C
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 10:52:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dW1xG-0001ms-Ta
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 10:52:31 -0400
References: <20170714093407.11526-1-pbonzini@redhat.com>
	<87shhzuye8.fsf@linaro.org>
	<52b9202e-7ad1-e7f8-e916-0f63f9d9b959@redhat.com>
	<87r2xjunot.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ddbfedcb-85ab-37b3-ce88-9a1e07ad8eb3@redhat.com>
Date: Fri, 14 Jul 2017 16:52:24 +0200
MIME-Version: 1.0
In-Reply-To: <87r2xjunot.fsf@linaro.org>
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

On 14/07/2017 15:56, Alex Benn=C3=A9e wrote:
>=20
> Paolo Bonzini <pbonzini@redhat.com> writes:
>=20
>> On 14/07/2017 12:05, Alex Benn=C3=A9e wrote:
>>>
>>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>>
>>>> docker-travis is limited to the -j3 flag specified for running on th=
e
>>>> SaaS Travis CI infrastructure.
>>>>
>>>> When running the test matrix locally with docker, however, we can ru=
n
>>>> much more jobs at the same time on a suitably beefy server.  Let peo=
ple
>>>> do that with the usual J=3Dnn option already supported by the other
>>>> docker-based tests.
>>>
>>> Eh, I was debugging stuff on our beefy server with J=3D20 and then I
>>> realised I was just running:
>>>
>>>   make docker-test-quick@travis J=3D20
>>>
>>> So I guess some people do use the pseudo Travis expansion then?
>>
>> How would that end up running tests/docker/travis?
>=20
> It runs the normal build and make check but in the Travis build
> environment. Essentially the .travis.yml is just a bunch of alternative
> configure invocations, there is nothing to stop you manually setting up
> a build with TARGET_LIST and EXTRA_CONFIGURE_OPTS which is what I do if
> there is a particular Travis test which is failing.

This is different, I want to run all Travis builds to ensure I don't
break one before going on vacation. :)

Paolo
