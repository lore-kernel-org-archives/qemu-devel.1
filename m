Received: from eggs.gnu.org ([2001:4830:134:3::10]:59817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cvWFJ-0001Sn-AE
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 17:44:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cvWFI-0004Om-6l
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 17:44:13 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:36017)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cvWFH-0004OX-Vu
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 17:44:12 -0400
Received: by mail-wm0-x230.google.com with SMTP id o81so35991729wmb.1
	for <qemu-devel@nongnu.org>; Tue, 04 Apr 2017 14:44:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170405.062259.994335017099386017.ryo_on@yk.rim.or.jp>
References: <20170405.062259.994335017099386017.ryo_on@yk.rim.or.jp>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Apr 2017 22:43:50 +0100
Message-ID: <CAFEAcA83HujBVrbYgXdfJq5YXTqzX9rOSLeGPgdtxaG2TwsbNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] How to provide build/CI environment for NetBSD host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ryo ONODERA <ryo_on@yk.rim.or.jp>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 4 April 2017 at 22:22, Ryo ONODERA <ryo_on@yk.rim.or.jp> wrote:
> I saw "Warning of unsupported host systems"
> in http://wiki.qemu-project.org/ChangeLog/2.9 wiki page.
>
> I would like to contribute to qemu's NetBSD host support.
>
> I can provide NetBSD/amd64(x86_64) 7-stable build
> environment as build/CI machine to the qemu project
> if nobody provides it to the project yet.
>
> How to provide build/CI environment to the qemu project?

Thanks for the offer. Since then, I've been able to set up
a NetBSD VM, which is probably a reasonable CI environment.

However, the other reason why netbsd isn't in the supported
list is that when I tried compiling it it didn't pass the basic
'make; make check' test. So obviously nobody's been
using or testing it :-(

You could start with looking at the compile failures
and submitting patches.

thanks
-- PMM
