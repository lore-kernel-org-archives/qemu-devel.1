Received: from eggs.gnu.org ([208.118.235.92]:59400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1gfCBg-0001GJ-Ns
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 18:14:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1gfCBb-0004cp-SE
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 18:14:04 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34433)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1gfCBa-0004Y6-21
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 18:13:58 -0500
Received: by mail-wr1-f68.google.com with SMTP id j2so35205958wrw.1
	for <qemu-devel@nongnu.org>; Thu, 03 Jan 2019 15:13:55 -0800 (PST)
MIME-Version: 1.0
References: <20190103172151.24706-1-philmd@redhat.com>
In-Reply-To: <20190103172151.24706-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Fri, 4 Jan 2019 00:13:42 +0100
Message-ID: <CAP+75-WvRE6roaEGBOobK1niHz7kR2h07He=SuvaLauv=or++A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docker: Use stable git tag for
 virglrenderer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <fam@euphon.net>
Cc: Gerd Hoffmann <kraxel@redhat.com>

On Thu, Jan 3, 2019 at 6:22 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> Use a stable tag instead of some random commit from mainstream
> development, to avoid unexpected build failures.
>
> This fixes:
>
>     CC       virglrenderer.lo
>   virglrenderer.c: In function 'virgl_has_gl_colorspace':
>   virglrenderer.c:208:11: error: implicit declaration of function 'virgl_=
has_egl_khr_gl_colorspace' [-Werror=3Dimplicit-function-declaration]
>              virgl_has_egl_khr_gl_colorspace(egl_info));
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   virglrenderer.c:208:43: error: 'egl_info' undeclared (first use in this=
 function)
>              virgl_has_egl_khr_gl_colorspace(egl_info));
>                                              ^~~~~~~~
>   virglrenderer.c:208:43: note: each undeclared identifier is reported on=
ly once for each function it appears in
>   cc1: some warnings being treated as errors
>
> As of this commit 'git virglrenderer-0.7.0' is the last stable tag.
> (virglrenderer commit breaking: fb4f7577f7ef)

Success on Shippable:
https://app.shippable.com/github/philmd/qemu/runs/310/summary/console
