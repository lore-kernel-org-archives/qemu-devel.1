Received: from eggs.gnu.org ([2001:4830:134:3::10]:54934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cgbZB-0006H2-8e
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 13:23:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cgbZ6-0002xT-Bc
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 13:23:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50182)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cgbZ6-0002xK-5M
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 13:23:00 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5CB6EC057FA9
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 18:23:00 +0000 (UTC)
Received: from localhost (ovpn-116-33.gru2.redhat.com [10.97.116.33])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1MIMxrn029818
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 13:22:59 -0500
Date: Wed, 22 Feb 2017 15:22:57 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170222182257.GB28403@thinpad.lan.raisama.net>
References: <20170119210449.11991-1-ehabkost@redhat.com>
	<20170119210449.11991-3-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170119210449.11991-3-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/6] i386: Add ordering field to CPUClass
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On Thu, Jan 19, 2017 at 07:04:45PM -0200, Eduardo Habkost wrote:
> Instead of using kvm_enabled to order the "-cpu help" list, use a
> new "ordering" field for that.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Applied to x86-next.

-- 
Eduardo
