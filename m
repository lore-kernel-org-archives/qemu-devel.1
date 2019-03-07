Received: from eggs.gnu.org ([209.51.188.92]:40160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1h1yLC-0001Ie-AO
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 14:06:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1h1yLA-00011m-E8
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 14:06:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1h1yLA-0000zu-4W
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 14:06:00 -0500
Date: Thu, 7 Mar 2019 14:05:54 -0500
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <20190307190554.w75ltd6wvnvhzsdh@dhcp-17-118.bos.redhat.com>
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
	<87r2bigarf.fsf@zen.linaroharston>
	<a6d25edf-1386-655e-6fd8-3b121838b00b@redhat.com>
	<CAFEAcA_ybrfeVdGrr=fWRg8xR1Yj33xySjX14-JmPvBySqKF8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_ybrfeVdGrr=fWRg8xR1Yj33xySjX14-JmPvBySqKF8w@mail.gmail.com>
Subject: Re: [Qemu-devel] converting build system to Meson?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On Thu, Mar 07, 2019 at 01:09:52PM +0000, Peter Maydell wrote:
> On Thu, 7 Mar 2019 at 12:56, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > In any case, this wouldn't change; as you suggest below, configure could
> > remain as a front-end (well, in-srcdir builds are not supported by
> > Meson, so "../configure && ninja" perhaps).
> 
> As an aside, it might be a nice idea to drop the in-srcdir
> build altogether for QEMU anyway -- it's not really a very
> good idea and it means our build system has to cope with two
> different ways of working to no particularly useful end.
>

THIS.  Please.

- Cleber.
