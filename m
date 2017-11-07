Received: from eggs.gnu.org ([2001:4830:134:3::10]:47349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eBxqY-0008WF-WA
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 01:58:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eBxqV-000825-TH
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 01:58:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eBxqV-00080B-N1
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 01:58:51 -0500
Date: Tue, 7 Nov 2017 14:58:36 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171107065836.GK16355@lemon>
References: <20171106094643.14881-1-peterx@redhat.com>
	<20171106094643.14881-8-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171106094643.14881-8-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v3 07/27] monitor: move the cur_mon hack
 deeper for QMP
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
> In monitor_qmp_read(), we have the hack to temporarily replace the
> cur_mon pointer.  Now we move this hack deeper inside the QMP dispatcher
> routine since the Monitor pointer can be passed in to that using the new
> JSON Parser opaque field now.
> 
> This does not make much sense as a single patch.  However, this will be
> a big step for the next patch, when the QMP dispatcher routine will be
> split from the QMP parser.
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fam Zheng <famz@redhat.com>
