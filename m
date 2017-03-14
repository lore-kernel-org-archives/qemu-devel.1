Received: from eggs.gnu.org ([2001:4830:134:3::10]:48555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cni0O-0002Ja-C5
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:40:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cni0N-0006vu-3l
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:40:32 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:33450)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cni0M-0006vD-O1
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:40:31 -0400
Received: by mail-lf0-x242.google.com with SMTP id r36so13586457lfi.0
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 01:40:30 -0700 (PDT)
MIME-Version: 1.0
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-10-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-10-git-send-email-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 14 Mar 2017 08:40:18 +0000
Message-ID: <CAJ+F1CL5PEdS11sRGgv8ij5Dsk0GCZEJ0vmk02Kz4jEc5GWskw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.9 09/47] qapi: Fix to reject empty
 union base gracefully
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

Hi

On Mon, Mar 13, 2017 at 10:19 AM Markus Armbruster <armbru@redhat.com>
wrote:

> Common Python pitfall: 'assert base_members' fires on [] in addition
> to None.  Correct to 'assert base_members is not None'.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  scripts/qapi.py                        |  2 +-
>  tests/qapi-schema/union-base-empty.err | 11 +----------
>  2 files changed, 2 insertions(+), 11 deletions(-)
>
> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index e98fd0c..eec7bfb 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -731,7 +731,7 @@ def check_union(expr, info):
>              raise QAPISemError(info, "Flat union '%s' must have a base"
>                                 % name)
>          base_members =3D find_base_members(base)
> -        assert base_members
> +        assert base_members is not None
>
>          # The value of member 'discriminator' must name a non-optional
>          # member of the base struct.
> diff --git a/tests/qapi-schema/union-base-empty.err
> b/tests/qapi-schema/union-base-empty.err
> index 61e6ec6..7695806 100644
> --- a/tests/qapi-schema/union-base-empty.err
> +++ b/tests/qapi-schema/union-base-empty.err
> @@ -1,10 +1 @@
> -Traceback (most recent call last):
> -  File "tests/qapi-schema/test-qapi.py", line 56, in <module>
> -    schema =3D QAPISchema(sys.argv[1])
> -  File "scripts/qapi.py", line 1483, in __init__
> -    self.exprs =3D check_exprs(parser.exprs)
> -  File "scripts/qapi.py", line 917, in check_exprs
> -    check_union(expr, info)
> -  File "scripts/qapi.py", line 734, in check_union
> -    assert base_members
> -AssertionError
> +tests/qapi-schema/union-base-empty.json:5: Discriminator 'type' is not a
> member of base struct 'Empty'
> --
> 2.7.4
>
>
> --
Marc-Andr=C3=A9 Lureau
