Received: from eggs.gnu.org ([2001:4830:134:3::10]:35817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1digkj-0000a4-JQ
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 08:51:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1digki-0002Rp-9k
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 08:51:53 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:36226)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1digki-0002RZ-1n
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 08:51:52 -0400
Received: by mail-wr0-x235.google.com with SMTP id f8so26205083wrf.3
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 05:51:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87r2w9i38i.fsf@linaro.org>
References: <150097502966.6397.351311629210845503.malonedeb@gac.canonical.com>
	<150240857521.18943.1371547756430353016.malone@chaenomeles.canonical.com>
	<87shgpi800.fsf@linaro.org>
	<CAFEAcA8S6S_T9d=QhncSb4or09HqRoZQNtxWDo3vj8OA9+pb-w@mail.gmail.com>
	<87r2w9i38i.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Aug 2017 13:51:30 +0100
Message-ID: <CAFEAcA-MciXfwrccwpQmpF5pNuEr7k0qphKmtk4hZ07M5uURHw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Bug 1706296] Re: Booting NT 4 disk causes
 /home/rjones/d/qemu/cpus.c:1580:qemu_mutex_lock_iothread: assertion failed:
 (!qemu_mutex_iothread_locked())
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Bug 1706296 <1706296@bugs.launchpad.net>, QEMU Developers <qemu-devel@nongnu.org>

On 18 August 2017 at 11:23, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote=
:
> If we invert the lock before writing the stack
> page is it just going to crash in a more esoteric way?

Paolo suggested a straightforward fix for 2.10 (which we unfortunately
never did :-() which we could use to check this theory.

thanks
-- PMM
