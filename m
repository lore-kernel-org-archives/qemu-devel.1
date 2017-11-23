Received: from eggs.gnu.org ([2001:4830:134:3::10]:48549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eHuuU-0004dx-0r
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 12:03:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eHuuP-0005xu-Ml
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 12:03:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1eHuuP-0005xP-HI
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 12:03:29 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A8676C05686E
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 17:03:28 +0000 (UTC)
Date: Thu, 23 Nov 2017 18:03:23 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171123170323.GC4375@localhost.localdomain>
References: <20171123135906.12852-1-famz@redhat.com>
	<20171123135906.12852-3-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171123135906.12852-3-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] qemu-options: Mention locking option
 of file driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, mreitz@redhat.com

Am 23.11.2017 um 14:59 hat Fam Zheng geschrieben:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  qemu-options.hx | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 3728e9b4dd..bcb7a88ec3 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -693,6 +693,9 @@ This is the protocol-level block driver for accessing regular files.
>  The path to the image file in the local filesystem
>  @item aio
>  Specifies the AIO backend (threads/native, default: threads)
> +@item locking
> +Specifies whether the image file is protected with Linux OFD / POSIX locks.
> +(auto/on/off, default: auto)

Maybe "should be protected" would be better than "is protected"?

Do we want to explain what "auto" means?

Kevin
