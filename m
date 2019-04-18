Received: from eggs.gnu.org ([209.51.188.92]:49195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hHDe1-0002Dd-GB
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:28:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hHDdz-0006Pp-L4
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:28:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32936)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hHDdx-0006LA-K3
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:28:27 -0400
Date: Thu, 18 Apr 2019 17:28:20 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190418202820.GM25134@habkost.net>
References: <20190418064602.24558-1-tao3.xu@intel.com>
	<20190418064602.24558-4-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190418064602.24558-4-tao3.xu@intel.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] numa: move numa global variable
 numa_info into MachineState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tao Xu <tao3.xu@intel.com>
Cc: imammedo@redhat.com, pbonzini@redhat.com, jingqi.liu@intel.com, qemu-devel@nongnu.org

On Thu, Apr 18, 2019 at 02:46:02PM +0800, Tao Xu wrote:
> The aim of this patch is to move existing numa global numa_info
> into NumaState.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>

`ms->numa_state->numa_info[i]` is not a very descriptive
expression.  Also, we don't need the "numa" prefix anymore, if
the identifier is not in global scope.

I suggest renaming it to NumaState::nodes.  So this:
>  ms->numa_state->numa_info[i].distance[j]
would become:
  ms->numa_state->nodes[i].distance[j]

This wouldn't block me from merging this patch, but it's a
suggestion in case you send v3 to address the comments on patch
1/3.

-- 
Eduardo
