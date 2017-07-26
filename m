Received: from eggs.gnu.org ([2001:4830:134:3::10]:50993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daD3T-0004TL-M3
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 23:32:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daD3O-0008Gf-QF
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 23:32:11 -0400
Received: from mail-ua0-x243.google.com ([2607:f8b0:400c:c08::243]:33974)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daD3O-0008GV-LT
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 23:32:06 -0400
Received: by mail-ua0-x243.google.com with SMTP id k43so9211912uaf.1
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 20:32:06 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170725011530.17958-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a13bfee5-f38a-86f4-d107-3b1e9fcc70d9@amsat.org>
Date: Wed, 26 Jul 2017 00:32:01 -0300
MIME-Version: 1.0
In-Reply-To: <20170725011530.17958-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] configure: fix qemu-ga missing '.exe'
 extension on windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sameeh Jubran <sjubran@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Daniel Rempel <daniel@daynix.com>, =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Cc: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Daniel P . Berrange" <berrange@redhat.com>

As noticed by Michael Roth the ./configure entry for qemu-ga is missing 
the $(EXESUF) on purpose (see fafcaf1d).

Patch dropped for 2.10

On 07/24/2017 10:15 PM, Philippe Mathieu-Daudé wrote:
> Reported-by: Sameeh Jubran <sjubran@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> original report from Sameeh Jubran:
> http://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg00906.html
> 
>   Makefile  | 2 +-
>   configure | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index ef721480eb..5f18243d05 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -490,7 +490,7 @@ clean:
>   	rm -f qemu-options.def
>   	rm -f *.msi
>   	find . \( -name '*.so' -o -name '*.dll' -o -name '*.mo' -o -name '*.[oda]' \) -type f -exec rm {} +
> -	rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) qemu-ga TAGS cscope.* *.pod *~ */*~
> +	rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) TAGS cscope.* *.pod *~ */*~
>   	rm -f fsdev/*.pod
>   	rm -f qemu-img-cmds.h
>   	rm -f ui/shader/*-vert.h ui/shader/*-frag.h
> diff --git a/configure b/configure
> index 48d4d7a2a7..f8b1d014d7 100755
> --- a/configure
> +++ b/configure
> @@ -5073,7 +5073,7 @@ fi
>   
>   if [ "$guest_agent" != "no" ]; then
>     if [ "$linux" = "yes" -o "$bsd" = "yes" -o "$solaris" = "yes" -o "$mingw32" = "yes" ] ; then
> -      tools="qemu-ga $tools"
> +      tools="qemu-ga\$(EXESUF) $tools"
>         guest_agent=yes
>     elif [ "$guest_agent" != yes ]; then
>         guest_agent=no
> 
