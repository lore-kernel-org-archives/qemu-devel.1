Received: from eggs.gnu.org ([2001:4830:134:3::10]:35700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZHYv-0001yb-Rh
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 10:08:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZHYs-0006I0-Mf
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 10:08:49 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:38874)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZHYs-0006GP-Gv
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 10:08:46 -0400
Received: by mail-qk0-x241.google.com with SMTP id t2so7951822qkc.5
	for <qemu-devel@nongnu.org>; Sun, 23 Jul 2017 07:08:45 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170705075411.6556-1-sameeh@daynix.com>
	<20170705075411.6556-2-sameeh@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3fc09beb-721d-01d6-dc5c-ce63b27dbe5e@amsat.org>
Date: Sun, 23 Jul 2017 11:08:40 -0300
MIME-Version: 1.0
In-Reply-To: <20170705075411.6556-2-sameeh@daynix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/5] Makefile: clean: Clean exe files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sameeh Jubran <sameeh@daynix.com>, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Yan Vugenfirer <yan@daynix.com>

Hi Sameeh,

On 07/05/2017 04:54 AM, Sameeh Jubran wrote:
> From: Sameeh Jubran <sjubran@redhat.com>
> 
> Clean exe files such as qemu-ga.exe
> 
> Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
> ---
>   Makefile | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Makefile b/Makefile
> index 16a0430..22d29d6 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -487,6 +487,7 @@ clean:
>   	rm -f config.mak op-i386.h opc-i386.h gen-op-i386.h op-arm.h opc-arm.h gen-op-arm.h
>   	rm -f qemu-options.def
>   	rm -f *.msi
> +	rm -f *${EXESUF}
>   	find . \( -name '*.so' -o -name '*.dll' -o -name '*.mo' -o -name '*.[oda]' \) -type f -exec rm {} +
>   	rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) qemu-ga TAGS cscope.* *.pod *~ */*~

It seems to me your problem is here, this line should be:

- rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) qemu-ga TAGS cscope.* 
*.pod *~ */*~
+ rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) qemu-ga${EXESUF} TAGS 
cscope.* *.pod *~ */*~

>   	rm -f fsdev/*.pod
> 

Regards,

Phil.
