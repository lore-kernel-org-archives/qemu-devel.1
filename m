Received: from eggs.gnu.org ([209.51.188.92]:59189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h3286-0000b1-EY
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 13:20:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h3284-0007oj-Fw
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 13:20:54 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:37161)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1h3282-0007mw-IP
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 13:20:50 -0400
References: <20190306031221.GA53@03612eec87fc>
	<20190306045432.GI75@03612eec87fc>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <67a67488-78b7-9c00-cec8-8e9995dd74cf@vivier.eu>
Date: Sun, 10 Mar 2019 18:20:31 +0100
MIME-Version: 1.0
In-Reply-To: <20190306045432.GI75@03612eec87fc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 9/10] qemu-binfmt-conf.sh: update usage()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>, qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, eblake@redhat.com

On 06/03/2019 05:54, Unai Martinez-Corral wrote:
> Reduce indentation to better use available space.
> 
> Add list of supported environment variables and their default values.
> 
> Signed-off-by: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
> ---
>  scripts/qemu-binfmt-conf.sh | 61 ++++++++++++++++++++-----------------
>  1 file changed, 33 insertions(+), 28 deletions(-)
> 
> diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
> index 4a45636b53..8ca2647ed0 100755
> --- a/scripts/qemu-binfmt-conf.sh
> +++ b/scripts/qemu-binfmt-conf.sh
> @@ -201,34 +201,31 @@ Usage: qemu-binfmt-conf.sh [--help][--path PATH][--suffix SUFFIX]
>                             [--persistent][--credential][--exportdir PATH]
>                             [--reset ARCHS][--systemd][--debian][CPUS]
> 
> -       Configure binfmt_misc to use qemu interpreter for the given CPUS.
> -       Supported formats for CPUS are: single arch or comma/space separated list.
> -       See QEMU target list below. If CPUS is 'ALL' or empty, configure all known
> -       cpus. If CPUS is 'NONE', no interpreter is configured.
> +    Configure binfmt_misc to use qemu interpreter for the given CPUS.
> +    Supported formats for CPUS are: single arch or comma/space separated list.
> +    See QEMU target list below. If CPUS is 'ALL' or empty, configure all known
> +    cpus. If CPUS is 'NONE', no interpreter is configured.
> 
> -       --help:        display this usage
> -       --path:        set path to qemu interpreter ($QEMU_PATH)
> -       --suffix:      add a suffix to the default interpreter name
> -                      ($QEMU_SUFFIX)
> -       --persistent:  if present, the interpreter is loaded when binfmt is
> -                      configured and remains in memory. All future uses
> -                      are cloned from the open file.
> -                      ($QEMU_PERSISTENT=yes)
> -       --credential:  if present, credential and security tokens are
> -                      calculated according to the binary to interpret
> -                      ($QEMU_CREDENTIAL=yes)
> -       --exportdir:   define where to write configuration files
> -                      (default: $SYSTEMDDIR or $DEBIANDIR)
> -       --reset:       remove registered interpreter for target ARCHS (comma
> -                      separated list). If ARCHS is 'ALL', remove all registered
> -                      'qemu-*' interpreters.
> -       --systemd:     don't write into /proc,
> -                      instead generate file for systemd-binfmt.service;
> -                      environment variable HOST_ARCH allows to override 'uname'
> -                      to generate configuration files for a different
> -                      architecture than the current one.
> -       --debian:      don't write into /proc,
> -                      instead generate update-binfmts templates
> +    --help:        display this usage.
> +    --path:        set path to qemu interpreter.
> +    --suffix:      add a suffix to the default interpreter name.
> +    --persistent:  if present, the interpreter is loaded when binfmt is
> +                   configured and remains in memory. All future uses
> +                   are cloned from the open file.
> +    --credential:  if present, credential and security tokens are
> +                   calculated according to the binary to interpret.
> +    --exportdir:   define where to write configuration files.
> +                   (default: $SYSTEMDDIR or $DEBIANDIR)
> +    --reset:       remove registered interpreter for target ARCHS (comma
> +                   separated list). If ARCHS is 'ALL', remove all registered
> +                   'qemu-*' interpreters.
> +    --systemd:     don't write into /proc,
> +                   instead generate file(s) for systemd-binfmt.service;
> +                   environment variable HOST_ARCH allows to override 'uname'
> +                   to generate configuration files for a different
> +                   architecture than the current one.
> +    --debian:      don't write into /proc,
> +                   instead generate update-binfmts templates.
> 
>      To import templates with update-binfmts, use :
> 
> @@ -240,6 +237,14 @@ Usage: qemu-binfmt-conf.sh [--help][--path PATH][--suffix SUFFIX]
> 
>      QEMU target list: $qemu_target_list
> 
> +    Options 'path, 'suffix', 'persistent' and 'credential' are also supported
> +    through environment variables. Defaults are:
> +
> +      QEMU_PATH=/usr/local/bin

You can write

        QEMU_PATH=$QEMU_PATH

to have the actual value.

> +      QEMU_SUFFIX=
> +      QEMU_PERSISTENT=no
> +      QEMU_CREDENTIAL=no

and
         QEMU_SUFFIX=$QEMU_SUFFIX
         QEMU_PERSISTENT=$QEMU_PERSISTENT
         QEMU_CREDENTIAL=$QEMU_CREDENTIAL=

> +
>  EOF
>  }
> 
> @@ -384,8 +389,8 @@ DEBIANDIR="/usr/share/binfmts"
> 
>  QEMU_PATH="${QEMU_PATH:-/usr/local/bin}"
>  QEMU_SUFFIX="${QEMU_SUFFIX:-}"
> -QEMU_CREDENTIAL="${QEMU_CREDENTIAL:-no}"
>  QEMU_PERSISTENT="${QEMU_PERSISTENT:-no}"
> +QEMU_CREDENTIAL="${QEMU_CREDENTIAL:-no}"
> 
>  options=$(getopt -o r:dsQ:S:e:hcp -l reset:,debian,systemd,path:,suffix:,exportdir:,help,credential,persistent -- "$@")
>  eval set -- "$options"


I think you can merge this patch with the previous one.

Thanks,
Laurent
