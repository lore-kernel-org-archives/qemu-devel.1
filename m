Received: from eggs.gnu.org ([2001:4830:134:3::10]:45655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g7f3w-0001se-A1
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 07:11:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g7f3v-0001xg-JI
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 07:11:28 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38525)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1g7f3u-0001xF-UU
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 07:11:27 -0400
Received: by mail-wr1-x443.google.com with SMTP id a13-v6so5649432wrt.5
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 04:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <20181003104605.8477-1-kchamart@redhat.com>
In-Reply-To: <20181003104605.8477-1-kchamart@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 3 Oct 2018 15:11:13 +0400
Message-ID: <CAJ+F1CKauAv6YCdszfR=L3b10vVeK+Vn=XpVmU9ravqNOyubHg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qapi/misc.json: Remove superfluous words
 in CpuModelExpansionType
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

Hi

On Wed, Oct 3, 2018 at 3:02 PM Kashyap Chamarthy <kchamart@redhat.com> wrot=
e:
>
> While at it, s/QMU/QEMU in @CpuDefinitionInfo.
>
> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  qapi/misc.json | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/qapi/misc.json b/qapi/misc.json
> index ada9af5add..f98de3a58c 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -2017,7 +2017,7 @@
>  #
>  # @migration-safe: whether a CPU definition can be safely used for
>  #                  migration in combination with a QEMU compatibility ma=
chine
> -#                  when migrating between different QMU versions and bet=
ween
> +#                  when migrating between different QEMU versions and be=
tween
>  #                  hosts with different sets of (hardware or software)
>  #                  capabilities. If not provided, information is not ava=
ilable
>  #                  and callers should not assume the CPU definition to b=
e
> @@ -2126,11 +2126,11 @@
>  # @static: Expand to a static CPU model, a combination of a static base
>  #          model name and property delta changes. As the static base mod=
el will
>  #          never change, the expanded CPU model will be the same, indepe=
ndent of
> -#          independent of QEMU version, machine type, machine options, a=
nd
> -#          accelerator options. Therefore, the resulting model can be us=
ed by
> -#          tooling without having to specify a compatibility machine - e=
.g. when
> -#          displaying the "host" model. static CPU models are migration-=
safe.
> -#
> +#          QEMU version, machine type, machine options, and accelerator =
options.
> +#          Therefore, the resulting model can be used by tooling without=
 having
> +#          to specify a compatibility machine - e.g. when displaying the=
 "host"
> +#          model. The @static CPU models are migration-safe.
> +
>  # @full: Expand all properties. The produced model is not guaranteed to =
be
>  #        migration-safe, but allows tooling to get an insight and work w=
ith
>  #        model details.
> --
> 2.17.1
>
>


--=20
Marc-Andr=C3=A9 Lureau
