Received: from eggs.gnu.org ([2001:4830:134:3::10]:34922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejtUV-0000ar-T8
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 16:12:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejtUU-00027u-W2
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 16:12:23 -0500
Received: from mail-ot0-x22c.google.com ([2607:f8b0:4003:c0f::22c]:34020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ejtUU-00027l-QK
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 16:12:22 -0500
Received: by mail-ot0-x22c.google.com with SMTP id l10so5695732oth.1
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 13:12:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <fd22674c-059e-8d37-338c-5d2d4d96eb20@redhat.com>
References: <20180125135129.9305-1-klim.kireev@virtuozzo.com>
	<bb1b8270-e924-3d41-a172-38ba79db9bf7@redhat.com>
	<fd22674c-059e-8d37-338c-5d2d4d96eb20@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Feb 2018 21:12:01 +0000
Message-ID: <CAFEAcA9eKZNznjgnRy_vuKvcQZ2e=0XD0b9reGBFBBFoBTREQg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] "make check -j4" hangs (was: Re:
 chardev/char-socket: add POLLHUP handler)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Klim Kireev <klim.kireev@virtuozzo.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 8 February 2018 at 19:13, Thomas Huth <thuth@redhat.com> wrote:
> I'm currently facing some issues with "make check -j4" (i.e. running the
> tests in parallel). Git bisect blames this commit - though I'm not sure
> whether this is really the right one ... Starting with this commit, I
> saw hangs in test-filter-redirector, but git master rather seems to hang
> with vhost-user-test instead.
> Stefan also had issues with "make check -j4" today, so it's apparently
> not only me ... can somebody else reproduce the problem with the git
> master branch?

Yeah, I was seeing odd make check hangs with parallelization enabled
too, on vhost-user-test... (my builds for merge tests are almost
all non-parallelized I think).

thanks
-- PMM
