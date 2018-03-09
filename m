Received: from eggs.gnu.org ([2001:4830:134:3::10]:40765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1euFXl-0005hz-UT
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 05:46:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1euFXl-0004GG-4v
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 05:46:33 -0500
Received: from mail-oi0-x232.google.com ([2607:f8b0:4003:c06::232]:41285)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1euFXl-0004G1-06
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 05:46:33 -0500
Received: by mail-oi0-x232.google.com with SMTP id g5so6646562oiy.8
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 02:46:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180309104145.dfkqpoq3ajr6nzjh@sirius.home.kraxel.org>
References: <20180308083231.20180-1-kraxel@redhat.com>
	<CAFEAcA8wUN_T9XrUULCROVFdv+vGipdMuhNz5km1mcX_nVrQgg@mail.gmail.com>
	<20180309065247.xzribx4zjgx5bnj5@sirius.home.kraxel.org>
	<20180309075054.e4bpa4wsl2wak57w@sirius.home.kraxel.org>
	<f0968a33-fb14-4de2-3a1b-130e2ae7b0ee@redhat.com>
	<20180309091533.uj3qpyjnczugfivh@sirius.home.kraxel.org>
	<20180309094403.gcsspbs4lzozx2zl@sirius.home.kraxel.org>
	<e38420ec-3c31-7a11-da80-43200d83b77b@redhat.com>
	<20180309104145.dfkqpoq3ajr6nzjh@sirius.home.kraxel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Mar 2018 10:46:12 +0000
Message-ID: <CAFEAcA-z3UsNhp_KaC120j9=75uoCSM=U3jKKK2_TRVAVEqc_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/8] Ui 20180308 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 9 March 2018 at 10:41, Gerd Hoffmann <kraxel@redhat.com> wrote:
> Well, I can add -Wno-address-of-packed-member to the list of flags
> configure tries to use with the compiler.  That gets me past that
> warning, but the build will stop on the next then.  qemu simply doesn't
> build warning-clean with clang ...

That depends on your clang version. I have 3.8.0 in my test set builds
with -Werror enabled.

At some point we should go through and fix the issues that newer
clang versions warn about.

thanks
-- PMM
