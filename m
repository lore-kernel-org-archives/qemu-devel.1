Received: from eggs.gnu.org ([2001:4830:134:3::10]:49473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1eJqqN-0005bT-KI
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 20:07:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1eJqqJ-0002Hx-2a
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 20:07:19 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:36326
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1eJqqI-0002Ej-N4
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 20:07:15 -0500
References: <20171005203638.19255-1-ehabkost@redhat.com>
	<20171005203638.19255-3-ehabkost@redhat.com>
	<20171128160817.1cb9a9b1@redhat.com>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <3e9cab89-519f-dc8e-b371-cb0cb1514eac@cn.fujitsu.com>
Date: Wed, 29 Nov 2017 09:06:56 +0800
MIME-Version: 1.0
In-Reply-To: <20171128160817.1cb9a9b1@redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 2/9] ACPI/unit-test: Add a new testcase for
 RAM allocation in numa node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

Hi Igor,

At 11/28/2017 11:08 PM, Igor Mammedov wrote:
> On Thu,  5 Oct 2017 17:36:31 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
>
>> From: Dou Liyang <douly.fnst@cn.fujitsu.com>
>>
>> As QEMU supports the memory-less node, it is possible that there is
>> no RAM in the first numa node(also be called as node0). eg:
>>   ... \
>>   -m 128,slots=3,maxmem=1G \
>>   -numa node -numa node,mem=128M \
>>
>> But, this makes it hard for QEMU to build a known-to-work ACPI SRAT
>> table. Only fixing it is not enough.
>>
>> Add a testcase for this situation to make sure the ACPI table is
>> correct for guest.
>>
>> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
>> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
>> Message-Id: <1504231805-30957-4-git-send-email-douly.fnst@cn.fujitsu.com>
>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>
> Pls retest/respin once dev window is open.
>

Yes, Thanks so much for your reminder. I will do that.

Thanks,
	dou.

>
>
>
