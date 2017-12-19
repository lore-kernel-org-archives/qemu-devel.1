Received: from eggs.gnu.org ([2001:4830:134:3::10]:38272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1eR96e-0001Zn-P5
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 23:02:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1eR96a-0003oH-Mq
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 23:02:16 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:15320
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1eR96a-0003io-83
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 23:02:12 -0500
References: <20171214040855.22231-1-douly.fnst@cn.fujitsu.com>
	<20171218220901.GE5209@localhost.localdomain>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <f5057cbf-c699-847a-d219-78a0ba6bff63@cn.fujitsu.com>
Date: Tue, 19 Dec 2017 12:01:59 +0800
MIME-Version: 1.0
In-Reply-To: <20171218220901.GE5209@localhost.localdomain>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RESEND PATCH for-2.12 0/2] ACPI/unit-test: Add a
 testcase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: imammedo@redhat.com, mst@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org, indou.takao@jp.fujitsu.com

Hi Eduardo,

At 12/19/2017 06:09 AM, Eduardo Habkost wrote:
> On Thu, Dec 14, 2017 at 12:08:53PM +0800, Dou Liyang wrote:
>> These are the patches left over from the pull request:
>>
>>    [Qemu-devel] [PULL 0/9] x86 and machine queue, 2017-10-05
>>
>> because of some errors when tested by "make check" command[1].
>>
>> Now, the QEMU 2.11.0 has been released, rebase/retest/respin them
>> for v2.12 dev.
>>
>> Changelog:
>>    --Rebase and retest this patch in v2.11.0
>>    --Update the DSDT.numamem:
>>
>> [1]: http://lists.gnu.org/archive/html/qemu-devel/2017-10/msg01334.html
> 
> Do we know what caused the failures Peter saw, and if we can now
> be sure it won't happen again?

Sorry, I can't. I tested it many times with my colleagues, it won't
happen like Peter saw. This issue is very subtle and funny. Could you
give me some suggestions?

BTW, I used "make TEST_ACPI_REBUILD_AML=1 check" to create the DSDT
file. Is it correct?

Thanks,
	dou.
>
