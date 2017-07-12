Received: from eggs.gnu.org ([2001:4830:134:3::10]:41988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dVJ5D-0005Gh-SU
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 10:57:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dVJ5A-000861-LD
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 10:57:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40759)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1dVJ5A-00084s-ED
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 10:57:40 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5A85F80F6D
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 14:57:38 +0000 (UTC)
References: <20170712094149.23069-1-jfreimann@redhat.com>
	<20170712094149.23069-2-jfreimann@redhat.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <eeee5860-e57b-bfeb-1f17-8ff34597ce5c@redhat.com>
Date: Wed, 12 Jul 2017 16:57:25 +0200
MIME-Version: 1.0
In-Reply-To: <20170712094149.23069-2-jfreimann@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 1/3] tests/vhost-user-bridge: disable
 debug output by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jens Freimann <jfreimann@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mst@redhat.com, victork@redhat.com



On 07/12/2017 11:41 AM, Jens Freimann wrote:
> From: Jens Freimann <jfreiman@redhat.com>
> 
> vhost-user-bridge prints out a lot of information, including dumps
> of all transmitted data. When called from a testcase this output
> clutters the actual test results, so let's make the default no debug
> output.
> 
> Signed-off-by: Jens Freimann <jfreiman@redhat.com>
> ---
>   tests/vhost-user-bridge.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Makes sense to have debug logs disabled by default.

Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Thanks,
Maxime

> diff --git a/tests/vhost-user-bridge.c b/tests/vhost-user-bridge.c
> index 1e5b5ca..93d9535 100644
> --- a/tests/vhost-user-bridge.c
> +++ b/tests/vhost-user-bridge.c
> @@ -34,7 +34,7 @@
>   #include "standard-headers/linux/virtio_net.h"
>   #include "contrib/libvhost-user/libvhost-user.h"
>   
> -#define VHOST_USER_BRIDGE_DEBUG 1
> +#define VHOST_USER_BRIDGE_DEBUG 0
>   
>   #define DPRINT(...) \
>       do { \
> 
