Received: from eggs.gnu.org ([2001:4830:134:3::10]:49206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dyyll-0000WD-1z
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 07:20:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dyylk-0000Rl-7K
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 07:20:17 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:49454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dyylj-0000R1-V2
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 07:20:16 -0400
Received: by mail-wm0-x236.google.com with SMTP id b189so6036400wmd.4
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 04:20:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171002111739.GH27086@redhat.com>
References: <CGME20171002083119eucas1p1a73232b22e354c9b27dbc4c0b9b78907@eucas1p1.samsung.com>
	<1506933058-28313-1-git-send-email-a.perevalov@samsung.com>
	<1506933058-28313-2-git-send-email-a.perevalov@samsung.com>
	<CAFEAcA8oo4cenAVsmcS5cmC3Uuh5e+bocM4hbHtvcpFB1ZJKGQ@mail.gmail.com>
	<20171002111739.GH27086@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Oct 2017 12:19:54 +0100
Message-ID: <CAFEAcA-t+RpfHQCNfLNhn-eGwS6H86yqHURFSura6_oDUOiEHQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] Makefile: don't use LINKPROG for
 tests/migration/stress
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Alexey Perevalov <a.perevalov@samsung.com>, heetae82.ahn@samsung.com, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, i.maximets@samsung.com
List-ID: <qemu-devel.nongnu.org>

On 2 October 2017 at 12:17, Daniel P. Berrange <berrange@redhat.com> wrote:
> On Mon, Oct 02, 2017 at 12:14:39PM +0100, Peter Maydell wrote:
>> Why does this executable need to define its own link rule anyway?
>> Ideally it should just use the standard rules.mak LINK function
>> like everything else. If it does need to do something weird
>> it should have a comment saying why it's weird...
>
> Primarily because we're static linking this binary so that it can be put
> into an initrd without needing any extra files added. It doesn't use any
> of the 3rd party libraries the rest of QEMU uses - ie no glib2 in particular.

Oh, are we committing our usual error of trying to build guest
binaries with the host toolchain?

thanks
-- PMM
