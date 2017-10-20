Received: from eggs.gnu.org ([2001:4830:134:3::10]:52917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5aDF-0003Gd-GK
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 12:31:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5aDE-0004EQ-RC
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 12:31:57 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:51257)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e5aDE-0004Ds-JW
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 12:31:56 -0400
Received: by mail-wm0-x22c.google.com with SMTP id f4so23668819wme.0
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 09:31:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <150851236210.17710.344438373871611833.malone@gac.canonical.com>
References: <150850189101.17148.14929440782690831821.malonedeb@wampee.canonical.com>
	<150851236210.17710.344438373871611833.malone@gac.canonical.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Oct 2017 17:31:34 +0100
Message-ID: <CAFEAcA_C3P3s=+5xWrgwsiztTKQm0RsXQWZ4czkKDw3jjN=67g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Bug 1725267] Re: armeb regression since qemu
 version 2.8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1725267 <1725267@bugs.launchpad.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 20 October 2017 at 16:12, Christophe Lyon
<christophe.lyon+launchpad@gmail.com> wrote:
> I'll add some printfs and see what this says.

I had a dig further in the logs and I suspect that we're either
doing the two halves of strexd or the two halves of ldrexd wrong
for linux-user bigendian.

thanks
-- PMM
