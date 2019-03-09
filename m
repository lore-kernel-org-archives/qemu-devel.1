Received: from eggs.gnu.org ([209.51.188.92]:37500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h2YZe-00057P-Kk
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 04:47:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h2YZd-00025J-Ph
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 04:47:22 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:49363)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1h2YZb-00023l-QZ
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 04:47:21 -0500
References: <20190306031221.GA53@03612eec87fc>
	<20190306044947.GE75@03612eec87fc>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <fa52b25f-5f1c-7ec2-e2f1-bbfc73943847@vivier.eu>
Date: Sat, 9 Mar 2019 10:46:59 +0100
MIME-Version: 1.0
In-Reply-To: <20190306044947.GE75@03612eec87fc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 5/10] qemu-binfmt-conf.sh: honour
 QEMU_PATH and/or QEMU_SUFFIX
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

On 06/03/2019 05:49, Unai Martinez-Corral wrote:
> Allow to set 'path' or 'suffix' through environment variables,
> consistently with 'persistent' and 'credential'.
> 
> Signed-off-by: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
> ---
>  scripts/qemu-binfmt-conf.sh | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
> index 68aa4c3f78..c113ff131e 100755
> --- a/scripts/qemu-binfmt-conf.sh
> +++ b/scripts/qemu-binfmt-conf.sh
> @@ -176,6 +176,7 @@ Usage: qemu-binfmt-conf.sh [--path PATH][--debian][--systemd CPU]
>         --help:        display this usage
>         --path:        set path to qemu interpreter ($QEMU_PATH)
>         --suffix:      add a suffix to the default interpreter name
> +                      ($QEMU_SUFFIX)
>         --debian:      don't write into /proc,
>                        instead generate update-binfmts templates
>         --systemd:     don't write into /proc,
> @@ -321,13 +322,11 @@ BINFMT_SET=qemu_register_interpreter
>  SYSTEMDDIR="/etc/binfmt.d"
>  DEBIANDIR="/usr/share/binfmts"
> 
> -QEMU_PATH=/usr/local/bin
> -
> +QEMU_PATH="${QEMU_PATH:-/usr/local/bin}"
> +QEMU_SUFFIX="${QEMU_SUFFIX:-}"
>  QEMU_CREDENTIAL="${QEMU_CREDENTIAL:-no}"
>  QEMU_PERSISTENT="${QEMU_PERSISTENT:-no}"
> 
> -QEMU_SUFFIX=""
> -
>  options=$(getopt -o ds:Q:S:e:hcp -l debian,systemd:,path:,suffix:,exportdir:,help,credential,persistent -- "$@")
>  eval set -- "$options"
> 
> --
> 2.20.1
> 

Same question as for PATCH 3/10: why?

And I think the usage text should be formatted differently to be cleared and looks 
like more the one of qemu-XXX:

  usage: qemu-m68k [options] program [arguments...]
  Linux CPU emulator (compiled for m68k emulation)

  Options and associated environment variables:

  Argument             Env-variable      Description
  -h                                     print this help
  -help                                  
  -g port              QEMU_GDB          wait gdb connection to 'port'
  -L path              QEMU_LD_PREFIX    set the elf interpreter prefix to 'path'
  -s size              QEMU_STACK_SIZE   set the stack size to 'size' bytes
  ...

Thanks,
Laurent
