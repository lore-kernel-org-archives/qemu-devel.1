Received: from eggs.gnu.org ([2001:4830:134:3::10]:50947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQbsY-0007oz-Ro
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:01:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQbsX-0000S9-T9
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:01:14 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:34975)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dQbsX-0000Rn-MP
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:01:13 -0400
Received: by mail-wm0-x22e.google.com with SMTP id w126so86589604wme.0
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 09:01:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1498743831-28676-1-git-send-email-groug@kaod.org>
References: <1498743831-28676-1-git-send-email-groug@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Jun 2017 17:00:51 +0100
Message-ID: <CAFEAcA_nEPOV25nimO1w2K51G7ooaRUseSwwy=Vc-gvFv2AkTA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/8] 9pfs patches for 2.10 20170629
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 29 June 2017 at 14:43, Greg Kurz <groug@kaod.org> wrote:
> The following changes since commit 464588675455afda2899e20a0b120e4075de50=
c7:
>
>   Merge remote-tracking branch 'remotes/sstabellini/tags/xen-20170627-tag=
' into staging (2017-06-29 11:45:01 +0100)
>
> are available in the git repository at:
>
>   https://github.com/gkurz/qemu.git tags/for-upstream
>
> for you to fetch changes up to 06a37db7b12e4d42a6699c2fef820158f470ec4f:
>
>   9pfs: handle transport errors in pdu_complete() (2017-06-29 15:11:51 +0=
200)
>
> ----------------------------------------------------------------
> - fixes a minor bug that could possibly prevent old guests to remove
>   directories
> - makes default permissions for new files configurable from the cmdline
>   when using mapped security modes
> - handle transport errors
> - g_malloc()+memcpy() converted to g_memdup()
>
> ----------------------------------------------------------------
> Bruce Rogers (1):
>       9pfs: local: remove: use correct path component
>
> Greg Kurz (4):
>       virtio-9p: record element after sanity checks
>       virtio-9p: message header is 7-byte long
>       virtio-9p: break device if buffers are misconfigured
>       9pfs: handle transport errors in pdu_complete()
>
> Marc-Andr=C3=A9 Lureau (1):
>       9pfs: replace g_malloc()+memcpy() with g_memdup()
>
> Stefano Stabellini (1):
>       xen-9pfs: disconnect if buffers are misconfigured
>
> Tobias Schramm (1):
>       9pfs: local: Add support for custom fmode/dmode in 9ps mapped secur=
ity modes
>

Applied, thanks.

-- PMM
