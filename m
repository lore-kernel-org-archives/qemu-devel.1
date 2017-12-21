Received: from eggs.gnu.org ([2001:4830:134:3::10]:37661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eRzQb-0001kX-5T
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 06:54:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eRzQW-00050X-8i
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 06:54:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37632)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eRzQW-0004zh-1e
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 06:54:16 -0500
Date: Thu, 21 Dec 2017 19:54:07 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171221115407.GR10812@lemon>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-22-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171219084557.9801-22-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v6 21/27] qmp: support out-of-band (oob)
 execution
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
> Having "allow-oob" to true for a command does not mean that this command
> will always be run in out-of-band mode.  The out-of-band quick path will
> only be executed if we specify the extra "run-oob" flag when sending the
> QMP request:
> 
>     { "execute":   "command-that-allows-oob",
>       "arguments": { ... },
>       "control":   { "run-oob": true } }
> 
> The "control" key is introduced to store this extra flag.  "control"
> field is used to store arguments that are shared by all the commands,
> rather than command specific arguments.  Let "run-oob" be the first.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fam Zheng <famz@redhat.com>
