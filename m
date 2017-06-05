Received: from eggs.gnu.org ([2001:4830:134:3::10]:47131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dHpag-0005R1-5y
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 06:50:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dHpaf-0006h1-3k
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 06:50:30 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:34768)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dHpae-0006gk-Ma
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 06:50:29 -0400
Received: by mail-lf0-x243.google.com with SMTP id o28so666242lfk.1
	for <qemu-devel@nongnu.org>; Mon, 05 Jun 2017 03:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <20170602074040.7400-1-marcandre.lureau@redhat.com>
	<CAFEAcA8nOzdR=ZHdkvX+aD-oCvDFcUvmgEJdE1CcUyOVMoEP8w@mail.gmail.com>
	<CAJ+F1CK5MVbEE6tMT0djyH7Rr0mWcZGdZh+rYp-qpSDoQuDtUQ@mail.gmail.com>
	<CAFEAcA8k9UoaV2Dg0E13Xq_Rzg2qGv-xArD5oFtG0oJO7iyU4w@mail.gmail.com>
In-Reply-To: <CAFEAcA8k9UoaV2Dg0E13Xq_Rzg2qGv-xArD5oFtG0oJO7iyU4w@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 05 Jun 2017 10:50:16 +0000
Message-ID: <CAJ+F1C+v1rkNj9XgFOGjkGoEqC-Wz6FukXJnfunzcTtBXmo-3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/15] chardev patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Hi

On Mon, Jun 5, 2017 at 2:15 PM Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 2 June 2017 at 20:15, Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.c=
om>
> wrote:
> > Sorry, git-publish printed an error on invalid remote, but keep going. =
I
> > should fix it. Here is the new pull request:
> >
> > The following changes since commit
> 43771d5d92312504305c19abe29ec5bfabd55f01:
> >
> >   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2017-05-3=
1'
> > into staging (2017-06-01 16:39:16 +0100)
> >
> > are available in the git repository at:
> >
> >   https://github.com/elmarco/qemu.git tags/chrfe-pull-request
> >
> >
> > for you to fetch changes up to 6b10e573d15ef82dbc5c5b3726028e6642e134f6=
:
> >
> >   char: move char devices to chardev/ (2017-06-02 11:33:53 +0400)
>
> Thanks, applied to master.
>
> You forgot to add your signed-off-by line as submaintainer to the
> commit from Philippe -- since it's a two line patch I didn't think it
>

Oh I didn't know I have to add my sign-off too, I thought reviewed-by was
enough. Ok


> was worth pushing back for a respin, but it's worth adding an
> automated "check all commits have my signoff" to your "make a pull
> request" script I think.
>
> For example, see lines 98--109 in my script:
>
> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/make-pu=
llreq


Ok, I am using git-publish (btw, Stefan merged a fix to avoid the previous
pullreq issue), and it seems -s will add missing sign-off during
format-patch.

Thanks,


>
>
> thanks
> -- PMM
>
--=20
Marc-Andr=C3=A9 Lureau
