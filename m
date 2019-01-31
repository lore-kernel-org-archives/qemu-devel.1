Received: from eggs.gnu.org ([209.51.188.92]:39768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gp77o-0003uU-EA
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:51:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gp77m-0007xT-Hm
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:51:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gp77m-0007gw-8C
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:51:02 -0500
References: <20190131073234.18037-1-yang.zhong@intel.com>
	<20190131073234.18037-3-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b6653b69-5f29-2759-1bf1-00ae3c98674e@redhat.com>
Date: Thu, 31 Jan 2019 08:50:34 +0100
MIME-Version: 1.0
In-Reply-To: <20190131073234.18037-3-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 02/27] ide: split ioport registration to
 a separate file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

On 2019-01-31 08:32, Yang Zhong wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> This is not needed on ARM, and brings in ISA bus code which is otherwise not
> necessary.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/ide/Makefile.objs |  4 +--
>  hw/ide/core.c        | 25 -----------------
>  hw/ide/ioport.c      | 66 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 68 insertions(+), 27 deletions(-)
>  create mode 100644 hw/ide/ioport.c

Reviewed-by: Thomas Huth <thuth@redhat.com>
