Received: from eggs.gnu.org ([209.51.188.92]:47739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h3J4D-00061P-5D
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 07:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h3J1s-00087K-Pc
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 07:23:37 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:48227)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1h3J1s-00086d-EJ
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 07:23:36 -0400
References: <20190311101428.GA11@765644dd90e5>
	<20190311102942.GE16@765644dd90e5>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <e47de9ed-9fe6-4228-d870-68054a2142fa@vivier.eu>
Date: Mon, 11 Mar 2019 12:23:16 +0100
MIME-Version: 1.0
In-Reply-To: <20190311102942.GE16@765644dd90e5>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 6/10] qemu-binfmt-conf.sh: honour
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

On 11/03/2019 11:29, Unai Martinez-Corral wrote:
> Allow to set 'path' or 'suffix' through environment variables,
> consistently with 'persistent' and 'credential'.
> 
> Signed-off-by: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
> ---
>  scripts/qemu-binfmt-conf.sh | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
> index 0918f7fba6..13e619794c 100755
> --- a/scripts/qemu-binfmt-conf.sh
> +++ b/scripts/qemu-binfmt-conf.sh
> @@ -177,7 +177,7 @@ Options and associated environment variables:
>  Argument             Env-variable     Description
>  -h|--help                             display this usage
>  -Q|--path PATH:      QEMU_PATH        set path to qemu interpreter(s)
> --F|--suffix SUFFIX:                   add a suffix to the default interpreter name
> +-F|--suffix SUFFIX:  QEMU_SUFFIX      add a suffix to the default interpreter name
>  -d|--debian:                          don't write into /proc, generate update-binfmts templates
>  -s|--systemd CPU:                     don't write into /proc, generate file for
>                                        systemd-binfmt.service for the given CPU; if CPU is "ALL",
> @@ -318,13 +318,11 @@ BINFMT_SET=qemu_register_interpreter
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
> 2.21.0
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
