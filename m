Received: from eggs.gnu.org ([2001:4830:134:3::10]:45400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gS1x5-0003xg-Qj
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 10:40:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gS1x4-0006ie-BO
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 10:40:35 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gS1x2-0006Li-Al
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 10:40:32 -0500
Received: by mail-wr1-x441.google.com with SMTP id x10so26765480wrs.8
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 07:40:23 -0800 (PST)
MIME-Version: 1.0
References: <20181122141741.11108-1-marcandre.lureau@redhat.com>
	<0432176d-72a6-2dd4-ccc7-8486ea49be7b@weilnetz.de>
In-Reply-To: <0432176d-72a6-2dd4-ccc7-8486ea49be7b@weilnetz.de>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 28 Nov 2018 19:40:09 +0400
Message-ID: <CAJ+F1C+iGrQFRyQdxyWM7rF8wx8kt48C6aUuqQ6RaMU=r3MW_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docs: apply some qemu.org-like CSS style
 to HTML
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: QEMU <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

Hi

On Wed, Nov 28, 2018 at 7:27 PM Stefan Weil <sw@weilnetz.de> wrote:
>
> Am 22.11.2018 um 15:17 schrieb Marc-Andr=C3=A9 Lureau:
> > Style a bit the HTML documents, to make them look like qemu.org pages.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  Makefile                     |   2 +
> >  docs/texinfo-extra-head.html |   7 ++
> >  docs/texinfo.css             | 226 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 235 insertions(+)
> >  create mode 100644 docs/texinfo-extra-head.html
> >  create mode 100644 docs/texinfo.css
>
>
> I tried this patch, and here are the results without the patch and with
> the patch, so everybody can compare both looks:
>
> old: https://qemu.weilnetz.de/doc/qemu-doc.html
> new: https://qemu.weilnetz.de/doc/3.1/qemu-doc.html
>
> I like the new look and can use it from now on, no matter whether it is
> merged into QEMU 3.1 or delayed for release 4.

With my limited knowledge of CSS, I tried to apply a style close to
what qemu.org already uses. Further tweaks would be welcome, but
better left to someone with more web design skills.

>
> Tested-by: Stefan Weil <sw@weilnetz.de>
>
> PS: https://qemu.weilnetz.de/doc/3.1/qemu-ga-ref.html and
> https://qemu.weilnetz.de/doc/3.1/qemu-qmp-ref.html are also candidates
> for the new look.

Oh, but the style is also applied for them, as they are also generated
from the same texinfo->html process.

I wonder if the generated pages could be somehow uploaded on release
on qemu.org, or simply committed to qemu-web?


--=20
Marc-Andr=C3=A9 Lureau
