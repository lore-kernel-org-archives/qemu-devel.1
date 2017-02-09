Received: from eggs.gnu.org ([2001:4830:134:3::10]:58960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cbmCI-0000ws-TH
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 05:43:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cbmCI-0003nK-5O
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 05:43:30 -0500
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:38470)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cbmCH-0003ll-W6
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 05:43:30 -0500
Received: by mail-wm0-x231.google.com with SMTP id r141so14844515wmg.1
	for <qemu-devel@nongnu.org>; Thu, 09 Feb 2017 02:43:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <f296fbdf-67c3-8891-e5ca-a25570e3e12f@redhat.com>
References: <1486399909-16338-1-git-send-email-quintela@redhat.com>
	<CAFEAcA-yFVYzwxt4FG9D3g3BwEJFPnmNrr-pJOzYV-h5Y6bu7A@mail.gmail.com>
	<87lgti1lta.fsf@emacs.mitica>
	<CAFEAcA9RXeubPXZhTS+FHyYVARvb=gVFOQxK8ZYt8OQnhe9WXw@mail.gmail.com>
	<f296fbdf-67c3-8891-e5ca-a25570e3e12f@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Feb 2017 10:43:08 +0000
Message-ID: <CAFEAcA9d9aoS=SaOghevNKTaX2V7Zu=jUev7UH1G4iSovT=_jA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/6] Migration pull
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 8 February 2017 at 08:47, Thomas Huth <thuth@redhat.com> wrote:
> How fast is that aarch64 machine?

It's a juno board, so it's not very fast, but I wouldn't
have expected it to hit a 100 second timeout assuming
the test isn't trying to do a ludicrous amount of work.

> The timeout of the prom-env test is
> already 100 seconds, so that seems to be plenty to me (the test normally
> finishes here on my laptop within 15 seconds).
> OTOH, if it helps with the aarch64 machine, I'm also fine if we increase
> the timeout further - but what value would be appropriate then? Could you
> please run the following on that slow machine:
>
>  time QTEST_QEMU_BINARY=ppc64-softmmu/qemu-system-ppc64 tests/prom-env-test

/ppc64/prom-env/mac99: OK
/ppc64/prom-env/g3beige: OK
/ppc64/prom-env/pseries: OK

real    1m37.657s
user    1m36.748s
sys     0m1.440s

Breaking that down per testcase:

<tmmu/qemu-system-ppc64 tests/prom-env-test -v -p /ppc64/prom-env/mac99
/ppc64/prom-env/mac99: OK

real    0m9.836s
user    0m9.584s
sys     0m0.424s
<u/qemu-system-ppc64 tests/prom-env-test -v -p /ppc64/prom-env/g3beige
/ppc64/prom-env/g3beige: OK

real    0m9.099s
user    0m8.988s
sys     0m0.144s
<qemu-system-ppc64 tests/prom-env-test -v -p /ppc64/prom-env/pseries
/ppc64/prom-env/pseries: OK

real    1m24.362s
user    1m23.572s
sys     0m1.144s

pseries is much slower than the other two and at 85 seconds is
not all that much below the 100s. Something's odd here.

thanks
-- PMM
