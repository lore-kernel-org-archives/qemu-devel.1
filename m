Received: from eggs.gnu.org ([209.51.188.92]:40346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gwseL-0001rm-A5
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:00:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gwseK-0003HL-Cb
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:00:45 -0500
References: <1550592459-7286-1-git-send-email-thuth@redhat.com>
	<20190219151825-mutt-send-email-mst@kernel.org>
	<bfdc4037-4017-a501-4e1f-e8da8949e672@redhat.com>
	<20190221115446-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <23d83057-1b9c-e574-d102-6b391f8dbddd@redhat.com>
Date: Thu, 21 Feb 2019 19:00:36 +0100
MIME-Version: 1.0
In-Reply-To: <20190221115446-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, yang.zhong@intel.com

On 21/02/19 17:55, Michael S. Tsirkin wrote:
> On Wed, Feb 20, 2019 at 07:24:00AM +0100, Thomas Huth wrote:
>> On 19/02/2019 21.19, Michael S. Tsirkin wrote:
>>> On Tue, Feb 19, 2019 at 05:07:39PM +0100, Thomas Huth wrote:
>>>> Some machines have an AHCI adapter, but no PCI. To be able to
>>>> compile hw/ide/ahci.c without CONFIG_PCI, we still need the two
>>>> functions msi_enabled() and msi_notify() for linking.
>>>> This is required for the upcoming Kconfig-like build system, if
>>>> a user wants to compile a QEMU binary with just one machine that
>>>> has AHCI, but no PCI, like the ARM "cubieboard" for example.
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>
>>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>>
>> Thanks!
>>
>>> Do you want me to merge this or do you prefer to
>>> merge it with kconfig patches?
>>
>> If you plan a pci pull request soon, feel free to take it. Otherwise, I
>> can also add it to my Kconfig-for-arm patch series where I need it.
>>
>>  Thomas
> 
> Feel free to include but please talk to Paolo about his
> ideas for abstracting it out.

Not a blocker for me.

Paolo
