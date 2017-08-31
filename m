Received: from eggs.gnu.org ([2001:4830:134:3::10]:56767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dnPSb-0006gt-QJ
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:24:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dnPSX-00042P-Ru
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:24:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dnPSX-00042G-LX
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:24:37 -0400
Date: Thu, 31 Aug 2017 15:24:33 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170831152433.0394264e.cohuck@redhat.com>
In-Reply-To: <20170831121828.85885-1-pasic@linux.vnet.ibm.com>
References: <20170831121828.85885-1-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] s390x/css: fix cc handling for XSCH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On Thu, 31 Aug 2017 14:18:28 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> The function ioinst_handle_xsch is presenting cc 2 when it's supposed to
> present cc 1 and the other way around, because css_do_xsch has the error
> codes mixed up. Because cc 1 has precedence over cc 2 we also have to
> swap the two checks.
> 
> Let us fix this.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Reported-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> ---
> 
> Was previously a part of a series (due to an accident the
> series had no name). This version also fixes the priority
> (aka precedence) problem.
> 
> ---
>  hw/s390x/css.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Thanks, applied.
