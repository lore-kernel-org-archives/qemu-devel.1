Received: from eggs.gnu.org ([2001:4830:134:3::10]:52869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1dDLRd-0003p1-9W
	for qemu-devel@nongnu.org; Tue, 23 May 2017 21:50:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1dDLRY-00045B-E0
	for qemu-devel@nongnu.org; Tue, 23 May 2017 21:50:37 -0400
Received: from mga11.intel.com ([192.55.52.93]:25346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tianyu.lan@intel.com>)
	id 1dDLRY-00044s-3E
	for qemu-devel@nongnu.org; Tue, 23 May 2017 21:50:32 -0400
References: <1495085580-10631-1-git-send-email-tianyu.lan@intel.com>
	<1495085580-10631-2-git-send-email-tianyu.lan@intel.com>
	<20170519111622.GA3260@perard.uk.xensource.com>
	<591EFB5D020000780015B47A@prv-mh.provo.novell.com>
	<3f3c2075-da6b-dd14-279f-23525f46b3c5@intel.com>
	<20170523170622.GD1591@perard.uk.xensource.com>
From: Lan Tianyu <tianyu.lan@intel.com>
Message-ID: <fe951106-a011-a0fc-e476-65d1beafe840@intel.com>
Date: Wed, 24 May 2017 09:40:56 +0800
MIME-Version: 1.0
In-Reply-To: <20170523170622.GD1591@perard.uk.xensource.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Xen-devel] [RFC PATCH V2 1/2] xen-pt: bind/unbind
 interrupt remapping format MSI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: Jan Beulich <JBeulich@suse.com>, Chao Gao <chao.gao@intel.com>, kevin.tian@intel.com, sstabellini@kernel.org, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, marcel@redhat.com, mst@redhat.com

On 2017年05月24日 01:06, Anthony PERARD wrote:
> On Tue, May 23, 2017 at 08:16:25PM +0800, Lan Tianyu wrote:
>> On 2017年05月19日 20:04, Jan Beulich wrote:
>>>>>> On 19.05.17 at 13:16, <anthony.perard@citrix.com> wrote:
>>>> On Thu, May 18, 2017 at 01:32:59AM -0400, Lan Tianyu wrote:
>>>>> --- a/include/hw/i386/apic-msidef.h
>>>>> +++ b/include/hw/i386/apic-msidef.h
>>>>> @@ -26,6 +26,7 @@
>>>>>  
>>>>>  #define MSI_ADDR_DEST_ID_SHIFT          12
>>>>>  #define MSI_ADDR_DEST_IDX_SHIFT         4
>>>>> -#define  MSI_ADDR_DEST_ID_MASK          0x00ffff0
>>>>> +#define  MSI_ADDR_DEST_ID_MASK          0x000fff00
>>>> The value of MSI_ADDR_DEST_ID_MASK is changed here. I think the patch
>>>> should be:
>>>> +#define  MSI_ADDR_DEST_ID_MASK          0x000ffff0
>>> Judging from other sources, rather the other way around - the
>>> mask needs to have further bits removed (should be 0x000ff000
>>> afaict). Xen sources confirm this, and while Linux has the value
>>> you suggest, that contradicts
>> Agree. Defining the mask as "0x000ff000" makes more sense.
>> Just check Qemu source code. Only apic_send_msi() and msi_dest_id() use
>> the mask
>> to get dest apic id. They mask MSI address field with 
>> MSI_ADDR_DEST_ID_MASK and
>> then right-shift 12bit. The low 12bit won't be used.
>>
>> Anthony, does this make sense?
> Yes, it does.
> The change to MSI_ADDR_DEST_ID_MASK should probably go in its own patch.
>
OK. Will update.


-- 
Best regards
Tianyu Lan
