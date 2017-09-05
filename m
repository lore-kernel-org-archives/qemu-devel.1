Received: from eggs.gnu.org ([2001:4830:134:3::10]:54301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dpMOB-0005Px-Bk
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 18:32:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dpMO6-0001fY-Gv
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 18:32:11 -0400
Received: from mail-qt0-x232.google.com ([2607:f8b0:400d:c0d::232]:33662)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dpMO6-0001fQ-CW
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 18:32:06 -0400
Received: by mail-qt0-x232.google.com with SMTP id i50so15886291qtf.0
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 15:32:06 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170905180602.28698-1-f4bug@amsat.org>
	<3eee420b-18de-9cd3-20d1-59cc8fe5814a@amsat.org>
	<CAJ+F1CLedohOTLB+Z+2QVWtPsKt2OPh9L5AUjOrgjMru05E02Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <33311559-30c5-a8ec-3ed1-76068bc44b54@amsat.org>
Date: Tue, 5 Sep 2017 19:32:02 -0300
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLedohOTLB+Z+2QVWtPsKt2OPh9L5AUjOrgjMru05E02Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] vhost-user: disable the *broken*
 subprocess tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, "Daniel P . Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

>     not vhost-user-test, but this still failed:
> 
>     ERROR:tests/rcutorture.c:388:gtest_stress: assertion failed (n_mberror
>     == 0): (1 == 0)
>     GTester: last random seed: R02S8905ef6a0d8ed82670297d559c40e919
>     make: *** [check-tests/rcutorture] Error 1
> 
>     CONFIG="--enable-debug --enable-debug-tcg --enable-trace-backends=log"
> 
>     https://travis-ci.org/philmd/qemu/jobs/272168998
> 
[...]
> 
> Not so, at least I can't reproduce locally yet.
> 
> If it's only reproducible on travis for now, shouldn't the failing tests 
> be disabled if getenv("TRAVIS") instead?

I restarted the Travis job and it succeeded so this seems to be another 
problem, not the vhost-user-test one :)

https://travis-ci.org/philmd/qemu/builds/272168994
