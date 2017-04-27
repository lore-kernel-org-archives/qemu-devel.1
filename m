Received: from eggs.gnu.org ([2001:4830:134:3::10]:41074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d3fOC-0001Uc-Pr
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:07:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d3fOB-0001xv-Nz
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:07:04 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:35611)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1d3fOB-0001xQ-GJ
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:07:03 -0400
Received: by mail-lf0-x244.google.com with SMTP id i3so3325200lfh.2
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 02:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <1493282486-28338-1-git-send-email-armbru@redhat.com>
	<1493282486-28338-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1493282486-28338-3-git-send-email-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 27 Apr 2017 09:06:51 +0000
Message-ID: <CAJ+F1CKUxUXyCYbg-ZU9sO22cH3tK2PESjyeu=kBGLUnPX_UAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/4] qobject-input-visitor: Document
 full_name_nth()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com

On Thu, Apr 27, 2017 at 12:41 PM Markus Armbruster <armbru@redhat.com>
wrote:

> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



> ---
>  qapi/qobject-input-visitor.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
> index 865e948..2530959 100644
> --- a/qapi/qobject-input-visitor.c
> +++ b/qapi/qobject-input-visitor.c
> @@ -55,6 +55,17 @@ static QObjectInputVisitor *to_qiv(Visitor *v)
>      return container_of(v, QObjectInputVisitor, visitor);
>  }
>
> +/*
> + * Find the full name of something @qiv is currently visiting.
> + * @qiv is visiting something named @name in the stack of containers
> + * @qiv->stack.
> + * If @n is zero, return its full name.
> + * If @n is positive, return the full name of the @n-th container
> + * counting from the top.  The stack of containers must have at least
> + * @n elements.
> + * The returned string is valid until the next full_name_nth(@v) or
> + * destruction of @v.
> + */
>  static const char *full_name_nth(QObjectInputVisitor *qiv, const char
> *name,
>                                   int n)
>  {
> --
> 2.7.4
>
>
> --
Marc-Andr=C3=A9 Lureau
