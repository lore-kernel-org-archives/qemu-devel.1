Received: from eggs.gnu.org ([2001:4830:134:3::10]:53215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eqCS2-0001qD-9G
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 01:39:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eqCRx-00073z-DP
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 01:39:54 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36342 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eqCRx-00073v-7u
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 01:39:49 -0500
References: <1519533358-13759-1-git-send-email-suhang16@mails.ucas.ac.cn>
	<1519533358-13759-3-git-send-email-suhang16@mails.ucas.ac.cn>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <53f804f8-fd71-0e3f-f44c-6ca02cbf7895@redhat.com>
Date: Mon, 26 Feb 2018 07:39:37 +0100
MIME-Version: 1.0
In-Reply-To: <1519533358-13759-3-git-send-email-suhang16@mails.ucas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 RFC 2/3] util/uri.c: remove brackets
 that wrap `return` statement's content.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Su Hang <suhang16@mails.ucas.ac.cn>, boxafox@163.com
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On 25.02.2018 05:35, Su Hang wrote:
> only remove brackets that wrap `return` statements' content.
> 
> use `perl -pi -e "s/return \((.*?)\);/return \1;/g" util/uri.c`
> to remove pattern like this: "return (1);"
> 
> Signed-off-by: Su Hang <suhang16@mails.ucas.ac.cn>
> ---
>  util/uri.c | 160 ++++++++++++++++++++++++++++++-------------------------------
>  1 file changed, 80 insertions(+), 80 deletions(-)

Looks good to me!

Reviewed-by: Thomas Huth <thuth@redhat.com>
