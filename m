Received: from eggs.gnu.org ([2001:4830:134:3::10]:47233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dL99h-0002j0-8P
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 10:20:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dL99b-0007oZ-Bv
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 10:20:21 -0400
Received: from mail-db5eur01on0132.outbound.protection.outlook.com
	([104.47.2.132]:32921
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1dL99a-0007mn-KA
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 10:20:15 -0400
Date: Wed, 14 Jun 2017 17:20:05 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20170614142004.GC2044@rkaganb.sw.ru>
References: <20170606181948.16238-1-rkagan@virtuozzo.com>
	<20170606181948.16238-21-rkagan@virtuozzo.com>
	<43a7c4b5-1445-a48f-b45b-f15030bb81b6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43a7c4b5-1445-a48f-b45b-f15030bb81b6@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

On Wed, Jun 14, 2017 at 01:19:21PM +0200, Paolo Bonzini wrote:
> On 06/06/2017 20:19, Roman Kagan wrote:
> > +typedef struct MsgHandler {
> > +    struct rcu_head rcu;
> > +    QLIST_ENTRY(MsgHandler) le;
> > +    uint32_t conn_id;
> > +    HvMsgHandler handler;
> > +    void *data;
> > +} MsgHandler;
> > +
> > +static QLIST_HEAD(, MsgHandler) msg_handlers;
> > +static QemuMutex msg_handlers_mutex;
> 
> Maybe use the same mutex for event and message handlers?

Are there other benefits in it beside saving 40 bytes?

Roman.
