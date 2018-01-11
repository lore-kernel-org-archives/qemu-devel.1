Received: from eggs.gnu.org ([2001:4830:134:3::10]:41051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1eZaIy-0003DO-EJ
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 05:41:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1eZaIv-0003FY-9V
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 05:41:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60234)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1eZaIv-00038r-3a
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 05:41:49 -0500
Date: Thu, 11 Jan 2018 16:11:28 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <20171225022835.23236-1-linzhecheng@huawei.com>
Message-ID: <nycvar.YSQ.7.76.1801111610210.28887@wniryva>
References: <20171225022835.23236-1-linzhecheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH] vga: check the validation of memory addr
 when draw text
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com
Cc: qemu-devel@nongnu.org, wangxinxin.wang@huawei.com, arei.gonglei@huawei.com, fabrice@bellard.org, linzhecheng <linzhecheng@huawei.com>

+-- On Mon, 25 Dec 2017, linzhecheng wrote --+
| --- a/hw/display/vga.c
| +++ b/hw/display/vga.c
| @@ -1279,6 +1279,10 @@ static void vga_draw_text(VGACommonState *s, int full_update)
|          cx_min = width;
|          cx_max = -1;
|          for(cx = 0; cx < width; cx++) {
| +            if (src + sizeof(uint16_t) > s->vram_ptr + s->vram_size) {
| +                printf("src is out of the range of vga ram.\n");
| +                return;
| +             }
|              ch_attr = *(uint16_t *)src;

This does fix the OOB access and segfault issue. Maybe it could 'break;' 
instead of 'return;' with no printf(...)?

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
