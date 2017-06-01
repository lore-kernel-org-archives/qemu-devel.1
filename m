Received: from eggs.gnu.org ([2001:4830:134:3::10]:39288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dGGXq-0006dg-T3
	for qemu-devel@nongnu.org; Wed, 31 May 2017 23:13:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dGGXh-0001x7-JN
	for qemu-devel@nongnu.org; Wed, 31 May 2017 23:13:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dGGXh-0001wx-DF
	for qemu-devel@nongnu.org; Wed, 31 May 2017 23:12:57 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6BEAF61D30
	for <qemu-devel@nongnu.org>; Thu,  1 Jun 2017 03:12:56 +0000 (UTC)
Date: Thu, 1 Jun 2017 11:12:53 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170601031253.GD32741@pxdev.xzpeter.org>
References: <20170531125746.17585-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170531125746.17585-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] edu: fix memory leak on msi_broken
 platforms
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com

On Wed, May 31, 2017 at 02:57:46PM +0200, Paolo Bonzini wrote:
> If msi_init fails, the thread has already been created and the
> mutex/condvar are not destroyed.  Initialize everything only
> after the point where pci_edu_realize cannot fail.
> 
> Reported-by: Markus Armbruster <armbru@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
