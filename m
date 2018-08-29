Received: from eggs.gnu.org ([2001:4830:134:3::10]:38069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fv4bj-0004yx-K4
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 13:50:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fv4bg-0008W4-ES
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 13:50:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fv4bg-0008Vc-7i
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 13:50:16 -0400
Date: Wed, 29 Aug 2018 14:50:09 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180829175009.GD17213@habkost.net>
References: <7328fb16c394eaf5d65437d11c2a9343647b6d3d.1535471899.git.yi.z.zhang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7328fb16c394eaf5d65437d11c2a9343647b6d3d.1535471899.git.yi.z.zhang@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] hostmem-file: fixed the memory leak
 while get pmem path.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Yi <yi.z.zhang@linux.intel.com>
Cc: mst@redhat.com, peter.maydell@linaro.org, yu.c.zhang@linux.intel.com, imammedo@redhat.com, junyan.he@intel.com, qemu-devel@nongnu.org, pbonzini@redhat.com, stefanha@redhat.com, crosthwaite.peter@gmail.com, richard.henderson@linaro.org, xiaoguangrong.eric@gmail.com

On Wed, Aug 29, 2018 at 12:14:22AM +0800, Zhang Yi wrote:
> object_get_canonical_path_component() returns a string which
> must be freed using g_free().
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

Queueing on machine-next, thanks.

-- 
Eduardo
