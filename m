Received: from eggs.gnu.org ([2001:4830:134:3::10]:55906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1evK0K-00079w-Ro
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:44:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1evK0H-0003KM-La
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:44:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33872 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1evK0H-0003JY-GP
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:44:25 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0BB474000B6E
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 09:44:25 +0000 (UTC)
Date: Mon, 12 Mar 2018 17:44:12 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180312094412.GA11787@xz-mi>
References: <20180308195811.24894-1-dgilbert@redhat.com>
	<20180308195811.24894-9-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180308195811.24894-9-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 08/29] libvhost-user: Open userfaultfd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, maxime.coquelin@redhat.com, marcandre.lureau@redhat.com, quintela@redhat.com, aarcange@redhat.com

On Thu, Mar 08, 2018 at 07:57:50PM +0000, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Open a userfaultfd (on a postcopy_advise) and send it back in
> the reply to the qemu for it to monitor.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
