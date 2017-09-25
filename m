Received: from eggs.gnu.org ([2001:4830:134:3::10]:35575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dwNqL-0003QZ-Lg
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 03:30:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dwNqG-0000D6-Mp
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 03:30:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54152)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dwNqG-0000CI-Hp
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 03:30:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 556CF4A6EF
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 07:30:11 +0000 (UTC)
Date: Mon, 25 Sep 2017 15:30:02 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170925073002.GC398@lemon.lan>
References: <1506321449-24013-1-git-send-email-peterx@redhat.com>
	<1506321449-24013-4-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1506321449-24013-4-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/4] iothread: export iothread_stop()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Mon, 09/25 14:37, Peter Xu wrote:
> So that internal iothread users can explicitly stop one iothread without
> destroying it.
> 
> Since at it, fix iothread_stop() to allow it to be called multiple
> times.  Before this patch we may call iothread_stop() more than once on
> single iothread, while that may not be correct since qemu_thread_join()
> is not allowed to run twice.  From manual of pthread_join():
> 
>   Joining with a thread that has previously been joined results in
>   undefined behavior.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fam Zheng <famz@redhat.com>
