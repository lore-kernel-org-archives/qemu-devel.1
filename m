Received: from eggs.gnu.org ([209.51.188.92]:44512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkXRE-0001hd-2u
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:56:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkXRD-0001hX-2o
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:56:11 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:40560)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkXRC-0001gP-O1
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:56:11 -0500
Received: by mail-ot1-x330.google.com with SMTP id s5so14954342oth.7
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 08:56:10 -0800 (PST)
MIME-Version: 1.0
References: <20190117201743.20470-1-ehabkost@redhat.com>
In-Reply-To: <20190117201743.20470-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 16:55:57 +0000
Message-ID: <CAFEAcA_whv5envgZ+dq1p+Hpd0j6H6oVkwq6wFym1rS5N_iDOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/9] Python queue, 2019-01-17
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>

On Thu, 17 Jan 2019 at 20:17, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> The following changes since commit 681d61362d3f766a00806b89d6581869041f73cb:
>
>   Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request' into staging (2019-01-17 12:48:42 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/python-next-pull-request
>
> for you to fetch changes up to 49ebe9b15876f3ce9a5f45cb53a16b6a788d65fd:
>
>   scripts/replay-dump.py: fix utf-8 mangling (2019-01-17 17:52:40 -0200)
>
> ----------------------------------------------------------------
> Python queue, 2019-01-17
>
> Fixes:
> * Actually test different Python versions on Travis CI
> * Fix qemu.py error message when qemu dies from signal
>
> Cleanups:
> * Track Python version on config-host.mak
> * Remove fixed crashes from scripts/device-crash-test
> * Acceptance tests: Linux initrd checking test
> * Fix utf-8 mangling at scripts/replay-dump.py
> * Remove unused python imports from multiple scripts
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
