Received: from eggs.gnu.org ([2001:4830:134:3::10]:54805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cgbYG-0005pM-0N
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 13:22:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cgbYB-0002jg-3B
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 13:22:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cgbYA-0002jP-TG
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 13:22:03 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3407B61BAD
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 18:22:02 +0000 (UTC)
Received: from localhost (ovpn-116-33.gru2.redhat.com [10.97.116.33])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BD5B784CF7
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 18:22:01 +0000 (UTC)
Date: Wed, 22 Feb 2017 15:21:58 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170222182158.GA28403@thinpad.lan.raisama.net>
References: <20170119210449.11991-1-ehabkost@redhat.com>
	<20170119210449.11991-2-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170119210449.11991-2-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/6] i386: Unset
 cannot_destroy_with_object_finalize_yet on "host" model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On Thu, Jan 19, 2017 at 07:04:44PM -0200, Eduardo Habkost wrote:
> The class is now safe because the assert(kvm_enabled()) line was
> removed by commit e435601058e656e6d24e3e87b187e5518f7bf16a.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Applied to x86-next.

-- 
Eduardo
