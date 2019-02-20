Received: from eggs.gnu.org ([209.51.188.92]:45958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gwKKS-00082t-9C
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 00:21:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gwK8n-0007ZZ-KL
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 00:09:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gwK8g-0007Te-Sm
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 00:09:49 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B0184859FE
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 05:09:39 +0000 (UTC)
Date: Wed, 20 Feb 2019 13:09:35 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190220050935.GA8252@xz-x1>
References: <20190219195928.12289-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190219195928.12289-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] migration: Fix cancel state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com

On Tue, Feb 19, 2019 at 07:59:28PM +0000, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> During a cancelled migration there's a race where the fd can
> go into an error state before we get back around the migration loop
> and migration_detect_error transitions from cancelling->failed.
> 
> Check for cancelled/cancelling and don't change the state.
> 
> Red Hat bug: https://bugzilla.redhat.com/show_bug.cgi?id=1608649
> 
> Fixes: b23c2ade250
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu
