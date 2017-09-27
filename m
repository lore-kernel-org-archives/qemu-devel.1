Received: from eggs.gnu.org ([2001:4830:134:3::10]:58618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dxKoN-00024I-TL
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 18:28:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dxKoM-0001di-Tn
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 18:28:11 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:56212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dxKoM-0001dX-NM
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 18:28:10 -0400
Received: by mail-wm0-x243.google.com with SMTP id u138so47217wmu.4
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 15:28:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170927203225.30896-3-ehabkost@redhat.com>
References: <20170927203225.30896-1-ehabkost@redhat.com>
	<20170927203225.30896-3-ehabkost@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 27 Sep 2017 15:27:39 -0700
Message-ID: <CAKmqyKOT_QOpo7isuiV-x2Sis2BHCP36U55Kz0nnbx84tn2WEQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/2] qemu-options: Deprecate -nodefconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Wed, Sep 27, 2017 at 1:32 PM, Eduardo Habkost <ehabkost@redhat.com> wrote:
> Since 2012 (commit ba6212d8 "Eliminate cpus-x86_64.conf file") we
> have no default config files that would be disabled using
> -nodefconfig.  Update documentation and document -nodefconfig as
> deprecated.
>
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Acked-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,
Alistair

> ---
>  qemu-options.hx | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 39225ae6c3..bc52e79184 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4069,24 +4069,25 @@ output to stdout. This can be later used as input file for @code{-readconfig} op
>  ETEXI
>  DEF("nodefconfig", 0, QEMU_OPTION_nodefconfig,
>      "-nodefconfig\n"
> -    "                do not load default config files at startup\n",
> +    "                do not load default config files at startup (deprecated)\n",
>      QEMU_ARCH_ALL)
>  STEXI
>  @item -nodefconfig
>  @findex -nodefconfig
> -Normally QEMU loads configuration files from @var{sysconfdir} and @var{datadir} at startup.
> -The @code{-nodefconfig} option will prevent QEMU from loading any of those config files.
> +This option was used to disable loading of config files from @var{sysconfdir}
> +and @var{datadir}, but it is deprecated as QEMU doesn't load any config files
> +from @var{datadir} anymore.  To disable loading of config files from
> +@var{sysconfdir}, use @code{-no-user-config} instead.
>  ETEXI
>  DEF("no-user-config", 0, QEMU_OPTION_nouserconfig,
>      "-no-user-config\n"
> -    "                do not load user-provided config files at startup\n",
> +    "                do not load default user-provided config files at startup\n",
>      QEMU_ARCH_ALL)
>  STEXI
>  @item -no-user-config
>  @findex -no-user-config
>  The @code{-no-user-config} option makes QEMU not load any of the user-provided
> -config files on @var{sysconfdir}, but won't make it skip the QEMU-provided config
> -files from @var{datadir}.
> +config files on @var{sysconfdir}.
>  ETEXI
>  DEF("trace", HAS_ARG, QEMU_OPTION_trace,
>      "-trace [[enable=]<pattern>][,events=<file>][,file=<file>]\n"
> --
> 2.13.5
>
>
