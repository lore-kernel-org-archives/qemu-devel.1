Received: from eggs.gnu.org ([2001:4830:134:3::10]:42625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzgfS-0003sB-Ml
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:12:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzgfR-0000a4-PW
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:12:42 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:47291)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dzgfR-0000Z8-Kz
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:12:41 -0400
Received: by mail-qt0-x242.google.com with SMTP id z50so13111409qtj.4
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 03:12:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171002140307.5292-7-armbru@redhat.com>
References: <20171002140307.5292-1-armbru@redhat.com>
	<20171002140307.5292-7-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 4 Oct 2017 12:12:40 +0200
Message-ID: <CAJ+F1CJd032A5G-tyn2u=omB6_dbKojAD0917m_KFewA=7AiNw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 6/8] qemu-options: Polish section "TPM
 device options"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>

On Mon, Oct 2, 2017 at 4:03 PM, Markus Armbruster <armbru@redhat.com> wrote=
:
> Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



> ---
>  qemu-options.hx | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 8568ee388c..615cb230ab 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -2915,19 +2915,18 @@ The general form of a TPM device option is:
>
>  @item -tpmdev @var{backend} ,id=3D@var{id} [,@var{options}]
>  @findex -tpmdev
> -Backend type must be:
> -@option{passthrough}.
>
>  The specific backend type will determine the applicable options.
>  The @code{-tpmdev} option creates the TPM backend and requires a
>  @code{-device} option that specifies the TPM frontend interface model.
>
> -Options to each backend are described below.
> +Use @code{-tpmdev help} to print all available TPM backend types.
>
> -Use 'help' to print all available TPM backend types.
> -@example
> -qemu -tpmdev help
> -@end example
> +@end table
> +
> +The available backends are:
> +
> +@table @option
>
>  @item -tpmdev passthrough, id=3D@var{id}, path=3D@var{path}, cancel-path=
=3D@var{cancel-path}
>
> @@ -2966,10 +2965,11 @@ To create a passthrough TPM use the following two=
 options:
>  Note that the @code{-tpmdev} id is @code{tpm0} and is referenced by
>  @code{tpmdev=3Dtpm0} in the device option.
>
> +ETEXI
> +
> +STEXI
>  @end table
> -
>  ETEXI
> -
>  DEFHEADING()
>
>  #endif
> --
> 2.13.6
>
>



--=20
Marc-Andr=C3=A9 Lureau
