Received: from eggs.gnu.org ([209.51.188.92]:57043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hM7ox-0005p3-4q
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:16:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hM7on-0008TO-1J
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:15:55 -0400
References: <20190427161322.24642-1-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <8f7591a2-5da4-1403-ecfd-b64ca4ec5ab3@vivier.eu>
Date: Thu, 2 May 2019 11:15:45 +0200
MIME-Version: 1.0
In-Reply-To: <20190427161322.24642-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] Makefile: Let the 'clean'
 rule remove qemu-ga.exe on Windows hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Stefan Weil <sw@weilnetz.de>

On 27/04/2019 18:13, Philippe Mathieu-Daudé wrote:
> Commit 48ff7a625b36 added the QEMU Guest Agent tool with the
> optional ".exe" suffix for Windows hosts, but forgot to use
> this suffix in the 'clean' rule. Calling this rule let a dangling
> executable in the build directory.
> Correct this by using the proper optional suffix.
> 
> Fixes: 48ff7a625b36
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 626a04d305c..07bfa26536a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -639,7 +639,7 @@ clean:
>  		! -path ./roms/edk2/BaseTools/Source/Python/UPT/Dll/sqlite3.dll \
>  		-exec rm {} +
>  	rm -f $(edk2-decompressed)
> -	rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) qemu-ga TAGS cscope.* *.pod *~ */*~
> +	rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) qemu-ga$(EXESUF) TAGS cscope.* *.pod *~ */*~
>  	rm -f fsdev/*.pod scsi/*.pod
>  	rm -f qemu-img-cmds.h
>  	rm -f ui/shader/*-vert.h ui/shader/*-frag.h
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
