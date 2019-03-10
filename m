Received: from eggs.gnu.org ([209.51.188.92]:58910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h327O-0008O2-CQ
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 13:20:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h325E-0006AY-E7
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 13:17:57 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:51851)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1h325E-0006AC-3z
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 13:17:56 -0400
References: <20190306031221.GA53@03612eec87fc>
	<20190306045335.GH75@03612eec87fc>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <5f648b18-162c-d9f7-dc84-395bf5f295fb@vivier.eu>
Date: Sun, 10 Mar 2019 18:17:35 +0100
MIME-Version: 1.0
In-Reply-To: <20190306045335.GH75@03612eec87fc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 8/10] qemu-binfmt-conf.sh: refactor
 usage()
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

On 06/03/2019 05:53, Unai Martinez-Corral wrote:
> Reorder how the options are presented to the user. Move 'systemd'
> and 'debian' to the end, so that the latter is close to the additional
> comments and example commands about it. Make the order in the prototype
> consistent with the list where each option is explained.
> 
> Signed-off-by: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
> ---
>  scripts/qemu-binfmt-conf.sh | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
> index 824e3c4c34..4a45636b53 100755
> --- a/scripts/qemu-binfmt-conf.sh
> +++ b/scripts/qemu-binfmt-conf.sh
> @@ -197,9 +197,9 @@ qemu_get_family() {
> 
>  usage() {
>      cat <<EOF
> -Usage: qemu-binfmt-conf.sh [--help][--path PATH][--debian][--systemd]
> -                           [--reset ARCHS][--credential][--exportdir PATH]
> -                           [--persistent][--suffix SUFFIX][CPUS]
> +Usage: qemu-binfmt-conf.sh [--help][--path PATH][--suffix SUFFIX]
> +                           [--persistent][--credential][--exportdir PATH]
> +                           [--reset ARCHS][--systemd][--debian][CPUS]
> 
>         Configure binfmt_misc to use qemu interpreter for the given CPUS.
>         Supported formats for CPUS are: single arch or comma/space separated list.
> @@ -210,25 +210,25 @@ Usage: qemu-binfmt-conf.sh [--help][--path PATH][--debian][--systemd]
>         --path:        set path to qemu interpreter ($QEMU_PATH)
>         --suffix:      add a suffix to the default interpreter name
>                        ($QEMU_SUFFIX)
> -       --debian:      don't write into /proc,
> -                      instead generate update-binfmts templates
> -       --systemd:     don't write into /proc,
> -                      instead generate file for systemd-binfmt.service;
> -                      environment variable HOST_ARCH allows to override 'uname'
> -                      to generate configuration files for a different
> -                      architecture than the current one.
> +       --persistent:  if present, the interpreter is loaded when binfmt is
> +                      configured and remains in memory. All future uses
> +                      are cloned from the open file.
> +                      ($QEMU_PERSISTENT=yes)
> +       --credential:  if present, credential and security tokens are
> +                      calculated according to the binary to interpret
> +                      ($QEMU_CREDENTIAL=yes)
>         --exportdir:   define where to write configuration files
>                        (default: $SYSTEMDDIR or $DEBIANDIR)
>         --reset:       remove registered interpreter for target ARCHS (comma
>                        separated list). If ARCHS is 'ALL', remove all registered
>                        'qemu-*' interpreters.
> -       --credential:  if present, credential and security tokens are
> -                      calculated according to the binary to interpret
> -                      ($QEMU_CREDENTIAL=yes)
> -       --persistent:  if present, the interpreter is loaded when binfmt is
> -                      configured and remains in memory. All future uses
> -                      are cloned from the open file.
> -                      ($QEMU_PERSISTENT=yes)
> +       --systemd:     don't write into /proc,
> +                      instead generate file for systemd-binfmt.service;
> +                      environment variable HOST_ARCH allows to override 'uname'
> +                      to generate configuration files for a different
> +                      architecture than the current one.
> +       --debian:      don't write into /proc,
> +                      instead generate update-binfmts templates
> 
>      To import templates with update-binfmts, use :
> 

Please, use the same presentation format as for qemu-XXX ("Argument
       Env-variable      Description")

Thanks,
Laurent
