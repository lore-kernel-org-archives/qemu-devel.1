Received: from eggs.gnu.org ([2001:4830:134:3::10]:37680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cUB70-0001mW-KT
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 06:42:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cUB6x-0005Vh-IQ
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 06:42:38 -0500
Received: from [59.151.112.132] (port=23188 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cUB6x-0005Q8-5n
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 06:42:35 -0500
References: <1484743207-10721-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<20170118144653.0d851927@nial.brq.redhat.com>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <de9fd71b-687f-fd2f-7e82-1c92e7ab57d2@cn.fujitsu.com>
Date: Thu, 19 Jan 2017 19:42:13 +0800
MIME-Version: 1.0
In-Reply-To: <20170118144653.0d851927@nial.brq.redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] cpu: numa: Fix the mapping
 initialization of VCPUs and NUMA nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org, fanc.fnst@cn.fujitsu.com, caoj.fnst@cn.fujitsu.com, stefanha@redhat.com, izumi.taku@jp.fujitsu.com, vilanova@ac.upc.edu

Hi, Igor,

At 01/18/2017 09:46 PM, Igor Mammedov wrote:
> On Wed, 18 Jan 2017 20:40:04 +0800
> Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:
>
>> As we fixed a bug(Bug 1) in below links, Named "Method-A":
>>
>> https://lists.nongnu.org/archive/html/qemu-devel/2017-01/msg03354.html
>>
>> Then, Eduardo gave us many suggests. Thanks very much!
>> when we try them, we also find another bugs named "Bug 2".
> I have an alternative fix for both issues for which
> I've been writing cover letter when I saw this series.
>
> My fix series more intrusive though as it's goal isn't
> just to fix 'info numa' but rather switch away from
> cpu-index based mapping to socket/core/thread based mapping
> and stop using bitmaps for mapping. And as 'info numa' was
> getting in the way, I fixed both issues in a slightly
> different way.
>
> So pls wait a bit, once travis build is completed,
> I'll post series here.

It doesn't matter. I am learning about your patches.
I think my method is temporary. your fix is better than me.

Thanks,
	Liyang.
