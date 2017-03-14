Received: from eggs.gnu.org ([2001:4830:134:3::10]:51435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cni9h-0005tB-SU
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:50:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cni9g-0002EL-Pq
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:50:09 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:35275)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cni9g-0002CF-Ed
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:50:08 -0400
Received: by mail-lf0-x244.google.com with SMTP id v2so13588406lfi.2
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 01:50:08 -0700 (PDT)
MIME-Version: 1.0
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-13-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-13-git-send-email-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 14 Mar 2017 08:49:56 +0000
Message-ID: <CAJ+F1CLqk7-wWrAJRoZZ1da_53XrtAAPz-A+T_9x+1U2ANZptg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.9 12/47] qapi/rocker: Fix up doc
 comment notes on optional members
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

On Mon, Mar 13, 2017 at 10:31 AM Markus Armbruster <armbru@redhat.com>
wrote:

> Talking about #optional like this
>
>     # Note: fields are marked #optional to indicate that they may or may
>     # not appear ...
>
> doesn't work so well in generated documentation, because the #optional
> tag is not visible there.  Replace by
>
>     # Note: optional members may or may not appear ...
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>

indeed,
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  qapi/rocker.json | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/qapi/rocker.json b/qapi/rocker.json
> index 97e2b83..f374038 100644
> --- a/qapi/rocker.json
> +++ b/qapi/rocker.json
> @@ -1,3 +1,5 @@
> +# -*- Mode: Python -*-
> +
>  ##
>  # =3D Rocker switch device
>  ##
> @@ -137,8 +139,8 @@
>  #
>  # @ip-dst: #optional IP header destination address
>  #
> -# Note: fields are marked #optional to indicate that they may or may not
> -# appear in the flow key depending if they're relevant to the flow key.
> +# Note: optional members may or may not appear in the flow key
> +# depending if they're relevant to the flow key.
>  #
>  # Since: 2.4
>  ##
> @@ -167,8 +169,8 @@
>  #
>  # @ip-tos: #optional IP header TOS field
>  #
> -# Note: fields are marked #optional to indicate that they may or may not
> -# appear in the flow mask depending if they're relevant to the flow mask=
.
> +# Note: optional members may or may not appear in the flow mask
> +# depending if they're relevant to the flow mask.
>  #
>  # Since: 2.4
>  ##
> @@ -194,8 +196,8 @@
>  #
>  # @out-pport: #optional physical output port
>  #
> -# Note: fields are marked #optional to indicate that they may or may not
> -# appear in the flow action depending if they're relevant to the flow
> action.
> +# Note: optional members may or may not appear in the flow action
> +# depending if they're relevant to the flow action.
>  #
>  # Since: 2.4
>  ##
> @@ -288,8 +290,8 @@
>  #
>  # @ttl-check: #optional perform TTL check
>  #
> -# Note: fields are marked #optional to indicate that they may or may not
> -# appear in the group depending if they're relevant to the group type.
> +# Note: optional members may or may not appear in the group depending
> +# if they're relevant to the group type.
>  #
>  # Since: 2.4
>  ##
> --
> 2.7.4
>
>
> --
Marc-Andr=C3=A9 Lureau
