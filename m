Received: from eggs.gnu.org ([209.51.188.92]:53296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h31Jn-0007Jb-C0
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 12:28:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h31Jm-0003zp-DL
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 12:28:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1h31Jm-0003zA-6h
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 12:28:54 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
Date: Sun, 10 Mar 2019 17:28:44 +0100
In-Reply-To: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com> (Paolo
	Bonzini's message of "Wed, 6 Mar 2019 19:12:33 +0100")
Message-ID: <87r2bevglf.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] converting build system to Meson?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, =?utf-8?Q?M?= =?utf-8?Q?arc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Richard Henderson <rth@twiddle.net>

Paolo Bonzini <pbonzini@redhat.com> writes:

> Hi all,
>
> lately I have been thinking of converting the QEMU build system to
> Meson.  Meson is a relatively new build system that can replace
> Autotools or hand-written Makefiles such as QEMU; as a die-hard
> Autotools fan, I must say that Meson is by far better than anything else
> that has ever tried to replace Autotools, and actually has the potential
> to do so.
>
> Advantages of Meson that directly matter for QEMU include:
[...]
> - ease of distributing a full copy of Meson to support distros that ship
> an older version (no dependencies apart from Python 3.5).  At 40000
> lines of Python, Meson is relatively small.

Meson is licensed under the Apache 2 license.  QEMU as a whole is
licensed under GPLv2 (and no later versions).  From
<https://www.gnu.org/licenses/license-list.html#apache2>:

    This is a free software license, compatible with version 3 of the
    GNU GPL.

    Please note that this license is not compatible with GPL version 2,
    because it has some requirements that are not in that GPL version.
    These include certain patent termination and indemnification
    provisions.  The patent termination provision is a good thing, which
    is why we recommend the Apache 2.0 license for substantial programs
    over other lax permissive licenses.

Can we distribute Meson along with QEMU anyway?

[...]
