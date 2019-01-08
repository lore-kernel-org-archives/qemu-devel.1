Received: from eggs.gnu.org ([209.51.188.92]:58633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1ggfvr-0006U4-O8
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 20:11:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1ggfvp-0001oC-SD
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 20:11:51 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:39470
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1ggfvo-0001jP-Cl
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 20:11:49 -0500
References: <1544063533-10139-1-git-send-email-lizhijian@cn.fujitsu.com>
	<1544063533-10139-4-git-send-email-lizhijian@cn.fujitsu.com>
	<CAGxU2F4c+xu-fadAEhumc9zt1bSW760D-1hg0foPikAXPQqwOQ@mail.gmail.com>
From: Li Zhijian <lizhijian@cn.fujitsu.com>
Message-ID: <9265bfc0-0480-7b8a-f9a9-6a4b63de5ea6@cn.fujitsu.com>
Date: Tue, 8 Jan 2019 09:11:41 +0800
MIME-Version: 1.0
In-Reply-To: <CAGxU2F4c+xu-fadAEhumc9zt1bSW760D-1hg0foPikAXPQqwOQ@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 v4 3/4] i386: import & use
 bootparam.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>, peter.maydell@linaro.org, philip.li@intel.com, zhijianx.li@intel.com, Philippe Mathieu Daude <philmd@redhat.com>

Hi Stefano,


On 1/5/19 00:41, Stefano Garzarella wrote:
>> +        # Remove everything except the macros from bootparam.h avoiding the
>> +        # unnecessary import of several video/ist/etc headers
>> +        sed -e '/__ASSEMBLY__/,/__ASSEMBLY__/d' $tmpdir/include/asm/bootparam.h > $tmpdir/bootparam.h
>> +        cp_portable $tmpdir/bootparam.h "$output/include/standard-headers/asm-$arch"
> Maybe is better to use the double quotes for all paths.

Sure, i will update it at next version.

Thanks
Zhijian


>
> Reviewed-by: Stefano Garzarella<sgarzare@redhat.com>
>
> Thanks,
> Stefano
>
