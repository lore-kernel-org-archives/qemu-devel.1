Received: from eggs.gnu.org ([2001:4830:134:3::10]:59754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f87S1-0006OU-HZ
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:57:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f87S0-0002Ho-Qn
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:57:57 -0400
Received: from mail-ot0-x22b.google.com ([2607:f8b0:4003:c0f::22b]:33638)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f87S0-0002HC-MF
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:57:56 -0400
Received: by mail-ot0-x22b.google.com with SMTP id g23-v6so3023927oti.0
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 09:57:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180416163953.31188-1-ehabkost@redhat.com>
References: <20180416163953.31188-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Apr 2018 17:57:35 +0100
Message-ID: <CAFEAcA9jQsRK4WW+Ov7j1rewCgtVHoWFkkDF7wfoWgdP0SeTgA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] i386: Don't automatically enable
 FEAT_KVM_HINTS bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 16 April 2018 at 17:39, Eduardo Habkost <ehabkost@redhat.com> wrote:
> Last remaining fix for -rc4.
>
> The following changes since commit 042f6a31af3d38eefc6ec995cce1d762c41d4515:
>
>   Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2018-04-16' into staging (2018-04-16 15:30:54 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/x86-next-pull-request
>
> for you to fetch changes up to 0d914f39a77954bf5472b16130aeefe573a068f5:
>
>   i386: Don't automatically enable FEAT_KVM_HINTS bits (2018-04-16 13:36:52 -0300)
>
> ----------------------------------------------------------------
> i386: Don't automatically enable FEAT_KVM_HINTS bits
>
> Bug fix for "-cpu host" with newer kernels.
>
> ----------------------------------------------------------------

Is this a regression since 2.11 ?

thanks
-- PMM
