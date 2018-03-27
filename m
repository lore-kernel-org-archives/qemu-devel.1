Received: from eggs.gnu.org ([2001:4830:134:3::10]:37190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=61706adb2=anthony.perard@citrix.com>)
	id 1f0l7t-0004Su-6a
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 05:42:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=61706adb2=anthony.perard@citrix.com>)
	id 1f0l7q-0004OJ-54
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 05:42:45 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:36382)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=61706adb2=anthony.perard@citrix.com>)
	id 1f0l7p-0004NB-V2
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 05:42:42 -0400
Date: Tue, 27 Mar 2018 10:42:05 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20180327094204.GC2208@perard>
References: <1520982894-4180-1-git-send-email-igor.druzhinin@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1520982894-4180-1-git-send-email-igor.druzhinin@citrix.com>
Subject: Re: [Qemu-devel] [PATCH v2] xen-pvdevice: Introduce a simplistic
 xen-pvdevice save state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Druzhinin <igor.druzhinin@citrix.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, sstabellini@kernel.org, paul.durrant@citrix.com, pbonzini@redhat.com, mst@redhat.com

On Tue, Mar 13, 2018 at 11:14:54PM +0000, Igor Druzhinin wrote:
> This should help to avoid problems with accessing the device after
> migration/resume without PV drivers by migrating its PCI configuration
> space state. Without an explicitly defined state record it resets
> every time a VM migrates which confuses the OS and makes every
> access to xen-pvdevice MMIO region to fail. PV tools enable some
> logic to save and restore PCI configuration state from within the VM
> every time it migrates which basically hides the issue.
> 
> Older systems will acquire the new record when migrated which should
> not change their state for worse.
> 
> Signed-off-by: Igor Druzhinin <igor.druzhinin@citrix.com>
> Reviewed-by: Paul Durrant <paul.durrant@citrix.com>
> ---
> v2: add more concrete info
> ---
>  hw/i386/xen/xen_pvdevice.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD
