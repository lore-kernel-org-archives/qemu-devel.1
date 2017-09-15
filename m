Received: from eggs.gnu.org ([2001:4830:134:3::10]:36690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dstBX-0000kp-QN
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 12:09:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dstBT-0007Fv-O0
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 12:09:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dstBT-0007FU-Gd
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 12:09:39 -0400
Date: Fri, 15 Sep 2017 17:09:28 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170915160927.GT2170@work-vm>
References: <1505375436-28439-1-git-send-email-peterx@redhat.com>
	<1505375436-28439-16-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1505375436-28439-16-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC 15/15] qmp: let migrate-incoming allow
 out-of-band
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>

* Peter Xu (peterx@redhat.com) wrote:
> So it can get rid of being run on main thread.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  qapi/migration.json | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/qapi/migration.json b/qapi/migration.json
> index ee2b3b8..dedc4f8 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -986,7 +986,8 @@
>  # <- { "return": {} }
>  #
>  ##
> -{ 'command': 'migrate-incoming', 'data': {'uri': 'str' } }
> +{ 'command': 'migrate-incoming', 'data': {'uri': 'str' },
> +  'allow-oob': true }

Are you completely convinced migrate-incoming is non-blocking?
What about during the tls handshake if tls is enabled?
(We only set non-blocking on the fd later)

I don't understand in this structure on which thread
process_incoming_migration_co gets run.

Dave

>  ##
>  # @xen-save-devices-state:
> -- 
> 2.7.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
