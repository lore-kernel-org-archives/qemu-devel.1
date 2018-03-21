Received: from eggs.gnu.org ([2001:4830:134:3::10]:43342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eyUNv-0006ty-6A
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 23:25:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eyUNr-0004Dl-UZ
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 23:25:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37854 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eyUNr-0004DV-PV
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 23:25:51 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 27A944040070
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 03:25:51 +0000 (UTC)
Date: Wed, 21 Mar 2018 11:25:47 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180321032547.GB20227@xz-mi>
References: <20180320151857.26340-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180320151857.26340-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] chardev-socket: remove useless if
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue, Mar 20, 2018 at 04:18:57PM +0100, Paolo Bonzini wrote:
> This trips Coverity, which believes the subsequent qio_channel_create_watch
> can dereference a NULL pointer.  In reality, tcp_chr_connect's callers
> all have s->ioc properly initialized, since they are all rooted at
> tcp_chr_new_client.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

(maybe replacing with an assertion would be nicer? No big deal.)

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
