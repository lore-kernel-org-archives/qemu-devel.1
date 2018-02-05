Received: from eggs.gnu.org ([2001:4830:134:3::10]:52862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eih6y-00027Z-Hl
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:47:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eih6t-0004qe-Ky
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:47:08 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:42968)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1eih6t-0004qM-G3
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:47:03 -0500
Received: by mail-qk0-f196.google.com with SMTP id f68so12287518qke.9
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 05:47:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180202130336.24719-19-armbru@redhat.com>
References: <20180202130336.24719-1-armbru@redhat.com>
	<20180202130336.24719-19-armbru@redhat.com>
From: Marc-Andre Lureau <mlureau@redhat.com>
Date: Mon, 5 Feb 2018 14:47:02 +0100
Message-ID: <CAMxuvaxA7XTPvhBRQmBBA13meiF0b8aXBXY6kJ0jdoSoT3Ku=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 18/21] qapi/common: Fix guardname() for
 funny filenames
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, marcandre <marcandre.lureau@redhat.com>, "Blake, Eric" <eblake@redhat.com>, mdroth@linux.vnet.ibm.com

On Fri, Feb 2, 2018 at 2:03 PM, Markus Armbruster <armbru@redhat.com> wrote=
:
> guardname() fails to return a valid C identifier for arguments
> containing anything but [A-Za-z0-9_.-'].  Fix that.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  scripts/qapi/common.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index 7ffffc78d9..7d497b5b17 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -1860,7 +1860,7 @@ def mcgen(code, **kwds):
>
>
>  def guardname(filename):
> -    return c_name(filename, protect=3DFalse).upper()
> +    return re.sub(r'[^A-Za-z0-9_]', '_', filename).upper()
>
>
>  def guardstart(name):
> --
> 2.13.6
>
