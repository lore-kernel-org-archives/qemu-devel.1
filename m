Received: from eggs.gnu.org ([2001:4830:134:3::10]:43406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cUPvx-0002By-F0
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 22:32:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cUPvs-0005ve-KW
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 22:32:13 -0500
Received: from [59.151.112.132] (port=32163 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cUPvs-0005tW-5P
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 22:32:08 -0500
References: <1484759609-264075-1-git-send-email-imammedo@redhat.com>
	<1484759609-264075-6-git-send-email-imammedo@redhat.com>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <d6ddd2f5-9ebc-7e19-c904-6271b47f5c1d@cn.fujitsu.com>
Date: Fri, 20 Jan 2017 11:31:56 +0800
MIME-Version: 1.0
In-Reply-To: <1484759609-264075-6-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 05/13] pc: move pcms->possible_cpus init out
 of pc_cpus_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: fanc.fnst@cn.fujitsu.com, caoj.fnst@cn.fujitsu.com, stefanha@redhat.com, izumi.taku@jp.fujitsu.com, vilanova@ac.upc.edu, ehabkost@redhat.com, peter.maydell@linaro.org, Andrew Jones <drjones@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>



At 01/19/2017 01:13 AM, Igor Mammedov wrote:
> possible_cpus could be initialized earlier then cpu objects,

s/then/than/

> i.e. when -smp is parsed so move init code to possible_cpu_arch_ids()

[...]
