Received: from eggs.gnu.org ([2001:4830:134:3::10]:48692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eBxvU-0001qz-US
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 02:04:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eBxvR-0002cL-O0
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 02:04:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eBxvR-0002bw-H1
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 02:03:57 -0500
Date: Tue, 7 Nov 2017 15:03:49 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171107070349.GL16355@lemon>
References: <20171106094643.14881-1-peterx@redhat.com>
	<20171106094643.14881-9-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171106094643.14881-9-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v3 08/27] monitor: unify global init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, marcandre.lureau@redhat.com, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Mon, 11/06 17:46, Peter Xu wrote:
> There are many places for monitor init its globals, at least:
> 
> - monitor_init_qmp_commands() at the very beginning
> - single function to init monitor_lock
> - in the first entry of monitor_init() using "is_first_init"
> 
> Unify them a bit.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fam Zheng <famz@redhat.com>
