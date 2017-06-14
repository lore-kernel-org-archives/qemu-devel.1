Received: from eggs.gnu.org ([2001:4830:134:3::10]:42711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dL6Kc-0003al-Jz
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 07:19:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dL6Kb-0005f9-R8
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 07:19:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33299)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dL6Kb-0005ek-KV
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 07:19:25 -0400
References: <20170606181948.16238-1-rkagan@virtuozzo.com>
	<20170606181948.16238-21-rkagan@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <43a7c4b5-1445-a48f-b45b-f15030bb81b6@redhat.com>
Date: Wed, 14 Jun 2017 13:19:21 +0200
MIME-Version: 1.0
In-Reply-To: <20170606181948.16238-21-rkagan@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 20/23] hyperv: process POST_MESSAGE
 hypercall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>



On 06/06/2017 20:19, Roman Kagan wrote:
> +typedef struct MsgHandler {
> +    struct rcu_head rcu;
> +    QLIST_ENTRY(MsgHandler) le;
> +    uint32_t conn_id;
> +    HvMsgHandler handler;
> +    void *data;
> +} MsgHandler;
> +
> +static QLIST_HEAD(, MsgHandler) msg_handlers;
> +static QemuMutex msg_handlers_mutex;

Maybe use the same mutex for event and message handlers?

Paolo
