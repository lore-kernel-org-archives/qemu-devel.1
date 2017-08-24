Received: from eggs.gnu.org ([2001:4830:134:3::10]:40151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dks48-00084R-FL
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 09:20:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dks43-00007o-0r
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 09:20:56 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:26583
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dks42-00005N-LQ
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 09:20:50 -0400
References: <1503372250-5092-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<1503372250-5092-3-git-send-email-douly.fnst@cn.fujitsu.com>
	<20170823104051.36488fcb@nial.brq.redhat.com>
	<9b19623e-55e9-ebac-11d3-6ff5fff176fe@cn.fujitsu.com>
	<20170823144502.17203857@nial.brq.redhat.com>
	<f7857c7a-ff39-d8c5-284b-f24cca1bef02@cn.fujitsu.com>
	<20170823194734.518d5cb3@Igors-MacBook-Pro.local>
	<033764b9-6098-1949-e4e7-a21cafcc6901@cn.fujitsu.com>
	<20170824143357.552a5cc0@nial.brq.redhat.com>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <39d47329-a805-0077-c371-658537ebbda6@cn.fujitsu.com>
Date: Thu, 24 Aug 2017 21:20:38 +0800
MIME-Version: 1.0
In-Reply-To: <20170824143357.552a5cc0@nial.brq.redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 2/2] ACPI/unit-test: Add a new testcase
 for RAM allocation in numa node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: pbonzini@redhat.com, rth@twiddle.net, mst@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com

Hi Igor,

At 08/24/2017 08:33 PM, Igor Mammedov wrote:
>> > test_acpi_one(" -numa node -numa node,mem=128", &data);
>> >
>> > but, the DSDT didn't match the default one. because, if we support
>> > NUMA, the DSDT will give us "_PXM" to map the CPU to node.
> Ok, looks like you'll have to include your variant of DSDT along with SRAT
>

Yes, got it.

I will modify and post this patch first.

Thanks,
	dou.

>


>
