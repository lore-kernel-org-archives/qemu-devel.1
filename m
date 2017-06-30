Received: from eggs.gnu.org ([2001:4830:134:3::10]:48461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dQw4c-0003uQ-4T
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:35:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dQw4Y-0002xu-7Q
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:35:02 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:41614)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1dQw4X-0002xa-UN
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:34:58 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1498749056-38565-4-git-send-email-pradeep.jagadeesh@huawei.com>
References: <1498749056-38565-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1498749056-38565-4-git-send-email-pradeep.jagadeesh@huawei.com>
Date: Fri, 30 Jun 2017 15:34:47 +0200
Message-ID: <w51mv8pd2fc.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 3/6] throttle: move out function to reuse
 the code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, Markus Armbruster <armbru@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

On Thu 29 Jun 2017 05:10:53 PM CEST, Pradeep Jagadeesh wrote:
> This patch move out the throttle code to util/throttle.c to maximize
> the reusability of the code.The same code is also used by fsdev.
>
> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>

> index 659a410..ac4f221 100644
> --- a/include/qemu/throttle-options.h
> +++ b/include/qemu/throttle-options.h
> @@ -10,6 +10,8 @@
>  #ifndef THROTTLE_OPTIONS_H
>  #define THROTTLE_OPTIONS_H
>  
> +#include "qmp-commands.h"
> +

Shouldn't this be qapi-types.h instead ?

Otherwise the patch looks fine.

Berto
