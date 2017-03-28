Received: from eggs.gnu.org ([2001:4830:134:3::10]:52852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1csm7m-0007Yr-69
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:05:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1csm7h-0006PQ-A5
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:05:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37992)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1csm7h-0006P2-5K
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:05:01 -0400
References: <20170327201146.1820-1-sw@weilnetz.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f4b891ea-88c0-7c22-c702-f0ad0740d4e5@redhat.com>
Date: Tue, 28 Mar 2017 10:04:56 +0200
MIME-Version: 1.0
In-Reply-To: <20170327201146.1820-1-sw@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9] Fix check for target OS support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org



On 27/03/2017 22:11, Stefan Weil wrote:
> * Support cross compilation with the most common cross prefixes
>   for Mingw-w64. Other cross builds are still broken!

Can you explain how it's broken?  Why does check_define not work at this
point, for cross builds?

"../configure --cross-prefix=x86_64-w64-mingw32-" seems to work for me.

Paolo

> +if test "$cross_prefix" = "i686_64-w64-mingw32-" ; then
> +  targetos='MINGW32'
> +elif test "$cross_prefix" = "x86_64-w64-mingw32-" ; then
> +  targetos='MINGW32'
> +elif test -n "$cross_prefix" ; then
> +  targetos="$cross_prefix"
> +elif check_define __linux__ ; then
>    targetos="Linux"
