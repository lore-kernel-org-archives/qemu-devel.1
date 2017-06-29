Received: from eggs.gnu.org ([2001:4830:134:3::10]:46976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQaZX-0007WO-QI
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:37:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQaZX-0000b4-0n
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:37:31 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:37658)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dQaZW-0000an-PN
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:37:30 -0400
Received: by mail-wm0-x22b.google.com with SMTP id i127so17052253wma.0
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 07:37:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <7de47a0f-baad-d849-eebd-87c86dae16c1@redhat.com>
References: <1497369290-20401-1-git-send-email-peter.maydell@linaro.org>
	<1497369290-20401-2-git-send-email-peter.maydell@linaro.org>
	<f279fd6d-d32f-79e8-66e3-62edc0e425a8@amsat.org>
	<937b2871-7380-4bfc-9a3b-997e496633ff@redhat.com>
	<7b7e4b38-923d-b928-ab09-716b2140273b@amsat.org>
	<7de47a0f-baad-d849-eebd-87c86dae16c1@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Jun 2017 15:37:08 +0100
Message-ID: <CAFEAcA_h+PM25Fxb3KZPLnRoFkiJw=e4dAeWJ7b6FU3c-rmKaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/3] travis: install more library
 dependencies
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>, "patches@linaro.org" <patches@linaro.org>, Fam Zheng <famz@redhat.com>

On 14 June 2017 at 17:49, Paolo Bonzini <pbonzini@redhat.com> wrote:
> This patch and patch 2 are
> useful, but I think I'd rather get full coverage, either with Shippable
> or by keeping on doing manual builds, than to rush things and switch to
> CI when it's not ready.

I agree with this, so is there a path forwards where we
get patch 2 into a shape where we can commit it and you
switch to using it for the manual uploads, (and maybe
eventually we have Shippable do it, but at least we have
a reproducible way for somebody other than you to do it
if needed) ?

I think for that we should update the comments at the top
to delete the bit that says "primary purpose is for travis".
I think we should also make the configure line include
--enable-foo for all the features we currently test, so that
if somebody tries to run it on a machine with missing
dependencies they get a configure error rather than silently
uploading with reduced coverage.

Can you suggest a set of --enable-foo flags which give us
the coverage we're getting currently with the machine you
do the manual runs on?

thanks
-- PMM
