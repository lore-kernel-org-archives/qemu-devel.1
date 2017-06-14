Received: from eggs.gnu.org ([2001:4830:134:3::10]:35764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dL8jh-0001fa-HC
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 09:53:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dL8jg-0004X3-NG
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 09:53:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dL8jg-0004Vl-H3
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 09:53:28 -0400
Date: Wed, 14 Jun 2017 10:53:25 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170614135325.GI5016@thinpad.lan.raisama.net>
References: <20170606181948.16238-1-rkagan@virtuozzo.com>
	<20170606181948.16238-13-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170606181948.16238-13-rkagan@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 12/23] hyperv: make HvSintRoute
 reference-counted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

On Tue, Jun 06, 2017 at 09:19:37PM +0300, Roman Kagan wrote:
> Multiple entities (e.g. VMBus devices) can use the same SINT route.  To
> make their lives easier in maintaining SINT route ownership, make it
> reference-counted.  Adjust the respective API names accordingly.
> 
> Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>

Isn't it easier to reuse existing refcounting infrastructure
here?  Is it overkill to make it a QOM object? (struct Object has
40 bytes)

-- 
Eduardo
