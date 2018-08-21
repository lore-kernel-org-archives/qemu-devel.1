Received: from eggs.gnu.org ([2001:4830:134:3::10]:57778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fs3j2-0008Jt-1A
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 06:17:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fs3iy-0002h0-Q6
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 06:17:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45538 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1fs3iy-0002gO-JO
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 06:17:20 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 89DA1402170B
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:17:19 +0000 (UTC)
Date: Tue, 21 Aug 2018 12:17:13 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180821121713.508bf63b.cohuck@redhat.com>
In-Reply-To: <1534845930-14451-1-git-send-email-thuth@redhat.com>
References: <1534845930-14451-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Remove deprecated -balloon option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>

On Tue, 21 Aug 2018 12:05:30 +0200
Thomas Huth <thuth@redhat.com> wrote:

> The "-balloon" option has been replaced by "-device virtio-balloon".
> It's been marked as deprecated since two releases, and nobody
> complained, so let's remove it now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  docs/virtio-balloon-stats.txt |  6 +++---
>  qemu-deprecated.texi          |  5 -----
>  qemu-options.hx               | 10 ----------
>  vl.c                          | 36 ------------------------------------
>  4 files changed, 3 insertions(+), 54 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
