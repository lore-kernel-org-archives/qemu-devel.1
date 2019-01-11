Received: from eggs.gnu.org ([209.51.188.92]:40654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1ghtfM-0004Od-7j
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 05:03:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1ghtfL-0005Jo-EV
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 05:03:52 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:64396
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1ghtfK-0005Hy-UF
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 05:03:51 -0500
References: <1547197071-14504-1-git-send-email-lizhijian@cn.fujitsu.com>
	<1547197071-14504-4-git-send-email-lizhijian@cn.fujitsu.com>
	<CAGxU2F4M22Vz6xTauvHAngzp6PMfzAkTqbmGfsA=5rwWYnZi_w@mail.gmail.com>
From: Li Zhijian <lizhijian@cn.fujitsu.com>
Message-ID: <3517ec7b-87e7-bc38-0ec5-d85cf4fc6a31@cn.fujitsu.com>
Date: Fri, 11 Jan 2019 18:03:41 +0800
MIME-Version: 1.0
In-Reply-To: <CAGxU2F4M22Vz6xTauvHAngzp6PMfzAkTqbmGfsA=5rwWYnZi_w@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 3/4] i386: import & use bootparam.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, zhijianx.li@intel.com, Philippe Mathieu Daude <philmd@redhat.com>

Hi Stefano


On 1/11/19 17:48, Stefano Garzarella wrote:
> Hi Li,
>
> On Fri, Jan 11, 2019 at 10:06 AM Li Zhijian <lizhijian@cn.fujitsu.com> wrote:
>> +        # unnecessary import of several video/ist/etc headers
>> +        sed -e '/__ASSEMBLY__/,/__ASSEMBLY__/d' $tmpdir/include/asm/bootparam.h > $tmpdir/bootparam.h
>> +        cp_portable $tmpdir/bootparam.h "$output/include/standard-headers/asm-$arch"
> Maybe you miss my comment. Anyway, IMHO is better to use the double
> quotes for all paths.
>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

So sorry about it, i folded it on a wrong branch at the beginning.

will update it soon.


Thanks
