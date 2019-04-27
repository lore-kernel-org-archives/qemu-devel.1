Received: from eggs.gnu.org ([209.51.188.92]:52077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1hKS22-0007Dn-HT
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 14:26:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1hKS1y-0004mP-IL
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 14:26:36 -0400
References: <20190427161322.24642-1-philmd@redhat.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <3f85f099-c650-b9d2-53cd-9c17f97708d7@weilnetz.de>
Date: Sat, 27 Apr 2019 20:26:26 +0200
MIME-Version: 1.0
In-Reply-To: <20190427161322.24642-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Makefile: Let the 'clean' rule remove
 qemu-ga.exe on Windows hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-trivial@nongnu.org

On 27.04.19 18:13, Philippe Mathieu-Daud=C3=A9 wrote:
> Commit 48ff7a625b36 added the QEMU Guest Agent tool with the
> optional ".exe" suffix for Windows hosts, but forgot to use
> this suffix in the 'clean' rule. Calling this rule let a dangling
> executable in the build directory.
> Correct this by using the proper optional suffix.
>=20
> Fixes: 48ff7a625b36
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Makefile b/Makefile
> index 626a04d305c..07bfa26536a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -639,7 +639,7 @@ clean:
>  		! -path ./roms/edk2/BaseTools/Source/Python/UPT/Dll/sqlite3.dll \
>  		-exec rm {} +
>  	rm -f $(edk2-decompressed)
> -	rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) qemu-ga TAGS cscope.*=
 *.pod *~ */*~
> +	rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) qemu-ga$(EXESUF) TAGS=
 cscope.* *.pod *~ */*~
>  	rm -f fsdev/*.pod scsi/*.pod
>  	rm -f qemu-img-cmds.h
>  	rm -f ui/shader/*-vert.h ui/shader/*-frag.h
>=20

Reviewed-by: Stefan Weil <sw@weilnetz.de>

Thank you!

Stefan
