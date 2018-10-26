Received: from eggs.gnu.org ([2001:4830:134:3::10]:49903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gG4IV-0003tU-Gh
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:45:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gG4Dy-0008PF-8s
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:40:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gG4Dx-0008O6-KU
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:40:33 -0400
Date: Fri, 26 Oct 2018 12:40:15 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181026154015.GI3902@habkost.net>
References: <cover.1540389255.git.yi.z.zhang@linux.intel.com>
	<a6491f996827f4039c1a52198ed5dcc7727cb0f9.1540389255.git.yi.z.zhang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6491f996827f4039c1a52198ed5dcc7727cb0f9.1540389255.git.yi.z.zhang@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] hostmem-file: remove the invalid pmem
 object id.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Yi <yi.z.zhang@linux.intel.com>
Cc: mst@redhat.com, peter.maydell@linaro.org, yu.c.zhang@linux.intel.com, imammedo@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com, stefanha@redhat.com, crosthwaite.peter@gmail.com, richard.henderson@linaro.org, xiaoguangrong.eric@gmail.com

On Wed, Oct 24, 2018 at 10:14:56PM +0800, Zhang Yi wrote:
> We will never get the canonical path from the object
> before object_property_add_child.
> 
> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>

Thanks.  I'm queueing it on machine-next, after rewriting the
subject line as:

  hostmem-file: remove object id from pmem error message

-- 
Eduardo
