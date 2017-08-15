Received: from eggs.gnu.org ([2001:4830:134:3::10]:50465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1dhSIo-0002Kq-HS
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 23:13:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1dhSIl-0007xR-5q
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 23:13:58 -0400
Received: from mga04.intel.com ([192.55.52.120]:33681)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tianyu.lan@intel.com>)
	id 1dhSIk-0007wG-UD
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 23:13:55 -0400
References: <1502311882-11038-1-git-send-email-tianyu.lan@intel.com>
	<1502311882-11038-3-git-send-email-tianyu.lan@intel.com>
	<20170811180438.GI1519@perard.uk.xensource.com>
From: Lan Tianyu <tianyu.lan@intel.com>
Message-ID: <d11787d1-dc57-1f22-86cc-9da639fd28af@intel.com>
Date: Tue, 15 Aug 2017 11:10:56 +0800
MIME-Version: 1.0
In-Reply-To: <20170811180438.GI1519@perard.uk.xensource.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V2 2/3] xen-pt: bind/unbind interrupt
 remapping format MSI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Chao Gao <chao.gao@intel.com>, sstabellini@kernel.org, mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, marcel@redhat.com, kevin.tian@intel.com

Hi Anthony:

On 2017年08月12日 02:04, Anthony PERARD wrote:
> On Wed, Aug 09, 2017 at 04:51:21PM -0400, Lan Tianyu wrote:
>> From: Chao Gao <chao.gao@intel.com>
>>
>> If a vIOMMU is exposed to guest, guest will configure the msi to remapping
>> format. The original code isn't suitable to the new format. A new pair
>> bind/unbind interfaces are added for this usage. This patch recognizes
>> this case and uses new interfaces to bind/unbind msi.
>>
>> Signed-off-by: Chao Gao <chao.gao@intel.com>
>> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
> 
> Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
> 
> That patch series can be applied once the Xen side patches are merged.
> 

Great. Thanks for your review.

-- 
Best regards
Tianyu Lan
