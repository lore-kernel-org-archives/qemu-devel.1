Received: from eggs.gnu.org ([209.51.188.92]:57944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gwLId-0005wc-4G
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 01:24:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gwLIc-0003Zl-DR
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 01:24:07 -0500
References: <1550592459-7286-1-git-send-email-thuth@redhat.com>
	<20190219151825-mutt-send-email-mst@kernel.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <bfdc4037-4017-a501-4e1f-e8da8949e672@redhat.com>
Date: Wed, 20 Feb 2019 07:24:00 +0100
MIME-Version: 1.0
In-Reply-To: <20190219151825-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/pci/pci-stub: Add msi_enabled() and
 msi_notify() to the pci stubs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, yang.zhong@intel.com, pbonzini@redhat.com

On 19/02/2019 21.19, Michael S. Tsirkin wrote:
> On Tue, Feb 19, 2019 at 05:07:39PM +0100, Thomas Huth wrote:
>> Some machines have an AHCI adapter, but no PCI. To be able to
>> compile hw/ide/ahci.c without CONFIG_PCI, we still need the two
>> functions msi_enabled() and msi_notify() for linking.
>> This is required for the upcoming Kconfig-like build system, if
>> a user wants to compile a QEMU binary with just one machine that
>> has AHCI, but no PCI, like the ARM "cubieboard" for example.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> 
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Thanks!

> Do you want me to merge this or do you prefer to
> merge it with kconfig patches?

If you plan a pci pull request soon, feel free to take it. Otherwise, I
can also add it to my Kconfig-for-arm patch series where I need it.

 Thomas
