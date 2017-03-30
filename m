Received: from eggs.gnu.org ([2001:4830:134:3::10]:51358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chao.gao@intel.com>) id 1ctnR9-0002f2-5u
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 23:41:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chao.gao@intel.com>) id 1ctnR4-0006eM-9c
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 23:41:19 -0400
Received: from mga09.intel.com ([134.134.136.24]:62140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chao.gao@intel.com>) id 1ctnR4-0006dc-0q
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 23:41:14 -0400
Date: Fri, 31 Mar 2017 04:38:39 +0800
From: Chao Gao <chao.gao@intel.com>
Message-ID: <20170330203839.GC98879@skl-2s3.sh.intel.com>
References: <1489750157-17401-1-git-send-email-tianyu.lan@intel.com>
	<1489750157-17401-5-git-send-email-tianyu.lan@intel.com>
	<20170330172929.GD1864@perard.uk.xensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170330172929.GD1864@perard.uk.xensource.com>
Subject: Re: [Qemu-devel] [RFC PATCH 4/4] msi: taking interrupt format into
 consideration during judging a pirq is binded with a event channel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: Lan Tianyu <tianyu.lan@intel.com>, qemu-devel@nongnu.org, xen-devel@lists.xensource.com, kevin.tian@intel.com, mst@redhat.com, marcel@redhat.com, sstabellini@kernel.org

On Thu, Mar 30, 2017 at 06:29:29PM +0100, Anthony PERARD wrote:
>On Fri, Mar 17, 2017 at 07:29:17PM +0800, Lan Tianyu wrote:
>> From: Chao Gao <chao.gao@intel.com>
>> Subject: msi: taking interrupt format into consideration during
>> judging a pirq is binded with a event channel
>
>This is quite a long title, I think we can make it shorter. Maybe "msi:
>Handle MSI remapping format.

OK.

>
>>      data = pci_get_word(dev->config + msi_data_off(dev, msi64bit));
>> -    if (xen_is_pirq_msi(data)) {
>> +    addr_lo = pci_get_word(dev->config + msi_address_lo_off(dev));
>
>This could be get_long, so addr_lo will actually have the all low bits
>of the addr.

yes.

>
>> +int xen_is_pirq_msi(uint32_t msi_data, uint32_t msi_addr_lo)
>>  {
>> +    /* If msi address is configurate to remapping format, the msi will not
>> +     * remapped into a pirq.
>> +     */
>> +    if ( msi_addr_lo & 0x10 )
>
>That's a magic number, is 0x10 MSI_ADDR_IM_MASK?

Yes.

Really thanks for your comments.

>
>Thanks,
>
>-- 
>Anthony PERARD
