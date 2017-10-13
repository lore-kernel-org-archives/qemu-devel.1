Received: from eggs.gnu.org ([2001:4830:134:3::10]:39406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e32c5-0007ii-Bc
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:15:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e32c4-0007Wg-CV
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:15:05 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:55038)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e32c4-0007WH-5C
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:15:04 -0400
Received: by mail-wm0-x232.google.com with SMTP id i124so22763597wmf.3
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 09:15:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f43d6c1c-1112-bfcf-ae19-ed2a002b7873@redhat.com>
References: <20171013102812.29648-1-berrange@redhat.com>
	<1c52fcd4-e8ce-51c1-a0c7-cf882fab6662@redhat.com>
	<a591ebd3-ae7f-cde6-1cd2-d4859c17494f@redhat.com>
	<20171013113859.GG20515@redhat.com>
	<f43d6c1c-1112-bfcf-ae19-ed2a002b7873@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Oct 2017 17:14:42 +0100
Message-ID: <CAFEAcA_Jmh-UyHDtMM+yzG_3Y1eJPzPmr9ATBQp3j_-1a4U7wQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] configure: pick the right compiler for
 OpenBSD by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On 13 October 2017 at 12:46, Thomas Huth <thuth@redhat.com> wrote:
> I disagree. If the next OpenBSD release uses Clang by default, we're not
> building QEMU there with the *working default* C compiler anymore.
> You're then rather forcing the OpenBSD users then to install an
> additional (likely unliked, since GPLv3) GCC package on their systems.
>
> So IMHO, just drop this patch and wait for the next OpenBSD release, and
> the problem will be solved automatically. (and the few users who still
> use an older release of OpenBSD will likely use the QEMU from their
> ports system anyway)

Another possible approach would be to have a configure test
for whatever feature it is that we need in our compiler,
and then run through a list that starts with "cc" and
goes on to try "egcc" etc until it finds one that works.
That way we'll automatically DTRT when OpenBSD upgrades
their "cc" to a working one.

thanks
-- PMM
