Received: from eggs.gnu.org ([2001:4830:134:3::10]:55578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTqQ6-0002hT-Hh
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:46:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTqQ2-0008A1-ID
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:46:02 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:38941)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gTqQ2-00089F-5f
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:45:58 -0500
Received: by mail-oi1-x244.google.com with SMTP id i6so11285833oia.6
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 07:45:58 -0800 (PST)
References: <20181130151712.2312-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e60ea922-af97-0568-a34c-6df24ca7fe19@linaro.org>
Date: Mon, 3 Dec 2018 09:45:53 -0600
MIME-Version: 1.0
In-Reply-To: <20181130151712.2312-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/10] Remove deprecated load_image()
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-ppc@nongnu.org, Li Zhijian <lizhijian@cn.fujitsu.com>, patches@linaro.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, Max Reitz <mreitz@redhat.com>, Philip Li <philip.li@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-block@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 11/30/18 9:17 AM, Peter Maydell wrote:
> Peter Maydell (10):
>   hw/ppc/mac_newworld, mac_oldworld: Don't use load_image()
>   hw/ppc/ppc405_boards: Don't use load_image()
>   hw/smbios/smbios.c: Don't use load_image()
>   hw/pci/pci.c: Don't use load_image()
>   hw/i386/pc.c: Don't use load_image()
>   hw/i386/multiboot.c: Don't use load_image()
>   hw/block/tc58128.c: Don't use load_image()
>   device_tree.c: Don't use load_image()
>   hw/core/loader.c: Remove load_image()
>   include/hw/loader.h: Document load_image_size()

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

with added casts for patch 5 from gsize back to posix types.


r~
