Received: from eggs.gnu.org ([2001:4830:134:3::10]:40355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dhPME-0000NK-Eh
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 20:05:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dhPMB-0000jr-Ad
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 20:05:18 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:33330)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dhPMB-0000id-3o
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 20:05:15 -0400
Received: by mail-wm0-f44.google.com with SMTP id k20so20377386wmg.0
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 17:05:14 -0700 (PDT)
References: <20170812213330.20539-1-mtparkr@gmail.com>
	<51a21727-6af3-cd8e-b542-d1e9e8e5ce8a@redhat.com>
	<20170814190317.ylpbagx347qwbz7p@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d2726cd1-b5a5-8930-7c79-3951769b7cb2@redhat.com>
Date: Tue, 15 Aug 2017 02:05:10 +0200
MIME-Version: 1.0
In-Reply-To: <20170814190317.ylpbagx347qwbz7p@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] net: rtl8139: do not use old_mmio accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Matt Parker <mtparkr@gmail.com>
Cc: qemu-devel@nognu.org, Jason Wang <jasowang@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>

On 14/08/2017 21:03, Matt Parker wrote:
>>>  static const MemoryRegionOps rtl8139_mmio_ops = {
>> I think you don't even need to declare a separate MemoryRegionOps, and
>> can just recycle rtl8139_io_ops?
> Looking at the memory region, it's only 0x100 bytes in size,
> so addr & 0xFF would not be needed.
> 
> In that case your right, the bar1 memory can just reuse the MemoryRegion from IO.
> I'll update the patch for this.

You can reuse the MemoryRegionOps; you cannot reuse the MemoryRegion,
but you can replace memory_region_init_io with memory_region_init_alias
if you prefer.

Paolo
