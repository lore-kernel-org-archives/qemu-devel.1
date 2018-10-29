Received: from eggs.gnu.org ([2001:4830:134:3::10]:57236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuchenlin@synology.com>) id 1gH4Mz-0003fo-A3
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 06:02:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuchenlin@synology.com>) id 1gH4Mv-0002Nu-4j
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 06:02:01 -0400
Received: from synology.com ([59.124.61.242]:53869)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuchenlin@synology.com>)
	id 1gH4Mu-0001us-F4
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 06:01:56 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 29 Oct 2018 18:01:24 +0800
From: yuchenlin <yuchenlin@synology.com>
In-Reply-To: <20181029094436.uuwiievt25fvlbu6@sirius.home.kraxel.org>
References: <20181022080053.9379-1-yuchenlin@synology.com>
	<20181029094436.uuwiievt25fvlbu6@sirius.home.kraxel.org>
Message-ID: <b9af7e4f272de131152cfedf58e74c53@synology.com>
Subject: Re: [Qemu-devel] [PATCH] vga_int: remove unused function protype
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, philmd@redhat.com

On 2018-10-29 17:44, Gerd Hoffmann wrote:
> On Mon, Oct 22, 2018 at 04:00:53PM +0800, yuchenlin@synology.com wrote:
>> From: yuchenlin <yuchenlin@synology.com>
>> 
>> Signed-off-by: yuchenlin <yuchenlin@synology.com>
>> ---
>>  hw/display/vga_int.h | 1 -
>>  1 file changed, 1 deletion(-)
>> 
>> diff --git a/hw/display/vga_int.h b/hw/display/vga_int.h
>> index 6e4fa48a79..55c418eab5 100644
>> --- a/hw/display/vga_int.h
>> +++ b/hw/display/vga_int.h
>> @@ -166,7 +166,6 @@ MemoryRegion *vga_init_io(VGACommonState *s, 
>> Object *obj,
>>                            const MemoryRegionPortio **vbe_ports);
>>  void vga_common_reset(VGACommonState *s);
>> 
>> -void vga_sync_dirty_bitmap(VGACommonState *s);
>>  void vga_dirty_log_start(VGACommonState *s);
>>  void vga_dirty_log_stop(VGACommonState *s);
> 
> Added to vga queue.
> 
> thanks,
>   Gerd

Hi, Gerd

Laurent has sent a pull request for this trivial commit.
See: 
http://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg05896.html

Thanks,
yuchenlin
