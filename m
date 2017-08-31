Received: from eggs.gnu.org ([2001:4830:134:3::10]:44778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dnQRx-0002kA-Qy
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:28:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dnQRt-0000TV-G5
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:28:05 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:38135)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dnQRt-0000Sr-8y
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:28:01 -0400
Received: by mail-wr0-x22c.google.com with SMTP id 40so2507618wrv.5
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 07:28:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a0308f02-4716-87ea-5070-b57d567aae07@gmx.com>
References: <20170831064302.14427-1-famz@redhat.com>
	<a0308f02-4716-87ea-5070-b57d567aae07@gmx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Aug 2017 15:27:39 +0100
Message-ID: <CAFEAcA9x1kmkhqvGM7y0AJRbr7+5t56sOqQPNQ0cowK8vCvVKA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 00/12] tests: Add VM based build tests
 (for non-x86_64 and/or non-Linux)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>
Cc: Fam Zheng <famz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Daniel P. Berrange" <berrange@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>

On 31 August 2017 at 15:04, Kamil Rytarowski <n54@gmx.com> wrote:
> Could we please add SmartOS image. It's an Illumos distribution,
> previously known as OpenSolaris.
>
> qemu is actively maintained for SmartOS in pkgsrc.
>
> The latest build fixes were introduced less than a week ago.
> https://github.com/NetBSD/pkgsrc/commit/f2608af5433f1491a92567bf570e9349dffbda7a

Maintaining out of tree patches without posting them upstream
is rather counterproductive, because if the host OS doesn't
build or have anybody submitting patches to fix it upstream
we will conclude that it's unused and delete the support entirely.
That E1000_SEC define has been around for nearly 10 years
without anybody saying it was a problem, for instance.
(Indeed Solaris is probably next after AIX on the "nobody
came along to tell us they cared enough to help us maintain
it" list for removal as a result.)

> I'm going to submit the SmartOS patches to fix the build
> regardless of the decision.

Thank you. Do you also have some instructions on how to
get it running in a VM or something so we can add it to
our build tests? (Login on a build machine, or a SmartOS
host in the gcc compile farm, would work too).

thanks
-- PMM
