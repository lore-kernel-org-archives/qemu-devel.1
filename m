Received: from eggs.gnu.org ([2001:4830:134:3::10]:46873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1f0OAX-0002MF-SE
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 05:12:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1f0OAU-0002cw-N5
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 05:11:57 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:51102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1f0OAU-0002ax-Hf
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 05:11:54 -0400
Received: by mail-it0-f65.google.com with SMTP id d13-v6so9810307itf.0
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 02:11:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180326063901.27425-5-peterx@redhat.com>
References: <20180326063901.27425-1-peterx@redhat.com>
	<20180326063901.27425-5-peterx@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 26 Mar 2018 11:11:53 +0200
Message-ID: <CAMxuvaxd8__zgt4RKATHmpv4QL19K=DtLdAtS1C4omobSU_TsQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12 4/8] qapi: restrict allow-oob
 value to be "true"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Mon, Mar 26, 2018 at 8:38 AM, Peter Xu <peterx@redhat.com> wrote:
> It was missed in the first version of OOB series.  We should check this
> to make sure we throw the right error when fault value is passed in.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Not exactly required imho, but why not:
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  scripts/qapi/common.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index 2c05e3c284..3e14bc41f2 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -872,7 +872,7 @@ def check_keys(expr_elem, meta, required, optional=3D=
[]):
>              raise QAPISemError(info,
>                                 "'%s' of %s '%s' should only use false va=
lue"
>                                 % (key, meta, name))
> -        if key =3D=3D 'boxed' and value is not True:
> +        if (key =3D=3D 'boxed' or key =3D=3D 'allow-oob') and value is n=
ot True:
>              raise QAPISemError(info,
>                                 "'%s' of %s '%s' should only use true val=
ue"
>                                 % (key, meta, name))
> --
> 2.14.3
>
