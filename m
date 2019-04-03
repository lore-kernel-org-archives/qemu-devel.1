Received: from eggs.gnu.org ([209.51.188.92]:33105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hBahM-0004Ng-HD
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 03:52:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hBahL-0002kq-LI
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 03:52:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33640)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hBahL-0002ju-D4
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 03:52:39 -0400
Received: by mail-wr1-f66.google.com with SMTP id q1so19976432wrp.0
	for <qemu-devel@nongnu.org>; Wed, 03 Apr 2019 00:52:38 -0700 (PDT)
Date: Wed, 3 Apr 2019 09:52:33 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190403075233.fjaira54eqpjzfnd@steredhat>
References: <20190403011016.12549-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403011016.12549-1-richardw.yang@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH v2] vmstate: check subsection_found is
 enough
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com

On Wed, Apr 03, 2019 at 09:10:16AM +0800, Wei Yang wrote:
> subsection_found is true implies vmdesc is not NULL.
> 
> This patch remove the additional check on vmdesc and rename
> subsection_found to vmdesc_has_subsections to make it more self-explain.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> 
> ---
> v2:
>   * rename it to vmdesc_has_subsections
> ---
>  migration/vmstate.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Acked-by: Stefano Garzarella <sgarzare@redhat.com>
