Received: from eggs.gnu.org ([2001:4830:134:3::10]:45042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ep913-0004UX-HZ
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 03:47:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ep912-0001wD-19
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 03:47:41 -0500
References: <1519372278-20644-1-git-send-email-suhang16@mails.ucas.ac.cn>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c3078a4e-24f4-cc37-ca7f-9f40213639bb@redhat.com>
Date: Fri, 23 Feb 2018 09:47:35 +0100
MIME-Version: 1.0
In-Reply-To: <1519372278-20644-1-git-send-email-suhang16@mails.ucas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/3] util/uri.c: only remove `return`'s
 brackets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Su Hang <suhang16@mails.ucas.ac.cn>, stefanha@redhat.com
Cc: qemu-devel@nongnu.org, QEMU Trivial <qemu-trivial@nongnu.org>

On 23.02.2018 08:51, Su Hang wrote:
> only remove brackets that wrap `return` statements' content.
> 
> use `perl -pi -e "s/return \((.*?)\);/return \1;/g" util/uri.c`
> to remove pattern like this: "return (1);"
> 
> Signed-off-by: Su Hang <suhang16@mails.ucas.ac.cn>
> ---
>  util/uri.c | 160 ++++++++++++++++++++++++++++++-------------------------------
>  1 file changed, 80 insertions(+), 80 deletions(-)

Looks good to me:

Reviewed-by: Thomas Huth <thuth@redhat.com>
