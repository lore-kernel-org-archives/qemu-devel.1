Received: from eggs.gnu.org ([2001:4830:134:3::10]:60230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gU5lk-0001HN-Qd
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 03:09:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gU5lh-0000GO-NY
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 03:09:24 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:3534
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gU5lh-0000DY-Bw
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 03:09:21 -0500
References: <1543848532-12604-1-git-send-email-lizhijian@cn.fujitsu.com>
	<1543848532-12604-4-git-send-email-lizhijian@cn.fujitsu.com>
	<20181203200403-mutt-send-email-mst@kernel.org>
From: Li Zhijian <lizhijian@cn.fujitsu.com>
Message-ID: <351854fc-c419-f006-8744-7f45d2701f16@cn.fujitsu.com>
Date: Tue, 4 Dec 2018 16:09:11 +0800
MIME-Version: 1.0
In-Reply-To: <20181203200403-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 v3 3/4] i386: import bootparam.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, philip.li@intel.com, zhijianx.li@intel.com



On 12/04/2018 09:06 AM, Michael S. Tsirkin wrote:
> On Mon, Dec 03, 2018 at 10:48:51PM +0800, Li Zhijian wrote:
>> It provides setup_data struct and header fields
>>
>> CC: Michael S. Tsirkin<mst@redhat.com>
>> Signed-off-by: Li Zhijian<lizhijian@cn.fujitsu.com>
> Sorry I was unclear when I said "import it from Linux".

Sorry, it's my fault.

>
> The way to import it is to copy the header
> from the linux kernel by adding it to ./scripts/update-linux-headers.sh
> and placing a copy into include/standard-headers/
>
> Hope that helps.

that's really helpful.

i wonder which type copy should i use 'cp' or 'cp_portable'
this header includes several sub-headers

$ grep include  /tmp/tmp.MBF10Z9MeS/include/asm/bootparam.h
#include <linux/types.h>
#include <linux/screen_info.h>
#include <linux/apm_bios.h>
#include <linux/edd.h>
#include <asm/ist.h>
#include <video/edid.h>

Thanks
Zhijian

>
>
>
