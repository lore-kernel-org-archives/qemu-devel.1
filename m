Received: from eggs.gnu.org ([2001:4830:134:3::10]:49211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ePmeB-0007GL-5o
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 04:51:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ePme6-0001Ak-C1
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 04:51:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:30538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1ePme6-0001A7-5G
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 04:51:10 -0500
Date: Fri, 15 Dec 2017 17:51:04 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171215095104.GD15187@lemon>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-20-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171205055200.16305-20-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v5 19/26] qapi: introduce new cmd option
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

On Tue, 12/05 13:51, Peter Xu wrote:
> --- a/qapi/introspect.json
> +++ b/qapi/introspect.json
> @@ -259,12 +259,16 @@
>  #
>  # @ret-type: the name of the command's result type.
>  #
> +# @allow-oob: whether the command allows out-of-band execution.
> +#             (Since: 2.11)

(Since: 2.12)

Fam
