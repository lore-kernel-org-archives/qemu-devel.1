Received: from eggs.gnu.org ([2001:4830:134:3::10]:40064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fj6PG-0000ng-M6
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 13:19:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fj6PF-0002yI-QR
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 13:19:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39508 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fj6PF-0002xt-Jw
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 13:19:57 -0400
Reply-To: thuth@redhat.com
References: <20180727151359.29061-1-armbru@redhat.com>
	<20180727151359.29061-24-armbru@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <51e15087-3153-bb22-5363-9ece7a0008bf@redhat.com>
Date: Fri, 27 Jul 2018 19:19:55 +0200
MIME-Version: 1.0
In-Reply-To: <20180727151359.29061-24-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 23/23] libqtest: Rename qtest_FOOv() to
 qtest_vFOO() for consistency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: f4bug@amsat.org, eblake@redhat.com

On 07/27/2018 05:13 PM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/libqtest.c | 12 ++++++------
>  tests/libqtest.h |  4 ++--
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index a0d44793fa..3706f30aa2 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -538,7 +538,7 @@ QDict *qmp_fdv(int fd, const char *fmt, va_list ap)
>      return qmp_fd_receive(fd);
>  }
>  
> -QDict *qtest_qmpv(QTestState *s, const char *fmt, va_list ap)
> +QDict *qtest_vqmp(QTestState *s, const char *fmt, va_list ap)

Unless you also add something to our coding conventions which mandates
the naming to be always this way, I think this is just unnecessary code
churn.

 Thomas
