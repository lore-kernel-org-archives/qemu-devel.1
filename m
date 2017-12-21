Received: from eggs.gnu.org ([2001:4830:134:3::10]:58990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eRzHv-0006kS-I2
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 06:45:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eRzHq-0003d2-Iw
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 06:45:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eRzHq-0003c5-CG
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 06:45:18 -0500
Date: Thu, 21 Dec 2017 19:45:11 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171221114511.GP10812@lemon>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-20-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171219084557.9801-20-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v6 19/27] qapi: introduce new cmd option
 "allow-oob"
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
> Here "oob" stands for "Out-Of-Band".  When "allow-oob" is set, it means
> the command allows out-of-band execution.
> 
> The "oob" idea is proposed by Markus Armbruster in following thread:
> 
>   https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg02057.html
> 
> This new "allow-oob" boolean will be exposed by "query-qmp-schema" as
> well for command entries, so that QMP clients can know which command can
> be used as out-of-band calls. For example the command "migrate"
> originally looks like:
> 
>   {"name": "migrate", "ret-type": "17", "meta-type": "command",
>    "arg-type": "86"}
> 
> And it'll be changed into:
> 
>   {"name": "migrate", "ret-type": "17", "allow-oob": false,
>    "meta-type": "command", "arg-type": "86"}
> 
> This patch only provides the QMP interface level changes.  It does not
> contains the real out-of-band execution implementation yet.
> 
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fam Zheng <famz@redhat.com>
