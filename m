Received: from eggs.gnu.org ([2001:4830:134:3::10]:60604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cTQTZ-0004eX-Tc
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:54:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cTQTY-0000xS-5p
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:54:50 -0500
Received: from mail-yw0-x233.google.com ([2607:f8b0:4002:c05::233]:33316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cTQTX-0000wq-Vk
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:54:48 -0500
Received: by mail-yw0-x233.google.com with SMTP id l75so83707294ywb.0
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 01:54:47 -0800 (PST)
MIME-Version: 1.0
References: <1484559200-2301-1-git-send-email-armbru@redhat.com>
	<CAFEAcA_BBbHeQhWYf_qrL+TwxGT8w34SvUNG_gcNfpNnyaGCzg@mail.gmail.com>
	<87pojmjdep.fsf@dusky.pond.sub.org>
In-Reply-To: <87pojmjdep.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 17 Jan 2017 09:54:36 +0000
Message-ID: <CAJ+F1C+okVYu7pvZzGVdC-Y5CeA0OLhCO5jU7TDLK8nUtm6R=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 000/180] QAPI patches for 2017-01-16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

Hi

On Tue, Jan 17, 2017 at 12:34 PM Markus Armbruster <armbru@redhat.com>
wrote:

> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On 16 January 2017 at 09:33, Markus Armbruster <armbru@redhat.com>
> wrote:
> >> This is Marc-Andr=C3=A9's "[PATCH v8 00/21] qapi doc generation (whole
> >> version, squashed)" with a few commit messages tweaked, and "[PATCH v8
> >> 14/21] (SQUASHED) move doc to schema" unsquashed into 161 patches.
> >>
> >> We did all the respins with in this squashed form to reduce noise.
> >> However, since the unsquashed form is better suited for review, and
> >> probably nicer if we have to revisit this part of the work down the
> >> road, I'm proposing to merge this unsquashed.
> >>
> >> If you want me to post the unsquashed patches, I'm happy to redo this
> >> pull request.
> >>
> >> If you'd rather pull the squashed version, likewise.
> >>
> >> I'm afraid this is a bit of a doc conflict magnet.  The sooner we can
> >> get it in, the easier for Marc-Andr=C3=A9 and me.
> >>
> >> v2:
> >> * Rebased (v1 conflicts with commit e1ff3c6)
> >> * test-qapi.py tweaked to avoid trailing empty lines in .out
> >>
> >> The following changes since commit
> b6af8ea60282df514f87d32e36afd1c9aeee28c8:
> >>
> >>   Merge remote-tracking branch
> 'remotes/ehabkost/tags/x86-and-machine-pull-request' into staging
> (2017-01-13 14:38:21 +0000)
> >>
> >> are available in the git repository at:
> >>
> >>   git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2017-01-16
> >>
> >> for you to fetch changes up to 56e8bdd46a8a42d89b0afea9da83ae7679cc043=
9:
> >>
> >>   build-sys: add qapi doc generation targets (2017-01-16 10:11:43 +010=
0)
> >>
> >> ----------------------------------------------------------------
> >> QAPI patches for 2017-01-16
> >
> > This seems to trigger some warnings from older makeinfo versions:
> >
> > On the Fedora 20 ppc64be box and Ubuntu 14.04.5 LTS aarch64 box
> > (Ubuntu: makeinfo (GNU texinfo) 5.2;
> >  Fedora: makeinfo (GNU texinfo) 5.1)
>
> Nobody should be using F20 by now, but the Ubuntu LTS is still legit.
>
> > /home/pm215/qemu/docs/qemu-ga-ref.texi:41: warning: undefined flag:
> VERSION
> > /home/pm215/qemu/docs/qemu-ga-ref.texi:41: warning: undefined flag:
> VERSION
> > /home/pm215/qemu/docs/qemu-qmp-ref.texi:41: warning: undefined flag:
> VERSION
> > /home/pm215/qemu/docs/qemu-qmp-ref.texi:41: warning: undefined flag:
> VERSION
>
> This is supposed to be defined in Makefile:
>
>     MAKEINFO=3Dmakeinfo -D 'VERSION $(VERSION)'
>
> Hrrm, Texinfo's NEWS file has for 6.0:
>
> * texi2any:
>   [...]
>   . -D'var val' on the command line works as intended again.
>
> I tried to find out more about this fix, but the Texinfo repository's
> commit log is useless.
>
> I can reproduce the warning with 6.2 by running makeinfo without -D.
> Curiously, output isn't affected.  Looks like @subtitle is ignored by
> makeinfo.
>
> Possible work-around I could squash in:
>
> diff --git a/docs/qemu-qmp-ref.texi b/docs/qemu-qmp-ref.texi
> index 818e525..e0f2454 100644
> --- a/docs/qemu-qmp-ref.texi
> +++ b/docs/qemu-qmp-ref.texi
> @@ -38,7 +38,9 @@ along with this manual.  If not, see
> http://www.gnu.org/licens
> es/ <http://www.gnu.org/licenses/>.
>
>  @titlepage
>  @title QMP Reference Manual
> +@iftex @c Work around bug in Texinfo prior to 6.0
>  @subtitle QEMU version @value{VERSION}
> +@end iftex
>  @page
>  @vskip 0pt plus 1filll
>  @insertcopying
>
> Marc-Andr=C3=A9, what do you think?
>

Since title @subtitle is being ignored by makeinfo, that looks fine.
However, I think I would prefer rather have the warning since it's a
makeinfo bug on old versions and it can be ignored. Hopefully, this thread
can easily be found for reference (update commit message too?). Either way,
I don't mind. Thanks


> > On OSX (makeinfo (GNU texinfo) 4.8):
>
> That's from 2004.  Just sayin'.
>
> > ./qemu-options.texi:60: warning: unlikely character [ in @var.
> > ./qemu-options.texi:60: warning: unlikely character ] in @var.
> > ./qemu-options.texi:61: warning: unlikely character [ in @var.
> > ./qemu-options.texi:61: warning: unlikely character ] in @var.
>
> Generated qemu-options.texi did not change (I checked).
>
> The offending lines are
>
>     @item -numa
> node[,mem=3D@var{size}][,cpus=3D@var{cpu[-cpu]}][,nodeid=3D@var{node}]
>     @itemx -numa
> node[,memdev=3D@var{id}][,cpus=3D@var{cpu[-cpu]}][,nodeid=3D@var{node}]
>
> which are generated from qemu-options.hx's
>
>     DEF("numa", HAS_ARG, QEMU_OPTION_numa,
>         "-numa node[,mem=3Dsize][,cpus=3Dcpu[-cpu]][,nodeid=3Dnode]\n"
>         "-numa node[,memdev=3Did][,cpus=3Dcpu[-cpu]][,nodeid=3Dnode]\n",
> QEMU_ARCH_ALL)
>
> by scripts/hxtool.
>
> This use of @var{} is perhaps questionable, but nothing changed around
> here for many moons.  Are you sure this is new in my pull request?
>
> > (OSX also has the long standing warning
> > /Users/pm215/src/qemu-for-merges/qemu-doc.texi:7: warning:
> > unrecognized encoding name `UTF-8'.
> > but you can ignore that since it's been that way for years
> > and is because osx's makeinfo is ancient.)
> >
> > thanks
> > -- PMM
>
> --
Marc-Andr=C3=A9 Lureau
