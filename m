Received: from eggs.gnu.org ([2001:4830:134:3::10]:35110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gIPTh-0008NZ-AS
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 22:46:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gIPTc-00026k-Mp
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 22:46:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55594)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gIPTb-00026D-EG
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 22:46:23 -0400
Date: Fri, 2 Nov 2018 10:46:11 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181102024611.GE7804@xz-x1>
References: <20181101101715.9443-1-fli@suse.com>
	<20181101101715.9443-7-fli@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181101101715.9443-7-fli@suse.com>
Subject: Re: [Qemu-devel] [PATCH RFC v7 6/9] migration: fix the multifd code
 when receiving less channels
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <fli@suse.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, dgilbert@redhat.com, famz@redhat.com, quintela@redhat.com

On Thu, Nov 01, 2018 at 06:17:12PM +0800, Fei Li wrote:

[...]

> @@ -1339,7 +1339,7 @@ bool multifd_recv_all_channels_created(void)
>  }
>  
>  /* Return true if multifd is ready for the migration, otherwise false */
> -bool multifd_recv_new_channel(QIOChannel *ioc)
> +bool multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
>  {
>      MultiFDRecvParams *p;
>      Error *local_err = NULL;
> @@ -1347,6 +1347,9 @@ bool multifd_recv_new_channel(QIOChannel *ioc)
>  
>      id = multifd_recv_initial_packet(ioc, &local_err);
>      if (id < 0) {
> +        error_propagate_prepend(errp, local_err,
> +                        "failed to receive packet via multifd channel %x: ",

I'd use either %d or 0x%x, and some indent issue.

Otherwise looks good to me.  Thanks,

-- 
Peter Xu
