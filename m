Received: from eggs.gnu.org ([2001:4830:134:3::10]:43662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emjqc-0003li-Nm
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:31:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emjqZ-0000an-Ke
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:30:58 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:35628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emjqZ-0000aG-Gk
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:30:55 -0500
Received: by mail-qt0-x242.google.com with SMTP id g14so4701930qti.2
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 09:30:55 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180216164620.GA53727@humpty.home.comstyle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c4407146-8ec6-c317-9ec8-a47ab909fb94@amsat.org>
Date: Fri, 16 Feb 2018 14:30:51 -0300
MIME-Version: 1.0
In-Reply-To: <20180216164620.GA53727@humpty.home.comstyle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] maintainers: Add myself as a OpenBSD
 maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brad Smith <brad@comstyle.com>, qemu-devel@nongnu.org

Hi Brad,

On 02/16/2018 01:46 PM, Brad Smith wrote:
> Add myself as an OpenBSD maintainer and add OpenBSD as maintained.
> 
> Signed-off-by: Brad Smith <brad@comstyle.com>
> 
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 57358a08e2..86329e274f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -386,6 +386,12 @@ M: Kamil Rytarowski <kamil@netbsd.org>
>  S: Maintained
>  K: ^Subject:.*(?i)NetBSD
>  
> +OPENBSD
> +L: qemu-devel@nongnu.org
> +M: Brad Smith <brad@comstyle.com>
> +S: Maintained
> +K: ^Subject:.*(?i)OpenBSD
> +

No problem here,

>  W32, W64
>  L: qemu-devel@nongnu.org
>  M: Stefan Weil <sw@weilnetz.de>
> diff --git a/configure b/configure
> index 913e14839d..850c46ebac 100755
> --- a/configure
> +++ b/configure
> @@ -760,6 +760,7 @@ OpenBSD)
>    audio_drv_list="sdl"
>    audio_possible_drivers="sdl"
>    HOST_VARIANT_DIR="openbsd"
> +  supported_os="yes"

But before announcing the host OS being supported again, I'd rather see
reproducible build/tests logs, in a (public - if possible) continuous
integration system. Else it is hard to notice when it get broken.

>  ;;
>  Darwin)
>    bsd="yes"
> 

Regards,

Phil.
