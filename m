Received: from eggs.gnu.org ([209.51.188.92]:37040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1grM38-0007rt-LB
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 07:11:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1grM37-0008IO-Jz
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 07:11:30 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45353)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1grM37-0008Fu-7l
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 07:11:29 -0500
Received: by mail-ot1-x344.google.com with SMTP id 32so11360153ota.12
	for <qemu-devel@nongnu.org>; Wed, 06 Feb 2019 04:11:24 -0800 (PST)
MIME-Version: 1.0
References: <20190129175403.18017-1-philmd@redhat.com>
	<20190129175403.18017-10-philmd@redhat.com>
	<CAFEAcA_ejg0yPkBZ_0-mgM5zgMHKqKe3SDGX0wMZ-neYC_Oy0A@mail.gmail.com>
	<e5dd8130-e041-7774-2141-cc506dee99f7@redhat.com>
	<94f74717-0bab-ea0a-e7cc-239a1b1136bf@comstyle.com>
	<e8177680-28fc-1213-a8f7-a3b94ef92e15@redhat.com>
	<20190206072911.urbbsuzxogkzj5sf@sirius.home.kraxel.org>
In-Reply-To: <20190206072911.urbbsuzxogkzj5sf@sirius.home.kraxel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 6 Feb 2019 12:11:12 +0000
Message-ID: <CAFEAcA8PM7KjaRx_fMcz5P-AmRYo+anGxzcWHtOkvgxaPzEBUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 09/18] tests/vm/openbsd: Install Bash
 from the ports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Brad Smith <brad@comstyle.com>, "Daniel P. Berrange" <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin" <mst@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>

On Wed, 6 Feb 2019 at 07:29, Gerd Hoffmann <kraxel@redhat.com> wrote:
> There also is a patch floating around to auto-install openbsd:
>         https://patchwork.kernel.org/patch/10749459/
>
> Not fully sure why this wasn't merged yet.  One problem is that this
> patch depends on a new slirp feature (added in the 3.1 devel cycle,
> needed to serve install.conf via http).  Which blocked merge during the
> 3.1 cycle, because depending on unreleased qemu for test builds isn't a
> good idea.  But 3.1 is released, so maybe we can merge that for 4.0 now?

The feature isn't in the installed QEMU for the Ubuntu box I
run the BSD VM tests on, which is what the blocker is -- I don't
want to have to keep around and maintain a non-system QEMU to run
the VMs that are doing the tests here. It would be preferable to
remove the dependency on the bleeding-edge slirp feature.

thanks
-- PMM
