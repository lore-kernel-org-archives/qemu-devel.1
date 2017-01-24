Received: from eggs.gnu.org ([2001:4830:134:3::10]:60361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cW1tl-00054C-Mz
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 09:16:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cW1tk-0008OR-Ds
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 09:16:37 -0500
Received: from mail-yb0-x241.google.com ([2607:f8b0:4002:c09::241]:34778)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cW1tk-0008OD-7u
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 09:16:36 -0500
Received: by mail-yb0-x241.google.com with SMTP id w194so13164594ybe.1
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 06:16:36 -0800 (PST)
MIME-Version: 1.0
References: <1485266538-10119-1-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1485266538-10119-1-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 24 Jan 2017 14:16:24 +0000
Message-ID: <CAJ+F1CJBkM9tJdi7thJSzMY_tqUFy=O-WALtVmYA2h2QYryJPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Makefile: Add qemu-doc.txt to distclean
 and dependencies
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, patches@linaro.org

Hi

On Tue, Jan 24, 2017 at 6:05 PM Peter Maydell <peter.maydell@linaro.org>
wrote:

> When qemu-doc.txt was added as a new output format in
> commit f8bab10b4c3f, it was not added to either the
> list of files to remove in distclean or to the dependency
> line that forces qemu-options.texi to be built before
> attempting to build qemu-doc.*.
>
> In particular, the missing dependency meant that on
> some platforms (notably OSX hosts) we would try to
> build qemu-doc.txt before qemu-options.texi had been
> fully written out, and then makeinfo would complain
> about missing cross-reference targets.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>


good catch, sorry about the regression

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


---
>  Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 9f8968d..c166d2d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -393,7 +393,7 @@ distclean: clean
>         rm -f qemu-doc.info qemu-doc.aux qemu-doc.cp qemu-doc.cps
>         rm -f qemu-doc.fn qemu-doc.fns qemu-doc.info qemu-doc.ky
> qemu-doc.kys
>         rm -f qemu-doc.log qemu-doc.pdf qemu-doc.pg qemu-doc.toc
> qemu-doc.tp
> -       rm -f qemu-doc.vr
> +       rm -f qemu-doc.vr qemu-doc.txt
>         rm -f config.log
>         rm -f linux-headers/asm
>         rm -f qemu-ga-qapi.texi qemu-qapi.texi
> @@ -590,7 +590,7 @@ info: qemu-doc.info docs/qemu-qmp-ref.info docs/
> qemu-ga-ref.info
>  pdf: qemu-doc.pdf docs/qemu-qmp-ref.pdf docs/qemu-ga-ref.pdf
>  txt: qemu-doc.txt docs/qemu-qmp-ref.txt docs/qemu-ga-ref.txt
>
> -qemu-doc.html qemu-doc.info qemu-doc.pdf: \
> +qemu-doc.html qemu-doc.info qemu-doc.pdf qemu-doc.txt: \
>         qemu-img.texi qemu-nbd.texi qemu-options.texi
> qemu-option-trace.texi \
>         qemu-monitor.texi qemu-img-cmds.texi qemu-ga.texi \
>         qemu-monitor-info.texi
> --
> 2.7.4
>
>
> --
Marc-Andr=C3=A9 Lureau
