Received: from eggs.gnu.org ([2001:4830:134:3::10]:60620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dL9t4-0007o5-0t
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:07:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dL9t0-0000Px-2G
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:07:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60630)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dL9sz-0000Pd-Rx
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:07:09 -0400
References: <20170606181948.16238-1-rkagan@virtuozzo.com>
	<20170606181948.16238-19-rkagan@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0f2b694b-b7d5-be6e-2d21-f0807886b1a0@redhat.com>
Date: Wed, 14 Jun 2017 17:07:03 +0200
MIME-Version: 1.0
In-Reply-To: <20170606181948.16238-19-rkagan@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 18/23] hyperv: add synic event flag
 signaling
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
> +
> +    if ((atomic_fetch_or(&flags[set_idx], set_mask) & set_mask) !=3D s=
et_mask) {
> +        ret =3D kvm_hv_sint_route_set_sint(sint_route);
> +        memory_region_set_dirty(&synic->evt_page_mr, 0,
> +                                sizeof(*synic->evt_page));

I would swap the kvm_hv_sint_route_set_sint and memory_region_set_dirty
lines.

Paolo

> +    } else {
> +        ret =3D 0;
> +    }
