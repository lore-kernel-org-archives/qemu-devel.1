Received: from eggs.gnu.org ([2001:4830:134:3::10]:38113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gI6H3-0001Ow-Qi
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 02:16:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gI6H2-0007Bt-Tu
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 02:16:09 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:35083)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gI6H2-0007BO-Ns
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 02:16:08 -0400
Received: by mail-io1-xd41.google.com with SMTP id 79-v6so11472873iou.2
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 23:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <1540357921-4199-1-git-send-email-liq3ea@gmail.com>
	<9943c62b-3d87-3359-a17f-d975ae228c0c@redhat.com>
	<874ld2qgbj.fsf@dusky.pond.sub.org>
In-Reply-To: <874ld2qgbj.fsf@dusky.pond.sub.org>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 1 Nov 2018 14:15:31 +0800
Message-ID: <CAKXe6SKN2QDF5YZVo6fY8gooMvTrNFPdq3Jgb0yOyBVwsoTZaQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] fw_cfg: print error message when reading
 splashfile failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: philmd@redhat.com, Laszlo Ersek <lersek@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>

Hello all,

I have sent out another patch.

As the email's subject and commit message changed,
I'm not sure is it suitable to add Philippe and Laszlo's R-b tag.

Thanks,
Li Qiang

Markus Armbruster <armbru@redhat.com> =E4=BA=8E2018=E5=B9=B410=E6=9C=8831=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8811:36=E5=86=99=E9=81=93=EF=BC=
=9A

> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>
> > On 24/10/18 7:12, Li Qiang wrote:
> >> Also remove unnecessary 'res' variable.
> >>
> >> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> >> ---
> >>   hw/nvram/fw_cfg.c | 7 +++----
> >>   1 file changed, 3 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> >> index 946f765..f4a52d8 100644
> >> --- a/hw/nvram/fw_cfg.c
> >> +++ b/hw/nvram/fw_cfg.c
> >> @@ -68,15 +68,14 @@ static char *read_splashfile(char *filename, gsize
> *file_sizep,
> >>                                int *file_typep)
> >>   {
> >>       GError *err =3D NULL;
> >> -    gboolean res;
> >>       gchar *content;
> >>       int file_type;
> >>       unsigned int filehead;
> >>       int bmp_bpp;
> >>   -    res =3D g_file_get_contents(filename, &content, file_sizep,
> >> &err);
> >> -    if (res =3D=3D FALSE) {
> >> -        error_report("failed to read splash file '%s'", filename);
> >> +    if (!g_file_get_contents(filename, &content, file_sizep, &err)) {
> >> +        error_report("failed to read splash file '%s', %s",
> >
> > Can you use a column like the rest of the codebase?
> >
> > i.e.: "failed to read splash file '%s': %s"
>
> Yes, please.
>
> Also, my remark on your "[PATCH] vl.c: print error message if loading
> fw_cfg file failed" applies to this patch as well.  Please improve the
> commit message.
>
> > The maintainer taking this patch can do this minor change, so:
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >
> >> +                     filename, err->message);
> >>           g_error_free(err);
> >>           return NULL;
> >>       }
> >>
>
