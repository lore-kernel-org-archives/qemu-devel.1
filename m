Received: from eggs.gnu.org ([209.51.188.92]:60974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gtvDC-0006hQ-I2
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 09:08:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gtvBM-0007fb-Vv
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 09:06:40 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40344)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gtvBJ-0007UQ-50
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 09:06:35 -0500
Received: by mail-wr1-x443.google.com with SMTP id q1so2621376wrp.7
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 06:06:30 -0800 (PST)
MIME-Version: 1.0
References: <1550058881-16351-1-git-send-email-thuth@redhat.com>
	<CAJ+F1CJLHPa3LtviMGQuuwjv-PMzeeR4tJGoHHOz_JqfRR927A@mail.gmail.com>
	<9336d69b-8896-4a19-c580-b6ce5aefec2d@redhat.com>
	<87imxniy4j.fsf@zen.linaroharston>
In-Reply-To: <87imxniy4j.fsf@zen.linaroharston>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 13 Feb 2019 15:06:17 +0100
Message-ID: <CAJ+F1CLRY15AUM0Tc1yxFkH9wn=77QGbjN6nF9GaiVJ63mTARg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] Add a gitlab-ci file for Continuous
 Integration testing on Gitlab
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, QEMU <qemu-devel@nongnu.org>, Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>

On Wed, Feb 13, 2019 at 3:03 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>
>
> Thomas Huth <thuth@redhat.com> writes:
>
> > On 2019-02-13 13:06, Marc-Andr=C3=A9 Lureau wrote:
> >> Hi
> >>
> >> On Wed, Feb 13, 2019 at 12:55 PM Thomas Huth <thuth@redhat.com> wrote:
> >>>
> >>> This is very convenient for people like me who store their QEMU git t=
rees
> >>> on gitlab.com: Automatic CI pipelines are now run for each branch tha=
t is
> >>> pushed to the server - useful for some extra-testing before sending P=
ULL-
> >>> requests for example. Since the runtime of the jobs is limited to 1h,=
 the
> >>> jobs are distributed into multiple pipelines - this way everything fi=
nishs
> >>> fine within time (ca. 30 minutes currently).
> >>>
> >>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >>> ---
> >>>  An example can be seen here: https://gitlab.com/huth/qemu/pipelines/
> >>>
> >>>  I'd really like to get this into the main QEMU repository, so that I=
 don't
> >>>  have to cherry-pick this patch onto my testing branches anymore each=
 time
> >>>  I want to test before sending a PULL request...
> >>>
> >>>  .gitlab-ci.yml | 73 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++
> >>>  MAINTAINERS    |  5 ++++
> >>>  2 files changed, 78 insertions(+)
> >>>  create mode 100644 .gitlab-ci.yml
> >>>
> >>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> >>> new file mode 100644
> >>> index 0000000..79d02cf
> >>> --- /dev/null
> >>> +++ b/.gitlab-ci.yml
> >>> @@ -0,0 +1,73 @@
> >>> +before_script:
> >>> + - apt-get update -qq
> >>> + - apt-get install -y -qq flex bison libglib2.0-dev libpixman-1-dev =
genisoimage
> >>> +
> >>> +build-system1:
> >>> + script:
> >>> + - apt-get install -y -qq libgtk-3-dev libvte-dev nettle-dev libcaca=
rd-dev
> >>> +      libusb-dev libvde-dev libspice-protocol-dev libgl1-mesa-dev
> >>> + - ./configure --enable-werror --target-list=3D"aarch64-softmmu alph=
a-softmmu
> >>> +      cris-softmmu hppa-softmmu lm32-softmmu moxie-softmmu microblaz=
eel-softmmu
> >>> +      mips64el-softmmu m68k-softmmu ppc-softmmu riscv64-softmmu spar=
c-softmmu"
> >>> + - make -j2
> >>
> >> Have you tried $(nproc) ?
> >
> > The containers are only single CPU there. I'm using -j2 just in case on=
e
> > of the processes is blocked by waiting for IO, the other one can still
> > continue compiling.
> >
> >> Despite the duplication of CI files, which is not really a problem imh=
o,
> >>
> >> lgtm,
> >> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Thanks!
> >
> > And yes, I also think the duplication of the CI files should not really
> > be a problem - it's rather a plus since we also got test variations thi=
s
> > way. I already found some bugs with this here that were not detected by
> > the other CI setups yet (e.g. since one of the pipelines uses
> > --disable-replication and other --disable-xxx flags).
>
> Sure I'm happy to have a thousand flowers bloom in this regard.
>
> Do you know if gitlab does build status buttons like the others?

I think that's called badges:
https://docs.gitlab.com/ee/user/project/pipelines/settings.html#pipeline-ba=
dges




--=20
Marc-Andr=C3=A9 Lureau
