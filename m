Received: from eggs.gnu.org ([2001:4830:134:3::10]:33004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f96bS-0000bc-M6
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 06:15:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f96bR-0007V6-Q6
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 06:15:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43772 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1f96bR-0007Tz-JS
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 06:15:45 -0400
References: <20180419091105.3943-1-stefanha@redhat.com>
	<20180419091105.3943-5-stefanha@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <800d3866-f677-4af9-09df-68025d617354@redhat.com>
Date: Thu, 19 Apr 2018 12:15:37 +0200
MIME-Version: 1.0
In-Reply-To: <20180419091105.3943-5-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/5] checkpatch: emit a warning on file
 add/move/delete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <famz@redhat.com>

On 19.04.2018 11:11, Stefan Hajnoczi wrote:
> From: Joe Perches <joe@perches.com>
> 
> Whenever files are added, moved, or deleted, the MAINTAINERS file
> patterns can be out of sync or outdated.
> 
> To try to keep MAINTAINERS more up-to-date, add a one-time warning
> whenever a patch does any of those.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> Acked-by: Andy Whitcroft <apw@canonical.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> (cherry picked from commit 13f1937ef33950b1112049972249e6191b82e6c9)
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  scripts/checkpatch.pl | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
