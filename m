Received: from eggs.gnu.org ([209.51.188.92]:37859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1glazo-000452-K2
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 09:56:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1glao1-0000q4-NU
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 09:44:06 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:37151)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1glao1-0000ph-HT
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 09:44:05 -0500
Received: by mail-ot1-x341.google.com with SMTP id s13so20728896otq.4
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 06:44:04 -0800 (PST)
MIME-Version: 1.0
References: <1547732292-14021-1-git-send-email-thuth@redhat.com>
In-Reply-To: <1547732292-14021-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Jan 2019 14:43:52 +0000
Message-ID: <CAFEAcA93W+-6xkBiGdqFStOx4t25oSq=GE07Mj86uUJ_xodFQg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v3 00/28] ivshmem deprecation, qtests,
 typedefs and gnu99
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Li Qiang <liq3ea@163.com>, Greg Kurz <groug@kaod.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, "Michael S. Tsirkin" <mst@redhat.com>

On Thu, 17 Jan 2019 at 13:38, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter!
>
> The following changes since commit 6f2f34177a25bffd6fd92a05e6e66c8d22d97094:
>
>   Merge remote-tracking branch 'remotes/thibault/tags/samuel-thibault' into staging (2019-01-15 18:32:57 +0000)
>
> are available in the git repository at:
>
>   https://gitlab.com/huth/qemu.git tags/pull-request-2019-01-17
>
> for you to fetch changes up to 3f0832c85380321ef697d64342b389648f8abb1c:
>
>   tests/hexloader-test: Don't pass -nographic to the QEMU under test (2019-01-17 14:25:12 +0100)
>
> ----------------------------------------------------------------
> - Remove deprecated "ivshmem" legacy device
> - Bug fix for vhost-user-test
> - Use more CONFIG Makefile switches for qtests
> - Get rid of global_qtests in some more qtests
> - typedef cleanups
> - Fixes for compiling with Clang
> - Force C standard to gnu99
> ----------------------------------------------------------------

I gave this another run now the ipmi-bt test has been
disabled. It gets this compile failure on clang builds:

In file included from
/home/petmay01/linaro/qemu-for-merges/hw/net/vhost_net.c:21:
/home/petmay01/linaro/qemu-for-merges/include/hw/virtio/virtio-net.h:189:3:
error: redefinition of typedef 'VirtIONet' is a C11 feature
[-Werror,-Wtypedef-redefinition]
} VirtIONet;
  ^
/home/petmay01/linaro/qemu-for-merges/include/hw/virtio/virtio-net.h:110:26:
note: previous definition is here
typedef struct VirtIONet VirtIONet;
                         ^
1 error generated.

thanks
-- PMM
