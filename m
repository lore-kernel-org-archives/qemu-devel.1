Received: from eggs.gnu.org ([209.51.188.92]:40515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gjiU2-0007Ii-6k
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 05:31:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gjiIQ-0007Bb-FG
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 05:19:44 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:61283
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gjiIQ-0006co-0L
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 05:19:42 -0500
References: <1547197071-14504-1-git-send-email-lizhijian@cn.fujitsu.com>
	<1547197071-14504-5-git-send-email-lizhijian@cn.fujitsu.com>
	<20190114175348.GY4500@habkost.net>
	<6a1206be-d363-ff73-595c-fde52a3dab66@cn.fujitsu.com>
	<20190114204414-mutt-send-email-mst@kernel.org>
From: Li Zhijian <lizhijian@cn.fujitsu.com>
Message-ID: <6e2b275c-e566-16d9-c848-582eb55fd1f3@cn.fujitsu.com>
Date: Wed, 16 Jan 2019 18:19:26 +0800
MIME-Version: 1.0
In-Reply-To: <20190114204414-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 4/4] i386: allow to load initrd below 4G
 for recent linux
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, philmd@redhat.com, zhijianx.li@intel.com, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

Hi Michael, Eduardo

On 1/15/19 09:46, Michael S. Tsirkin wrote:
> On Tue, Jan 15, 2019 at 09:35:09AM +0800, Li Zhijian wrote:
>> Hi Eduardo
>>
>>
>> On 1/15/19 01:53, Eduardo Habkost wrote:
>>
>>          +    if (protocol >= 0x20c &&
>>          +        lduw_p(header+0x236) & XLF_CAN_BE_LOADED_ABOVE_4G) {
>>          +        /*
>>          +         * Linux has supported initrd up to 4 GB for a very long time (2007,
>>          +         * long before XLF_CAN_BE_LOADED_ABOVE_4G which was added in 2013),
>>          +         * though it only sets initrd_max to 2 GB to "work around bootloader
>>          +         * bugs". Luckily, QEMU firmware(which does something like bootloader)
>>          +         * has supported this.
>>          +         *
>>          +         * It's believed that if XLF_CAN_BE_LOADED_ABOVE_4G is set, initrd can
>>          +         * be loaded into any address.
>>          +         *
>>          +         * In addition, initrd_max is uint32_t simply because QEMU doesn't
>>          +         * support the 64-bit boot protocol (specifically the ext_ramdisk_image
>>          +         * field).
>>          +         *
>>          +         * Therefore here just limit initrd_max to UINT32_MAX simply as well.
>>          +         *
>>          +         * FIXME: it's possible that linux protocol within [0x208, 0x20c]
>>          +         * supports up to 4G initrd as well.
>>
>>      I don't understand what exactly this FIXME comment is
>>      documenting.  What exactly needs to be fixed?
>>
>>
>> XLF_CAN_BE_LOADED_ABOVE_4G is one of the indicators, actually as comments said,
>> linux has supported up to 4 GB initrd since linux-2.26(protocol version 0x208).
>>
>>
>> I just want to comment that linux with protocol within [0x208, 0x20c] supports up to 4 GB initrd as well.
>>
>> Is documenting with FIXME appropriate?
>>
>>
>> Thanks
>>
>>
>
> Fixme should say what is missing in the qemu implementation.



thanks for your explanation @Michael
I'd like to update "FIXME" to "NOTE" and move it into git-commit-log if no objection
and it's okay to delete it simply if it confuses others :)

BTW: any other comments for the others

Thanks
Zhijian




> E.g.
>
> /*
>   * Bar 2010 and up can actually be supported using foo.
>   * FIXME: make use of foo to support bar.
>   */
>
>
