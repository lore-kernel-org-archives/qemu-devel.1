Received: from eggs.gnu.org ([2001:4830:134:3::10]:42961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzgg4-0004Ra-Ok
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:13:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzgfy-00013u-Iw
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:13:20 -0400
MIME-Version: 1.0
In-Reply-To: <20171002140307.5292-2-armbru@redhat.com>
References: <20171002140307.5292-1-armbru@redhat.com>
	<20171002140307.5292-2-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 4 Oct 2017 12:13:13 +0200
Message-ID: <CAJ+F1C+S6TD92YiEs42c3CCvZAuCCgfbYDHVXm3+OHDSOupmbg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/8] qemu-options: Remove stray colons from
 output of --help
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-stable <qemu-stable@nongnu.org>

On Mon, Oct 2, 2017 at 4:03 PM, Markus Armbruster <armbru@redhat.com> wrote=
:
> Commit 43f187a broke --help: it put colons into blank lines.  It
> removed the colon from DEFHEADING(TITLE:) and added it back in the
> macro expansion of DEFHEADING(TITLE), so hxtool can emit "@subsection
> TITLE" more easily.  Trouble is it's added back even for the blank
> lines made with DEFHEADING().
>
> Put the colons back where they were before commit 43f187a, and strip
> them in hxtool instead.
>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> CC: qemu-stable@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  qemu-options-wrapper.h |  2 +-
>  qemu-options.hx        | 27 ++++++++++++++-------------
>  scripts/hxtool         |  3 ++-
>  3 files changed, 17 insertions(+), 15 deletions(-)
>
> diff --git a/qemu-options-wrapper.h b/qemu-options-wrapper.h
> index 4d7aeb1352..13bfea0294 100644
> --- a/qemu-options-wrapper.h
> +++ b/qemu-options-wrapper.h
> @@ -14,7 +14,7 @@
>
>  #define ARCHHEADING(text, arch_mask) \
>      if ((arch_mask) & arch_type)    \
> -        puts(stringify(text) ":");
> +        puts(stringify(text));
>
>  #define DEFHEADING(text) ARCHHEADING(text, QEMU_ARCH_ALL)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 39225ae6c3..0fed2fc009 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -6,7 +6,7 @@ HXCOMM construct option structures, enums and help messag=
e for specified
>  HXCOMM architectures.
>  HXCOMM HXCOMM can be used for comments, discarded from both texi and C
>
> -DEFHEADING(Standard options)
> +DEFHEADING(Standard options:)
>  STEXI
>  @table @option
>  ETEXI
> @@ -578,7 +578,7 @@ STEXI
>  ETEXI
>  DEFHEADING()
>
> -DEFHEADING(Block device options)
> +DEFHEADING(Block device options:)
>  STEXI
>  @table @option
>  ETEXI
> @@ -1177,7 +1177,7 @@ STEXI
>  ETEXI
>  DEFHEADING()
>
> -DEFHEADING(USB options)
> +DEFHEADING(USB options:)
>  STEXI
>  @table @option
>  ETEXI
> @@ -1242,7 +1242,7 @@ STEXI
>  ETEXI
>  DEFHEADING()
>
> -DEFHEADING(Display options)
> +DEFHEADING(Display options:)
>  STEXI
>  @table @option
>  ETEXI
> @@ -1779,7 +1779,7 @@ STEXI
>  ETEXI
>  ARCHHEADING(, QEMU_ARCH_I386)
>
> -ARCHHEADING(i386 target only, QEMU_ARCH_I386)
> +ARCHHEADING(i386 target only:, QEMU_ARCH_I386)
>  STEXI
>  @table @option
>  ETEXI
> @@ -1895,7 +1895,7 @@ STEXI
>  ETEXI
>  DEFHEADING()
>
> -DEFHEADING(Network options)
> +DEFHEADING(Network options:)
>  STEXI
>  @table @option
>  ETEXI
> @@ -2476,7 +2476,7 @@ STEXI
>  ETEXI
>  DEFHEADING()
>
> -DEFHEADING(Character device options)
> +DEFHEADING(Character device options:)
>  STEXI
>
>  The general form of a character device option is:
> @@ -2809,7 +2809,7 @@ STEXI
>  ETEXI
>  DEFHEADING()
>
> -DEFHEADING(Device URL Syntax)
> +DEFHEADING(Device URL Syntax:)
>  STEXI
>
>  In addition to using normal file images for the emulated storage devices=
,
> @@ -3039,7 +3039,7 @@ STEXI
>  @end table
>  ETEXI
>
> -DEFHEADING(Bluetooth(R) options)
> +DEFHEADING(Bluetooth(R) options:)
>  STEXI
>  @table @option
>  ETEXI
> @@ -3115,7 +3115,7 @@ ETEXI
>  DEFHEADING()
>
>  #ifdef CONFIG_TPM
> -DEFHEADING(TPM device options)
> +DEFHEADING(TPM device options:)
>
>  DEF("tpmdev", HAS_ARG, QEMU_OPTION_tpmdev, \
>      "-tpmdev passthrough,id=3Did[,path=3Dpath][,cancel-path=3Dpath]\n"
> @@ -3189,7 +3189,7 @@ DEFHEADING()
>
>  #endif
>
> -DEFHEADING(Linux/Multiboot boot specific)
> +DEFHEADING(Linux/Multiboot boot specific:)
>  STEXI
>
>  When using these options, you can use a given Linux or Multiboot
> @@ -3245,7 +3245,7 @@ STEXI
>  ETEXI
>  DEFHEADING()
>
> -DEFHEADING(Debug/Expert options)
> +DEFHEADING(Debug/Expert options:)
>  STEXI
>  @table @option
>  ETEXI
> @@ -4160,7 +4160,8 @@ STEXI
>  @end table
>  ETEXI
>  DEFHEADING()
> -DEFHEADING(Generic object creation)
> +
> +DEFHEADING(Generic object creation:)
>  STEXI
>  @table @option
>  ETEXI
> diff --git a/scripts/hxtool b/scripts/hxtool
> index 1e2c97c5e6..7d7c4289e3 100644
> --- a/scripts/hxtool
> +++ b/scripts/hxtool
> @@ -19,7 +19,8 @@ hxtoh()
>  print_texi_heading()
>  {
>      if test "$*" !=3D ""; then
> -        printf "@subsection %s\n" "$*"
> +        title=3D"$*"
> +        printf "@subsection %s\n" "${title%:}"
>      fi
>  }
>
> --
> 2.13.6
>
>



--=20
Marc-Andr=C3=A9 Lureau
