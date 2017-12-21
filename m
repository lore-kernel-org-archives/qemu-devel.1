Received: from eggs.gnu.org ([2001:4830:134:3::10]:60279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eRzJ8-0007Rg-1o
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 06:46:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eRzJ7-0004zV-Df
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 06:46:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39324)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eRzJ7-0004yz-6t
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 06:46:37 -0500
Date: Thu, 21 Dec 2017 19:46:30 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171221114630.GQ10812@lemon>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-21-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171219084557.9801-21-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v6 20/27] qmp: export qmp_dispatch_check_obj
 and allow "id"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Tue, 12/19 16:45, Peter Xu wrote:
> We need this for earlier check for OOB, before reaching
> do_qmp_dispatch().  Meanwhile, a small touch-up to allow "id" field,
> after all we allow that for sure in the spec (in any form).
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fam Zheng <famz@redhat.com>
