Received: from eggs.gnu.org ([2001:4830:134:3::10]:43455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzghv-0006Cg-KN
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:15:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzghu-0003EL-L3
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:15:15 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:37455)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dzght-0003DV-Vf
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:15:14 -0400
Received: by mail-qk0-x243.google.com with SMTP id a12so5000126qka.4
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 03:15:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171002141341.24616-3-armbru@redhat.com>
References: <20171002141341.24616-1-armbru@redhat.com>
	<20171002141341.24616-3-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 4 Oct 2017 12:15:12 +0200
Message-ID: <CAJ+F1CKxWet4f4+1CSncCUkB9EV8NCaWcOV0-4VYnBjy5ACVog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 02/11] qapi: Stop rejecting #optional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

On Mon, Oct 2, 2017 at 4:13 PM, Markus Armbruster <armbru@redhat.com> wrote=
:
> Commit 1d8bda1 got rid of #optional tags, and added a check to keep
> them from getting added back, to make sure patches then in flight
> don't add them back.  It's been six months, time to drop that check.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  scripts/qapi.py | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index 62dc52ed6e..dc92bca620 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -234,10 +234,6 @@ class QAPIDoc(object):
>              raise QAPIParseError(self.parser,
>                                   "'%s' not allowed in free-form document=
ation"
>                                   % match.group(1))
> -        # TODO Drop this once the dust has settled
> -        if (isinstance(self.section, QAPIDoc.ArgSection)
> -                and '#optional' in line):
> -            raise QAPISemError(self.info, "Please drop the #optional tag=
")
>          self.section.append(line)
>
>      def connect_member(self, member):
> --
> 2.13.6
>
>



--=20
Marc-Andr=C3=A9 Lureau
