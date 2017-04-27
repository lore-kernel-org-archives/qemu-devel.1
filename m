Received: from eggs.gnu.org ([2001:4830:134:3::10]:41063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d3fOA-0001P6-QG
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:07:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d3fO9-0001wb-Ry
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:07:02 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:33295)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1d3fO9-0001vv-Jw
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:07:01 -0400
Received: by mail-lf0-x242.google.com with SMTP id 88so3340867lfr.0
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 02:07:01 -0700 (PDT)
MIME-Version: 1.0
References: <1493282486-28338-1-git-send-email-armbru@redhat.com>
	<1493282486-28338-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1493282486-28338-4-git-send-email-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 27 Apr 2017 09:06:49 +0000
Message-ID: <CAJ+F1CJUdoKtoZo=fLaPw1zYxfyOxexoZqtcEwkfNVB8atUB=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/4] qapi: Document intended use of @name
 within alternate visits
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

On Thu, Apr 27, 2017 at 12:42 PM Markus Armbruster <armbru@redhat.com>
wrote:

> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



> ---
>  include/qapi/visitor.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
> index 1a1b620..b0e233d 100644
> --- a/include/qapi/visitor.h
> +++ b/include/qapi/visitor.h
> @@ -63,8 +63,10 @@
>   * The @name parameter of visit_type_FOO() describes the relation
>   * between this QAPI value and its parent container.  When visiting
>   * the root of a tree, @name is ignored; when visiting a member of an
> - * object, @name is the key associated with the value; and when
> - * visiting a member of a list, @name is NULL.
> + * object, @name is the key associated with the value; when visiting a
> + * member of a list, @name is NULL; and when visiting the member of an
> + * alternate, @name should equal the name used for visiting the
> + * alternate.
>   *
>   * The visit_type_FOO() functions expect a non-null @obj argument;
>   * they allocate *@obj during input visits, leave it unchanged on
> --
> 2.7.4
>
>
> --
Marc-Andr=C3=A9 Lureau
