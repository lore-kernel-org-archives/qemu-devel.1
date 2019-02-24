Received: from eggs.gnu.org ([209.51.188.92]:52212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gxzrC-0003iN-L0
	for qemu-devel@nongnu.org; Sun, 24 Feb 2019 14:54:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gxzrB-0006RU-4F
	for qemu-devel@nongnu.org; Sun, 24 Feb 2019 14:54:38 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:45700)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gxzrA-0006QM-TD
	for qemu-devel@nongnu.org; Sun, 24 Feb 2019 14:54:37 -0500
Received: by mail-ot1-x333.google.com with SMTP id 32so6066573ota.12
	for <qemu-devel@nongnu.org>; Sun, 24 Feb 2019 11:54:36 -0800 (PST)
MIME-Version: 1.0
References: <155085278488.30597.14551761138419562879.malonedeb@chaenomeles.canonical.com>
	<155103713660.11385.8973225882401821375.malone@gac.canonical.com>
In-Reply-To: <155103713660.11385.8973225882401821375.malone@gac.canonical.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 24 Feb 2019 19:54:23 +0000
Message-ID: <CAFEAcA8Lti+JrJ=Fh=k8D7Tqt=dE2YQSjyisVXU=rXWF=zqWBA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Bug 1817345] Re: configure script breaks when
 $source_path contains white spaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1817345 <1817345@bugs.launchpad.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Sun, 24 Feb 2019 at 19:46, Michael Tokarev
<1817345@bugs.launchpad.net> wrote:
> I think it is better to just disallow building in a path containing
> spaces, -- there are so many packages and other tools that fails in this
> config, might require lots of work to fix this AND to ensure all future
> changes are still working, and there's an easy workaround

Certainly I bet that the problems with spaces in the path do
not stop with the handling of the target-list help message.
Make does not really get on at all with spaces...
It would probably be helpful if we made configure complain
if it finds spaces in the build or source paths.

thanks
-- PMM
