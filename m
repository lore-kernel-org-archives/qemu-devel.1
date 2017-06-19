Received: from eggs.gnu.org ([2001:4830:134:3::10]:46758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dMzN7-0006AT-UV
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 12:17:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dMzN2-0006HX-3G
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 12:17:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:65070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dMzN1-0006G5-Tx
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 12:17:44 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F070DC04B953
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 16:17:42 +0000 (UTC)
Date: Mon, 19 Jun 2017 13:17:39 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170619161739.GV5016@thinpad.lan.raisama.net>
References: <1497876588-947-1-git-send-email-peterx@redhat.com>
	<1497876588-947-5-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1497876588-947-5-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 04/13] accel: introduce
 AccelState.global_props
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Mon, Jun 19, 2017 at 08:49:39PM +0800, Peter Xu wrote:
> Introduce this new field for the accelerator instances so that each
> specific accelerator in the future can register its own global
> properties to be used further by the system.  It works just like how the
> old machine compatible properties do, but only tailored for
> accelerators.
> 
> Use the newly exported register_compat_prop() to pass the accelerator
> global properties to the global_props list.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

As noted on other patches, I believe this should be
AccelClass::global_props (initialized statically in class_init)
instead of AccelState::global_props (built at runtime).
Otherwise, I don't see the benefit of the new field.

-- 
Eduardo
