Received: from eggs.gnu.org ([2001:4830:134:3::10]:60963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dL9tv-0000Ag-U4
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:08:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dL9tv-0000qh-5D
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:08:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dL9tu-0000qS-Uz
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:08:07 -0400
References: <20170606181948.16238-1-rkagan@virtuozzo.com>
	<20170606181948.16238-18-rkagan@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ebb4867f-a072-cfa0-6ca8-b493ef157458@redhat.com>
Date: Wed, 14 Jun 2017 17:08:02 +0200
MIME-Version: 1.0
In-Reply-To: <20170606181948.16238-18-rkagan@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 17/23] hyperv: add synic message delivery
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
> +    sint_route->msg_status =3D ret;
> +    /* notify the msg originator of the progress made; if the slot was=
 busy we
> +     * set msg_pending flag in it so it will be the guest who will do =
EOM and
> +     * trigger the notification from KVM via sint_ack_notifier */
> +    if (ret !=3D -EAGAIN) {
> +        qemu_bh_schedule(sint_route->msg_bh);
> +    }

It may be faster to use aio_bh_schedule_oneshot, depending on the number
of devices.

Paolo
