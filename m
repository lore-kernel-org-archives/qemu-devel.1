Received: from eggs.gnu.org ([2001:4830:134:3::10]:43780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cpzi8-0006kt-3U
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:59:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cpzi2-000710-NB
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:59:08 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:37614)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cpzi2-00070v-HR
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:59:02 -0400
Received: by mail-wm0-x22d.google.com with SMTP id n11so68289136wma.0
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 08:59:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170317160811.28370-1-pbonzini@redhat.com>
References: <20170317160811.28370-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Mar 2017 15:58:40 +0000
Message-ID: <CAFEAcA-Vf7x_vOddvZouLXQYhY=CPox3iv4E9Q-HUj_yiqv1Mw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH for 2.9 v2] configure: remove Cygwin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>

On 17 March 2017 at 16:08, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The Cygwin target is really compiling for native Win32 with -mno-cygwin.
> Except, GCC 4.7.0 has finally removed the long deprecated -mno-cygwin
> option, and that happened about five years ago.
>
> Let it rest in peace.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  bsd-user/mmap.c | 5 -----
>  configure       | 6 ------
>  2 files changed, 11 deletions(-)
>

Applied to master, thanks.

-- PMM
