Received: from eggs.gnu.org ([209.51.188.92]:37847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gzJem-0006PZ-7A
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 06:15:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gzJel-0006MF-CC
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 06:15:16 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:38944)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gzJel-0005kr-1X
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 06:15:15 -0500
Received: by mail-wr1-x42a.google.com with SMTP id l5so21486086wrw.6
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 03:14:58 -0800 (PST)
MIME-Version: 1.0
References: <CACxphuH+U=C1bUASDKTqg+AiwQLV9ARJ3DHYSE97Uw9d=bM_VA@mail.gmail.com>
In-Reply-To: <CACxphuH+U=C1bUASDKTqg+AiwQLV9ARJ3DHYSE97Uw9d=bM_VA@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 28 Feb 2019 12:14:45 +0100
Message-ID: <CAJ+F1C+Dh2xsT9FgPkToF7T0AitfKcVj_OWM9Q=tAML+JXtV8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] sorecvfrom freezes guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: llyzs <llyzs.vic@gmail.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: QEMU <qemu-devel@nongnu.org>

Hi,

On Thu, Feb 28, 2019 at 11:45 AM llyzs <llyzs.vic@gmail.com> wrote:
>
> Hi,
>
> I am having a guest freeze issue (win10), and through debugging I found o=
ut
> that sometimes sorecvfrom() is called from slirp.c because revents =3D=3D
> G_IO_IN, however inside sorecvfrom() function, ioctlsocket() returns 0
> bytes available and recvfrom could be blocking indefinitely. I am not sur=
e
> the root cause of the situation, but I added a non-blocking check to
> recvfrom and it fixed my issue. My patch is as attached. Please check if
> this is a right fix.


Thank you for the patch.

Could you resend it inline, with the comment in the commit message?

Also add the subsystem maintainers in CC:

$ scripts/get_maintainer.pl -f slirp
Samuel Thibault <samuel.thibault@ens-lyon.org> (maintainer:SLIRP)
Jan Kiszka <jan.kiszka@siemens.com> (maintainer:SLIRP)
qemu-devel@nongnu.org (open list:All patches CC here)

(see also https://wiki.qemu.org/Contribute/SubmitAPatch)

--=20
Marc-Andr=C3=A9 Lureau
