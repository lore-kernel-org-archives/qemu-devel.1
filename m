Received: from eggs.gnu.org ([2001:4830:134:3::10]:39873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f6t1R-0007Oj-1e
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 03:21:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f6t1N-0002zY-46
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 03:21:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38428 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1f6t1M-0002yn-VH
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 03:21:21 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1521515720-612046-1-git-send-email-mst@redhat.com>
	<1521515720-612046-22-git-send-email-mst@redhat.com>
Date: Fri, 13 Apr 2018 09:21:04 +0200
In-Reply-To: <1521515720-612046-22-git-send-email-mst@redhat.com> (Michael
	S. Tsirkin's message of "Tue, 20 Mar 2018 05:17:29 +0200")
Message-ID: <87d0z37esf.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PULL v2 21/50] Makefile: add target to print
 generated files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> This is helpful for automatic code analysis.

Out of curiosity: how?

> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  Makefile | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index 677a54b..f799390 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1045,6 +1045,9 @@ endif
>  include $(SRC_PATH)/tests/docker/Makefile.include
>  include $(SRC_PATH)/tests/vm/Makefile.include
>  
> +printgen:
> +	@echo $(GENERATED_FILES)
> +
>  .PHONY: help
>  help:
>  	@echo  'Generic targets:'

I tried to answer my question myself by looking up the thread where this
patch was posted for review.  I can't find any.  Am I blind?
