Received: from eggs.gnu.org ([2001:4830:134:3::10]:41084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVxTU-00034x-Tz
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:05:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVxTP-0003O0-Uk
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:05:28 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:38394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dVxTP-0003NF-Nk
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:05:23 -0400
Received: by mail-wm0-x231.google.com with SMTP id f67so17641396wmh.1
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 03:05:22 -0700 (PDT)
References: <20170714093407.11526-1-pbonzini@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170714093407.11526-1-pbonzini@redhat.com>
Date: Fri, 14 Jul 2017 11:05:19 +0100
Message-ID: <87shhzuye8.fsf@linaro.org>
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

> docker-travis is limited to the -j3 flag specified for running on the
> SaaS Travis CI infrastructure.
>
> When running the test matrix locally with docker, however, we can run
> much more jobs at the same time on a suitably beefy server.  Let people
> do that with the usual J=nn option already supported by the other
> docker-based tests.

Eh, I was debugging stuff on our beefy server with J=20 and then I
realised I was just running:

  make docker-test-quick@travis J=20

So I guess some people do use the pseudo Travis expansion then?

>
> Paolo
>
> Paolo Bonzini (2):
>   docker: allow customizing Travis global_env variables
>   travis: move make -j flag out of script
>
>  .travis.yml            | 3 ++-
>  tests/docker/travis.py | 6 +++---
>  2 files changed, 5 insertions(+), 4 deletions(-)


--
Alex Bennée
