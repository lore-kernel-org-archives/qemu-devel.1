Received: from eggs.gnu.org ([209.51.188.92]:57873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1qvc-0006ex-AW
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 06:11:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1qvb-0007F7-GI
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 06:11:08 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35224)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h1qvb-0007EZ-9J
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 06:11:07 -0500
Received: by mail-wm1-x341.google.com with SMTP id y15so8863806wma.0
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 03:11:07 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
	<9fb589af-a78e-6eeb-ca1c-a5049c5ac5ab@redhat.com>
	<CAFEAcA_RQU+HYczN4Z=vEL8U31---GTi_HOxg8y50pzX8p+p7Q@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <baa5b3a8-6b74-cbf1-8ae7-a9c91cb9e90c@redhat.com>
Date: Thu, 7 Mar 2019 12:11:04 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_RQU+HYczN4Z=vEL8U31---GTi_HOxg8y50pzX8p+p7Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] converting build system to Meson?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 07/03/19 11:13, Peter Maydell wrote:
> Yes, that tends to be my view. Our current build system:
>  * has no dependencies that are problematic for older hosts
>    (contrast Meson, which needs Python 3.5, even if we take
>    the drastic step of shipping an entire build tool along
>    with QEMU; OSX python is 2.7 still)

Regarding OS X, don't we require Homebrew anyway?  (We will have to deal
with the Python 2 issue sometime in 2020, and I don't expect much
happening wrt Meson in QEMU before then).

>  * is not particularly hard to deal with for the common cases
>    ("add new source file" is straightforward)
>  * covers all our requirements as far as I'm aware
>    (whereas you've listed a couple of places where Meson
>    would need changes/extensions to support things we do already)

Indeed---I mentioned that rejection of these changes/extensions would be
a blocker.  I think those extensions are useful anyway, so I am
contributing them to Meson even if we don't end up using them.  My
experience so far with the Meson community makes me positive that _some_
kind of solution will be found even if it's not what I'm proposing.

> (This might change in the future, eg if Meson catches on to the
> extent that everybody is using it and competitors like CMake are
> more obviously eclipsed by it, in the way that git took over
> from svn and relegated mercurial and bzr to obscurity.)

It's very hard to displace established contenders in this area because
unlike, switching to git or svn, a switch involves a major rewrite
effort.  Nevertheless, big projects _are_ switching.

Meson has a very different design than Autotools or even CMake, despite
the apparent similarity with the latter.  The lack of an escape
mechanism sounds annoying, but it is much less of a problem than you'd
think.  In fact it has the interesting side effect, of discouraging
forks very much: new features are contributed upstream for everyone's
use and vetted by the Meson developers.

This makes Meson way more polished than CMake or Autotools, or
hand-crafted Makefile such as ours; so it takes more effort to switch,
but the result is good.  I have started following Meson about a year
ago, and a lot of missing features have been added since then, slowly
but surely, which is why I am only reaching out now to you and others.

Paolo
