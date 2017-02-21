Received: from eggs.gnu.org ([2001:4830:134:3::10]:41899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cg5cE-0007eg-0p
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 03:16:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cg5cC-00005Y-U2
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 03:16:05 -0500
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:35391)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cg5cC-00005A-Le
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 03:16:04 -0500
Received: by mail-lf0-x243.google.com with SMTP id z127so8451619lfa.2
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 00:16:04 -0800 (PST)
MIME-Version: 1.0
References: <1487663871-11859-1-git-send-email-kraxel@redhat.com>
In-Reply-To: <1487663871-11859-1-git-send-email-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 21 Feb 2017 08:15:52 +0000
Message-ID: <CAJ+F1CLG+WsjD=L5B2sj6Oj15Xx0ihVG7QfaoSHGweGsKv+8GA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] spice: set merge-lists
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

Hi

On Tue, Feb 21, 2017 at 12:00 PM Gerd Hoffmann <kraxel@redhat.com> wrote:

> This way you can use -spice multiple times on the command line
> and qemu will actually pick up all options.
>
>
Is this actually a good thing to have? vnc doesn't have it for example.
Perhaps some day we may want to have -spice for difference server
instances? (although there are some parameters that would be global, like
gl/rendernode)



> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  ui/spice-core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/ui/spice-core.c b/ui/spice-core.c
> index 39ccab7..d613f1a 100644
> --- a/ui/spice-core.c
> +++ b/ui/spice-core.c
> @@ -412,6 +412,7 @@ static SpiceChannelList *qmp_query_spice_channels(voi=
d)
>
>  static QemuOptsList qemu_spice_opts =3D {
>      .name =3D "spice",
> +    .merge_lists =3D true,
>      .head =3D QTAILQ_HEAD_INITIALIZER(qemu_spice_opts.head),
>      .desc =3D {
>          {
> --
> 1.8.3.1
>
>
> --
Marc-Andr=C3=A9 Lureau
