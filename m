Received: from eggs.gnu.org ([2001:4830:134:3::10]:53845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gTp3l-0005fA-Ey
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:18:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gTp3j-0008IG-Oi
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:18:52 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:32907)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gTp3j-0008Hl-KU
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:18:51 -0500
Received: by mail-ot1-x344.google.com with SMTP id i20so11706774otl.0
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 06:18:51 -0800 (PST)
MIME-Version: 1.0
References: <1543845937-300-1-git-send-email-thuth@redhat.com>
	<1543845937-300-2-git-send-email-thuth@redhat.com>
	<20181203141611.GG8870@redhat.com>
In-Reply-To: <20181203141611.GG8870@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Dec 2018 14:18:39 +0000
Message-ID: <CAFEAcA9Jkegcx6VmYkzDE4dYrxec2s5XFjWd3qOWb9=PAhaDfg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 1/7] configure: Add a test for the
 minimum compiler version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, 3 Dec 2018 at 14:16, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
> NB although this will succeed, it is not technically checking the
> right thing on macOS platforms as their clang used a completely
> different numbering scheme. It just happens to have larger numbers
> than upstream clang, so we'll always succeed.
>
> Compare clang on Ubuntu:
>
>   https://travis-ci.org/qemu/qemu/jobs/460892603
>
>   $ clang --version
>   clang version 5.0.0 (tags/RELEASE_500/final)
>
> with clang on macOS:
>
>   https://travis-ci.org/qemu/qemu/jobs/460892611
>
>   $ clang --version
>   Apple LLVM version 9.1.0 (clang-902.0.39.2)
>
> Fortunately there's a mapping recorded here:
>
>    https://en.wikipedia.org/wiki/Xcode#Latest_versions
>
> See "LLVM" and "CLang version string" columns.

...but overall it is better to check for feature presence/absence
where possible rather than using a version number check.
clang does at least make this easier than it has historically
been for gcc.

thanks
-- PMM
