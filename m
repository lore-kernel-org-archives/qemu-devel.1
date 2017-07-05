Received: from eggs.gnu.org ([2001:4830:134:3::10]:40146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dSkYk-0000Gw-N9
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 09:41:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dSkYk-0006C2-1E
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 09:41:38 -0400
References: <20170705133635.11850-1-famz@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e8fbd4aa-53c7-2416-0bd6-fc7e9a8512cb@redhat.com>
Date: Wed, 5 Jul 2017 15:41:25 +0200
MIME-Version: 1.0
In-Reply-To: <20170705133635.11850-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/6] block: Add VFIO based driver for
 NVMe device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Keith Busch <keith.busch@intel.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Karl Rister <krister@redhat.com>



On 05/07/2017 15:36, Fam Zheng wrote:
> v3: Rebase, small tweaks/fixes and add locks to provide basic thread safety
>     (basic because it is not really tested).

Sounds good, it can be converted to CoMutex later.

Paolo
