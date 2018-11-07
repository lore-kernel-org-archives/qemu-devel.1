Received: from eggs.gnu.org ([2001:4830:134:3::10]:34331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKO9f-00022E-9o
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 08:46:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKO9e-0006VM-4N
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 08:45:59 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:34657)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gKO9d-0006Tm-JD
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 08:45:57 -0500
Received: by mail-ot1-x32b.google.com with SMTP id t5so11161635otk.1
	for <qemu-devel@nongnu.org>; Wed, 07 Nov 2018 05:45:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181107124910.GX12503@habkost.net>
References: <20181031003120.26771-1-ehabkost@redhat.com>
	<20181031003120.26771-12-ehabkost@redhat.com>
	<CAFEAcA_ScL828ya7P_5=HMx=vbxo=jK4047nAbmb9Ep=6r=2og@mail.gmail.com>
	<f1bd429f-198a-ee27-9184-636692332816@redhat.com>
	<20181106141302.GP12503@habkost.net>
	<87efbxxw1c.fsf@dusky.pond.sub.org>
	<20181107124910.GX12503@habkost.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Nov 2018 13:45:35 +0000
Message-ID: <CAFEAcA_no6zJ0MG4Af-R0bTi5B9U1M+uArVtJUqkY89iuYgicQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] tests: Fix Python 3 detection
 on older GNU make versions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Qemu-block <qemu-block@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>

On 7 November 2018 at 12:49, Eduardo Habkost <ehabkost@redhat.com> wrote:
> Now, why do we need --with-python, and why do we need to use
> $(PYTHON) when running tests?  If somebody wants to use a
> different Python binary when running tests, they can already use
> $PATH for that.
>
> (That's the same argument I used for iotests a while ago:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg566631.html)

I'm not a great fan of requiring the user to mess with their PATH
to get configure to work. Also, the first python on the path
might be the wrong one, and we don't pass PATH from configure
to make so you end up having to make sure you specify it
right in both places.

Plus we already have --with-python, so if you want to drop
it you need to deprecate it first, and you need a justification
that's strong enough to outweigh breaking users' existing
build/packaging setups and scripts...

thanks
-- PMM
