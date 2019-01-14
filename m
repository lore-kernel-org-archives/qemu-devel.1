Received: from eggs.gnu.org ([209.51.188.92]:32841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gj02s-00066W-6W
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 06:04:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gj02q-0005xH-3o
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 06:04:42 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b]:41836)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gj02p-0005nA-LV
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 06:04:40 -0500
Received: by mail-oi1-x22b.google.com with SMTP id j21so17488842oii.8
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 03:04:33 -0800 (PST)
MIME-Version: 1.0
References: <20190111182533.31593-1-ehabkost@redhat.com>
In-Reply-To: <20190111182533.31593-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Jan 2019 11:04:21 +0000
Message-ID: <CAFEAcA-q-ZamiVtN6yLD9jFAywqLgo3aq6H7rukyBOZ62dQaDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] Work around test-qht-par + gprof issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Emilio G. Cota" <cota@braap.org>

On Fri, 11 Jan 2019 at 18:25, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> The following changes since commit e53f7796fbe71a5c7c24ffebf04b4aa9a759da36:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-request' into staging (2019-01-11 13:35:48 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
>
> for you to fetch changes up to ce2eefd7c21697fee87a0686353de881081d22c6:
>
>   tests: Disable qht-bench parallel test when using gprof (2019-01-11 16:21:45 -0200)
>
> ----------------------------------------------------------------
> Work around test-qht-par + gprof issues
>
> Travis CI jobs are failing because of test-qht-par when gprof is
> enabled.  Temporarily disable test-qht-par if gprof is enabled,
> until we fix the bug.
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
