Received: from eggs.gnu.org ([209.51.188.92]:47766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h3J4D-000623-HJ
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 07:26:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h3J1K-0007iT-S4
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 07:23:05 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:57929)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1h3J1I-0007gG-Oa
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 07:23:02 -0400
References: <20190311101428.GA11@765644dd90e5>
	<20190311102733.GC16@765644dd90e5>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <ddb227ec-84ea-caa8-43e6-b5aade0bba2a@vivier.eu>
Date: Mon, 11 Mar 2019 12:22:38 +0100
MIME-Version: 1.0
In-Reply-To: <20190311102733.GC16@765644dd90e5>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 4/10] qemu-binfmt-conf.sh: use the same
 presentation format as for qemu-*
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

On 11/03/2019 11:27, Unai Martinez-Corral wrote:
> 
> Signed-off-by: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
> ---
>  scripts/qemu-binfmt-conf.sh | 58 +++++++++++++++++--------------------
>  1 file changed, 27 insertions(+), 31 deletions(-)
> 
> diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
> index e7a714e22c..489d7d2326 100755
> --- a/scripts/qemu-binfmt-conf.sh
> +++ b/scripts/qemu-binfmt-conf.sh
> @@ -167,47 +167,43 @@ qemu_get_family() {
> 
>  usage() {
>      cat <<EOF
> -Usage: qemu-binfmt-conf.sh [--qemu-path PATH][--debian][--systemd CPU]
> -                           [--help][--credential][--exportdir PATH]
> -                           [--persistent][--qemu-suffix SUFFIX]
> +Usage: qemu-binfmt-conf.sh [options]
> 
> -       Configure binfmt_misc to use qemu interpreter
> +Configure binfmt_misc to use qemu interpreter
> 
> -       --help:        display this usage
> -       --qemu-path:   set path to qemu interpreter ($QEMU_PATH)
> -       --qemu-suffix: add a suffix to the default interpreter name
> -       --debian:      don't write into /proc,
> -                      instead generate update-binfmts templates
> -       --systemd:     don't write into /proc,
> -                      instead generate file for systemd-binfmt.service
> -                      for the given CPU. If CPU is "ALL", generate a
> -                      file for all known cpus
> -       --exportdir:   define where to write configuration files
> -                      (default: $SYSTEMDDIR or $DEBIANDIR)
> -       --credential:  if present, credential and security tokens are
> -                      calculated according to the binary to interpret
> -                      ($QEMU_CREDENTIAL=yes)
> -       --persistent:  if present, the interpreter is loaded when binfmt is
> -                      configured and remains in memory. All future uses
> -                      are cloned from the open file.
> -                      ($QEMU_PERSISTENT=yes)
> +Options and associated environment variables:
> 
> -    To import templates with update-binfmts, use :
> +Argument             Env-variable     Description
> +-h|--help                             display this usage
> +-Q|--qemu-path PATH: QEMU_PATH        set path to qemu interpreter

Please, remove all the ':' above and below.
You should merge PATCH 9/10 with this one.

Thanks,
Laurent
