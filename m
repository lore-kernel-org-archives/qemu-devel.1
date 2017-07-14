Received: from eggs.gnu.org ([2001:4830:134:3::10]:42433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dW15F-0005oK-Jp
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:56:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dW15B-0004Nl-Of
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:56:41 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:35883)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dW15B-0004NQ-G8
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:56:37 -0400
Received: by mail-wr0-x22a.google.com with SMTP id v60so1579260wrc.3
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 06:56:37 -0700 (PDT)
References: <20170714093407.11526-1-pbonzini@redhat.com>
	<87shhzuye8.fsf@linaro.org>
	<52b9202e-7ad1-e7f8-e916-0f63f9d9b959@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <52b9202e-7ad1-e7f8-e916-0f63f9d9b959@redhat.com>
Date: Fri, 14 Jul 2017 14:56:34 +0100
Message-ID: <87r2xjunot.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 14/07/2017 12:05, Alex Bennée wrote:
>>
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>
>>> docker-travis is limited to the -j3 flag specified for running on the
>>> SaaS Travis CI infrastructure.
>>>
>>> When running the test matrix locally with docker, however, we can run
>>> much more jobs at the same time on a suitably beefy server.  Let people
>>> do that with the usual J=nn option already supported by the other
>>> docker-based tests.
>>
>> Eh, I was debugging stuff on our beefy server with J=20 and then I
>> realised I was just running:
>>
>>   make docker-test-quick@travis J=20
>>
>> So I guess some people do use the pseudo Travis expansion then?
>
> How would that end up running tests/docker/travis?

It runs the normal build and make check but in the Travis build
environment. Essentially the .travis.yml is just a bunch of alternative
configure invocations, there is nothing to stop you manually setting up
a build with TARGET_LIST and EXTRA_CONFIGURE_OPTS which is what I do if
there is a particular Travis test which is failing.

>
> Paolo
>
>>>
>>> Paolo
>>>
>>> Paolo Bonzini (2):
>>>   docker: allow customizing Travis global_env variables
>>>   travis: move make -j flag out of script
>>>
>>>  .travis.yml            | 3 ++-
>>>  tests/docker/travis.py | 6 +++---
>>>  2 files changed, 5 insertions(+), 4 deletions(-)
>>
>>
>> --
>> Alex Bennée
>>


--
Alex Bennée
