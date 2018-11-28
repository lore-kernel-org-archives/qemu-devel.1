Received: from eggs.gnu.org ([2001:4830:134:3::10]:42582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gS1pU-0006kK-HF
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 10:32:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gS1pT-0003ql-N7
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 10:32:44 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:42672)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gS1pT-0003q1-EW
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 10:32:43 -0500
Received: by mail-ot1-x341.google.com with SMTP id v23so18445937otk.9
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 07:32:43 -0800 (PST)
MIME-Version: 1.0
References: <1543399094-2260-1-git-send-email-thuth@redhat.com>
In-Reply-To: <1543399094-2260-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 28 Nov 2018 15:32:30 +0000
Message-ID: <CAFEAcA8jBUhbUjixnXkFo8H9KMfFfZknG5HMxchp6UGEKBueKQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-3.1?] target/arm/sve_helper: Fix
 compilation with clang 3.4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, qemu-arm <qemu-arm@nongnu.org>

On Wed, 28 Nov 2018 at 09:58, Thomas Huth <thuth@redhat.com> wrote:
>
> Clang 3.4 does not know the "flatten" attribute yet. We've already
> introduced the QEMU_FLATTEN macro for this in commit 97ff87c0ed020c2,
> so use this macro now here, too, to fix this issue.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Applied to master, thanks.

-- PMM
