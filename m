Received: from eggs.gnu.org ([2001:4830:134:3::10]:38362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fnhyY-0001ud-Qo
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 06:15:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fnhyT-0000sz-SU
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 06:15:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58162 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fnhyT-0000sP-Jc
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 06:15:21 -0400
References: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
	<20180806143412.27722-6-e.emanuelegiuseppe@gmail.com>
	<f5a3c33f-f459-806c-1465-3b5415a5ccc1@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <141175f7-a38a-5236-cd63-70353870913a@redhat.com>
Date: Thu, 9 Aug 2018 12:15:18 +0200
MIME-Version: 1.0
In-Reply-To: <f5a3c33f-f459-806c-1465-3b5415a5ccc1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 05/34] tests/qgraph: sdhci driver and
 interface nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>

On 09/08/2018 12:10, Laurent Vivier wrote:
>>  libqgraph-pci-obj-y = $(libqos-pc-obj-y)
>>  libqgraph-pci-obj-y += $(libqgraph-machines-obj-y)
>> +libqgraph-pci-obj-y += tests/libqos/sdhci.o
> The file also implements memory mapped SDHCI, should we split the file
> in two files, one added to libqgraph-pci-obj-y and the other to
> check-qtest-arm-y and check-qtest-aarch64-y?
> 

No, there is only one libqgraph.  The same test (qos-test) can run for
both PCI and non-PCI machines, and will cull the unnecessary part of the
graph automatically simply because there is no path from a machine to a
PCI device.

Paolo
